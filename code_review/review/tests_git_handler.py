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
    def setUp(self):
        # Create some fake assignments 
        self.user = User.objects.create_user('Alex')
        self.user = ReviewUser.objects.create(djangoUser=self.user)
        self.course = Course.objects.create(course_code='TEST1234')
        self.asmt = Assignment.objects.create(course_code=self.course, name='TestAsmt', submission_close_date=timezone.now(), review_close_date=timezone.now())
        self.sub = AssignmentSubmission.objects.create(by=self.user, submission_for=self.asmt)
    
    def test_clone(self):
        '''Not necessary?'''
        pass 

    def test_root_folder_name(self):
        '''Test that the root folder name is of the form 
        userID_Year-month-day_hour-minute-seconds
        '''
        pass 

    def test_add_source_folder(self):
        '''Not necessary?'''
        pass

    def test_add_source_file(self):
        '''Also possibly not necessary'''
        pass 

    def test_traverse_tree(self):
        '''Test that the database is updated correctly after cloning.
        I.e., check that the folder structures all match.
        '''
        pass 

    '''
        Test precondition: ssh has been setup correctly.
        Which really means this test is pretty meaningless, because the problems are
        going to happen with ssh not being set up correctly.
    '''
    def test_private_populate_db(self):
        url = "git@github.com:avadendas/private_test_repo.git"
        sub = self.sub
        sub.submission_repository = url
        
        # Get the Repo object
        rootFolder = "githandler_test"
        studentRepo = root_folder_name(sub)

        # Needed for call to populate_db
        relDir = os.path.join(rootFolder, strftime("%Y-%m-%d_%H:%M:%S"))
        directory = os.path.join(settings.MEDIA_ROOT, relDir)

        # Do it! 
        populate_db(sub, relDir)

        # Now check the directory structure is all good.
        folders = SourceFolder.objects.all()
        
        # Check that folders have all been created and have correct names
        self.assertEqual(len(folders), 4)
        # Because the folder name involves time (down to the second)
        # at which it was created, we can't be sure that it'll match;
        # for our purposes it is sufficient that the username part matches.
        # ind = studentRepo.find('_')
        # studentRepo = studentRepo[:ind]
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
        self.assertEqual(repr(file1.file), '<FieldFile: ' + dir + '/folder1/folder1_testfile.txt>') 
        self.assertEqual(file1.folder, folders[1])
        
        file2 = files[1]
        self.assertEqual(file2.name, 'folder1-sub-testfile.py')
        self.assertEqual(file2.folder, folders[2])
        
        file3 = files[2]
        self.assertEqual(file3.name, 'folder2_testfile.py')
        self.assertEqual(file3.folder, folders[3])
        
    def test_public_populate_db(self):
        # Create some fake assignments 
        url = "https://github.com/avadendas/public_test_repo.git"
        sub = self.sub
        sub.submission_repository = url
        
        # Get the Repo object
        rootFolder = "githandler_test"
        studentRepo = root_folder_name(sub)
        
        # Needed for call to populate_db
        relDir = os.path.join(rootFolder, strftime("%Y-%m-%d_%H:%M:%S"))
        directory = os.path.join(settings.MEDIA_ROOT, relDir)
        
        # Do it! 
        populate_db(sub, relDir)

        # Now check the directory structure is all good.
        folders = SourceFolder.objects.all()
        
        # Check that folders have all been created and have correct names
        self.assertEqual(len(folders), 4)
        # Repo name involves the time of folder creation so won't match; 
        # Truncate so that we only have the username part of it.
        # ind = studentRepo.find('_')
        # studentRepo = studentRepo[:ind]
        # In fact because code executes quickly, times are usu. the same.
        
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
        self.assertEqual(len(files), 4)
        
        file0 = files[0]
        self.assertEqual(file0.name, 'rootfile.txt')
        # Make sure file was in root directory
        self.assertEqual(file0.folder.name, studentRepo)

        file1 = files[1]
        self.assertEqual(file1.name, 'folder1_testfile.txt')
        dir = os.path.join(relDir, studentRepo)
        self.assertEqual(repr(file1.file), '<FieldFile: ' + dir + '/folder1/folder1_testfile.txt>') 
        self.assertEqual(file1.folder, folders[1])
        
        file2 = files[2]
        self.assertEqual(file2.name, 'folder1-sub-testfile.py')
        self.assertEqual(file2.folder, folders[2])
        
        file3 = files[3]
        self.assertEqual(file3.name, 'folder2_testfile.py')
        self.assertEqual(file3.folder, folders[3])
