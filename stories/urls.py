from django.urls import path

from .views      import StoryView

urlpatterns = [
    path('/story', StoryView.as_view()),
]