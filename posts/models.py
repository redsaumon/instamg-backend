from django.db           import models
from imagekit.models     import ProcessedImageField
from imagekit.processors import ResizeToFit


class Post(models.Model):
    user_id    = models.ForeignKey('users.User', on_delete=models.CASCADE)
    content    = models.CharField(max_length=3000, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    like_count = models.IntegerField(default=0)

    class Meta:
        db_table = 'posts'

class PostAttachFiles(models.Model):
    post_id        = models.ForeignKey('Post', on_delete=models.CASCADE, related_name='post_attach_files')
    view_count     = models.IntegerField(default=0)
    file_type      = models.CharField(max_length=100)
    path           = models.ImageField(upload_to='files/%Y%m%d')
    thumbnail_path = ProcessedImageField(
        upload_to='thumbnail',
        processors=[ResizeToFit(width=614, upscale=False)],
        options={'quality': 100}
    )

    class Meta:
        db_table = 'post_attach_files'

class Comment(models.Model):
    post_id    = models.ForeignKey('Post', on_delete=models.CASCADE, related_name='comments')
    user_id    = models.ForeignKey('users.User', on_delete=models.CASCADE)
    comment_id = models.ForeignKey('Comment', on_delete=models.CASCADE, null=True)
    content    = models.CharField(max_length=2000)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'comments'

class Like(models.Model):
    post_id    = models.ForeignKey('Post', on_delete=models.CASCADE, null=True, related_name='likes')
    user_id    = models.ForeignKey('users.User', on_delete=models.CASCADE)
    comment_id = models.ForeignKey('Comment', on_delete=models.CASCADE, null=True, related_name='likes')

    class Meta:
        db_table = 'likes'

class PostRead(models.Model):
    post_id = models.ForeignKey('Post', on_delete=models.CASCADE)
    user_id = models.ForeignKey('users.User', on_delete=models.CASCADE)

    class Meta:
        db_table = 'post_reads'