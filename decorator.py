import json
import jwt
import datetime

from django.http import JsonResponse

from my_settings import SECRET
from users.models import User

# 로그인 체크
def login_check(func):
    def wrapper(self, request, *args, **kwargs):
        #data       = json.loads(request.body)
        try:
            token      = request.headers.get('Authorization')
            user_token = jwt.decode(token, SECRET, algorithms='HS256')
            print(request.headers)
            print(user_token)

            setattr(request, 'user', User.objects.get(id=user_token['id']))
        except jwt.exceptions.DecodeError:
            return JsonResponse({'message':'INVALID_TOKEN'}, status=400)
        except User.DoesNotExist:
            return JsonResponse({'message':'INVALID_USER'}, status=400)
        return func(self, request, *args, **kwargs)
    return wrapper

# KeyError
def key_error_killer(func):
    def wrapper(self, request, *args, **kwargs):
        try:
            print('keyError decorator입니다.')
        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
        return func(self, request, *args, **kwargs)
    return wrapper
