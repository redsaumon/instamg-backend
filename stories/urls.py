from django.urls import path

from .views      import StoryView, ProfileStoryView

urlpatterns = [
    path('/write', StoryView.as_view()),
    path('/profile/<int:user_id>', ProfileStoryView.as_view()),
]