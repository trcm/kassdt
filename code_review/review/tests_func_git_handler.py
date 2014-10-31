"""
Functional tests for submitting assignments.

This covers the git submission system as well as restrictions
such as not being able to submit an assignment unless it's open,
and the due date has not gone by.

WARNINGS:
    -- test_ssh will only work if ssh is set up. 
    -- test_nonrepo_url will take a long time (in the order of 30 seconds
       to a minute) to run. Feel free to skip this test. It works.
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
    fixtures = ['assign_reviews']
    server_url = 'http://localhost:8000'
        
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
    def getError(self):
        '''Get the error message on the submission page.
        Preconditions:
            we are at the assignment submission page and an error has appeared.
        Returns:
            A string error message.
        '''
        err = self.xpath("//*[@id='assSubmitDiv']/div[2]/div/form/div[2]").text
        return str(err)

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
    
    def test_nonexistent_repo(self):
        '''Try submitting a repo that is a well-formed URL but which is not
        an actual, existing repo.
        
        NB github and bitbucket behave differently here. Github will first ask
        you for your credentials, THEN realise the repo doesn't exist. 
        Bitbucket will immediately kick back saying the repo doesn't exist.
        '''
        self.login('naoise', 'naoise')
        notarepo = "https://kassdt@bitbucket.org/kassdt/notarepo.git"
        self.submitAssignment('ABCD1234', 'Learning 1', notarepo)
        expectedErr = "ERROR!\nThe URL appears incorrect... is this really your repo? Please also check your internet connection."
        self.assertEqual(expectedErr, self.getError())
    
    def test_bad_protocol(self):
        '''Try to submit a URL which has a non-existent protocol;
        in this case we will use httomps instead of https.
        '''
        self.login('naoise', 'naoise')
        badProtocol= "httomps://kassdt@bitbucket.org/kassdt/private_test_repo.git"
        self.submitAssignment('ABCD1234', 'Learning 1', badProtocol)
        expectedErr = "ERROR!\nSomething went wrong! Please check your URL (for instance, did you put a non-existent protocol like httppp instead of https?). If that doesn't work, please contact sysadmin."
        self.assertEqual(expectedErr, self.getError())
        sleep(5)

    def test_bad_url(self):
        '''Test a badly-formed URL: https://www.google.com
        (should have a / at the end; also, obviously not a repo.
        '''
        self.login('naoise', 'naoise')
        badURL = "https://google.com"
        self.submitAssignment('ABCD1234', 'ASMT1', badURL)
        expectedErr = "ERROR!\nPlease check your URL"
        self.assertEqual(expectedErr, self.getError())

    def test_nonrepo_url(self):
        '''Test a well-formed URL which is not even an existing address.
        Need this test on top of all the other bad URL tests because they
        all raise different exceptions!
        '''
        self.login('naoise', 'naoise')
        badURL = "https://blahblahblahblahblah.com/"
        self.submitAssignment('ABCD1234', 'ASMT1', badURL)
        expectedErr = "ERROR!\nConnection timed out. Please check your URL."
        self.assertEqual(expectedErr, self.getError())

    def test_nonsense(self):
        '''Try putting in total gibberish that doesn't even resemble a URL.
        If people leave out https, it will raise the same exception.
        It only likes perfectly-written URLs.
        '''
        self.login('naoise', 'naoise')
        badURL = "dflkajdf"
        self.submitAssignment('ABCD1234', 'ASMT1', badURL)
        expectedErr = "ERROR!\nWhat you entered is not a valid url; remember to include https://"
        self.assertEqual(expectedErr, self.getError())
        badURL = "kassdt@bitbucket.org/kassdt/private_test_repo.git"
        self.submitAssignment('ABCD1234', 'ASMT1', badURL)
        self.assertEqual(expectedErr, self.getError())

    def test_blank_url(self):
        '''Hit submit assignment without putting in anything in the url field.'''
        self.login('naoise', 'naoise')
        self.submitAssignment('ABCD1234', 'ASMT1', '')
        expectedErr = "ERROR!\nWhat you entered is not a valid url; remember to include https://"
        self.assertEqual(expectedErr, self.getError())

    def test_submission_not_yet_open(self):
        '''Make sure students can't submit until the submission open date.
        This means making sure submission is closed on assignment page
        and also that they can't get to the submission page by entering the
        URL in directly.
        '''
        # First check that assignment page shows submissions to be closed.
        # Importantly, make sure there is no submit button!
        self.login('naoise', 'naoise')
        submitButtonExists = True

        try:
            self.submitAssignment('ABCD1234', 'NotOpen', '')
        except Exception as e:
            expected = "Unable to locate element"
            print e
            self.assertTrue(expected in str(e))
            submitButtonExists = False     
        
        self.assertFalse(submitButtonExists)
        
        # Now try going to the usual submission URL and ensure that the 
        # tricksy user is met with a nasty error message. 
        self.selenium.get("http://localhost:8000/review/course/ABCD1234/NotOpen/submit/")
        expectedErr = "Submissions are closed"
        actualErr = str(self.xpath("//*[@id='cannotSubmit']/h2").text)
        self.assertEqual(expectedErr, actualErr)

    def test_deadline_gone(self):
        '''Make sure students can't submit once the deadline has rolled by.
        This means making sure submission is closed on assignment page
        and also that they can't get to the submission page by entering the
        URL in directly.
        '''
        self.login('naoise', 'naoise')
        submitButtonExists = True

        try:
            self.submitAssignment('ABCD1234', 'DeadlineGone', '')
        except Exception as e:
            expected = "Unable to locate element"
            print e
            self.assertTrue(expected in str(e))
            submitButtonExists = False     
        
        self.assertFalse(submitButtonExists)
        
        # Now try going to the usual submission URL and ensure that the 
        # tricksy user is met with a nasty error message. 
        self.selenium.get("http://localhost:8000/review/course/ABCD1234/DeadlineGone/submit/")
        expectedErr = "Submissions are closed"
        actualErr = str(self.xpath("//*[@id='cannotSubmit']/h2").text)
        self.assertEqual(expectedErr, actualErr)
        sleep(5) 

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


    def test_junk(self):
        '''Test submitting junk in the URL field, like aldkjadlkfj'''
        pass

    def test_blank(self):
        '''Submit blank URL'''
        pass
    """

