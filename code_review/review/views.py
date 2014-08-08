from django.shortcuts import render, redirect
from django.http import HttpResponse

# authentication libraries
# base django user system
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout

# we can use this as a pre condition for any method that requires the user to be logged in
# which will probably be all of them.  You can see below that the index method uses this
from django.contrib.auth.decorators import login_required

from review.models import *


# this is the basic index view, it required login before the user can do any
# as you can see at the moment this shows nothing other than a logout button
# as I haven't added any content to it yet
@login_required(login_url='/review/login_redirect/')
def index(request):
    
    return render(request, 'index.djhtml', {'name': 'tom'})
    
def loginUser(request):
    pass
    # this is useless code at the moment.  Originally I was using it to log in
    # users but i changed it to use django's auth system
    # This will probably just be deleted in the future
    
    # if request.method == 'POST':
    #     username = request.POST['username']
    #     password = request.POST['password']

    #     user = authenticate(username=username, password=password)
    #     print username
    #     print user
    #     if user is not None:
    #         login(request, user)
    #         print "logged in"
    #         # return HttpResponse("logged in")
    #         return redirect('/review/')


    # return redirect('/review/login_redirect/')


# simply logs the user out
def logout(request):
    logout(request)
    return HttpResponse("logout")
    # return redirect('/review/')
    
