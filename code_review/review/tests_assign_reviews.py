'''
Tests for the helper functions in assign_reviews.py

'''
from django.test import TestCase

from django.contrib.auth.models import User, Group
from django.db.models.base import ObjectDoesNotExist
from review.models import *
from django.conf import settings 
from review.assign_reviews import *
from django.core.exceptions import *

import os
import os.path
import sys 

from git_handler import *
from git import *
from time import strftime

class AssignReviewsTest(TestCase):
    fixtures = ['assign_reviews']

    def setUp(self):
        self.course = Course.objects.get(pk=1)
        self.asmt = Assignment.objects.get(course_code=self.course, name="ASMT1")
        self.users = ReviewUser.objects.filter(courses=self.course)
        # Assignment Submissions for this assignment
        self.subs = AssignmentSubmission.objects.filter(submission_for=self.asmt)

        # Set up for another course and its assignment
        self.comp3301 = Course.objects.get(course_code='COMP3301')
        self.operatingSys = Assignment.objects.get(course_code=self.comp3301, name='OperatingSystems')
        self.operatingSys.min_annotations = 3
        self.opSubs = AssignmentSubmission.objects.filter(submission_for=self.operatingSys)
        self.compUsers = ReviewUser.objects.filter(courses=self.comp3301)
        self.latest = get_latest(self.comp3301, self.operatingSys, self.opSubs, self.compUsers)

    def test_get_errors_too_few_subs(self):
        '''Test that if there are too few submissions, i.e., if
        number of submissions < number of reviews per student + 1 
        (the + 1 is necessary because students shouldn't be assigned
        to review their own submissions), return the appropriate
        error message.
        '''
        numSubs = len(self.subs)
        numRevs = numSubs
        err = get_errors(self.course, self.asmt, numRevs)
        expectedErr = "There are not enough submissions to be able to assign %d reviews; need %d submissions but only have %d" %(numRevs, numRevs+1, numSubs)
        self.assertEqual(expectedErr, err)

    def test_get_errors_no_errors(self):
        '''Test that a correct request returns an empty error string.
        Here correct means that the number of submissions >= 
        number of reviews per student + 1, and the number of reviews
        is positive.
        '''
        numSubs = len(self.subs)
        numRevs = max(numSubs - 1, 1)
        err = get_errors(self.course, self.asmt, numRevs)
        self.assertEqual('', err)

    def test_get_latest(self):
        '''Test that when students have submitted multiple submissions
        for an assignment, that the latest submissions are returned.
        '''
        #TODO actually check that the submissions are the latest, not just 
        # that the one was returned per user... 
        latest = get_latest(self.comp3301, self.operatingSys, self.opSubs, self.compUsers)
        self.assertEqual(len(latest), 5)

    #TODO something wrong the tests below hang forever
    def test_distribute_reviews_first_time(self):
        #Test that when students have not been assigned to do any 
        #reviews yet, i.e., when the assign_reviews view is called for
        #the first time, that each student is assigned the correct number
        #of reviews.
        
        print self.operatingSys.min_annotations

        # Test on COMP3301 course 
        numSubs = len(self.latest)
        numRevs = max(3, numSubs-3)
        distribute_reviews(self.operatingSys, numRevs)
        
        print "test_distribute_reviews_first_time"
        print "got past trouble" 
        # Check each user got the right number of reviews to do
        for user in self.compUsers:
            reviewErr = 0
            # Check that staff haven't been assigned reviews 
            if (user.djangoUser.is_staff or user.djangoUser.is_superuser):
                try:
                    asmtRev = AssignmentReview.objects.get(by=user, assignment=self.operatingSys)
                except AssignmentReview.DoesNotExist:
                    reviewErr = 1

                self.assertTrue(reviewErr)
                continue 
            
            asmtRev = AssignmentReview.objects.get(by=user, assignment=self.operatingSys)
            # Get the assignment review this user has 
            self.assertEqual(numRevs, AssignmentReview.numReviewsRemaining(asmtRev))
            subs = asmtRev.submissions.all()
            self.assertEqual(numRevs, len(subs))

            # Check they didn't get their own submisson to review
            for sub in subs:
                self.assertNotEqual(sub.by, user)
    
    def test_distribute_reviews_reduce_reviews(self):
        pass
        '''Test that when reviews have already been assigned, and the 
        admin wants to reduce the number of reviews per student, that
        they are able to correctly.
        # First assign some reviews ...
        numRevs = 3 
        distribute_reviews(self.operatingSys, numRevs)
        
        # Now reduce. 
        numRevs = numRevs - 2
        distribute_reviews(self.operatingSys, numRevs)
        asmtRevs = AssignmentReview.objects.filter(assignment=self.operatingSys)
        self.assertEquals(numRevs, len(self.compUsers))
        
        # Check each user got the right number of reviews to do
        for user in self.compUsers:
            # Get the assignment review this user has 
            asmtRev = AssignmentReview.objects.get(by=user)
            self.assertEqual(numRevs, AssignmentReview.numReviewsRemaining(asmtRev))
            subs = asmtRev.subs
            self.assertEqual(numRevs, subs)

            # Check they didn't get their own submisson to review
            for sub in subs:
                self.assertNotEqual(sub.by, user)
        '''

    def test_distribute_reviews_reduce_reviews_annotations(self):
        '''Test reducing the number of reviews when students have already
        done some annotations. Not sure how important this is, I doubt
        course coordinator will change the number of reviews s/he assigns.
        '''
        pass

    def test_distribute_reviews_increase_reviews(self):
        pass
        '''Test that when reviews have already been assigned, and the
        admin wants to increase the number of reviews per student, that
        they are able to do so.
        # First assign some reviews ...
        numSubs = len(self.opSubs)
        numRevs = 1
        distribute_reviews(self.operatingSys, numRevs)
        
        # Now increase. 
        numRevs = numSubs - 2
        distribute_reviews(self.operatingSys, numRevs)
        asmtRevs = AssignmentReview.objects.filter(assignment=self.operatingSys)
        self.assertEquals(numRevs, len(self.compUsers))
        
        # Check each user got the right number of reviews to do
        for user in self.compUsers:
            # Get the assignment review this user has 
            asmtRev = AssignmentReview.objects.get(by=user)
            self.assertEqual(numRevs, AssignmentReview.numReviewsRemaining(asmtRev))
            subs = asmtRev.subs
            self.assertEqual(numRevs, subs)

            # Check they didn't get their own submisson to review
            for sub in subs:
                self.assertNotEqual(sub.by, user)
         '''       
