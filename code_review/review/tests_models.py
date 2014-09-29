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
    
    fixtures = ['assignmentreview_assigned']

    def setUp(self):
        # Assign the reviews. 
        self.course = Course.objects.get(pk=1)
        self.asmt = Assignment.objects.get(course_code=self.course, name="ASMT1")

        # Get everyone who does course ABCD1234.
        # PRECOND: they have all made at least one submission to ASMT1
        self.users = ReviewUser.objects.filter(courses=self.course)
    
    def tearDown(self):
        # Destroy the submissions 
        # I think Django does this for you maybe? 
        pass

    def test_submissionsAnnotations(self):
        '''Check:
                - Check the number of submissions assigned matches 
                  what's stored in Assignment (we use a fixture which has all
                  the right data, so we don't need assign_review working)
                - Check whether each submission has the correct number of 
                  associated annotations (should be zero at this stage)
        '''
        # Assume fixture working, 5 students submitted and everyone assigned
        # to do 3 reviews.
        allAsmtRevs = AssignmentReview.objects.all()
        self.assertEqual(len(allAsmtRevs), 5)
        self.assertEqual(len(self.users), 9)
        # For each user, check they've been assigned to do 3 
        # And that they've done no annotations so far PRECOND fixture assures.
        failures = 0

        for user in self.users:
            if(user.djangoUser.is_staff or user.djangoUser.is_superuser):
                print("%s is staff." %(user))
                continue 
            
            # Get the {submission: numAnnotations} dictionary
            asmtRev = AssignmentReview.objects.get(assignment=self.asmt, by=user)
            subAnn = AssignmentReview.submissionsAnnotations(asmtRev)
            self.assertEqual(len(subAnn), 3)
            
            # Check nobody has done any annotations 
            for sub in subAnn:
                self.assertEqual(subAnn[sub], 0)

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

