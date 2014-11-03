from django.test import TestCase

from django.contrib.auth.models import User, Group
from django.db.models.base import ObjectDoesNotExist
from review.models import *
from review.helpers import *
from help.models import *

from django.test import LiveServerTestCase
from selenium.webdriver.chrome import webdriver
from selenium.common.exceptions import NoSuchElementException

class PostTest(TestCase):
    fixtures = ['fixtures/dump.json']

    def setUp(self):
        ru = ReviewUser.objects.get(id=1)
        c = Course.objects.get(course_code="ABCD1234")
        p = Post.objects.create(course_code=c,
                                by=ru,
                                title="Default",
                                question="Test question",
                                submission_repository="https://github.com/avadendas/public_test_repo.git"
        )

    def test_pass(self):
        self.assertTrue(True)

    def test_post_creation(self):
        c = Course.objects.get(course_code="ABCD1234")
        ru = ReviewUser.objects.get(id=1)
        p = Post.objects.create(course_code=c,
                                by=ru,
                                title="Test",
                                question="Test question",
                                submission_repository="https://github.com/avadendas/public_test_repo.git"
        )
        p.save()

        self.assertIn(p, Post.objects.all())

    def test_post_creation_with_invalid_user(self):
        error = False
        try:

            ru = User.objects.get(username="DOesn't exit").reviewuser
            c = Course.objects.get(course_code="ABCD1234")
            p = Post.objects.create(course_code=c,
                                    by=ru,
                                    title="Test",
                                    question="Test question",
                                    submission_repository="https://github.com/avadendas/public_test_repo.git"
            )
            p.save()
        except User.DoesNotExist:
            error = True

        self.assertTrue(error)

    def test_post_creation_with_invalid_title_question(self):
        # TODO alter
        ru = ReviewUser.objects.get(id=1)
        c = Course.objects.get(course_code="ABCD1234")
        p = Post.objects.create(course_code=c,
                                by=ru,
                                title="",
                                question="",
                                submission_repository="https://github.com/avadendas/public_test_repo.git"
        )
        p.save()

    def test_post_deletion(self):

        p = Post.objects.get(title="Default")
        p.delete()

        self.assertNotIn(p, Post.objects.all())

    def test_post_deletion_invalid_post(self):
        error = False
        try:
            p = Post.objects.get(title="I dont exist")

        except Post.DoesNotExist:
            error = True

        self.assertTrue(error)

    def test_editing_post(self):


        p = Post.objects.get(title="Default")
        p.title = "Changed"
        p.save()

        self.assertTrue(Post.objects.get(title="changed"))


class SeleniumHelp(LiveServerTestCase):
    server_url = 'http://localhost:8000'

    @classmethod
    def setUpClass(cls):
        cls.selenium = webdriver.WebDriver()
        super(SeleniumHelp, cls).setUpClass()

    @classmethod
    def tearDownClass(cls):
        cls.selenium.quit()
        super(SeleniumHelp, cls).tearDownClass()

    def login(self):

        """
        login - Log the user in and proceed to the help page for Learning 1
        """

        self.selenium.get("%s" % self.server_url)
        username_input = self.selenium.find_element_by_id("id_username")
        password_input = self.selenium.find_element_by_id("id_password")
        username_input.send_keys('tom')
        password_input.send_keys('tom')
        self.selenium.find_element_by_xpath("//input[@value='Login']").click()
        next = self.selenium.find_element_by_partial_link_text("Courses").click()
        self.selenium.find_element_by_partial_link_text("ABCD1234").click()

    def test_01_create_post(self):
        self.login()
        sel = self.selenium
        sel.find_element_by_partial_link_text("Get help").click()
        sel.find_element_by_partial_link_text("New Post").click()
        sel.find_element_by_xpath("//input[@id='id_title']").send_keys('Selenium')
        sel.find_element_by_xpath("//textarea[@id='id_question']").send_keys("selenium")
        sel.find_element_by_xpath("//input[@id='id_submission_repository']").send_keys("https://github.com/avadendas/public_test_repo.git")
        self.selenium.find_element_by_name("submit").click()

    def test_02_edit_post(self):
        ''' check for editing of posts'''
        self.selenium.find_element_by_partial_link_text("Selenium").click()
        self.selenium.find_element_by_id("editModalBtn").click()
        alert = self.selenium.switch_to_alert()
        self.selenium.implicitly_wait(10)
        editText = alert.driver.find_element_by_id("id_question")
        self.selenium.implicitly_wait(10)

    def test_03_resolve_and_delete(self):
        sel = self.selenium
        sel.back()
        sel.find_element_by_partial_link_text("Selenium").click()
        sel.find_element_by_id("resolve").click()
        resolved = sel.find_element_by_xpath("//table/tbody/tr[1]/td[4]/p")
        self.assertEqual("True", resolved.text)
        sel.find_elements_by_partial_link_text("Delete")[0].click()
        error = False
        try:
            sel.find_element_by_partial_link_text("Selenium").click()
        except NoSuchElementException:
            error = True

        self.assertTrue(error)
