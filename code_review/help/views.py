from django.shortcuts import render
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, HttpResponseRedirect, Http404, HttpResponseNotFound
from django.contrib.auth.decorators import login_required, user_passes_test

# import models from review
from review.models import *
from review.views import error_page
from review.forms import annotationForm, annotationRangeForm
# import needed code from help
from help.models import Post

from help.forms import postForm, editForm

from git_handler import *

@login_required(login_url='/review/login_direct/')
def index(request, course_code):

    """
    This is the default index page for the help application. It shows the currently open
    posts and allows the user to view their posts and create a new post.

    Parameters:
    request (HttpRequest) -- request from the user to view the help page

    Returns:
    HttpResponse rendering the page, or a relevant error page.
    """

    context = {}
    course_code = course_code.encode('ascii', 'ignore')
    openPosts = []
    U = None
    try:
        # Get the course object for the course code
        c = Course.objects.get(course_code=course_code)
        # get all the open posts for the course and sort them by creation date
        openPosts = c.posts.all().filter(open=True).order_by('-created')
        U = User.objects.get(id=request.user.id)
    except User.DoesNotExist:
        error = "User %s does not exist" % request.user
        error_page(request, error)
    except Course.DoesNotExist:
        error = "Course %s does not exist" % course_code
        error_page(request, error)

    context['user'] = U
    context['course_code'] = course_code
    context['Posts'] = openPosts
    print "help index"
    return render(request, 'help.html', context)


def newPost(request, course_code):

    """
    Displays all the data for creating a new help post

    Parameters:
    request (HttpRequest) -- request from the user to start creating a new post

    Returns:
    HttpReponse rendering the new post page or a redirect to an relevant error page.
    """

    context = {}
    course_code = course_code.encode('ascii', 'ignore')
    print "new post"
    U = None
    try:
        U = User.objects.get(id=request.user.id)
    except User.DoesNotExist:
        error = "User %s does not exist" % request.user
        error_page(request, error)

    form = postForm()
    context['user'] = U
    context['course_code'] = course_code
    context['form'] = form
    return render(request, 'new_post.html', context)


def createPost(request, course_code):

    """
    Validate the data from the new post form, grabs the form data
    from the post request to generate data for the new Post object

    Parameters:
    request (HttpRequest) -- http request from the user to create a new Post

    Returns:

    """

    context = {}
    form = {}
    course_code = course_code.encode('ascii', 'ignore')
    print "creating course"
    if request.method == "POST":
        form = postForm(request.POST)
        # print request
        if form.is_valid():
            title = form.cleaned_data['title']
            repo = form.cleaned_data['submission_repository']
            question = form.cleaned_data['question']

            try:
                print "Creating Post"
                U = User.objects.get(id=request.user.id)
                c = Course.objects.get(course_code=course_code)
                post = Post.objects.create(by=U.reviewuser,
                                           course_code=c,
                                           question=question,
                                           title=title,
                                           submission_repository=repo)
                post.save()
                relDir = os.path.join('help', post.by.djangoUser.username)
                populate_db(post, relDir)

                return HttpResponseRedirect('/help/' + course_code)
            except GitCommandError as giterr:
                print giterr.args
                sub.delete()
                context['errMsg'] = "Something wrong with the repository URL."
                template = 'new_post.html'

        else:
            print form.errors
            context['course_code'] = course_code
            context['errMsg'] = "Something wrong with the values you entered; did you enter a blank URL?"

    context['form'] = form

    return render(request, 'new_post.html', context)


def viewPost(request, post_uuid):

    """
    view a post from the help system

    Parameters:
    request (HttpRequest) -- request from the user to view the post
    postUuid (String) -- identifier for the specific post

    Returns:

    """
    context = {}
    uuid = post_uuid.encode('ascii','ignore')
    try:
        file = None
        code = None
        folders = []

        # grab the submission and the associated files and folders

        post = Post.objects.get(post_uuid=uuid)
        # for f in post.root_folder.files.all():
        #     folders.append(f)
        #     for f in post.root_folder.folders.all():
        #         folders.append(f)
        #         for s in f.files.all():
        #             folders.append(s)
                    # root_files = post.root_folder.files

        user = User.objects.get(id=request.session['_auth_user_id'])
        folders = grabPostFiles(post.root_folder)
        # return all the data for the postmission to the context
        context['user'] = user
        context['question'] = post.question
        context['title'] = post.title
        context['post'] = post
        context['course_code'] = post.course_code.course_code
        # files = root_files.all()
        context['files'] = folders
        context['code'] = code
        edit = editForm(instance=post)
        context['editForm'] = edit

        # context['files'] = files
        # context['files'] = get_list(post.root_folder, [])
        return render(request, 'view_post.html', context)

    except Post.DoesNotExist:
        raise Http404


def viewPostFile(request, post_uuid, file_uuid):

    """
    View a specific file from the post

    Parameters:
    parameters

    Returns:
    returns
    """
    uuid = post_uuid.encode('ascii', 'ignore')
    print post_uuid
    print "Post uuid %s " % uuid
    file_uuid = file_uuid.encode('ascii', 'ignore')
    context = {}
    try:
        form = annotationForm()
        rangeForm = annotationRangeForm()

        currentUser = User.objects.get(id=request.session['_auth_user_id'])
        context = grabPostFileData(request, uuid, file_uuid)
        print context
        print uuid
        # context['post'] = uuid
        context['form'] = annotationForm()
        context['rangeform'] = rangeForm
        context['editForm'] = editForm()
        return render(request, 'view_post.html', context)

    except User.DoesNotExist:
        error = "User does not exist"
        error_page(request, error)


def grabPostFileData(request, submissionUuid, file_uuid):
    """
    Refactored from reviewFile so cut down on code repetition.
    Grabs a dictionary containng all the file information.

    Parameters:
    submission_uuid (string) - identifier for the submission
    file_uuid (string) - identifier for the file

    Returns:
    type
    """
    context = {}
    uuid = submissionUuid
    try:
        currentUser = User.objects.get(id=request.session['_auth_user_id'])
        print currentUser
        file = SourceFile.objects.get(file_uuid=file_uuid)
        print 'get file'
        code = highlight(file.content, guess_lexer(file.content),
                         HtmlFormatter(linenos="table"))
        print code
        folders = []

        # grab submission and all the associated files and folders

        post = Post.objects.get(post_uuid=uuid)
        folders = grabPostFiles(post.root_folder)
        # for f in post.root_folder.files.all():
        #     folders.append(f)
        # for f in post.root_folder.folders.all():
        #     folders.append(f)
        #     for s in f.files.all():
        #         folders.append(s)

        # get root folder
        iter = file.folder
        while iter.parent is not None:
            iter = iter.parent
        # get owner id
        owner = Post.objects.get(root_folder=iter).by

        # get all annotations for the current file
        # if user is the owner of the files or super user get all annotations
        # if currentUser.is_staff or currentUser == owner:
        #     annotations = SourceAnnotation.objects.filter(source=file)
        # else:
        annotations = SourceAnnotation.objects.filter(source=file, user=currentUser.reviewuser)

        annotationRanges = []
        # aDict = []

        # get all the ranges for the annotations
        for a in annotations:
            ranges = a.ranges.all()
            for r in ranges:
                annotationRanges.append(r)
            # annotationRanges.append(SourceAnnotationRange.objects.get(range_annotation=a))
            # aDict.append(a)

        # print annotationRanges

        annotationRanges.sort(key=lambda x: x.start)
        sortedAnnotations = []
        # grab the annotations again based on the sorted order
        for a in annotationRanges:
            sortedAnnotations.append(a.range_annotation)

        context['annotations'] = zip(sortedAnnotations, annotationRanges)
        context['post_uuid'] = submissionUuid
        context['post'] = post
        context['course_code'] = post.course_code.course_code
        context['uuid'] = file_uuid
        context['files'] = folders
        context['code'] = code
        context['file'] = file
        context['title'] = post.title
        context['question'] = post.question
        return context
    except AssignmentSubmission.DoesNotExist:
        error_page(request, "Submission does not exit")


def deletePost(request, course_code, post_uuid):

    currentUser = User.objects.get(id=request.session['_auth_user_id'])
    course_code = course_code.encode('ascii', 'ignore')
    try:
        post = Post.objects.get(post_uuid=post_uuid)
        if post.by == currentUser.reviewuser or currentUser.reviewuser.isStaff:
            post.delete()
        else:
            error_page(request, "you're trying to delete something you don't have the persmissions for")

        return HttpResponseRedirect('/help/' + course_code)
    except Post.DoesNotExit:
        error_page(request, "Post does not exist")
    return HttpResponse("delete")


def updatePost(request, post_uuid):

    """
    Updates a post uses a model on the view_post template, users can only edit
    the title and question of the post.

    Parameters:
    request (HttpRequest) -- request from the user to update a post

    Returns:
    HttpReponse to render with the post view or an error page
    """

    uuid = post_uuid.encode('ascii', 'ignore')
    print uuid
    if request.method == "POST":
        try:
            form = editForm(request.POST)
            if form.is_valid():
                title = form.cleaned_data['title']
                question = form.cleaned_data['question']
                print title, question
                post = Post.objects.get(post_uuid=uuid)
                post.title = title
                post.question = question
                post.save()
                return HttpResponseRedirect("/help/view/" + uuid + '/')
            else:
                post = Post.objects.get(post_uuid=uuid)
                folders = grabPostFiles(post.root_folder)
                context = {}
                context['editForm'] = editForm(request.POST)
                context['post'] = post
                context['question'] = post.question
                context['title'] = post.title
                context['course_code'] = post.course_code.course_code
                context['user'] = post.by.djangoUser
                context['editError'] = True
                context['files'] = folders
                return render(request, 'view_post.html', context)
        except Post.DoesNotExist:
            error_page(request, "Post does not exist")

    else:
        # Request is not a POST request, redirect back to the help index page
        return HttpResponseRedirect('/help')


def grabPostFiles(root):
    # dfs first search
    folders = []
    s = []
    s.append(root)
    while len(s) > 0:
        v = s.pop()
        if v not in folders:
            folders.append(v)
            print v
            for i in v.folders.all():
                s.append(i)
            for i in v.files.all():
                if i not in folders:
                    folders.append(i)
    
    return folders
