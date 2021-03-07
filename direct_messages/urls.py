from django.urls import path

from .           import views, consumers
from .views      import DirectMessageView, DirectMessageSearchView, DirectMessageRecordView

urlpatterns = [
    path('', DirectMessageView.as_view()),
    path('/search', DirectMessageSearchView.as_view()),
    path('/<str:room_name>', DirectMessageRecordView.as_view()),
]