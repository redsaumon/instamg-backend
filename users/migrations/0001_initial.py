# Generated by Django 3.1.4 on 2021-02-24 05:57

from django.db import migrations, models
import django.db.models.deletion
import imagekit.models.fields


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('stories', '0001_initial'),
        ('posts', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Follow',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'follows',
            },
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('account', models.CharField(max_length=100)),
                ('password', models.CharField(max_length=2000)),
                ('phone', models.CharField(max_length=100, null=True)),
                ('email', models.EmailField(max_length=130, null=True)),
                ('profile_photo', models.ImageField(null=True, upload_to='files/%Y%m%d')),
                ('thumbnail_path', imagekit.models.fields.ProcessedImageField(null=True, upload_to='thumbnail')),
                ('profile_message', models.CharField(max_length=5000, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('follow', models.ManyToManyField(related_name='_user_follow_+', through='users.Follow', to='users.User')),
            ],
            options={
                'db_table': 'users',
            },
        ),
        migrations.CreateModel(
            name='TaggedUser',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('comment_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='posts.comment')),
                ('post_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='posts.post')),
                ('story_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='stories.story')),
                ('user_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='users.user')),
            ],
            options={
                'db_table': 'tagged_users',
            },
        ),
        migrations.AddField(
            model_name='follow',
            name='followed_user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='following', to='users.user'),
        ),
        migrations.AddField(
            model_name='follow',
            name='follower_user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='follower', to='users.user'),
        ),
    ]
