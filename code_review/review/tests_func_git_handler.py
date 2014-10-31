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
    # Obviously, ssh test only works if you have it set up.
    sshRepo = "git@github.com:avadendas/private_test_repo.git"
    privateRepo = "https://kassdt@bitbucket.org/kassdt/private_test_repo.git"

    username = "kassdt"
    password = "kassdtIsAwesome"

    @classmethod
    def setUpClass(cls):
        cls.selenium = webdriver.WebDriver()
        super(AssignmentSubmissionTest, cls).setUpClass()
        cls.selenium.maximize_window()
        
        print ReviewUser.objects.all()
        print User.objects.all()
        
    @classmethod
    def tearDownClass(cls):
        cls.selenium.quit()
        super(AssignmentSubmissionTest, cls).tearDownClass()
   
    def setUp(self):
        self.student = User.objects.get(pk=86)
        self.admin = User.objects.get(username='tom')
        self.studentRevUser = ReviewUser.objects.get(djangoUser=self.student)

    def login(self, username, password):
        self.selenium.get("%s" % self.server_url)
        username_input = self.selenium.find_element_by_id("id_username")
        password_input = self.selenium.find_element_by_id("id_password")
        username_input.send_keys(username)
        password_input.send_keys(password)
        self.selenium.find_element_by_xpath("//input[@value='Login']").click()
   
    @classmethod
    def loginStudent(self):
        self.login('naoise', 'naoise')

    @classmethod
    def partialLink(self, text):
        return self.selenium.find_element_by_partial_link_text(text)
    
    @classmethod
    def xpath(self,text):
        return self.selenium.find_element_by_xpath(text)
    
    @classmethod
    def assignmentPage(self, course, asmt):
        '''Go to the assignment page of asmt'''
        # Go to course page
        self.partialLink("Courses").click()
        self.partialLink(course).click()
        # Go to assignment page
        path = "//a[@href='%s/']" %(asmt)
        self.xpath(path).click()
    
    @classmethod 
    def byId(self, text):
        return self.selenium.find_element_by_id(text)
    
    @classmethod 
    def repoUrl(self, url):
        '''Go from assignment page to submitting assignment'''
        self.submit()
        # Enter repo URL 
        self.byId("id_submission_repository").send_keys(url)
        sleep(3)
        # Hit submit
        self.selenium.find_elements_by_xpath("id('assignmentList')/div[1]/div/div/form/form/span/input[2]")[0].submit()
        #self.xpath("id('assignmentList')/div/div[2]/div/form/span/input[2]").submit()
        #self.byId("id_submit").click()

    @classmethod 
    def submit(self):
        '''@pre we are on the assignment page'''
        self.xpath("//div[@class='panel-footer']/form/input").submit()
        #self.byId("id_submissionPage").click()

    def confirmSubmission(self):
        # Check redirected to confirmation page 
        message = self.xpath("//*[@id='submissionConfirmation']/div/h3").text.encode('ascii', 'ignore')
        self.assertTrue("submitted" in message)
    
    @classmethod 
    def submitViaPassword(self, username, password):
        '''@pre we have already submitted the repo and are at the username prompt'''
        self.xpath("//*[@id='id_repoUsername']").clear()
        self.xpath("//*[@id='id_repoUsername']").send_keys(username)
        self.xpath("//*[@id='id_repoPassword']").clear()
        self.xpath("//*[@id='id_repoPassword']").send_keys(password)
        self.xpath("//*[@id='id_submitRepo']").click()

    @classmethod
    def get_latest(self, user, asmt):
        return AssignmentSubmission.objects.filter(by=user, submission_for=asmt).latest()
    
    @classmethod 
    def submitAssignment(self, course, asmt, url):
        '''Starting from the home page, navigate through and click submit repo'''
        next = self.selenium.find_element_by_partial_link_text("Courses").click()
        self.selenium.find_element_by_partial_link_text(course).click()
        self.selenium.find_element_by_xpath("//a[@href='%s/']" %asmt).click()
        self.selenium.find_element_by_id("id_submissionPage").click()
        self.selenium.find_element_by_id("id_submission_repository").send_keys(url)
        self.selenium.find_element_by_id("id_submitRepo").click()

    def test_00_submit_public(self):
        '''Test submitting a public repository, with URL correct.'''
        self.login('naoise', 'naoise')
        # How many submissions are there already?
        course = Course.objects.get(course_code="ABCD1234")
        asmt = Assignment.objects.get(course_code=course, name='SingleSubmit')
        oldSubs = AssignmentSubmission.objects.filter(submission_for=asmt, by=self.studentRevUser)
        
	next = self.selenium.find_element_by_partial_link_text("Courses").click()
        self.selenium.find_element_by_partial_link_text("ABCD1234").click()
        self.selenium.find_element_by_xpath("//a[@href='Learning 1/']").click()
        self.selenium.find_element_by_id("id_submissionPage").click()
        #self.selenium.find_elements_by_xpath("//div[@class='panel-footer']/form/input")[0].submit()
        self.selenium.find_element_by_id("id_submission_repository").send_keys('https://github.com/xagefu/test.git')
        self.selenium.find_element_by_id("id_submitRepo").click()

        '''Make sure the confirmation text appears'''
        message = self.xpath("//*[@id='submissionConfirmation']/div/h3").text.encode('ascii', 'ignore')
        message = str(message)
        print(message)
        self.assertTrue("submitted" in message)
        
    def test_ssh(self):
        '''Test private repo submission via ssh'''
        self.login('naoise', 'naoise')
        self.submitAssignment('COMP3301', 'OperatingSystems', self.sshRepo)
        self.confirmSubmission()
    
    def test_correct_password_auth(self):
        '''Test submitting private repo with (correct) username and password'''
        self.login('naoise', 'naoise')
        self.submitAssignment('COMP3301', 'OperatingSystems', self.privateRepo)
        self.xpath("//*[@id='id_repoUsername']").send_keys(self.username)
        self.xpath("//*[@id='id_repoPassword']").send_keys(self.password)
        self.xpath("//*[@id='id_submitRepo']").click()
        self.confirmSubmission()
    
    def test_incorrect_username(self):
        '''Submit with incorrect username first time, then correct next time'''
        self.login('naoise', 'naoise')
        self.submitAssignment('COMP3301', 'OperatingSystems', self.privateRepo)
        self.submitViaPassword('notkassdt', self.password)
        # Get the displayed error message
        err = self.xpath("//*[@id='assSubmitDiv']/div[2]/div/form/div[2]").text
        err = str(err)
        self.assertEquals(err, "ERROR!\nUsername and/or password incorrect.")
        self.submitViaPassword(self.username, self.password)
        self.confirmSubmission()

    def test_incorrect_password(self):
        '''Submit with incorrect password and correct username first time.
        Make sure right error message displayed. 
        Then submit with everything correct.
        '''
        self.login('naoise', 'naoise')
        self.submitAssignment('COMP3301', 'OperatingSystems', self.privateRepo)
        self.submitViaPassword(self.username, "kassdtIsNotAwesome")
        # Get the displayed error message
        err = self.xpath("//*[@id='assSubmitDiv']/div[2]/div/form/div[2]").text
        err = str(err)
        self.assertEquals(err, "ERROR!\nUsername and/or password incorrect.")
        self.submitViaPassword(self.username, self.password)
        self.confirmSubmission()

    def test_incorrect_credentials(self):
        '''Submit with neither password nor username correct first time.
        Make sure error message is correct.
        Then submit with both correct.
        '''
        self.login('naoise', 'naoise')
        self.submitAssignment('COMP3301', 'OperatingSystems', self.privateRepo)
        self.submitViaPassword("kasddt", "kassdtIsNotAwesome")
        # Get the displayed error message
        err = self.xpath("//*[@id='assSubmitDiv']/div[2]/div/form/div[2]").text
        err = str(err)
        self.assertEquals(err, "ERROR!\nUsername and/or password incorrect.")
        self.submitViaPassword(self.username, self.password)
        self.confirmSubmission()

    def test_blank_credentials(self):
        '''Try submitting without entering in anything in username and password.
        The fields should just stay there. 
        '''
        self.login('naoise', 'naoise')
        self.submitAssignment('COMP3301', 'OperatingSystems', self.privateRepo)
        # Leave both fields blank 
        self.submitViaPassword('', '')
        # Nothing terrible should have happened, we can now submit the actual
        # username and password. 
        self.submitViaPassword(self.username, self.password)
        self.confirmSubmission()

    """
    def test_submit_single(self):
        '''Only one submission allowed; user should be blocked from trying to submit.'''
        pass

    def test_submission_not_open(self):
        pass

    def test_submission_closed(self):
        pass

    def test_multiple_submit(self):
       pass

    def test_bad_transport(self):
        '''Test non-existent protocol httomps://'''
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
    """

