import json

from channels.generic.websocket import AsyncWebsocketConsumer
from channels.db                import database_sync_to_async

from direct_messages.models     import DirectMessage, DirectMessageAttachFiles, Room
from users.models               import User
from decorators                 import login_check


class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_name = self.scope['url_route']['kwargs']['room_name']
        self.room_group_name = 'chat_%s' % self.room_name

        # Join room group
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )
        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    # Receive message from WebSocket
    async def receive(self, text_data):
        data         = json.loads(text_data)
        message      = data['message']
        user_account = data['user_account']
        room_name    = data['room_name']
        rooms        = Room.objects.filter(name__contains=user_account)

        await self.create_message(user_account, message, rooms, room_name)

        # Send message to room group
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type'         : 'chat_message',
                'message'      : message,
                'user_account' : user_account
            }
        )

    # Receive message from room group
    async def chat_message(self, event):
        message      = event['message']
        user_account = event['user_account']
        self.created_at = await self.get_created_at()

        # Send message to WebSocket
        await self.send(text_data=json.dumps({
            'message'      : message,
            'user_account' : user_account,
            'created_at'   : str(self.created_at)
        }))

    @database_sync_to_async
    def create_message(self, user_account, message, rooms, room_name):
        if len(rooms) > 0:
            talked_user = sorted(room_name.split(user_account))[-1]
            for room in rooms:
                if talked_user in room.name and user_account in room.name:
                    room_name = room.name

        if not Room.objects.filter(name=room_name).exists():
            Room.objects.create(
                name = room_name
            )

        return DirectMessage.objects.create(
            room_id = Room.objects.get(name=room_name),
            user_id = User.objects.get(account=user_account),
            message = message
            )

    @database_sync_to_async
    def get_created_at(self):
        return DirectMessage.objects.last().created_at