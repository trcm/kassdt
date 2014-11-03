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
        self.selenium.find_elements_by_xpath("id('assignmentList')/div[2]/div/div/form/span/input[2]")[0].submit()
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
        self.selenium.find_element_by_tag_name("select").click()
        self.selenium.find_elements_by_tag_name("option")[1].click()
        self.selenium.find_elements_by_class_name('lineno')[0].click()
        text_input = self.selenium.find_element_by_xpath("//textarea[@id='id_text']")
        text_input.location_once_scrolled_into_view
        text_input.send_keys('selenium test')
        self.selenium.find_element_by_xpath("//input[@value='Submit']").click()

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
        self.selenium.find_element_by_tag_name("select").click()
        self.selenium.find_elements_by_tag_name("option")[1].click()
        # self.selenium.find_element_by_xpath("//div[@id='reviewFiles']/ul/li[2]/a").click()
        self.selenium.find_element_by_xpath("//div[@id='ui-id-2']/a[3]").click()
        try:
            self.selenium.find_element_by_xpath("//p[text() ='Comment: selenium test']")
        except NoSuchElementException:
            error = True

        self.assertTrue(error)

    def test_03_create_invalid_annotation(self):
        """
        Test that if an annotation is created with no text then an error is displayed
        """
        self.selenium.find_elements_by_class_name('lineno')[0].click()
        self.selenium.find_element_by_xpath("//input[@value='Submit']").click()
        self.selenium.find_elements_by_class_name('lineno')[0].click()
        # Check that the errors are now present by checking that error list exists
        self.selenium.find_elements_by_class_name('errorlist')
    

class SeleniumReviews(LiveServerTestCase):
    """
    Tests that the review system works corrently.
    ie. Reviews are counted as completed, annotations count towards
    completed reviews, when the annotation count is met the review 
    is complete.
    """
    
    server_url = 'http://localhost:8000'
    fixtures = ['assign_reviews']
    
    @classmethod
    def setUpClass(cls):
        cls.selenium = webdriver.WebDriver()
        super(SeleniumReviews, cls).setUpClass()
        cls.selenium.maximize_window()

    @classmethod
    def tearDownClass(cls):
        cls.selenium.quit()
        super(SeleniumReviews, cls).tearDownClass()

    def login(self):
        self.selenium.get("%s" % self.server_url)
        username_input = self.selenium.find_element_by_id("id_username")
        password_input = self.selenium.find_element_by_id("id_password")
        username_input.send_keys('fionn')
        password_input.send_keys('fionn')
        self.selenium.find_element_by_xpath("//input[@value='Login']").click()

    def test_01_ensure_user_only_sees_own_comments(self):
        """ tests that when the user starts reviewing an assigment they only see their
        own annotations"""
        sel = self.selenium
        self.login()

        error = False
        
        next = sel.find_element_by_partial_link_text("Courses").click()
        sel.find_element_by_partial_link_text("COMP3301").click()
        sel.find_element_by_xpath("//a[@href='Test1/']").click()
        sel.find_element_by_xpath("//tbody[@id='assignment_page_tbody']/tr/td[2]/form/input").click()
        sel.find_element_by_tag_name("select").click()
        sel.find_elements_by_tag_name("option")[1].click()
        annotes = sel.find_elements_by_xpath("id('comment')")
        self.assertEqual(len(annotes), 0)

        
    def test_02_check_annotation_count(self):
        """
        Tests that when an annotation is created on a file, the counter for completed
        annotations is incremented.
        """
        sel = self.selenium
        next = sel.find_element_by_partial_link_text("Courses").click()
        sel.find_element_by_partial_link_text("COMP3301").click()
        sel.find_element_by_xpath("//a[@href='Test1/']").click()
        sel.find_element_by_xpath("//tbody[@id='assignment_page_tbody']/tr/td[2]/form/input").click()
        sel.find_element_by_tag_name("select").click()
        sel.find_elements_by_tag_name("option")[1].click()
        sel.find_elements_by_class_name('lineno')[0].click()
        text_input = sel.find_element_by_xpath("id('id_text')")
        text_input.location_once_scrolled_into_view
        text_input.send_keys('selenium test')
        sel.find_element_by_xpath("//input[@value='Submit']").click()
        sel.find_element_by_partial_link_text("Submit").click()
        completed = sel.find_element_by_xpath("id('reviewTable')/tbody/tr/td[1]").text
        self.assertEqual(completed, "Completed 1 annotations of 1")

    def test_03_check_reviews_count(self):
        """ Check that the counter for reviews left as decremented and then delete the review"""
        sel = self.selenium
        reviews_left = sel.find_element_by_xpath("id('assignmentList')/div[4]/h4").text
        self.assertEqual(reviews_left, "Based on the minimum required amount of annotations- you have 0 of 1 reviews left to complete.")
        # clean up the annotation created
        sel.find_element_by_xpath("//tbody[@id='assignment_page_tbody']/tr/td[2]/form/input").click()
        sel.find_element_by_tag_name("select").click()
        sel.find_elements_by_tag_name("option")[1].click()
        sel.find_element_by_xpath("id('ui-id-2')/a[3]").click()

    def test_04_can_view_reviews(self):
        """ Check that reviews can be seen on submissions"""
        sel = self.selenium
        next = sel.find_element_by_partial_link_text("Courses").click()
        sel.find_element_by_partial_link_text("COMP3301").click()
        sel.find_element_by_xpath("//a[@href='Test1/']").click()
        sel.find_element_by_xpath("id('assignment_page_tbody')/tr/td[3]/form/input").click()
        sel.find_element_by_tag_name("select").click()
        sel.find_elements_by_tag_name("option")[1].click()
        
        commentText = sel.find_element_by_xpath("id('comment')").text
        self.assertEqual("Test", commentText)

    def test_05_view_user_annotations(self):
        """Checks that the user can only view their own annotations on a submission"""
