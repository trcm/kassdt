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
