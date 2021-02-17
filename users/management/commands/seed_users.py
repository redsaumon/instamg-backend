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

        def name_generator():
            for i in range(number):
                account = fake.first_name()
                if not User.objects.filter(account=account).exists():
                    yield account

        seeder.add_entity(User, number, {
            'account'         : lambda x : random.choice([account for account in name_generator()]),
            'password'        : bcrypt.hashpw('testtest'.encode(), bcrypt.gensalt()).decode(),
            'phone'           : lambda x : fake.phone_number(),
            'email'           : lambda x : fake.email(),
            'profile_photo'   : None,
            'profile_message' : lambda x : fake.sentence()
        })
        seeder.execute()
        self.stdout.write(self.style.SUCCESS(f'{number} users created!'))