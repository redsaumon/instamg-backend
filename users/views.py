import jwt
import json
import bcrypt

from decorators   import login_check
from django.http  import JsonResponse
from django.views import View

from my_settings  import SECRET
from .models      import User, Follow

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

            if len(password) < 8:
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
                    token = jwt.encode({'id': user.id}, SECRET, algorithm='HS256')
                    return JsonResponse({'token':token}, status=200)
                else:
                     return JsonResponse({'message':'INVALID_PASSWORD'}, status=401)

            if data.get('account') is not None:
                account        = data["account"]
                user           = User.objects.get(account=data["account"])
                password_check = user.password
                if bcrypt.checkpw(password.encode('utf-8'), password_check.encode('utf-8')):
                    token = jwt.encode({'id': user.id}, SECRET, algorithm='HS256')
                    return JsonResponse({'token':token}, status=200)
                else:
                     return JsonResponse({'message':'INVALID_PASSWORD'}, status=401)

            if data.get('phone') is not None:
                phone          = data["phone"]
                user           = User.objects.get(phone=data["phone"])
                password_check = user.password
                if bcrypt.checkpw(password.encode('utf-8'), password_check.encode('utf-8')):
                    token = jwt.encode({'id': user.id}, SECRET, algorithm='HS256')
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
            else:
                Follow.objects.create(followed_user_id=user, follower_user_id=follower)
            return JsonResponse({'message':'SUCCESS'}, status=201)
        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
        except User.DoesNotExist :
            return JsonResponse({'message':'USER_DOES_NOT_EXIST'}, status=400)