from django.db           import models
from imagekit.models     import ProcessedImageField
from imagekit.processors import ResizeToFit


class Story(models.Model):
    user_id       = models.ForeignKey('users.User', on_delete=models.CASCADE)
    story_profile = models.BooleanField(default=0)
    title         = models.CharField(max_length=200, null=True)
    created_at    = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'stories'


class StoryAttachFiles(models.Model):
    story_id       = models.ForeignKey('Story', on_delete=models.CASCADE, related_name='story_attach_files')
    file_type      = models.CharField(max_length=100)
    path           = models.ImageField(upload_to='files/%Y%m%d')
    thumbnail_path = ProcessedImageField(
        upload_to='thumbnail',
        processors=[ResizeToFit(width=614, upscale=False)],
        options={'quality': 100}
    )

    class Meta:
        db_table = 'story_attach_files'


class StoryRead(models.Model):
    user_id  = models.ForeignKey('users.User', on_delete=models.CASCADE)
    story_id = models.ForeignKey('Story', on_delete=models.CASCADE)

    class Meta:
        db_table = 'story_reads'