import random

from django.core.management.base import BaseCommand
from django_seed                 import Seed
from faker                       import Faker

from users.models                import User, Follow


class Command(BaseCommand):

    help = 'This command creates followings'
    
    def add_arguments(self, parser):
        parser.add_argument(
            '--number', default=1, type=int, help='how many followings do you want to create?'
        )

    def handle(self, *args, **options):
        number = options.get('number')
        seeder = Seed.seeder()
        follow = User.objects.all()
        
        for i in range(number):
            followed = random.choice(follow)
            follower = random.choice(follow)
            if followed != follower and not Follow.objects.filter(followed_user_id=followed, follower_user_id=follower).exists(): 
                Follow.objects.create(
                    followed_user_id = followed,
                    follower_user_id = follower
                )
        
        self.stdout.write(self.style.SUCCESS(f'{number} followings created!'))