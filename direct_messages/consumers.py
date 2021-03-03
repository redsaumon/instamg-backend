import json
from channels.generic.websocket import AsyncWebsocketConsumer, WebsocketConsumer
from asgiref.sync               import async_to_sync

from direct_messages.models     import DirectMessage, DirectMessageAttachFiles, Room
from users.models               import User
from decorators                 import login_check


class ChatConsumer(WebsocketConsumer):
    def connect(self):
        self.room_name = self.scope['url_route']['kwargs']['room_name']
        self.room_group_name = 'chat_%s' % self.room_name

        # Join room group
        async_to_sync(self.channel_layer.group_add)(
            self.room_group_name,
            self.channel_name
        )

        self.accept()

    def disconnect(self, close_code):
        # Leave room group
        async_to_sync(self.channel_layer.group_discard)(
            self.room_group_name,
            self.channel_name
        )

    # Receive message from WebSocket
    def receive(self, text_data):
        data = json.loads(text_data)
        # if not Room.objects.filter(name=data['room_name']).exists():
        # Room.objects.create(
        #     name = data['room_name']
        # )
        direct_message = DirectMessage.objects.create(
            room_id = Room.objects.get(id=1),#Room.objects.get(name=data['room_name']),
            user_id = User.objects.get(id=2), # decorator 달아서 request.user로 받기
            message = data['message']
        )
        print(data)
        message = data['message']

        # Send message to room group
        async_to_sync(self.channel_layer.group_send)(
            self.room_group_name,
            {
                'type': 'chat_message',
                'message': message
            }
        )

    # Receive message from room group
    def chat_message(self, event):
        message = event['message']

        # Send message to WebSocket
        self.send(text_data=json.dumps({
            'message': message
        }))