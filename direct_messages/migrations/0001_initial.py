# Generated by Django 3.1.4 on 2021-02-17 01:45

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='DirectMessage',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.CharField(max_length=2000)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('is_read', models.BooleanField(default=0)),
                ('received_user_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='received_user', to='users.user')),
                ('send_user_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='send_user', to='users.user')),
            ],
            options={
                'db_table': 'direct_messages',
            },
        ),
        migrations.CreateModel(
            name='DirectMessageAttachFiles',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('file_type', models.CharField(max_length=100)),
                ('path', models.URLField(max_length=2000)),
                ('direct_message_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='direct_messages.directmessage')),
                ('user_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='users.user')),
            ],
            options={
                'db_table': 'direct_message_attach_files',
            },
        ),
    ]
