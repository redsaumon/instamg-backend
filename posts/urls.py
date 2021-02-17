from django.urls import path
from .views      import PostView, PostDeleteView, PostReadView, PostStoryView, PostCommentView#,PostDetailView

urlpatterns = [
    path('', PostReadView.as_view()),
    path('/write' ,PostView.as_view()),
    path('/story', PostStoryView.as_view()),
    path('/<int:post_id>/comment', PostCommentView.as_view()),
    path('/delete/<int:post_id>', PostDeleteView.as_view()),
    #path('/<int:post_id>', PostDetailView.as_view()),
    # path('/like/<int:post_id>', LikeView.as_view()),
    # path('/update/<int:post_id>', PostUpdateView.as_view()),
    # path('/comment/<int:post_id>', CommentView.as_view()),
    # path('/comment/<int:post_id>/<int:comment_id>', CommentDeleteView.as_view()),
    # path('/recomment/<int:post_id>/<int:comment_id>', RecommentView.as_view()),

]