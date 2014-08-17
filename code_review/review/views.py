from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, HttpResponseRedirect, Http404

# authentication libraries
# base django user system
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout

# we can use this as a pre condition for any method that requires the user to be logged in
# which will probably be all of them.  You can see below that the index method uses this
from django.contrib.auth.decorators import login_required, user_passes_test

from review.models import *

from helpers import staffTest

# imports the form for assignment creation
from forms import AssignmentForm


# this is the basic index view, it required login before the user can do any
# as you can see at the moment this shows nothing other than a logout button
# as I haven't added any content to it yet
@login_required(login_url='/review/login_redirect/')
def index(request):
    context = {}

    # whatever stuff we're goign to show in the index page needs to
    # generated here
    U = User.objects.get(id=request.user.id)
    context['user'] = U
    
    try:
        courses = U.reviewuser.courses.all()
        context['courses'] = courses
        return render(request, 'course.html', context)
    except Exception as UserExcept:
        print UserExcept.args
    
    return render(request, 'course.html', context)


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
# @user_passes_test(staffTest)
def adminRedirect(request, course_code):
    context = {}
    # get the current assignments for the subject, subject choosing
    # will be added later
    U = User.objects.get(id=request.user.id)
    context['user'] = U
    code = course_code.encode('ascii', 'ignore')
    c = Course.objects.get(course_code=code)
    assignments = c.assignments.all()
    context['assignments'] = assignments
    context['course'] = c
    try:
        print "Getting courses"
        courses = U.reviewuser.courses.all()
        context['courses'] = courses
        return render(request, 'admin.html', context)
    except Exception as UserExcept:
        print UserExcept.args
        raise Http404

    return render(request, 'admin.html', context)

@login_required
def student_homepage(request):
    return HttpResponse("This is a student's homepage.")

# gets the course code for the current course being used and
# creates a form for creating a new assignment, redirects to the
# assignment create page


@login_required
@user_passes_test(staffTest)
def create_assignment(request, course_code):

    context = {}

    # grab course code from the url and convert to a string from unicode
    code = course_code.encode('ascii', 'ignore')
    # grab the course object for the course
    c = Course.objects.get(course_code=code)

    # generate form for new assignemnt, thing this will get changed
    # to a pre specified form rather than a generated form
    form = AssignmentForm()

    # add all the data to thte context dict
    context['form'] = form
    context['course'] = c

    return render(request, 'admin/new_assignment.html', context)


# Validates the data from the assignment creation form.
# If the data is valid then it creates the assignment,
# otherwise the user is kicked back to the form to fix the data


def validateAssignment(request):
    form = None
    context = {}
    # gets the data from the post request
    if request.method == "POST":
        print request
        form = AssignmentForm(request.POST)
        print request.POST['course_code']
        if form.is_valid():
            try:
                # gets the cleaned data from the post request

                # Just to check the code is working
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
                # prints the exception
                print "DREADED EXCEPTION"
                print AssError.args
            return HttpResponseRedirect('/review/course_admin/')

    context['form'] = form
    context['course'] = Course.objects.get(id=request.POST['course_code'])

    return render(request, 'admin/new_assignment.html', context)
