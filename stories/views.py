import json

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
            video = ['m4v', 'avi', 'mpg', 'mp4', 'webm'] 
            image = ['jpg', 'gif', 'bmp', 'png', 'jpeg']

            if str(request.FILES['path']).split('.')[-1] in video:
                file_type = 'video'
            else:
                file_type = 'image'

            Story(
                user_id = request.user,
                title = None
                #title = data['title'],
                #story_profile = data['story_profile']
            ).save()

            StoryAttachFiles(
                story_id       = Story.objects.last(),
                file_type      = file_type,
                path           = request.FILES['path'],
                thumbnail_path = request.FILES['path']
            ).save()

            return JsonResponse({'message':'SUCCESS'}, status=201)
        except ValueError:
            return JsonResponse({'message':'VALUE_ERROR'}, status=400)


class ProfileStoryView(View):
    def get(self, request, user_id):
        try:
            user    = User.objects.get(id = user_id)
            stories = []
            for story in user.story_set.all():
                if story.story_profile==1:
                    for files in story.storyattachfiles_set.all():
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


