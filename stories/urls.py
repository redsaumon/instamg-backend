from django.urls import path

from .views      import StoryView

urlpatterns = [
    path('/write', StoryView.as_view()),
]