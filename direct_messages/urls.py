from django.urls import path

from .           import views
from .views      import DirectMessageView, DirectMessageSearchView

urlpatterns = [
    path('', DirectMessageView.as_view()),
    path('/search', DirectMessageSearchView.as_view()),
]