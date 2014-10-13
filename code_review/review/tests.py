"""
test.py - beginning of unit and functional testing for the code_review
project.

Currently this uses some basic unit tests and we have written
the base of some tests using selenium.  One of the next sprints
we will be running in development is to write tests for the project
as it is.
"""

from django.test import TestCase

from django.contrib.auth.models import User, Group
from django.db.models.base import ObjectDoesNotExist
from review.models import *
from review.helpers import *

from django.test import LiveServerTestCase
from selenium.webdriver.chrome import webdriver
from selenium.common.exceptions import NoSuchElementException

def setup_group(self):
    Group.objects.create(name='student')

# Initializes the user with a username and password


def setup_user(self):

    username = "test"
    password = "test"
    newUser = User.objects.create(username=username, password=password)
    # newUser
    newUser.groups.add(Group.objects.get(name='student'))
    newUser.save()


class UserTests(TestCase):

    def test_user_is_a_student(self):
        setup_group(self)
        setup_user(self)
        user = User.objects.get(username='test')
        user.is_Staff = False
        self.assertFalse(user.is_Staff)

    def test_user_is_staff(self):
        setup_group(self)
        setup_user(self)
        user = User.objects.get(username='test')
        user.is_Staff = True
        self.assertTrue(user.is_Staff)

    def test_user_creating_reviewUser(self):
        setup_group(self)
        setup_user(self)
        user = User.objects.get(username='test')
        c = Course.objects.create(course_code='test1234')
        user.save()
        ru = ReviewUser.objects.create(djangoUser=user)
        ru.courses.add(c)
        ru.save()
        self.assertTrue(ru == user.reviewuser)

    def test_user_in_course(self):
        setup_group(self)
        setup_user(self)
        user = User.objects.get(username='test')
        c = Course.objects.create(course_code='test1234')
        user.save()
        ru = ReviewUser.objects.create(djangoUser=user)
        ru.courses.add(c)
        ru.save()
        courses = ru.courses.filter()
        self.assertTrue(c == courses[0])

    def test_user_isnt_in_course(self):
        setup_group(self)
        setup_user(self)
        user = User.objects.get(username='test')
        c = Course.objects.create(course_code='test1234')
        d = Course.objects.create(course_code='test1235')
        user.save()
        ru = ReviewUser.objects.create(djangoUser=user)
        ru.courses.add(c)
        ru.save()
        courses = ru.courses.filter()
        self.assertFalse(d == courses[0])

    def test_user_is_tutor(self):
        setup_group(self)
        setup_user(self)
        c = Course.objects.create(course_code='test1234')
        user = User.objects.get(username='test')
        user.save()
        ru = ReviewUser.objects.create(djangoUser=user)
        ru.courses.add(c)
        ru.save()
        createTutor(user.reviewuser, c)
        self.assertTrue(isTutor(user, c))

    def test_user_isnt_tutor(self):
        setup_group(self)
        setup_user(self)
        c = Course.objects.create(course_code='test1234')
        user = User.objects.get(username='test')
        user.save()
        ru = ReviewUser.objects.create(djangoUser=user)
        ru.courses.add(c)
        ru.save()
        user.reviewuser.courses.add(c)
        self.assertFalse(isTutor(user, c))


class AnnotationTests(TestCase):
    
    """
    Test SourceAnnotation and SourceAnnotationRange together, they're never created
   separately
    """

    fixtures = ['fixtures/dump.json']

    def createAnnotation(self):
        U = User.objects.get(username='test')
        ru = ReviewUser.objects.create(djangoUser=U)
        course = Course.objects.get(course_code="ABCD1234")
        sub = AssignmentSubmission.objects.get(id=1)
        subFile = SourceFile.objects.filter(submission=sub)[0]
        
        annotation = SourceAnnotation.objects.create(user=ru,
                                                     source=subFile,
                                                     submission=sub,
                                                     text="Test",
                                                     quote="Test")
        annotation.save()
        rangeA = SourceAnnotationRange.objects.create(range_annotation=annotation,
                                                      start=1,
                                                      end=1,
                                                      startOffset=1,
                                                      endOffset=1)
        rangeA.save()

    def setUp(self):
        # setup_group(self)
        setup_user(self)
        
    def test_create_annotation(self):
        U = User.objects.get(username='test')
        ru = ReviewUser.objects.create(djangoUser=U)
        course = Course.objects.get(course_code="ABCD1234")
        # sub = AssignmentSubmission.objects.get(id=1)
        subFile = SourceFile.objects.all()[0]
        sub = subFile.submission
        
        annotation = SourceAnnotation.objects.create(user=ru,
                                                     source=subFile,
                                                     submission=sub,
                                                     text="Test",
                                                     quote="Test")
        annotation.save()
        rangeA = SourceAnnotationRange.objects.create(range_annotation=annotation,
                                                      start=1,
                                                      end=1,
                                                      startOffset=1,
                                                      endOffset=1)
        rangeA.save()

        self.assertIn(annotation, SourceAnnotation.objects.all())
        self.assertIn(rangeA, SourceAnnotationRange.objects.all())

        
    # def test_delete_annotation(self):
    #     # self.createAnnotation()
    #     pass

    # def test_delete_invalid_annotation(self):
    #     pass

    # def test_edit_annotaion(self):
    #     pass

    # def test_create_annotation_invalid_line_number(self):
    #     pass 

    # def test_create_annotation_blank_comment(self):
    #     pass
        
class MySeleniumTests(LiveServerTestCase):
    fixtures = ['fixtures/dump.json']
    server_url = 'http://localhost:8000'

    @classmethod
    def setUpClass(cls):
        cls.selenium = webdriver.WebDriver()
        super(MySeleniumTests, cls).setUpClass()
        cls.selenium.maximize_window()
        '''
        '''

    @classmethod
    def tearDownClass(cls):
        cls.selenium.quit()
        super(MySeleniumTests, cls).tearDownClass()

    def login(self):
        self.selenium.get("%s" % self.server_url)
        username_input = self.selenium.find_element_by_id("id_username")
        password_input = self.selenium.find_element_by_id("id_password")
        username_input.send_keys('tom')
        password_input.send_keys('tom')
        self.selenium.find_element_by_xpath("//input[@value='Login']").click()

    def test_01_course_page(self):
        self.login()
        next = self.selenium.find_element_by_partial_link_text("Courses").click()
        self.selenium.find_element_by_partial_link_text("ABCD1234").click()
        page_title = self.selenium.find_element_by_tag_name('h1')
        self.assertTrue(page_title.text == "Assignments for ABCD1234")

    def test_02_assignment_submission(self):
        next = self.selenium.find_element_by_partial_link_text("Courses").click()
        self.selenium.find_element_by_partial_link_text("ABCD1234").click()
        self.selenium.find_element_by_xpath("//a[@href='Learning 1/']").click()
        self.selenium.find_elements_by_xpath("//div[@class='panel-footer']/form/input")[0].submit()
        self.selenium.find_elements_by_id("id_submission_repository")[0].send_keys('https://github.com/xagefu/test.git')
        self.selenium.find_elements_by_xpath("//span[@class='input-group-btn']/input")[0].submit()
        self.assertTrue(self.selenium.find_element_by_xpath("//h1[text() ='Submission Confirmed']"))

    def test_03_previous_submission(self):
        next = self.selenium.find_element_by_partial_link_text("Courses").click()
        self.selenium.find_element_by_partial_link_text("ABCD1234").click()
        self.selenium.find_element_by_xpath("//a[@href='Learning 1/']").click()
        self.selenium.find_elements_by_xpath("id('assignmentList')/div[3]/table/tbody/tr/td[3]/form/input")[0].submit()


class SeleniumAnnotations(LiveServerTestCase):
    server_url = 'http://localhost:8000'
    
    @classmethod
    def setUpClass(cls):
        cls.selenium = webdriver.WebDriver()
        super(SeleniumAnnotations, cls).setUpClass()
        cls.selenium.maximize_window()

    @classmethod
    def tearDownClass(cls):
        cls.selenium.quit()
        super(SeleniumAnnotations, cls).tearDownClass()

    def login(self):
        self.selenium.get("%s" % self.server_url)
        username_input = self.selenium.find_element_by_id("id_username")
        password_input = self.selenium.find_element_by_id("id_password")
        username_input.send_keys('tom')
        password_input.send_keys('tom')
        self.selenium.find_element_by_xpath("//input[@value='Login']").click()

    def test_00_create_annotation(self):
        
        """
        test_create_annotation(self)
       
        Tests that annotations can be created on a submission.  
        Asserts that the annotation exits.
        """

        self.login()
        next = self.selenium.find_element_by_partial_link_text("Courses").click()
        self.selenium.find_element_by_partial_link_text("ABCD1234").click()
        self.selenium.find_element_by_xpath("//a[@href='Learning 1/']").click()
        self.selenium.find_element_by_xpath("//table/tbody/tr/td[3]/form/input").click()
        self.selenium.find_element_by_xpath("//div[@id='reviewFiles']/ul/li[2]/a").click()
        self.selenium.find_elements_by_class_name('lineno')[0].click()
        # line_input = self.selenium.find_element_by_xpath("//input[@id='id_start']").send_keys('1')
        #self.selenium.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        text_input = self.selenium.find_element_by_xpath("//textarea[@id='id_text']")
        text_input.location_once_scrolled_into_view
        text_input.send_keys('selenium test')
        self.selenium.find_element_by_xpath("//input[@value='Submit']").click()
        # self.assertTrue(self.selenium.find_element_by_xpath("//p[text() ='Comment: selenium test']"))

    def test_01_edit_annotation(self):
        """ test_01_edit_annotation
        Tests to check that the user can edit annotations they have made
        """
        self.selenium.find_element_by_xpath("//div[@id='ui-id-2']/a[text() = 'Edit']").click()
        editBox = self.selenium.find_element_by_xpath("//textarea[@id='id_text']")
        editBox.send_keys("Editedit")
        self.selenium.find_element_by_xpath("//input[starts-with(@id, 'saveBtn')]").click()
        
    def test_02_delete_annotation(self):
        
        """
        test_delete_annotation 
        Tests that the annotation created in the previous test can be deleted
        """
        error = False
        self.selenium.get("%s" % self.server_url)
        next = self.selenium.find_element_by_partial_link_text("Courses").click()
        self.selenium.find_element_by_partial_link_text("ABCD1234").click()
        self.selenium.find_element_by_xpath("//a[@href='Learning 1/']").click()
        self.selenium.find_element_by_xpath("//table/tbody/tr/td[3]/form/input").click()
        self.selenium.find_element_by_xpath("//div[@id='reviewFiles']/ul/li[2]/a").click()
        self.selenium.find_element_by_xpath("//div[@id='ui-id-2']/a[3]").click()
        try:
            self.selenium.find_element_by_xpath("//p[text() ='Comment: selenium test']")
        except NoSuchElementException:
            error = True

        self.assertTrue(error)
