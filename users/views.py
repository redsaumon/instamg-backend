import re
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
            'account'        : user.account,
            'phone'          : user.phone,
            'email'          : user.email,
            'prfile_message' : user.profile_message,
            'profile_photo'  : "/media/"+ str(user.thumbnail_path) if str(user.thumbnail_path) else None,
        }
        return JsonResponse({'profile' : user_profile}, status = 200)

    # 키에러 벨류에러 안잡힘, 에러 수정해야함
    @login_check
    def post(self, request):
        print(request.POST.get('json'))
        try:
            user = request.user
            PASSWORD_LENGTH = 8
            EMAIL_VALIDATOR = re.compile(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            # data = request.POST['json']
            # profile_photo = request.FILES['profile_photo']
            # if request.POST['json'] or request.FILES['profile_photo'] is None:
            #     return JsonResponse({'error'}, status=400)
            if request.POST.get('json') is not None:
                data = json.loads(request.POST.get('json'))
                new_password = data.get('new_password')
                new_account = data.get('new_account')
                new_phone = data.get('new_phone')
                new_email = data.get('new_email')
                new_profile_message = data.get('new_profile_message')
        
                if new_account:
                    if User.objects.filter(account=new_account).exists():
                        return JsonResponse({'message' : 'ALREADY_IN_USE'}, status=400)
                    User.objects.filter(id=user.id).update(account=new_account)
                    return JsonResponse({'message' : 'ACCOUNT_CHANGE_COMPLETE'}, status=200)
        
                if new_email:
                    if User.objects.filter(email = new_email).exists():
                        return JsonResponse({'message' : 'ALREADY_IN_USE'}, status=400)
                    if not EMAIL_VALIDATOR.match(new_email):
                        return JsonResponse({'message' : 'INVALID_EMAIL'}, status=400)
                    User.objects.filter(id=user.id).update(email=new_email)
                    return JsonResponse({'message' : 'EMAIL_CHANGE_COMPLETE'}, status=200)
        
                if new_phone:
                    if User.objects.filter(phone=new_phone).exists():
                        return JsonResponse({'message' : 'ALREADY_IN_USE'}, status=400)
                    User.objects.filter(id=user.id).update(phone=new_phone)
                    return JsonResponse({'message' : 'PHONE_CHANGE_COMPLETE'})
                
                if new_password:
                    if len(new_password) < PASSWORD_LENGTH:
                        return JsonResponse({'message' : 'INVALID_PASSWORD'}, status=400)
                    if not bcrypt.checkpw(data['password'].encode('utf-8'), user.password.encode('utf-8')):
                        return JsonResponse({'message' : 'PASSWORD_MISMATCH'}, status=400)
                    encrypt_pw = bcrypt.hashpw(new_password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
                    User.objects.filter(id=user.id).update(password=encrypt_pw)
                    return JsonResponse({'message' : 'PASSWORD_CHANGE_COMPLETE'})
    
                if new_profile_message:
                    User.objects.filter(id=user.id).update(profile_message=new_profile_message)
                    return JsonResponse({'message' : 'PROFILE_MESSAGE_CHANGE_COMPLETE'}, status=200)
        
    
            if request.FILES.get('profile_photo'):
                files = request.FILES['profile_photo']
                User.objects.filter(id = user.id).update(profile_photo=files, thumbnail_path=files)
                return JsonResponse({'message' : 'PROFILE_PHOTO_CHANGE_COMPLETE'})
     
        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status=400, safe=False)
        except ValueError:
            return JsonResponse({'message' : 'VALUE_ERROR'}, status=400, safe=False)


