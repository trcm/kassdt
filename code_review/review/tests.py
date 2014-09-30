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
from selenium.webdriver.firefox import webdriver


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
        rangeA = SourceAnnotationRange.objects.create(range_annotation=annotaion,
                                                      start=1,
                                                      end=1)
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
                                                      end=1)
        rangeA.save()

        self.assertIn(annotation, SourceAnnotation.objects.all())
        self.assertIn(rangeA, SourceAnnotationRange.objects.all())

        
    def test_delete_annotation(self):
        # self.createAnnotation()
        pass

    def test_delete_invalid_annotation(self):
        pass

    def test_edit_annotaion(self):
        pass

    def test_create_annotation_invalid_line_number(self):
        pass 

    def test_create_annotation_blank_comment(self):
        pass
        
class MySeleniumTests(LiveServerTestCase):
    server_url = 'http://localhost:8000'

    @classmethod
    def setUpClass(cls):
        cls.selenium = webdriver.WebDriver()
        super(MySeleniumTests, cls).setUpClass()

    @classmethod
    def tearDownClass(cls):
        cls.selenium.quit()
        super(MySeleniumTests, cls).tearDownClass()

    # def login(self):
    #     self.selenium.get("%s" % self.server_url)
    #     username_input = self.selenium.find_element_by_id("id_username")
    #     password_input = self.selenium.find_element_by_id("id_password")
    #     username_input.send_keys('tom')
    #     password_input.send_keys('tom')
    #     self.selenium.find_element_by_xpath("//input[@value='Login']").click()

    def test_login(self):
        self.selenium.get("%s" % self.server_url)
        username_input = self.selenium.find_element_by_id("id_username")
        password_input = self.selenium.find_element_by_id("id_password")
        username_input.send_keys('tom')
        password_input.send_keys('tom')
        self.selenium.find_element_by_xpath("//input[@value='Login']").click()

    def test_course_page(self):
        self.selenium.get("%s" % self.server_url)
