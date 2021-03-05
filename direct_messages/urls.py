from django.urls import path

<<<<<<< HEAD
from .           import views
=======
from .           import views, consumers
>>>>>>> ad59381... Add: DM2
from .views      import DirectMessageView, DirectMessageSearchView, DirectMessageRecordView

urlpatterns = [
    path('', DirectMessageView.as_view()),
    path('/search', DirectMessageSearchView.as_view()),
    path('/<str:room_name>', DirectMessageRecordView.as_view()),
]