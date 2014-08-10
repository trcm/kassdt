from django.test import TestCase

from django.contrib.auth.models import User, Group
from review.models import *

def setup_group(self):
    Group.objects.create(name='student')

def setup_user(self):
        
    username = "test"
    password = "test"
    newUser = User.objects.create(username=username, password=password)
    # newUser
    newUser.groups.add(Group.objects.get(name='student'))
    newUser.save()
    
# class ReviewTest(TestCase):
    

    
class UserTests(TestCase):
    
    def test_user_is_a_student(self):
        setup_group(self)
        setup_user(self)
        user = User.objects.get(username='test')
        group = Group.objects.get(name='student')
        self.assertIn(group, user.groups.all())
        
        # self.assertIn(Group.objects.get(name='student'), User.objects.get(username='student').groups.all())

