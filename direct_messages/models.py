from django.db import models

class DirectMessage(models.Model):
    send_user_id     = models.ForeignKey('users.User', on_delete=models.CASCADE, related_name='send_user')
    received_user_id = models.ForeignKey('users.User', on_delete=models.CASCADE, related_name='received_user')
    content          = models.CharField(max_length=2000)
    created_at       = models.DateTimeField(auto_now_add=True)
    is_read          = models.BooleanField(default=0)

    class Meta:
        db_table = 'direct_messages'

class DirectMessageAttachFiles(models.Model):
    direct_message_id = models.ForeignKey('DirectMessage', on_delete=models.CASCADE)
    user_id           = models.ForeignKey('users.User', on_delete=models.CASCADE)
    file_type         = models.CharField(max_length=100)
    path              = models.URLField(max_length=2000)

    class Meta:
        db_table = 'direct_message_attach_files'