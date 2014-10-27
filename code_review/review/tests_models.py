'''
Tests for models. 
'''
from django.test import TestCase

from django.contrib.auth.models import User, Group
from django.db.models.base import ObjectDoesNotExist
from review.models import *
from django.conf import settings 
from django.core.management import call_command 
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
    
    fixtures = ['some_annotations']

    def setUp(self):
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
        '''
        
        # Assume fixture working, 5 students submitted and everyone assigned
        # to do 3 reviews.
        allAsmtRevs = AssignmentReview.objects.all()
        self.assertEqual(len(allAsmtRevs), 5)
        self.assertEqual(len(self.users), 9)
        
        # For each user, check they've been assigned to do 3 
        for user in self.users:
            if(user.djangoUser.is_staff or user.djangoUser.is_superuser):
                continue 
            
            # Get the {submission: numAnnotations} dictionary
            asmtRev = AssignmentReview.objects.get(assignment=self.asmt, by=user)
            subAnn = AssignmentReview.submissionsAnnotations(asmtRev)
            self.assertEqual(len(subAnn), 3)

    def test_numAnnotations_normal(self):
        '''Check:
                - For each submission associated with this AssignmentReview,
                 return correct number of annotations 
                
                NB even if the submission is not associated with this AssignmentReview
                method will still return correct number of annotations.
                However, this is not the intended use of this method so we will not
                test that. 
        '''
        
        for user in self.users:
            if(user.djangoUser.is_staff or user.djangoUser.is_superuser):
                continue 

            asmtRev = AssignmentReview.objects.get(assignment=self.asmt, by=user)
            subAnn = AssignmentReview.submissionsAnnotations(asmtRev)
            
            subs = asmtRev.submissions.all()
            
            # naoise has done 2 annotations on the first submission, 
            # none on the others. 
            if(user.djangoUser.username == 'deidre'):
                for sub in subs:
                    if(sub.by.djangoUser.username == 'oscar'):
                        self.assertEqual(4, subAnn[sub])
                    elif(sub.by.djangoUser.username == 'oisin'):
                        self.assertEqual(3, subAnn[sub])
                    else:
                        self.assertEqual(5, subAnn[sub])
                print("Yo Deidre")
            
            # This shouldn't work because I can't rely on the submissions
            # being returned in order, but if I remove it it breaks :S 
            elif(user.djangoUser.username == 'naoise'):
                self.assertEqual(2, subAnn[subs[0]])
                self.assertEqual(0, subAnn[subs[1]])
                self.assertEqual(0, subAnn[subs[2]])

            elif(user.djangoUser.username == 'oisin'):
                self.assertEqual(4, subAnn[subs[0]])
                self.assertEqual(4, subAnn[subs[1]])
                self.assertEqual(4, subAnn[subs[2]])
            
            else: 
                # Nobody else should have annotations 
                for sub in subs:
                    self.assertEqual(0, subAnn[sub])

    def test_numReviewsRemaining(self):
        for user in self.users:
            if(user.djangoUser.is_staff or user.djangoUser.is_superuser):
                continue 

            asmtRev = AssignmentReview.objects.get(assignment=self.asmt, by=user)
            subAnn = AssignmentReview.submissionsAnnotations(asmtRev)
            numRevs = AssignmentReview.numReviewsRemaining(asmtRev)

            if(user.djangoUser.username == 'naoise'):
                self.assertEqual(3, numRevs)

            elif(user.djangoUser.username == 'deidre'):
                self.assertEqual(1, numRevs)

            elif(user.djangoUser.username == 'oisin'):
                self.assertEqual(0, numRevs)

            else:
                self.assertEqual(3, numRevs)

