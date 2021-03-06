from django.urls import path

from .views      import StoryView, ProfileStoryView, StoryListView

urlpatterns = [
    path('/write', StoryView.as_view()),
    path('/profile/<int:user_id>', ProfileStoryView.as_view()),
    path('', StoryListView.as_view()),
]