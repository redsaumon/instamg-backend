from django.urls import re_path

from .           import consumers

websocket_urlpatterns = [
    re_path(r'ws/direct_message/(?P<room_name>\w+)$', consumers.ChatConsumer.as_asgi()),
]