from django.urls import path
from .views      import SignUpView, SignInView, FollowView, UserProfileView

urlpatterns = [
    path('/signup', SignUpView.as_view()),
    path('/signin', SignInView.as_view()),
    path('/<int:user_id>', FollowView.as_view()),
    path('/profile', UserProfileView.as_view()),
]