import random
import bcrypt

from django.core.management.base import BaseCommand
from django_seed                 import Seed
from faker                       import Faker

from users.models                import User


class Command(BaseCommand):

    help = 'This command creates users'
    
    def add_arguments(self, parser):
        parser.add_argument(
            '--number', default=1, type=int, help='how many users do you want to create?'
        )

    def handle(self, *args, **options):
        number  = options.get('number')
        fake    = Faker()
        seeder  = Seed.seeder()

        seeder.add_entity(User, number, {
            'name'            : lambda x : fake.first_name(),
            'password'        : bcrypt.hashpw('testtest'.encode(), bcrypt.gensalt()).decode(),
            'phone'           : lambda x : fake.phone_number(),
            'email'           : lambda x : fake.email(),
            'profile_photo'   : None,
            'profile_message' : lambda x : fake.sentence()
        })
        seeder.execute()
        self.stdout.write(self.style.SUCCESS(f'{number} users created!'))