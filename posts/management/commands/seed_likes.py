import random

from django.core.management.base import BaseCommand
from django_seed                 import Seed
from faker                       import Faker

from users.models                import User
from posts.models                import Comment, Post, Like


class Command(BaseCommand):

    help = 'This command creates likes'
    
    def add_arguments(self, parser):
        parser.add_argument(
            '--number', default=1, type=int, help='how many likes do you want to create?'
        )

    def handle(self, *args, **options):
        number   = options.get('number')
        seeder   = Seed.seeder()
        users    = User.objects.all()
        posts    = Post.objects.all()
        comments = Comment.objects.all()

        for i in range(number):
            user    = random.choice(users)
            post    = random.choice(posts)
            comment = random.choice(comments)

            if not Like.objects.filter(user_id=user.id).exists():
                Like.objects.create(
                    comment_id = Comment.objects.get(id=comment.id),
                    post_id    = Post.objects.get(id=post.id),
                    user_id    = User.objects.get(id=user.id)
                )

        self.stdout.write(self.style.SUCCESS(f'{number} likes created!'))