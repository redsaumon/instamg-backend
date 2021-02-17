# Generated by Django 3.1.4 on 2021-02-17 00:30

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Story',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('story_profile', models.BooleanField(default=0)),
                ('title', models.CharField(default=None, max_length=100)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'db_table': 'stories',
            },
        ),
        migrations.CreateModel(
            name='StoryAttachFiles',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('file_type', models.CharField(max_length=2000)),
                ('path', models.CharField(max_length=1024)),
            ],
            options={
                'db_table': 'story_attach_files',
            },
        ),
        migrations.CreateModel(
            name='StoryRead',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('story_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='stories.story')),
            ],
            options={
                'db_table': 'story_reads',
            },
        ),
    ]
