from django.db           import models
from imagekit.models     import ProcessedImageField
from imagekit.processors import ResizeToFit


class User(models.Model):
    account         = models.CharField(max_length=100)
    password        = models.CharField(max_length=2000)
    phone           = models.CharField(max_length=100, null=True)
    email           = models.EmailField(max_length=130, null=True)
    profile_photo   = models.ImageField(upload_to='files/%Y%m%d', null=True)
    thumbnail_path  = ProcessedImageField(
        upload_to='thumbnail',
        processors=[ResizeToFit(width=168, upscale=False)],
        options={'quality': 100},
        null=True
    )
    profile_message = models.CharField(max_length=5000, null=True)
    created_at      = models.DateTimeField(auto_now_add=True)
    follow          = models.ManyToManyField('self', through='Follow', related_name='followers')

    class Meta:
        db_table = 'users'

class Follow(models.Model):
    followed_user_id = models.ForeignKey('User', on_delete=models.CASCADE, related_name='following')
    follower_user_id = models.ForeignKey('User', on_delete=models.CASCADE, related_name='follower')

    class Meta:
        db_table = 'follows'

class TaggedUser(models.Model):
    user_id    = models.ForeignKey('users.User', on_delete=models.CASCADE)
    post_id    = models.ForeignKey('posts.Post', on_delete=models.CASCADE, null=True)
    comment_id = models.ForeignKey('posts.Comment', on_delete=models.CASCADE, null=True)
    story_id   = models.ForeignKey('stories.Story', on_delete=models.CASCADE, null=True)

    class Meta:
        db_table = 'tagged_users'