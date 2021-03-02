from django.db import models
from imagekit.models     import ProcessedImageField
from imagekit.processors import ResizeToFit

class DirectMessage(models.Model):
    send_user_id     = models.ForeignKey('users.User', on_delete=models.CASCADE, related_name='send_user')
    received_user_id = models.ForeignKey('users.User', on_delete=models.CASCADE, related_name='received_user')
    content          = models.CharField(max_length=2000)
    created_at       = models.DateTimeField(auto_now_add=True)
    is_read          = models.BooleanField(default=0)

    def __str__(self):
        return self.send_user_id.account

    def last_10_messages(self):
        return DirectMessage.objects.order_by('-timestamp').all()[:10]

    class Meta:
        db_table = 'direct_messages'

class DirectMessageAttachFiles(models.Model):
    direct_message_id = models.ForeignKey('DirectMessage', on_delete=models.CASCADE)
    user_id           = models.ForeignKey('users.User', on_delete=models.CASCADE)
    file_type         = models.CharField(max_length=100)
    path              = models.ImageField(upload_to='files/%Y%m%d')
    thumbnail_path    = ProcessedImageField(
        upload_to='thumbnail',
        processors=[ResizeToFit(width=614, upscale=False)],
        options={'quality': 100}
    )

    class Meta:
        db_table = 'direct_message_attach_files'