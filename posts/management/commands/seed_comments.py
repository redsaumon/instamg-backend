import random

from django.core.management.base import BaseCommand
from django_seed                 import Seed
from faker                       import Faker

from users.models                import User
from posts.models                import Comment, Post


class Command(BaseCommand):

    help = 'This command creates comments'
    
    def add_arguments(self, parser):
        parser.add_argument(
            '--number', default=1, type=int, help='how many comments do you want to create?'
        )

    def handle(self, *args, **options):
        number = options.get('number')
        seeder = Seed.seeder()
        fake   = Faker()
        user   = User.objects.all()
        post   = Post.objects.all()

        seeder.add_entity(Comment, number, {
            'content'    : lambda x : fake.sentence(),
            'comment_id' : None,
            'post_id'    : lambda x : random.choice(post),
            'user_id'    : lambda x : random.choice(user),
        })
        seeder.execute()

        self.stdout.write(self.style.SUCCESS(f'{number} comments created!'))