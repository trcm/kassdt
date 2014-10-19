"""
Functional tests for submitting assignments
"""

from django.test import TestCase

from django.contrib.auth.models import User, Group
from django.db.models.base import ObjectDoesNotExist
from review.models import *
from review.helpers import *

from django.test import LiveServerTestCase
from selenium.webdriver.chrome import webdriver
from selenium.common.exceptions import NoSuchElementException

from review.tests import *
from time import sleep

class AssignmentSubmissionTest(LiveServerTestCase):
    server_url = 'http://localhost:8000'
    fixtures = ['assign_reviews']
        
    publicRepo = "https://github.com/avadendas/public_test_repo.git"
    sshRepo = "https://github.com/avadendas/private_test_repo.git"
    privateRepo = 
    @classmethod
    def setUpClass(cls):
        cls.selenium = webdriver.WebDriver()
        super(AssignmentSubmissionTest, cls).setUpClass()
        cls.selenium.maximize_window()
        
    @classmethod
    def tearDownClass(cls):
        cls.selenium.quit()
        super(AssignmentSubmissionTest, cls).tearDownClass()

    def login(self):
        self.selenium.get("%s" % self.server_url)
        username_input = self.selenium.find_element_by_id("id_username")
        password_input = self.selenium.find_element_by_id("id_password")
        username_input.send_keys('naoise')
        password_input.send_keys('naoise')
        self.selenium.find_element_by_xpath("//input[@value='Login']").click()
    
    @classmethod
    def partialLink(self, text):
        return self.selenium.find_element_by_partial_link_text(text)
    
    @classmethod
    def xpath(self,text):
        return self.selenium.find_element_by_xpath(text)
    
    @classmethod
    def assignmentPage(self, course, asmt):
        '''Go to the assignment page of asmt'''
        '''Submit to a single-submission only assignment and attempt to resubmit'''
        self.partialLink("Courses").click()
        self.partialLink(course).click()
        path = "//a[@href='%s/']" %(asmt)
        self.xpath(path).click()
    
    @classmethod 
    def byId(self, text):
        self.selenium.find_element_by_id(text)

    @classmethod 
    def submit(self, url, username=None, password=None):
        '''@pre we are on the assignment page'''
        self.byId("id_submission_repository").send_keys(url)

    def test_00_submit_public(self):
        '''Believe this has already been done by Kieran in tests:MySeleniumTests.'''
        pass
    
    def test_01_submit_single(self):
        self.login()
        self.assignmentPage("ABCD1234", 'SingleSubmit')
        submit(

    def test_submission_not_open(self):
        pass

    def test_submission_closed(self):
        pass

    def test_multiple_submit(self):
       pass

    def test_bad_transport(self):
        '''Test non-existent protocol httomps://'''
        pass

    def test_ssh(self):
        '''Test private repo submission via ssh'''
        pass

    def test_password_auth(self):
        '''Test submitting private repo with username and password'''
        pass

    def test_bad_password(self):
        '''Test submitting private repo with incorrect password'''
        pass

    def test_junk(self):
        '''Test submitting junk in the URL field, like aldkjadlkfj'''
        pass

    def test_blank(self):
        '''Submit blank URL'''
        pass
