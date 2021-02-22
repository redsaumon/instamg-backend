import json

from django.views import View
from django.http  import JsonResponse
from django.db    import transaction

from .models      import Story, StoryAttachFiles
from decorators   import login_check

class StoryView(View):
    @login_check
    @transaction.atomic
    def post(self, request):
        try:
            data  = json.loads(request.POST['json'])
            video = ['m4v', 'avi', 'mpg', 'mp4', 'webm'] 
            image = ['jpg', 'gif', 'bmp', 'png']

            if str(request.FILES['path']).split('.')[-1] in video:
                file_type = 'video'
            else:
                file_type = 'image'

            Story(
                user_id = request.user,
                title   = None
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