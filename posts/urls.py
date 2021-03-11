from django.urls import path
from .views      import (
    PostView,
    PostModifyView,
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
    CommentLikeView,
    GoToPostView,
    Viewcount
)

urlpatterns = [
    path('/write', PostView.as_view()),
    path('/modify/<int:post_id>', PostModifyView.as_view()),
    path('/delete/<int:post_id>', PostDeleteView.as_view()),
    path('/feed/<int:post_id>', PostDetailView.as_view()),
    path('/like/<int:post_id>', PostLikeView.as_view()),
    path('', PostReadView.as_view()),
    path('/story', PostStoryView.as_view()),
    path('/<int:post_id>/comment', PostCommentView.as_view()),
    path('/profile/<int:user_id>', ProfileView.as_view()),
    path('/profile/feed/<int:user_id>', ProfileFeedView.as_view()),
    path('/comment/<int:post_id>', CommentView.as_view()),
    path('/comment/delete/<int:comment_id>', CommentDeleteView.as_view()),
    path('/comment/<int:post_id>/<int:comment_id>', CommentModifyView.as_view()),
    path('/comment/like/<int:comment_id>', CommentLikeView.as_view()),
    path('/<int:user_id>/<int:post_id>', GoToPostView.as_view()),
    path('/view/<int:postattachfiles_id>', Viewcount.as_view())
]