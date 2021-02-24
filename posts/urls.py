from django.urls import path
from .views      import (
    PostView,
    PostDeleteView,
    PostDetailView,
    PostLikeView,
    PostReadView,
    PostStoryView,
    PostCommentView,
    ProfileView,
    ProfileFeedView, 
    CommentView,
    CommentDeleteView,
    CommentModifyView, 
    RecommentView,
)

urlpatterns = [
    path('/write', PostView.as_view()),
    path('/delete/<int:post_id>', PostDeleteView.as_view()),
    path('/feed/<int:post_id>', PostDetailView.as_view()),
    path('/like/<int:post_id>', PostLikeView.as_view()),
    path('', PostReadView.as_view()),
    path('/story', PostStoryView.as_view()),
    path('/<int:post_id/comment', PostCommentView.as_view()),
    path('/profile/<int:user_id>', ProfileView.as_view()),
    path('/profile/feed/<int:user_id>', ProfileFeedView.as_view()),
    path('/comment/<int:post_id>', CommentView.as_view()),
    path('/comment/delete/<int:comment_id>', CommentDeleteView.as_view()),
    path('/comment/<int:post_id>/<int:comment_id>', CommentModifyView.as_view()),
    path('/recomment/<int:post_id>/<int:comment_id>', RecommentView.as_view()),

]