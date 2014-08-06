from django.shortcuts import render, redirect
from django.http import HttpResponse

# authentication libraries
# base django user system
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout

from django.contrib.auth.decorators import login_required

from review.models import *


@login_required(login_url='/review/login_redirect/')
def index(request):
    return render(request, 'index.djhtml', {'name': 'tom'})

def loginView(request):
    print "\n\n\n"
    print request.method
    return render(request, 'login.djhtml')
    
def loginUser(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        user = authenticate(username=username, password=password)
        print username
        print user
        if user is not None:
            login(request, user)
            print "logged in"
            # return HttpResponse("logged in")
            return redirect('/review/')


    return redirect('/review/login_redirect/')

def logout(request):
    logout(request)
    return HttpResponse("logout")
    # return redirect('/review/')
    
