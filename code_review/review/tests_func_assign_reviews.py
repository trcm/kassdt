"""
Functional tests for assigning reviews to students.
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

class AssignReviewsTest(LiveServerTestCase):
    server_url = 'http://localhost:8000'
    
    @classmethod
    def setUpClass(cls):
        cls.selenium = webdriver.WebDriver()
        super(AssignReviewsTest, cls).setUpClass()
        cls.selenium.maximize_window()

    @classmethod
    def tearDownClass(cls):
        cls.selenium.quit()
        super(AssignReviewsTest, cls).tearDownClass()

    def login(self):
        self.selenium.get("%s" % self.server_url)
        username_input = self.selenium.find_element_by_id("id_username")
        password_input = self.selenium.find_element_by_id("id_password")
        username_input.send_keys('tom')
        password_input.send_keys('tom')
        self.selenium.find_element_by_xpath("//input[@value='Login']").click()
    
    def test_00_assign_reviews(self):
        self.login()
        next = self.selenium.find_element_by_partial_link_text("Courses").click()
        self.selenium.find_element_by_partial_link_text("COMP3301").click()
        self.selenium.find_element_by_xpath("//a[@href='OperatingSystems/']").click()
        self.selenium.find_element_by_xpath("//div[@id='adminTools']/div[@id='adminToolsButtons']/a[@href='assign_reviews']").click()

