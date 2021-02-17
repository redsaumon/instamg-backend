import json

from pytz              import utc
from django.views      import View
from django.http       import JsonResponse
from django.db         import transaction
from datetime          import datetime

from decorators        import login_check
from stories.models    import Story
from users.models      import User, Follow
from .models           import Post, PostAttachFiles, Comment, Like, PostRead

class PostView(View):
    @login_check
    @transaction.atomic
    def post(self, request):
        try:
            data  = json.loads(request.POST['json'])
            user  = request.user
            video = ['m4v', 'avi','mpg','mp4', 'webm']
            image = ['jpg', 'gif', 'bmp', 'png', 'jpeg']

            Post.objects.create(
                user_id = user,
                content = data['content']
            )
            
            for path in request.FILES.getlist('path'):
                if str(path).split('.')[-1] in video:
                    file_type = "video"
                else:
                    file_type = "image"
                PostAttachFiles.objects.create(
                post_id        = Post.objects.last(),
                file_type      = file_type,
                path           = path,
                thumbnail_path = path
            )

            return JsonResponse({'message':'SUCCESS'}, status=201)
        except ValueError:
            return JsonResponse({'message':'VALUE_ERROR'}, status=400)


# post 상세 조회 - 정민님 파트, 추후 추가 필요
class PostDetailView(View):
    def get(self, request, post_id): 
        try:
            post       = Post.objects.filter(id=post_id).prefetch_related('post_attach_files')[0]
            post_list = [{   
                    'user_id'       : post.user_id.id,
                    'account'       : post.user_id.account,
                    'content'       : post.content,
                    'profile_photo' : post.user_id.profile_photo,
                    'like_count'    : post.like_count,
                    'created_at'    : post.created_at,
                    'file'          :[{
                                    'file_type'      : post_attach_file.file_type,
                                    'path'           : "/media/"+str(post_attach_file.path),
                                    'thumbnail_path' : "/media/"+str(post_attach_file.thumbnail_path)
                    }for post_attach_file in post.post_attach_files.all()]
            }]

            return JsonResponse({'post':post_list}, status=200)
        except ValueError:
            return JsonResponse({'message':'VALUE_ERROR'}, status=400)
        except IndexError:
            return JsonResponse({'message':'POST_DOES_NOT_EXIST'}, status=400)


# 게시물 전체 조회
class PostReadView(View):
    @login_check
    def get(self, request):
        try:
            user      = request.user
            following = Follow.objects.filter(follower_user_id=user)
            #이미 읽은 post, story 받아서 조회할 때 이미 읽은 애들 빼기
            post_list = [[{ 
                    'post_id'        : post.id,
                    'user_id'        : post.user_id.id,
                    'account'        : post.user_id.account,
                    'content'        : post.content,
                    'profile_photo'  : post.user_id.profile_photo,
                    'like_count'     : post.like_count,
                    'is_liked'       : post.likes.filter(user_id=user, comment_id=None).exists(),
                    'total_comments' : post.comments.all().count(),
                    'comments'       : [{
                                        'comment_id': comment.id,
                                        'user'      : comment.user_id.account,
                                        'content'   : comment.content,
                                        'is_liked'  : comment.likes.exists()
                                        } for comment in post.comments.all()[:2]],
                    'created_at'     : post.created_at,
                    'file'           :[{
                                        'file_type'      : post_attach_file.file_type,
                                        'path'           : "/media/"+str(post_attach_file.path),
                                        'thumbnail_path' : "/media/"+str(post_attach_file.thumbnail_path)
                                        }for post_attach_file in post.post_attach_files.all()]
                } for post in Post.objects.filter(user_id=follow.followed_user_id).prefetch_related('post_attach_files','likes')]
                # follow한 사람 중 게시물 0인 사람은 [] 빈 배열이 넘어가버림. comprehension 안에서 조건문, continue 사용 불가
            for follow in following]

            return JsonResponse({'feed':post_list}, status=200)
        except ValueError:
            return JsonResponse({'message':'VALUE_ERROR'}, status=400)
        except IndexError:
            return JsonResponse({'message':'POST_DOES_NOT_EXIST'}, status=400)

                        
# 게시물 스토리
class PostStoryView(View):
    @login_check
    def get(self,request):
            try:
                following = Follow.objects.filter(follower_user_id=request.user)
                now = utc.localize(datetime.utcnow())

                story_list = [[{
                'story_id'     : story.id,
                'user_id'      : story.user_id.id,
                'user_account' : story.user_id.account,
                'profile_photo': story.user_id.profile_photo,
                } for story in Story.objects.filter(user_id=follow.followed_user_id).prefetch_related('story_attach_files') if 'days' not in str(now - story.created_at) and int(str(now - story.created_at).split(':')[0]) < 24 ]
                for follow in following]
                
                user_dict = {
                    'user_id'       : request.user.id,
                    'account'       : request.user.account,
                    'profile_photo' : request.user.profile_photo
                }

                story_list.append(user_dict)

                return JsonResponse({'stories':story_list}, status=200)
            
            except KeyError:
                return JsonResponse({'message':'KEY_ERROR'}, status=400)


# 댓글, 대댓글 조회
class PostCommentView(View):
    @login_check
    def get(self, request, post_id):
        try:
            post = Post.objects.filter(id=post_id).prefetch_related('comments')[0]
            comments_list=[{
                'comment_id'                 : comment.id,
                'content'                    : comment.content,
                'comment_user_id'            : comment.user_id.id,
                'comment_user_profile_photo' : comment.user_id.profile_photo,
                'created_at'                 : comment.created_at,
                'is_liked'                   : comment.likes.exists(),
                'recomment'                  :[{
                                        'recomment_id'                 :recomment.id,
                                        'content'                      : recomment.content,
                                        'recomment_user_id'            : recomment.user_id.id,
                                        'recomment_user_profile_photo' : recomment.user_id.profile_photo,
                                        'created_at'                   : recomment.created_at,
                                        'is_liked'                     : comment.likes.exists()

                } for recomment in Comment.objects.filter(comment_id=comment.id)]
            } for comment in post.comments.all()]
            return JsonResponse({'comment':comments_list}, status=200)

        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)


# 게시물 삭제
class PostDeleteView(View):    
    @login_check
    def delete(self, request, post_id):
        try:
            post              = Post.objects.get(id=post_id)
            post_attach_files = post.postattachfiles_set.all()

            if post.user_id.id == request.user.id:
                post_attach_files.delete()
                post.delete()
                return JsonResponse({'message':'SUCCESS'}, status=200)
            else:
                return JsonResponse({'message':'NO_PERMISSION'}, status=403)
        except Post.DoesNotExist:
            return JsonResponse({"message":'POST_DOES_NOT_EXIST'}, status=400)

# # 게시물 수정
# class PostUpdateView(View):
#     @login_check
#     def put(self, request, post_id):
#         try:
#             data          = json.loads(request.body)
#             post_querySet = Post.objects.filter(id=post_id)
#             post          = post_querySet[0]
#             user          = request.user
#             new_image     = data['image']
#             image         = post.image_set.all()

#             if post.user.id == user.id:
#                 image.update(image=new_image)
#                 return JsonResponse({'message':'게시물 수정 완료'}, status=200)
#             else:
#                 return JsonResponse({'message':'권한이 없습니다.'}, status=403)
                
#         except Post.DoesNotExist:
#             return JsonResponse({"message":'해당하는 게시물이 없습니다.'}, status=400)


# # 댓글 작성, 조회
# class CommentView(View):
#     @login_check
#     def post(self, request, post_id):
#         try:
#             data      = json.loads(request.body)

#             Comment(
#                 post      = Post.objects.get(id=post_id),
#                 user      = request.user,
#                 content   = data['content']
#             ).save()

#             return JsonResponse({'message':'SUCCESS'}, status=201)

#         except KeyError:
#             return JsonResponse({'message':'KEY_ERROR'}, status=400)
#         except Post.DoesNotExist :
#             return JsonResponse({'message':'해당하는 게시물이 없습니다.'}, status=400)
       
#     def get(self, request, post_id): # post 출력 따로 comment 출력 따로..?
#         post     = Post.objects.get(id=post_id)
#         user     = post.user.account
#         comments = post.comment_set.all()
#         pub_date = post.pub_date

#         if comments.count() == 0:
#             return JsonResponse({'message':'댓글이 없는 게시물입니다.'}, status=400)

#         contents_list = []
#         for index, comment in enumerate(comments):
#             print(comment.user.id)
#             contents_dict = {
#                 'content '+ str(index+1) : comment.content,
#                 'writer_id'              : comment.user.id
#             }
#             contents_list.append(contents_dict)

#         comment_dict = {
#             'post_id'  : post.id,
#             'user'     : user,
#             'contents' : contents_list,
#             'pub_date' : pub_date 
#         }

#         return JsonResponse({'comment':comment_dict}, status=200)

# # 댓글 삭제
# class CommentDeleteView(View):
#     @login_check
#     def delete(self, request, post_id, comment_id):
#         try:
#             data    = json.loads(request.body)
#             user    = request.user
#             post    = Post.objects.get(id=post_id)
#             comment = post.comment_set.get(id=comment_id) # post 테이블에 oneToManyField 달아줘야할까?

#             if comment.user.id == user.id:
#                 comment.delete()
#                 return JsonResponse({'message':'댓글 삭제 완료'}, status=200)
#             return JsonResponse({'message':'권한이 없습니다.'}, status=403)

#         except Post.DoesNotExist:
#             return JsonResponse({'message':'해당하는 게시물이 없습니다.'}, status=400) 
#         except Comment.DoesNotExist:
#             return JsonResponse({'message':'해당하는 댓글이 없습니다.'}, status=400) 

# # 좋아요 하기
# class LikeView(View):
#     @login_check
#     def post(self, request, post_id):
#         try:
#             data          = json.loads(request.body)
#             post_querySet = Post.objects.filter(id=post_id)
#             post          = post_querySet[0]
#             user          = request.user

#             if Like.objects.filter(post=post_id): # 좋아요 테이블에 있는 게시물일 때
#                 if Like.objects.filter(post=post_id, user=user.id):
#                     post.likes -= 1
#                     like = Like.objects.filter(post=post_id, user=user.id)
#                     like.delete()
#                 else:
#                     post.likes += 1
#             else:
#                 Like.objects.create(post=post, user=user)
#                 post.likes += 1

#             post_likes = Like.objects.filter(post=post_id).count()
#             post_querySet.update(likes = post_likes)

#             return JsonResponse({'message':'SUCCESS'}, status=201)

#         except KeyError:
#             return JsonResponse({'message':'KEY_ERROR'}, status=400)
#         except IndexError :
#             return JsonResponse({'message':'해당하는 게시물이 없습니다.'}, status=400)      

# # 대댓글 달기
# class RecommentView(View):
#     @login_check
#     def post(self, request, post_id, comment_id):
#         try:
#             data     = json.loads(request.body)
#             comments = Comment.objects.filter(post=post_id)
#             for comment in comments:
#                 if comment.id == comment_id:
#                     Recomment(
#                         post      = Post.objects.get(id=post_id),
#                         user      = request.user,
#                         comment   = Comment.objects.get(id=comment_id),
#                         content   = data['content']
#                     ).save()
#                     return JsonResponse({'message':'SUCCESS'}, status=201)
    
#             return JsonResponse({'message':'해당하는 댓글이 없습니다.'}, status=400)

#         except KeyError:
#             return JsonResponse({'message':'KEY_ERROR'}, status=400)
#         except Comment.DoesNotExist :
#            return JsonResponse({'message':'해당하는 게시물이 없습니다.'}, status=400)