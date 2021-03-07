import json
import subprocess

from pytz         import utc
from django.views import View
from django.http  import JsonResponse
from django.db    import transaction
from datetime     import datetime

from users.models import User, Follow
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

# 개인프로필에 저장한 스토리보기
class ProfileStoryView(View):
    def get(self, request, user_id):
        try:
            user    = User.objects.get(id = user_id)
            stories = []
            for story in user.story_set.all():
                if story.story_profile==1:
                    for files in story.story_attach_files.all():
                        stories.append({
                            "story_id"       : story.id,
                            "title"          : story.title,
                            "created_at"     : story.created_at.astimezone(timezone('Asia/Seoul')),
                            "thumbnail_path" : str(files.thumbnail_path),
                            "path"           : "media/"+str(files.path),
                            "file_type"      : files.file_type
                        })
            return JsonResponse({"profile_story" : stories}, status=200)
        except KeyError:
            return JsonResponse({"message" : "KEY_ERROR"}, status=400)

# 메인리스트에서 스토리 조회
class StoryListView(View):
    @login_check
    def get(self, request):
        try:
            login_user = request.user
            following  = Follow.objects.filter(follower_user_id=login_user.id)
            now        = utc.localize(datetime.utcnow())
            user       = [{
                    'user_id'       : request.user.id,
                    'user_account'  : request.user.account,
                    'profile_photo' : 'media/'+str(request.user.thumbnail_path) if str(request.user.thumbnail_path) else None,
            }]
            story_list = [[{
                    'story_id'     : story.id,
                    'story_title'  : story.title,
                    'created_at'   : story.created_at,
                    'user_id'      : story.user_id.id,
                    'user_account' : story.user_id.account,
                    'profile_photo': 'media/'+str(story.user_id.thumbnail_path) if str(story.user_id.thumbnail_path) else None,
                    'files' : [{
                        'file_type'      : story_file.file_type,
                        'path'           : 'media/'+str(story_file.path),
                        'thumbnail_path' : str(story_file.thumbnail_path),
                    }for story_file in story.story_attach_files.all()]
                    } for story in Story.objects.exclude(story_profile=1).filter(user_id=follow.followed_user_id).prefetch_related('story_attach_files') if 'days' not in str(now - story.created_at)]
                    for follow in following if len(Story.objects.filter(user_id=follow.followed_user_id).prefetch_related('story_attach_files')) > 0] 

            return JsonResponse({'story_list' : story_list, 'user' : user}, status=200)

        except KeyError:
            return sonResponse({'message' : 'KEY_ERROR'}, status=400)
    



