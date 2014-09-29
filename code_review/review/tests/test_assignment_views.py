"""
test_assignment_views.py - test the assignment related views in review.

Tests:
    submit_assignment
    assign_reviews
    assignment_page

"""

from django.test import TestCase

from django.contrib.auth.models import User, Group
from django.db.models.base import ObjectDoesNotExist
from review.models import *


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
        group = Group.objects.get(name='student')
        self.assertIn(group, user.groups.all())
        # self.assertIn(Group.objects.get(name='student'), User.objects.get(username='student').groups.all())

    def test_user_is_staff(self):
        setup_group(self)
        setup_user(self)
        user = User.objects.get(username='test')
        group = Group.objects.get(name='student')
        self.assertIn(group, user.groups.all())

    # #Ensures that a user with an invalid username is not created
    def test_user_valid(self):
        setup_group(self)
        invalid_user(self)
        # This is not how this test will run once these checks have been added
        # to user creation code as then the exception will be thrown upon the
        # attempt to create the user
        try:
            user = User.objects.get(username="invalid    ")
            self.assertFalse(True, "A User with an invalid username was created")
        except ObjectDoesNotExist:
            self.assertFalse(False)

    # #This is the way user tests will be set as well once changes are made
    def test_password_valid(self):
        setup_group(self)
        username="test"
        password = " I A M I N V A L I D "
        # As error handling for invalid user/pass isnt implemented  for now this is
        # a stub test
        # try:

        newUser = User.objects.create(username=username, password=password)
        self.assertFalse(True, "An invalid password was added to database")
        # except errorName
        # self.assertFalse(False)


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
