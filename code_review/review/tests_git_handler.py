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
        rootFolder = "githandler_test"
        studentRepo ="test_student_repo"
        # Needed for call to populate_db
        relDir = os.path.join(rootFolder, strftime("%Y-%m-%d_%H:%M:%S"))
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

        # Now check the directory structure is all good.
        folders = SourceFolder.objects.all()
        
        # Check that folders have all been created and have correct names
        self.assertEqual(len(folders), 4)
        # NB this root folder (test_student_repo) will have a different name in future versions
        self.assertEqual(folders[0].name, studentRepo)
        self.assertEqual(folders[1].name, 'folder1')
        self.assertEqual(folders[2].name, 'folder1-sub')
        self.assertEqual(folders[3].name, 'folder2')
        
        # Check that subfolders are correct
        subfolder = folders[2] # this is folder1-sub
        self.assertEqual(subfolder.parent.name, 'folder1')
        self.assertEqual(subfolder.parent.parent.name, studentRepo)
        subfolder = folders[3] # this is folder2
        self.assertEqual(subfolder.parent.name, studentRepo)

        # Check all the files are correct
        files = SourceFile.objects.all()
        self.assertEqual(len(files), 3)
        file1 = files[0]

        self.assertEqual(file1.name, 'folder1_testfile.txt')
        dir = os.path.join(relDir, studentRepo)
        self.assertEqual(repr(file1.file), '<FieldFile: ' + dir + '/folder1>') 
        self.assertEqual(file1.folder, folders[1])
        
        file2 = files[1]
        self.assertEqual(file2.name, 'folder1-sub-testfile.py')
        self.assertEqual(file2.folder, folders[2])
        
        file3 = files[2]
        self.assertEqual(file3.name, 'folder2_testfile.py')
        self.assertEqual(file3.folder, folders[3])
        
       



