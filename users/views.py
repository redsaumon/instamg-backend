import re
import jwt
import json
import bcrypt

from decorators             import login_check
from django.http            import JsonResponse
from django.views           import View
            
from my_settings            import SECRET,PASSWORD_LENGTH, EMAIL_VALIDATOR, ALGORITHM
from .models                import User, Follow
from direct_messages.models import Room


# 회원가입
class SignUpView(View):
    def post(self, request):
        try:
            data            = json.loads(request.body)
            email           = data.get('email')
            phone           = data.get('phone')
            password        = data['password'].encode('utf-8')
            hashed_password = bcrypt.hashpw(password, bcrypt.gensalt()).decode('utf-8')

            if User.objects.filter(account=data['account']).exists():
                return JsonResponse({'message': 'ACCOUNT_ALREADY_EXIST'}, status=400)

            if len(password) < PASSWORD_LENGTH:
                return JsonResponse({'message': 'MINIMUM_PASSWORD_LENGTH_IS_8'}, status=400)

            if email is not None: 
                if User.objects.filter(email=data["email"]).exists():
                    return JsonResponse({'message': 'EMAIL_ALREADY_EXIST'}, status=400)
                elif '@' and '.' not in email:
                    return JsonResponse({'message': 'WRONG_EMAIL_FORMAT'}, status=400)

            User(
                account  = data['account'],
                password = hashed_password,
                phone    = phone,
                email    = email).save()
            return JsonResponse({'message': 'SUCCESS'}, status=201)
        except KeyError:
            return JsonResponse({''})


# 로그인
class SignInView(View):
    def post(self, request):
        try:
            data      = json.loads(request.body)
            password  = data['password']

            if 'email' in data:
                email          = data["email"]
                user           = User.objects.get(email=data["email"])
                password_check = user.password
                if bcrypt.checkpw(password.encode('utf-8'), password_check.encode('utf-8')):
                    token = jwt.encode({'id': user.id}, SECRET, ALGORITHM)
                    return JsonResponse({'token':token}, status=200)
                else:
                     return JsonResponse({'message':'INVALID_PASSWORD'}, status=401)

            if data.get('account') is not None:
                account        = data["account"]
                user           = User.objects.get(account=data["account"])
                password_check = user.password
                if bcrypt.checkpw(password.encode('utf-8'), password_check.encode('utf-8')):
                    token = jwt.encode({'id': user.id}, SECRET, ALGORITHM)
                    return JsonResponse({'token':token}, status=200)
                else:
                     return JsonResponse({'message':'INVALID_PASSWORD'}, status=401)

            if data.get('phone') is not None:
                phone          = data["phone"]
                user           = User.objects.get(phone=data["phone"])
                password_check = user.password
                if bcrypt.checkpw(password.encode('utf-8'), password_check.encode('utf-8')):
                    token = jwt.encode({'id': user.id}, SECRET, ALGORITHM)
                    return JsonResponse({'token':token}, status=200)
                else:
                     return JsonResponse({'message':'INVALID_PASSWORD'}, status=401)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
        except User.DoesNotExist:
            return JsonResponse({'message':'USER_DOES_NOT_EXIST'}, status=400)


# follow하기
class FollowView(View):
    @login_check
    def post(self, request, user_id):
        try:
            user     = User.objects.get(id=user_id)
            follower = request.user # 로그인 하면서 받는 유저

            if follower.id == user_id:
                return JsonResponse({'message':"CAN'T_FOLLOW_YOURSELF"}, status=400)
            
            if Follow.objects.filter(followed_user_id=user_id, follower_user_id=follower).exists(): # unfollow
                Follow.objects.filter(followed_user_id=user_id, follower_user_id=follower).delete()
                return JsonResponse({'message':'SUCCESS'}, status=200)
         
            Follow.objects.create(followed_user_id=user, follower_user_id=follower)
            return JsonResponse({'message':'SUCCESS'}, status=201)
        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
        except User.DoesNotExist :
            return JsonResponse({'message':'USER_DOES_NOT_EXIST'}, status=400)


# 유저 프로필 수정
class UserProfileView(View):
    @login_check
    def get(self, request):
        user = request.user
        user_profile = {
            'account'         : user.account,
            'phone'           : user.phone,
            'email'           : user.email,
            'profile_message' : user.profile_message,
            'profile_photo'   : "media/"+ str(user.thumbnail_path) if str(user.thumbnail_path) else None,
        }
        return JsonResponse({'profile' : user_profile}, status = 200)

    
    @login_check
    def post(self, request):
        try:
            user            = request.user
            data            = json.loads(request.POST['json'])
            new_password    = data.get('new_password')
        
            if User.objects.exclude(id=user.id).filter(account=data['new_account']).exists():
                return JsonResponse({'message' : 'ALREADY_IN_USE_ACCOUNT'}, status=400)
            User.objects.filter(id=user.id).update(account=data['new_account'])
            if Room.objects.filter(name__contains=user.account).exists():
                rooms = Room.objects.filter(name__contains=user.account)
                for room in rooms:
                    Room.objects.filter(id=room.id).update(name=room.name.replace(user.account, data['new_account']))

            if User.objects.exclude(id=user.id).filter(email=data['new_email']).exists():
                return JsonResponse({'message' : 'ALREADY_IN_USE_EMAIL'}, status=400)
            if not EMAIL_VALIDATOR.match(data['new_email']):
                return JsonResponse({'message' : 'INVALID_EMAIL'}, status=400)
            User.objects.filter(id=user.id).update(email=data['new_email'])
    
            if User.objects.exclude(id=user.id).filter(phone=data['new_phone']).exists():
                return JsonResponse({'message' : 'ALREADY_IN_USE_PHONE'}, status=400)
            User.objects.filter(id=user.id).update(phone=data['new_phone'])
            
            if new_password:
                if len(new_password) < PASSWORD_LENGTH:
                    return JsonResponse({'message' : 'INVALID_PASSWORD'}, status=400)
                if not bcrypt.checkpw(data['password'].encode('utf-8'), user.password.encode('utf-8')):
                    return JsonResponse({'message' : 'PASSWORD_MISMATCH'}, status=400)
                encrypt_pw = bcrypt.hashpw(new_password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
                User.objects.filter(id=user.id).update(password=encrypt_pw)
    
            User.objects.filter(id=user.id).update(profile_message=data['new_profile_message'])
    
            if request.FILES.get('profile_photo'):
                path = request.FILES['profile_photo']
                user = User.objects.filter(id=user.id)[0]
                user.profile_photo  = path
                user.thumbnail_path = path
                user.save()

            return JsonResponse({'message' : 'CHANGE_COMPLETE'}, status=200)
     
        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status=400, safe=False)
        except ValueError:
            return JsonResponse({'message' : 'VALUE_ERROR'}, status=400, safe=False)