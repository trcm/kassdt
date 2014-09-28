'''
Tests for models. 
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

'''
All these guys don't really have any methods that are worth testing...
'''
class SourceFolderTest(TestCase):
    pass

class SourceFileTest(TestCase):
    pass

class AssignmentTest(TestCase):
    pass

class AssignmentSubmissionTest(TestCase):
    pass

class AssignmentReviewTest(TestCase):
    '''Test the AssignmentReview model and its methods.
       
       Notes: 
         - Only created when course admin goes to the assign_review
           page to assign reviews 
         - all methods require an instance of AssignmentReview. 
    '''

    def setUp(self):
        # Assign the reviews. 
        pass
    
    def tearDown(self):
        # Destroy the submissions 
        # I think Django does this for you maybe? 
        pass

    def test_submissionsAnnotations(self):
        '''Check:
                - Check the number of submissions assigned matches 
                  what's stored in Assignment (this is then also a test of 
                  whether assign_reviews worked properly... ew dependencies)
                - Check whether each submission has the correct number of 
                  associated annotations (again really a test of whether all
                  the other methods work rather than whether or not this one 
                  works...)
        '''
        pass

    def test_numAnnotations_normal(self):
        '''Check:
                - For each submission associated with this AssignmentReview,
                 return correct number of annotations 
                
                NB even if the submission is not associated with this AssignmentReview
                method will still return correct number of annotations.
                However, this is not the intended use of this method so we will not
                test that. 
        '''
        pass
    
    def test_numReviewsRemaining_allRemain(self):
        '''Check that when there are no annotations on any of the submissions,
           the number of remaining reviews is the total number of reviews assigned.
        '''
        pass

    def test_numReviewsRemaining_nonRemain(self):
        '''Once all reviews are complete, return 0'''
        pass

    def test_numReviewsRemaining_someRemain(self):
        '''When only some reviews are done, return correct number.'''

        pass

