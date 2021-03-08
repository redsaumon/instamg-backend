from django.db           import models
from imagekit.models     import ProcessedImageField
from imagekit.processors import ResizeToFit


class Room(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        db_table = 'rooms'

class DirectMessage(models.Model):
    room_id     = models.ForeignKey(Room, on_delete=models.CASCADE, related_name='direct_messages')
    user_id     = models.ForeignKey('users.User', on_delete=models.CASCADE, related_name='direct_messages')
    message     = models.CharField(max_length=2000)
    created_at  = models.DateTimeField(auto_now_add=True)
    is_read     = models.BooleanField(default=0)

    class Meta:
        db_table = 'direct_messages'

class DirectMessageAttachFiles(models.Model):
    direct_message_id = models.ForeignKey('DirectMessage', on_delete=models.CASCADE)
    user_id           = models.ForeignKey('users.User', on_delete=models.CASCADE)
    file_type         = models.CharField(max_length=100)
    path              = models.ImageField(upload_to='files/%Y%m%d')
    thumbnail_path    = ProcessedImageField(
        upload_to='thumbnail',
        processors=[ResizeToFit(width=200, upscale=False)],
        options={'quality': 100}
    )

    class Meta:
        db_table = 'direct_message_attach_files'