"""
views.py handles all the controllers for the application.

This file will eventually be separated into various files for each
of the main sections of the application.  Currently it contains views,
for all the features to date.
"""
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, HttpResponseRedirect, Http404

# authentication libraries
# base django user system
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm

# we can use this as a pre condition for any method that requires the user to be logged in
# which will probably be all of them.  You can see below that the index method uses this
from django.contrib.auth.decorators import login_required, user_passes_test

# used to make django objects into json
from django.core import serializers
from django.forms.models import model_to_dict
import json

#  Imports all the lexers and the formatters currently needed
# to highlight the source code
from pygments import *
from pygments.lexers import *
from pygments.formatters import *
from pygments.styles import *

from review.models import *

# imports any helpers we might need to write
from helpers import staffTest

# imports the form for assignment creation
from forms import AssignmentForm, UserCreationForm, AssignmentSubmissionForm, uploadFile, annotationForm, annotationRangeForm

from django.utils import timezone

from git_handler import *

import os
import os.path

@login_required(login_url='/review/login_redirect/')
def index(request):
    """
    this is the basic index view, it required login before the user can do any
    as you can see at the moment this shows nothing other than a logout button
    as I haven't added any content to it yet
    """
    context = {}

    # whatever stuff we're goign to show in the index page needs to
    # generated here
    U = User.objects.get(id=request.user.id)
    context['user'] = U
    if U.reviewuser.isStaff:
        try:
            courses = U.reviewuser.courses.all()
            context['courses'] = courses
            return render(request, 'sidebar.html', context)
        except Exception as UserExcept:
            print UserExcept.args
    else:  # user is student
        return student_homepage(request)

    return render(request, 'sidebar.html', context)

# simply logs the user out
def logout(request):
    logout(request)
    return HttpResponse("logout")
    # return redirect('/review/')


@login_required(login_url='/review/login_redirect/')
# @user_passes_test(staffTest)
def coursePage(request, course_code):
    """
    Redirects the user to the course page the user has selected
    """
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
        return render(request, 'course_page.html', context)
    except Exception as UserExcept:
        print UserExcept.args
        raise Http404

    return render(request, 'course_page.html', context)


@login_required(login_url='/review/login_redirect/')
@user_passes_test(staffTest)
def create_assignment(request, course_code):
    """
    creates a new assignment for the current course,
    this can only be used if the user has staff access.
    """
    context = {}

    # grab course code from the url and convert to a string from unicode
    code = course_code.encode('ascii', 'ignore')
    # grab the course object for the course
    c = Course.objects.get(course_code=code)

    # generate form for new assignemnt, thing this will get changed
    # to a pre specified form rather than a generated form
    form = AssignmentForm()

    # add all the data to the context dict
    context['form'] = form
    context['course'] = c

    return render(request, 'admin/new_assignment.html', context)

# course administration alternative instead of using the django backend


@login_required(login_url='/review/login_redirect/')
@user_passes_test(staffTest)
def createUser(request):
    context = {}
    userForm = UserCreationForm()
    context['form'] = userForm

    return render(request, 'admin/userCreate.html', context)


@login_required(login_url='/review/login_redirect/')
@user_passes_test(staffTest)
def courseAdmin(request):
    """
    Dummy Course admin for the review admin
    """
    context = {}
    courses = Course.objects.all()
    context['courses'] = courses

    return render(request, 'admin/courseList.html', context)


@login_required(login_url='/review/login_redirect/')
@user_passes_test(staffTest)
def userAdmin(request):
    """
    Dummy User administration for the review admin
    """
    context = {}
    users = User.objects.all()
    context['users'] = users

    return render(request, 'admin/userList.html', context)


@login_required(login_url='/review/login_redirect/')
@user_passes_test(staffTest)
def validateAssignment(request):
    """
    Validates the data from the assignment creation form.
    If the data is valid then it creates the assignment,
    otherwise the user is kicked back to the form to fix the data
    """
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
                print "Creating assignment"
                course = Course.objects.get(id=request.POST['course_code'])
                name = form.cleaned_data['name']
                repository_format = form.cleaned_data['repository_format']
                first_display_date = form.cleaned_data['first_display_date']
                submission_open_date = form.cleaned_data['submission_open_date']
                submission_close_date = form.cleaned_data['submission_close_date']
                review_open_date = form.cleaned_data['review_open_date']
                review_close_date = form.cleaned_data['review_close_date']

                # Create the new assignment object and try saving it
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


@login_required(login_url='/review/login_redirect/')
@user_passes_test(staffTest)
def validateUser(request):
    """
    validates the data for user creation, pretty much the same as the view above
    but for users.  Also creates a new review user for the user
    """
    form = None
    context = {}

    if request.method == "POST":
        # grab form from the request
        form = UserCreationForm(request.POST)

        if form.is_valid():
            try:
                # grab the cleaned data from the form and try creating a
                # new user object
                username = form.cleaned_data['username']
                first_name = form.cleaned_data['first_name']
                last_name = form.cleaned_data['last_name']
                email = form.cleaned_data['email']
                password = form.cleaned_data['password']
                is_staff = form.cleaned_data['is_staff']
                newUser = User.objects.create(username=username,
                                              first_name=first_name,
                                              last_name=last_name,
                                              email=email,
                                              password=password,
                                              is_staff=is_staff)

                newRUser = ReviewUser.objects.create(djangoUser=newUser,
                                                     isStaff=is_staff)
                print User.objects.filter(username=username).count()

                try:
                    newUser.save()
                    newRUser.save()
                except Exception as r:
                    print r.args
                    context['error'] = "Errr Something went wrong, Tom fix this"
                    return render(request, 'admin/userCreate.html', context)

                context['users'] = User.objects.all()
                return render(request, 'admin/userList.html', context)
            except Exception as ValidationError:
                print ValidationError.args

    context['form'] = form
    return render(request, 'admin/userCreate.html', context)


@login_required(login_url='/review/login_redirect/')
@user_passes_test(staffTest)
def validateCourse(request):
    """
    validateCourse validates the data from the course creation template
    If the course is valid then it will create a new object.
    """
    form = None
    context = {}

    if request.method == "POST":
        # grab the form from the template
        form = CourseCreationForm(request.POST)
        if form.is_valid():
            try:
                # grab the cleaned data from the form and try
                # creating a new course object
                course_code = form.cleaned_data['course_code']
                course_name = form.cleaned_data['course_name']
                newCourse = Course.objects.reate(course_code=course_code,
                                                 course_name=course_name)
                try:
                    newCourse.save()
                except:
                    return render(request, '/admin/courseCreate.html', context)

                context['courses'] = Course.objects.all()
                return render(request, 'admin/courseList.html', context)

            except Exception as ValidationError:
                print ValidationError.args

    context['form'] = form
    return render(request, '/admin/courseCreate.html', context)

@login_required(login_url='/review/login_redirect/')
def student_homepage(request):
    """
    Displays all the information for the current user, including upcoming assignments
    and tasks
    """
    context = {}
    U = User.objects.get(id=request.user.id)
    context['user'] = U
    context['open_assignments'] = get_open_assignments(U)
    # For the course template which we inherit from
    context['courses'] = U.reviewuser.courses.all()
    context['form'] = annotationForm()
    return render(request, 'student_homepage.html', context)

def get_open_assignments(user):
    '''
    Grabs the list of currently open assignments for
    the current user
    :user User

    return List[(Course, Assignment)]
    '''
    timenow = timezone.now()
    openAsmts = []
    courses = user.reviewuser.courses.all()
    for course in courses:
        # Get assignments in the course
        assignments = Assignment.objects.filter(course_code__course_code=course.course_code)
        for assignment in assignments:
            if(can_submit(assignment)):
                openAsmts.append((course, assignment))
    return openAsmts

@login_required(login_url='/review/login_redirect/')
def assignment_page(request, course_code, asmt):
    '''
    assignment_page Displays the data for a specific assignment
    :course_code Course.course_code
    :asmt Assignment
    '''
    context = {}

    U = User.objects.get(id=request.user.id)
    courseList = U.reviewuser.courses.all()
    courseCode = course_code.encode('ascii', 'ignore')
    course = Course.objects.get(course_code=courseCode)
    asmtName = asmt.encode('ascii', 'ignore')
    assignment = Assignment.objects.get(name=asmtName)

    context['user'] = U
    context['course'] = course
    context['asmt'] = assignment
    context['courses'] = courseList
    context['canSubmit'] = can_submit(assignment)

    return render(request, 'assignment_page.html', context)

def can_submit(asmt):
    '''
    :asmt Assignment

    Return True if allowed to submit asmt now
    False otherwise
    '''
    now = timezone.now()
    return now < asmt.submission_close_date and now > asmt.submission_open_date


@login_required(login_url='/review/login_redirect/')
def submit_assignment(request, course_code, asmt):
    """
    :request the HTTP request object
    :course_code String course code
    :asmt Assignment the assignment for which we want to submit

    TODO - handle multiple submission and single-submission assignments
           differently
    """
    # Duplicated code... not good.
    context = {}
    U = User.objects.get(id=request.user.id)
    courseList = U.reviewuser.courses.all()
    courseCode = course_code.encode('ascii', 'ignore')
    course = Course.objects.get(course_code=courseCode)
    asmtName = asmt.encode('ascii', 'ignore')
    assignment = Assignment.objects.get(name=asmtName)

    if request.method == 'POST':
        form = AssignmentSubmissionForm(request.POST)
        if form.is_valid():
            # form.save(commit=True)
            repo = request.POST['submission_repository']
            # Create AssignmentSubmission object
            try:
                sub = AssignmentSubmission.objects.create(by=U.reviewuser, submission_repository=repo,
                                                    submission_for=assignment)
                sub.save()
                # Populate databse.
                relDir = os.path.join(courseCode, asmtName)
                populate_db(sub, relDir)
                # User will be shown confirmation.
                template = 'submission_confirmation.html'

            except GitCommandError as giterr:
                print giterr.args
                sub.delete()
                context['errMsg'] = "Something wrong with the repository URL."
                template = 'assignment_submission.html'

        else:
            print form.errors
            context['errMsg'] = "Something wrong with the values you entered; did you enter a blank URL?"
            template = 'assignment_submission.html'

    else: # not POST; show the submission page.
        form = AssignmentSubmissionForm()
        template = 'assignment_submission.html'

    context['form'] = form
    context['course'] = course
    context['asmt'] = assignment
    context['courses'] = courseList

    return render(request, template, context)

@login_required(login_url='/review/login_redirect/')
def createAnnotation(request, submission_uuid, file_uuid):
    """
    Creates an annotation form the currently opened file.
    If it succesfully creates an annotation then the user is returned the current file.

    :submission_uuid - the uuid of the current submission
    :file_uuid - the uuid of the current file
    """
    context = {}

    try:
        print request
        # Get the current user and form data
        currentUser = User.objects.get(id=request.session['_auth_user_id'])
        form = annotationForm(request.GET)
        rangeForm = annotationRangeForm(request.GET)

        text = form['text'].value()
        start = rangeForm['start'].value()
        end = rangeForm['end'].value()

        # TODO This needs a conditional wrapped around it
        form.is_valid()
        rangeForm.is_valid()

        file = SourceFile.objects.get(file_uuid=file_uuid)
        # Create and try saving the new annotation and range
        newAnnotation = SourceAnnotation.objects.create(user=currentUser.reviewuser,
                                                        source=file,
                                                        text=text,
                                                        quote=text)
        newAnnotation.save()
        newRange = SourceAnnotationRange.objects.create(range_annotation=newAnnotation,
                                                        start=start,
                                                        end=end,
                                                        startOffset=start,
                                                        endOffset=end)

        newRange.save()
        print newAnnotation, newRange

        return HttpResponseRedirect('/review/file/' + submission_uuid + '/' + file_uuid + '/')
    except User.DoesNotExist or SourceFile.DoesNotExist:
        return Http404()

    return HttpResponse("test")


@login_required(login_url='/review/login_redirect/')
def grabFile(request):
    """
    this just grabs the file, pygmetizes it and returns it in,
    this gets sent to the ajax request

    This was used in the Ajax version of this application but
    it isn't currently used.
    """
    print request.session['_auth_user_id']
    # get current user
    currentUser = User.objects.get(id=request.session['_auth_user_id'])
    print currentUser
    if request.is_ajax():
        try:
            toGrab = request.GET['uuid']
            path = SourceFile.objects.get(file_uuid=toGrab)
            # get root folder
            iter = path.folder
            while iter.parent is not None:
                iter = iter.parent
            # get owner id
            owner = AssignmentSubmission.objects.get(root_folder=iter).by
            # formatted = path.content
            formatted = highlight(path.content, guess_lexer(path.content),
                                  HtmlFormatter(linenos="table", style="friendly"))

            # get all annotations for the current file
            # if user is the owner of the files or super user get all annotations
            if currentUser.is_staff or currentUser == owner:
                annotations = SourceAnnotation.objects.filter(source=path)
            else:
                annotations = Sou
                rceAnnotation.objects.filter(source=path, user=currentUser.reviewuser)

            annotationRanges = []
            aDict = []

            for a in annotations:
                annotationRanges.append(model_to_dict(SourceAnnotationRange.objects.get(range_annotation=a)))
                aDict.append(model_to_dict(a))

            # create the array to return
            ret = []
            ret.append(formatted)
            # zip up the two annotation lists so they can be called one after each other
            ret.append(zip(aDict, annotationRanges))
            # send the formatted file and the current annotations to the ajax call
            return HttpResponse(json.dumps(ret))
        except SourceFile.doesNotExist:
            print "Source file doesn't not exist"
            return Http404()


def upload(request):
    """
    Test view for uploading files, not needed in the final version
    """
    print "upload"
    if request.method == "POST":
        form = uploadFile(request.POST, request.FILES)
        if form.is_valid():
            print "valid"
            form.save()
            return HttpResponse("Upload")
    else:
        return HttpResponse("Fail")


def reviewFile(request, submissionUuid, file_uuid):
    """
    Grabs all the files for the current submission, but it also
    grabs and pygmentizes the current file.
    :submissionUuid - current submission identifier
    :file_uuid - the identifier of the rile to be annotated.
    """
    uuid = submissionUuid.encode('ascii', 'ignore')
    file_uuid = file_uuid.encode('ascii', 'ignore')
    context = {}
    currentUser = User.objects.get(id=request.session['_auth_user_id'])
    print currentUser

    try:
        file = SourceFile.objects.get(file_uuid=file_uuid)
        print 'get file'
        code = highlight(file.content, guess_lexer(file.content),
                         HtmlFormatter(linenos="table"))
        print code
        folders = []

        sub = AssignmentSubmission.objects.get(submission_uuid=uuid)
        for f in sub.root_folder.files.all():
            folders.append(f)
        for f in sub.root_folder.folders.all():
            folders.append(f)
            for s in f.files.all():
                folders.append(s)
        # root_files = sub.root_folder.files

        # get root folder
        iter = file.folder
        while iter.parent is not None:
            iter = iter.parent
        # get owner id
        owner = AssignmentSubmission.objects.get(root_folder=iter).by

        # get all annotations for the current file
        # if user is the owner of the files or super user get all annotations
        if currentUser.is_staff or currentUser == owner:
            annotations = SourceAnnotation.objects.filter(source=file)
        else:
            annotations = SourceAnnotation.objects.filter(source=file, user=currentUser.reviewuser)

        annotationRanges = []
        aDict = []

        for a in annotations:
            annotationRanges.append(SourceAnnotationRange.objects.get(range_annotation=a))
            aDict.append(a)

        print annotationRanges
        form = annotationForm()
        rangeForm = annotationRangeForm()
        context['annotations'] = zip(aDict, annotationRanges)
        context['sub'] = submissionUuid
        context['form'] = form
        context['rangeform'] = rangeForm
        # files = root_files.all()
        context['uuid'] = file_uuid
        context['files'] = folders
        context['code'] = code
        # context['files'] = files
        # context['files'] = get_list(sub.root_folder, [])
        return render(request, 'review.html', context)

    except AssignmentSubmission.DoesNotExist:
        return Http404()

def review(request, submissionUuid, **kwargs):
    """
    review simply grabs all the files for the current submission.
    """
    uuid = submissionUuid.encode('ascii', 'ignore')
    context = {}

    print "normal review"
    try:
        file= None
        code = None
        if 'uuid' in kwargs.keys():
            print "get file"

            file = SourceFile.objects.get(file_uuid=uuid)
            code = highlight(file.content, guess_lexer(file.content),
                             HtmlFormatter(linoes="table"))

        folders = []

        sub = AssignmentSubmission.objects.get(submission_uuid=uuid)
        for f in sub.root_folder.files.all():
            folders.append(f)
        for f in sub.root_folder.folders.all():
            folders.append(f)
            for s in f.files.all():
                folders.append(s)
        # root_files = sub.root_folder.files

        context['sub'] = submissionUuid
        # files = root_files.all()
        context['files'] = folders
        context['code'] = code
        # context['files'] = files
        # context['files'] = get_list(sub.root_folder, [])
        return render(request, 'review.html', context)

    except AssignmentSubmission.DoesNotExist:
        return Http404()

def get_list(root_folder, theList):
    """
    Gets all the folders and files underneath root_folder
    as a list of lists (of lists etc.)
    Format like this:
    [root_folder, Folder1, Folder2, [Folder1, sub-folder-of-folder1, file1..], [Folder2, ...]]

    :root_folder SourceFolder
    """

    theList.append(root_folder)

    # Files directly under root_folder
    files = root_folder.files.all()

    # Folders directly under root_folder
    folders = root_folder.folders.all()
    for folder in folders:
        theList.append(folder)

    for file in files:
        theList.append(file)

    # Now get everything underneath the folders in root_folder
    for folder in folders:
        theList.append(get_list(folder, []))

    return theList
