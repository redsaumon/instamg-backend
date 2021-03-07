from django.views      import View
from django.http       import JsonResponse

from decorators        import login_check
from .models           import DirectMessage, Room
from users.models      import Follow,User


class DirectMessageView(View):
    @login_check
    def get(self, request):
        try:
            login_user       = request.user.account
            room_names       = Room.objects.filter(name__contains=login_user)
            talked_user_list = [User.objects.filter(account=sorted(name.name.split(login_user))[-1])[0] for name in room_names]

            user_list = {
                'user_account' : login_user,
                 'talked_user' :[{
                     'talked_user_account': user.account,
                     'profile_photo'      : str(user.thumbnail_path) if str(user.thumbnail_path) else None
                 } for user in talked_user_list]}

            return JsonResponse({'user_list':user_list}, status=200)
        except ValueError:
            return JsonResponse({'message':'VALUE_ERROR'}, status=400)


class DirectMessageSearchView(View):
    @login_check
    def get(self, request):
        try:
            user       = request.user
            followings = Follow.objects.filter(follower_user_id=user)

            following_list = [{
                'user_account' : following.followed_user_id.account,
                'profil_phofo' : str(following.followed_user_id.thumbnail_path) if str(following.followed_user_id.thumbnail_path) else None
            } for following in followings]

            return JsonResponse({'following':following_list}, status=200)
        except Follow.DoesNotExist:
            return JsonResponse({'message':'FOLLOWING_DOES_NOT_EXIST'}, status=400)


class DirectMessageRecordView(View):
    @login_check
    def get(self, request, room_name):
        if not Room.objects.filter(name=room_name).exists():
            user_account        = request.user.account
            talked_user_account = sorted(room_name.split(user_account))[-1]
            rooms = []
            rooms.append(user_account+talked_user_account)
            rooms.append(talked_user_account+user_account)

            if  len(Room.objects.filter(name__in=rooms)) > 0:
                room_name = Room.objects.filter(name__in=rooms)[0].name
            else:
                return JsonResponse({'message':'MESSAGE_DOES_NOT_EXIST'}, status=200)

        if Room.objects.filter(name=room_name).exists():
            room      = Room.objects.filter(name=room_name).prefetch_related('direct_messages')[0]
            user1     = request.user.account
            user_list = []
            user_list.insert(0,[])
            user_list.insert(1,[])

            message_list = [{
                'message'      : data.message,
                'created_at'   : data.created_at,
                'user_account' : data.user_id.account
            } for data in room.direct_messages.all()]

            for i in range(len(message_list)):
                if message_list[i]['user_account'] == user1:
                    user_list[0].append(message_list[i])
                else:
                    user_list[-1].append(message_list[i])
 
            return JsonResponse({'message_list':user_list}, status=200)
