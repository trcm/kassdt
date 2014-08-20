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
        url = "https://github.com/avadendas/public_test_repo.git"
        directory = os.path.join(settings.MEDIA_ROOT, "githandler_test")
        directory = os.path.join(directory, strftime("%Y-%m-%d_%H:%M:%S"))
        repo = Repo.clone_from(url, directory)
