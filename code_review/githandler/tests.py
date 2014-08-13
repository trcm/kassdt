"""
This file demonstrates writing tests using the unittest module. These will pass
when you run "manage.py test".

Replace this with more appropriate tests for your application.
"""

from django.test import TestCase
from review.models import *
from githandler.handler import *

class SimpleTest(TestCase):
    def test_basic_addition(self):
        """
        Tests that 1 + 1 always equals 2.
        """
        self.assertEqual(1 + 1, 2)

'''
    Test cloning from public repo
'''

'''
    Test that database is populate correctly
'''
class PopulateDatabaseTest(TestCase):
    
    def setUp(self):
	print('Getting a Repo object to do tests on.')
	print('By default we clone to MEDIA_ROOT/media/githandle_test')
