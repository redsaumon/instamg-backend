from django.urls import path
from .views      import (PostView, PostDeleteView, ProfileView, ProfileFeedView, 
                         PostDetailView, CommentView, CommentDeleteView, CommentModifyView, 
                         PostLikeView, RecommentView, PostReadView, PostStoryView)#PostDetailView, RecommentModifyView, RecommentDeleteView

urlpatterns = [
    path('', PostReadView.as_view()),
    path('/write' ,PostView.as_view()),
    path('/story', PostStoryView.as_view()),
    path('/delete/<int:post_id>', PostDeleteView.as_view()),
    path('/profile/<int:user_id>', ProfileView.as_view()),
    path('/profile/feed/<int:user_id>', ProfileFeedView.as_view()),
    path('/feed/<int:post_id>', PostDetailView.as_view()),
    path('/comment/<int:post_id>', CommentView.as_view()),
    path('/comment/delete/<int:comment_id>', CommentDeleteView.as_view()),
    path('/comment/<int:post_id>/<int:comment_id>', CommentModifyView.as_view()),
    path('/like/<int:post_id>', PostLikeView.as_view()),
    path('/recomment/<int:post_id>/<int:comment_id>', RecommentView.as_view()),
    # path('/recomment/modify/<int:post_id>/<int:comment_id>', RecommentModifyView.as_view()),
    # path('/recomment/delete/<int:comment_id>', RecommentDeleteView.as_view()),

    # path('/profile/post/<int:post_id>', ProfileFeedDetailView.as_view()),
    # path('/like/<int:post_id>', LikeView.as_view()),
    # path('/update/<int:post_id>', PostUpdateView.as_view()),
    # path('/comment/<int:post_id>', CommentView.as_view()),
    # path('/comment/<int:post_id>/<int:comment_id>', CommentDeleteView.as_view()),

]