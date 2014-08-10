from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect

# authentication libraries
# base django user system
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout

# we can use this as a pre condition for any method that requires the user to be logged in
# which will probably be all of them.  You can see below that the index method uses this
from django.contrib.auth.decorators import login_required, user_passes_test

from review.models import *
from forms import AssignmentForm

def staffTest(User):
    return User.is_staff

# this is the basic index view, it required login before the user can do any
# as you can see at the moment this shows nothing other than a logout button
# as I haven't added any content to it yet
@login_required(login_url='/review/login_redirect/')
def index(request):
    # whatever stuff we're goign to show in the index page needs to
    # generated here
    
    return render(request, 'index.djhtml', {'name': 'tom'})

def loginUser(request):
    pass 

# simply logs the user out
def logout(request):
    logout(request)
    return HttpResponse("logout")
    # return redirect('/review/')


# This will redirect the admin user to the admin panel.
# It will also list all the courses they're currently
@login_required
@user_passes_test(staffTest)
def adminRedirect(request):

    context = {}
    
    # get the current assignments for the subject, subject choosing will be added later

    c = Course.objects.get(course_code="ABCD1234")
    assignments = c.assignments.all()
    context['assignments'] = assignments
    context['course'] = c
    
    
    return render(request, 'admin.html', context)

    
@login_required
@user_passes_test(staffTest)
def create_assignment(request, course_code):
    
    context = {}

    # grab course code from the url and convert to a string from unicode
    code = course_code.encode('ascii','ignore')
    # grab the course object for the course
    c = Course.objects.get(course_code=code)

    # generate form for new assignemnt, thing this will get changed
    # to a pre specified form rather than a generated form
    form = AssignmentForm()

    # add all the data to thte context dict
    context['form'] = form
    context['course'] = c
    
    
    return render(request, 'admin/new_assignment.html', context)


def validateAssignment(request):
    form = None
    context = {}
    
    if request.method == "POST":
        print request
        form = AssignmentForm(request.POST)
        print request.POST['course_code']
        if form.is_valid():
            try:
                print "Creating assignment"
                course = Course.objects.get(id=request.POST['course_code'])
                name = form.cleaned_data['name']
                repository_format = form.cleaned_data['repository_format']
                first_display_date = form.cleaned_data['first_display_date']
                submission_open_date = form.cleaned_data['submission_open_date']
                submission_close_date = form.cleaned_data['submission_close_date']
                review_open_date = form.cleaned_data['review_open_date']
                review_close_date = form.cleaned_data['review_close_date']
                ass = Assignment.objects.create(course_code=course, name=name,
                                                repository_format=repository_format,
                                                first_display_date=first_display_date,
                                                submission_open_date=submission_open_date,
                                                submission_close_date=submission_close_date,
                                                review_open_date=review_open_date,
                                                review_close_date=review_close_date)
                ass.save()
            except Exception as AssError:
                print "DREADED EXCEPTION"
                print AssError.args
                
                
                return render(request)
    
            
    context['form'] = form
    context['course'] = Course.objects.get(id=request.POST['course_code'])
    
    return render(request, 'admin/new_assignment.html', context)

