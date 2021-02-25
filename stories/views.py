import json
import subprocess

from django.views import View
from django.http  import JsonResponse
from django.db    import transaction

from users.models import User
from .models      import Story, StoryAttachFiles
from decorators   import login_check

class StoryView(View):
    @login_check
    @transaction.atomic
    def post(self, request):
        try:
            data  = json.loads(request.POST['json'])
            video = ['m4v', 'avi', 'mpg', 'mp4', 'webm', 'MOV'] 
            image = ['jpg', 'gif', 'bmp', 'png', 'jpeg']

            if str(request.FILES['path']).split('.')[-1] in video:
                file_type = 'video'
            else:
                file_type = 'image'

            Story(
                user_id = request.user,
                title   = data.get('title')
            ).save()

            StoryAttachFiles(
                story_id       = Story.objects.last(),
                file_type      = file_type,
                path           = request.FILES['path'],
                thumbnail_path = None
            ).save()

            story_file     = str(StoryAttachFiles.objects.last().path)
            video_path     = 'media/'+story_file
            thumbnail_path = 'media/thumbnail/'+story_file.split('/')[-1]

            subprocess.call(['ffmpeg', '-i', video_path, '-ss', '00:00:00.000', '-vframes', '1', thumbnail_path])
            
            story_file = StoryAttachFiles.objects.last()
            story_file.thumbnail_path = thumbnail_path
            story_file.save()

            return JsonResponse({'message':'SUCCESS'}, status=201)
        except ValueError:
            return JsonResponse({'message':'VALUE_ERROR'}, status=400)


class ProfileStoryView(View):
    def get(self, request, user_id):
        try:
            user    = User.objects.get(id = user_id)
            stories = []
            for story in user.story_set.all():
                print("스토리", story)
                if story.story_profile==1:
                    print(1111)
                    for files in story.story_attach_files.all():
                        print(files)
                        stories.append({
                            "story_id"       : story.id,
                            "title"          : story.title,
                            "created_at"     : story.created_at,
                            "thumbnail_path" : "/media/"+str(files.thumbnail_path),
                            "file_type"      : files.file_type
                        })
            return JsonResponse({"profile_story" : stories}, status = 200)
        except KeyError:
            return JsonResponse({"message" : "KEY_ERROR"}, status=400)


