"""
help/views.py - handles all the controllers for the help application.

"""
from django.shortcuts import render
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, HttpResponseRedirect, Http404, HttpResponseNotFound
from django.contrib.auth.decorators import login_required, user_passes_test

# import models and required forms from the review application.
from review.models import *
from review.forms import annotationForm, annotationRangeForm, editAnnotationForm

# import needed code from help
from help.models import Post
from help.forms import postForm, editForm

# import required modules for git uploading of code`
from pygit2 import GitError
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
    course_code (string) -- course code for the course for which the help
                            post is being created.
    Returns:
    HttpResponse rendering the view post page. If the git repo requires 
    a username and password the user will first be required to enter their username
    and password before the post is created.
    """

    context = {}
    form = {}
    course_code = course_code.encode('ascii', 'ignore')
    context['course_code'] = course_code
    print "creating course"
    if request.method == "POST":
        form = postForm(request.POST)

        # check that the form is valid
        if form.is_valid():
            title = form.cleaned_data['title']
            repo = form.cleaned_data['submission_repository']
            question = form.cleaned_data['question']

            try:
                # attempt to create the post
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
                (absolutePath, rootFolderName) = abs_repo_path(post, relDir)
                username = request.POST.get('repoUsername', False)
                password = request.POST.get('repoPassword', False)
                print username
                print password
                # clone the repo to the local directory
                if(username and password):
                    clone(repo, absolutePath, username=username, password=password)
                else:
                    clone(repo, absolutePath)

                populate_from_local(absolutePath, rootFolderName, post, relDir)

                return HttpResponseRedirect('/help/' + course_code)

            except GitError as ge:
                msg = ge.message
                print msg
                
                if(msg == 'authentication required but no callback set'):
                    # this means they need to input a username and pasword, redirects back to the
                    # create post page
                    context['pswd_auth'] = True
                    form.submission_repository = repo
                    form.fields['submission_repository'].widget.attrs['readonly'] = True
                    post.delete()

                elif(msg == 'Unsupported URL protocol'):
                    # Means they entered rubbish in the url field
                    context['errMsg'] = 'What you entered is not a valid url; remember to include https://'
                    sub.delete()

                elif('Connection timed out' in msg):
                    # They entered what looks like a URL but isn't an existing repo
                    context['errMsg'] = 'Please check your url.' 
                    post.delete()

                elif(msg == u"This transport isn\'t implemented. Sorry"):
                    # Private repo with ssh set up. Call old populate_db. 
                    print "Private repo with ssh set up."
                    try:
                        populate_db(post, relDir)
                        post.save()
                        template = "view_post.html"
                        print "All good."
                    except GitCommandError as ohNo:
                        print ohNo.args
                        context['errMsg'] = "Something went wrong! Please check your URL (did you type in a non-existent protocol like httomps instead of http? If that doesn't work, please contact sysadmin."
                        post.delete()
                
                elif(msg == 'Unexpected HTTP status code: 401'):
                    # Incorrect username or password 
                    context['errMsg'] = "Username and/or password incorrect."
                    context['pswd_auth'] = True
                    # Disable editing url field 
                    form.fields['submission_repository'].widget.attrs['readonly'] = True
                    post.delete()
                elif('404' in msg or 'Failed to resolve address' in msg):
                    context['errMsg'] = 'The URL appears incorrect... is this really your repo?' 
                    post.delete()
                else:
                    print msg
                    context['errMsg'] = 'Something is REALLY wrong. Please contact alex.hs.lee@gmail.com'
                    post.delete()

            except ValueError as verr:
                if('invalid url' in verr.message):
                    context['errMsg'] = "The URL is not correct."
                    post.delete()
                else:
                    print verr.message
                    context['errMsg'] = "We are sorry but we don't know what's wrong. Please contact the                                            sysadmin. Maybe you'll get an extension on your assignment?"

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
    postUuid (UUID) -- identifier for the specific post

    Returns:
    HttpResponse redirecting the user to the desired post page.
    """
    context = {}
    uuid = post_uuid.encode('ascii','ignore')
    try:
        file = None
        code = None
        folders = []

        # grab the submission and the associated files and folders
        post = Post.objects.get(post_uuid=uuid)

        user = User.objects.get(id=request.session['_auth_user_id'])
        folders = grabPostFiles(post.root_folder)
        # return all the data for the postmission to the context
        context['user'] = user
        context['question'] = post.question
        context['title'] = post.title
        context['post'] = post
        context['course_code'] = post.course_code.course_code
        context['files'] = folders
        context['code'] = code
        edit = editForm(instance=post)
        context['editForm'] = edit

        return render(request, 'view_post.html', context)

    except Post.DoesNotExist:
        raise Http404


def viewPostFile(request, post_uuid, file_uuid):

    """
    View a specific file from the post

    Parameters:
    requet (HTTPRequest) - request from the user to view the help post.
    post_uuid (UUIDField) - identifier for the help post.
    file_uuid (UUIDField) - identifier for the current file being viewed.

    Returns:
    HttpReponse showing the user the desired file from the post.

    """
    uuid = post_uuid.encode('ascii', 'ignore')
    file_uuid = file_uuid.encode('ascii', 'ignore')
    context = {}
    try:
        # create the forms for creating annotations
        form = annotationForm()
        rangeForm = annotationRangeForm()

        currentUser = User.objects.get(id=request.session['_auth_user_id'])
        # grab the annotations on the file along with the code for the file
        context = grabPostFileData(request, uuid, file_uuid)
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
    A context dictionary representing all the data required for the views.
    """
    context = {}
    uuid = submissionUuid
    try:
        currentUser = User.objects.get(id=request.session['_auth_user_id'])
        print currentUser
        file = SourceFile.objects.get(file_uuid=file_uuid)
        print 'get file'
        folders = []

        # grab submission and all the associated files and folders

        post = Post.objects.get(post_uuid=uuid)
        folders = grabPostFiles(post.root_folder)

        # get root folder
        iter = file.folder
        while iter.parent is not None:
            iter = iter.parent
        # get owner id
        owner = Post.objects.get(root_folder=iter).by

        # get all annotations for the current file
        # if user is the owner of the files or super user get all annotations
        annotations = SourceAnnotation.objects.filter(source=file, user=currentUser.reviewuser)

        annotationRanges = []

        # get all the ranges for the annotations
        for a in annotations:
            ranges = a.ranges.all()
            for r in ranges:
                annotationRanges.append(r)

        # sort all the annotations so they appear in order
        annotationRanges.sort(key=lambda x: x.start)
        sortedAnnotations = []
        # grab the annotations again based on the sorted order
        for a in annotationRanges:
            sortedAnnotations.append(a.range_annotation)
        editForms = []
        for a in sortedAnnotations:
            editForms.append(editAnnotationForm(instance=a))
        annotationRanges.sort(key=lambda x: x.start)

        # grab lines that need to be highlighted
        hl_lines = []
        for i in annotationRanges:
            hl_lines.append(i.start)

        # render the code from the file as html, highlighting the annotated lines
        code = highlight(file.content, guess_lexer(file.content),
                         HtmlFormatter(linenos="inline", hl_lines=hl_lines))

        # zip up the annotations, their ranges and the editforms for displaying on the template
        context['annotations'] = zip(sortedAnnotations, annotationRanges, editForms)
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
    except Post.DoesNotExist:
        error_page(request, "Submission does not exit")


def deletePost(request, course_code, post_uuid):
    
    """
    Delete a post from the system
    
    Parameters:
    request (HttpRequest) - Request from the user to delete a specific post
    course_code (String) - string representing the course code of the post
    post_uuid (UUID) - identifier for the post to be deleted.

    Returns:
    HTTPReponse deleting the post and redirecting the user to the view post page. 
    """

    currentUser = User.objects.get(id=request.session['_auth_user_id'])
    course_code = course_code.encode('ascii', 'ignore')
    try:
        print "deleted"
        post = Post.objects.get(post_uuid=post_uuid)
        if post.by == currentUser.reviewuser or currentUser.is_staff:
            post.delete()
        else:
            error_page(request, "you're trying to delete something you don't have the persmissions for")

        return HttpResponseRedirect('/help/' + course_code)
    except Post.DoesNotExist:
        error_page(request, "Post does not exist")


def resolvePost(request, course_code, post_uuid):
    
    """
    Marks a post as resolved by the user.
    
    Parameters:
    request (HttpRequest) -- request from the user to resolve the post
    course_code (String) -- course code of the specific post
    post_uuid (UUID) -- identifier for the post
    
    Returns:
    HttpResponse -- Redirects the user to view post page and makes the post as resolved or unresolved.
    If there is an error it will redirect to the error page.
    """

    currentUser = User.objects.get(id=request.session['_auth_user_id'])
    course_code = course_code.encode('ascii', 'ignore')
    try:
        # grab post and toggle resolving.
        post = Post.objects.get(post_uuid=post_uuid)
        if post.resolved is False:
            post.resolved = True
        else:
            post.resolved = False
        post.save()
        return HttpResponseRedirect('/help/' + course_code)
    except Post.DoesNotExist:
        error_page(request, "Post does not exist")
    return HttpResponseRedirect('/help/' + course_code)


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
                # if the form is valid then change the post information
                # then redirect to the post's page
                title = form.cleaned_data['title']
                question = form.cleaned_data['question']
                print title, question
                post = Post.objects.get(post_uuid=uuid)
                post.title = title
                post.question = question
                post.save()
                return HttpResponseRedirect("/help/view/" + uuid + '/')
            else:
                # the post is invalid so redirect to the post page and open
                # the modal with all the invalid form information in it.
                post = Post.objects.get(post_uuid=uuid)
                folders = grabPostFiles(post.root_folder)
                # create the context dictionary with all the required information
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


def grabPostFiles(dir, prefix=""):
    files = []
    
    for folder in dir.folders.all():
        files = files + grabPostFiles(folder, prefix + "/" + folder.name)

    for file in dir.files.all():
        file.path = prefix + "/" + file.name
        files.append(file)

    return files

    
def error_page(request, message):
    """Display an error page with Http status 404.

    Arguments:
        request (HttpRequest) -- the request which provoked the error.
        message (String) -- message to display on the 404 page.

    Returns:
        HttpResponse object to display error page.
    """
    context = {'errorMessage': message}
    return render(request, 'error.html', context, status=404)
