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

#Initializes the user with a username and password


def setup_user(self):

    username = "test"
    password = "test"
    newUser = User.objects.create(username=username, password=password)
    # newUser
    newUser.groups.add(Group.objects.get(name='student'))
    newUser.save()


def invalid_user(self):

    username = "invalid    "
    password = "test"
    # try:
    newUser = User.objects.create(username=username, password=password)
    newUser.groups.add(Group.objects.get(name='student'))
    newUser.save()
    # Whatever error we throw upon invalid username/password caught here
    # except errorName


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

    def login(self):
        self.selenium.get("%s" % self.server_url)
        username_input = self.selenium.find_element_by_id("id_username")
        password_input = self.selenium.find_element_by_id("id_password")
        username_input.send_keys('tom')
        password_input.send_keys('tom')
        self.selenium.find_element_by_xpath("//input[@value='Login']").click()

    def test_login(self):
        self.selenium.get("%s" % self.server_url)
        username_input = self.selenium.find_element_by_id("id_username")
        password_input = self.selenium.find_element_by_id("id_password")
        username_input.send_keys('tom')
        password_input.send_keys('tom')
        self.selenium.find_element_by_xpath("//input[@value='Login']").click()

    def test_course_page(self):
        self.selenium.get("%s" % self.server_url)
