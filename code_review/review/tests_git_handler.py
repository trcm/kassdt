'''
Tests for git handler. Strictly speaking not really unit tests but 
they're still tests so who cares.
'''
from django.test import TestCase

from django.contrib.auth.models import User, Group
from django.db.models.base import ObjectDoesNotExist
from review.models import *
from django.conf import settings 

import os
import os.path
import sys 

from git_handler import *
from git import *
from time import strftime

class RepoTests(TestCase):
    def test_pass(self):
        pass

    def test_public_populate_db(self):
        # Get the Repo object
        url = "https://github.com/avadendas/public_test_repo.git"
        # Needed for call to populate_db
        relDir = os.path.join("githandler_test", strftime("%Y-%m-%d_%H:%M:%S"))
        directory = os.path.join(settings.MEDIA_ROOT, relDir)
        
        # Create some fake assignments 
        user = User.objects.create_user('Alex')
        user = ReviewUser.objects.create(djangoUser=user)
        course = Course.objects.create(course_code='TEST1234')
        asmt = Assignment.objects.create(course_code=course, name='TestAsmt', submission_close_date=timezone.now(), review_close_date=timezone.now())
        sub = AssignmentSubmission.objects.create(by=user, submission_for=asmt)
        sub.submission_repository = url

        # Do it! 
        populate_db(sub, relDir)
