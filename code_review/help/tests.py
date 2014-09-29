from django.test import TestCase

from django.contrib.auth.models import User, Group
from django.db.models.base import ObjectDoesNotExist
from review.models import *
from review.helpers import *
from help.models import *

from django.test import LiveServerTestCase
from selenium.webdriver.firefox import webdriver


class PostTest(TestCase):
    fixtures = ['fixtures/dump.json']

    def setUp(self):
        ru = ReviewUser.objects.get(id=1)
        c = Course.objects.get(course_code="ABCD1234")
        p = Post.objects.create(course_code=c,
                                by=ru,
                                title="Default",
                                question="Test question",
                                submission_repository="https://github.com/avadendas/public_test_repo.git"
        )
    
    def test_pass(self):
        self.assertTrue(True)

    def test_post_creation(self):
        c = Course.objects.get(course_code="ABCD1234")
        ru = ReviewUser.objects.get(id=1)
        p = Post.objects.create(course_code=c,
                                by=ru,
                                title="Test",
                                question="Test question",
                                submission_repository="https://github.com/avadendas/public_test_repo.git"
        )
        p.save()

        self.assertIn(p, Post.objects.all())
        
    def test_post_creation_with_invalid_user(self):
        error = False
        try:
            
            ru = User.objects.get(username="DOesn't exit").reviewuser
            c = Course.objects.get(course_code="ABCD1234")
            p = Post.objects.create(course_code=c,
                                    by=ru,
                                    title="Test",
                                    question="Test question",
                                    submission_repository="https://github.com/avadendas/public_test_repo.git"
            )
            p.save()
        except User.DoesNotExist:
            error = True

        self.assertTrue(error)

    def test_post_creation_with_invalid_title_question(self):
        # TODO alter 
        ru = ReviewUser.objects.get(id=1)
        c = Course.objects.get(course_code="ABCD1234")
        p = Post.objects.create(course_code=c,
                                by=ru,
                                title="",
                                question="",
                                submission_repository="https://github.com/avadendas/public_test_repo.git"
        )
        p.save()

    def test_post_deletion(self):

        p = Post.objects.get(title="Default")
        p.delete()

        self.assertNotIn(p, Post.objects.all())

    def test_post_deletion_invalid_post(self):
        error = False
        try:
            p = Post.objects.get(title="I dont exist")

        except Post.DoesNotExist:
            error = True
            
        self.assertTrue(error)

    def test_editing_post(self):

        
        p = Post.objects.get(title="Default")
        p.title = "Changed"
        p.save()

        self.assertTrue(Post.objects.get(title="changed"))

