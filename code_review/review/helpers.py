"""
helpers.py -
Helpers will contain any extra code that is needed, that doesn't fall into one
of the already created files. ie. Any authentication tests and reusable code we need.
"""
from review.models import *
from django.shortcuts import get_object_or_404


def staffTest(User):
    """
    staffTest - this fuction is called when deciding on user permissions
    through out the file.

    :User - the current user object

    Returns:
    True or False depending on the user's permissions
    """
    return User.is_staff


def enrolledTest(user, course):

    """
    enrolledTest - test to check that a user is actually enrolled in a course.
    If the user is not enrolled in the course that they are trying to
    access then they will be redirected to the index page with an appropriate
    error.
    
    Parameters:
    user (ReviewUser) -- ReviewUser object
    course (Course) -- course object for the user to be checked against

    Returns:
    Either a boolean object "True" or it will redirect the user to the index page 
    with an appropriate error
    """

    if course in user.courses.all():
        return True

    
def getUser(request):
    """
    getUser - grabs the current user object based on the user id
    in the http request. If getting the object fails the user will
    be redirected to a 404 page.

    :request - The current http request
    
    Returns:
    user - User model object of current user.
    """
    user = User.objects.get_object_or_404(id=request.user.id)
    return user


def getCourses(request):
    pass


def isTutor(user, course):
    e = user.reviewuser.enrolment.filter(course=course)
    for item in e:
        if item.tutor:
            return True
    return False


def createTutor(user, course):
    e = Enrol.objects.create(user=user,
                             course=course,
                             student=False,
                             tutor=True)
    e.save()
