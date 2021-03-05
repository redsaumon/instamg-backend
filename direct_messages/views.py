from django.views      import View
from django.http       import JsonResponse

from decorators        import login_check
from .models           import DirectMessage
from users.models      import Follow

class DirectMessageView(View):
    @login_check
    def get(self, request):
        try:
            login_user       = request.user
            rooms            = DirectMessage.objects.filter(user_id=login_user)
            room_list        = []
            talked_user_list = []

            for room in rooms:
                if room.room_id not in room_list:
                    room_list.append(room.room_id)

            for room in room_list:
                users = DirectMessage.objects.filter(room_id=room)
                for user in users:
                    if user.user_id not in talked_user_list and user.user_id != login_user:
                        talked_user_list.append(user.user_id)
            
            user_list = {
                'user_account' : login_user.account,
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