from review.models import *
from django.shortcuts import get_object_or_404

# Authentication test for the user_passes_test
# decorator.
def staffTest(User):
    return User.is_staff

def getUser(request):
    user = User.objects.get_object_or_404(id=request.user.id)
    return user

def getCourses(request):
    pass
