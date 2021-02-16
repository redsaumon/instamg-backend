from django.db    import models


class Story(models.Model):
    user_id       = models.ForeignKey('users.User', on_delete=models.CASCADE)
    story_profile = models.BooleanField(default=0)
    created_at    = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'stories'


class StoryAttachFiles(models.Model):
    story_id  = models.ForeignKey('Story', on_delete=models.CASCADE)
    file_type = models.CharField(max_length=2000)
    path      = models.CharField(max_length=1024)

    class Meta:
        db_table = 'story_attach_files'


class StoryRead(models.Model):
    user_id  = models.ForeignKey('users.User', on_delete=models.CASCADE)
    story_id = models.ForeignKey('Story', on_delete=models.CASCADE)

    class Meta:
        db_table = 'story_reads'