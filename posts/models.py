from django.db import models


class Post(models.Model):
    user_id    = models.ForeignKey('users.User', on_delete=models.CASCADE)
    content    = models.CharField(max_length=3000, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    like_count = models.IntegerField(default=0)

    class Meta:
        db_table = 'posts'

class PostAttachFiles(models.Model):
    post_id   = models.ForeignKey('Post', on_delete=models.CASCADE)
    file_type = models.CharField(max_length=200)
    path      = models.URLField(max_length=2000)

    class Meta:
        db_table = 'post_attach_files'

class Comment(models.Model):
    post_id    = models.ForeignKey('Post', on_delete=models.CASCADE)
    user_id    = models.ForeignKey('users.User', on_delete=models.CASCADE)
    comment_id = models.ForeignKey('Comment', on_delete=models.CASCADE, null=True)
    content    = models.CharField(max_length=2000)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'comments'

class Like(models.Model):
    post_id      = models.ForeignKey('Post', on_delete=models.CASCADE, null=True)
    user_id      = models.ForeignKey('users.User', on_delete=models.CASCADE)
    comment_id   = models.ForeignKey('Comment', on_delete=models.CASCADE, null=True)

    class Meta:
        db_table = 'likes'

class PostRead(models.Model):
    post_id = models.ForeignKey('Post', on_delete=models.CASCADE)
    user_id = models.ForeignKey('users.User', on_delete=models.CASCADE)

    class Meta:
        db_table = 'post_reads'