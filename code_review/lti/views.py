"""
Code originally sourced from: 
    https://pypi.python.org/pypi/django-uocLTI/0.1.2
lti/views.py contains the controller for handling LTI-related requests,
namely the launch request, which sends the Learning Management System's (LMS)
user and course details and causes the CPRS to show the home page of the
appropriate user. 

Methods:
    launch_lit -- launches the CPRS.

"""

from django.contrib.auth import login
from django.http import HttpResponseRedirect
from django.template import RequestContext
from django.shortcuts import get_object_or_404, render_to_response
from ims_lti_py.tool_provider import DjangoToolProvider
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User
from django.core.exceptions import PermissionDenied

from django.conf import settings 
from utils import *
from models import *
from review.models import *

@csrf_exempt
def launch_lti(request):
    """Process launch (start cprs) request from a leaning management system.
    This was modified from the original source.

    The method extracts the user's details such as name, ID, email, course
    and role (e.g., teacher, student) from the request and checks whether the
    user has permission to enter the system (see Raises section for details). 
    If the user has permission, then the corresponding CPRS user is retrieved
    or created. The user's enrolments in the CPRS are updated with the course
    information in the request. The user is then redirected to his/her home page
    in the CPRS. 

    Arguments:
        request (HttpRequest) -- the Http request sent by the LMS. 

    Returns:
        HttpResponseRedirect which redirects the user to their home page
        in the CPRS if they have permission to access the system, or an error page
        if their role is not allowed.

    Raises:
        PermissionDenied -- if the user does not have permission to access the system. 
                            this happens if:
                                - the request does not contain an email or user id
                                - the role sent in the request is None 
                                - the authentication key is missing 
                                - the request is not valid. 
    """

    print "LAUNCH LTI HAS BEEN CALLED!!!"
    """ Receives a request from the lti consumer and creates/authenticates user in django """
    """ See post items in log by setting LTI_DEBUG=True in settings """    
    if settings.LTI_DEBUG:
        for item in request.POST:
            print ('%s: %s \r' % (item, request.POST[item]))

    if 'oauth_consumer_key' not in request.POST:
        raise PermissionDenied()  
    
    """ key/secret from settings """
    consumer_key = settings.CONSUMER_KEY 
    secret = settings.LTI_SECRET    
    tool_provider = DjangoToolProvider(consumer_key, secret, request.POST)

    """ Decode parameters - UOC LTI uses a custom param to indicate the encoding: utf-8, iso-latin, base64 """
    encoding = None
    utf8 = get_lti_value('custom_lti_message_encoded_utf8', tool_provider)         
    iso = get_lti_value('custom_lti_message_encoded_iso', tool_provider)       
    b64 = get_lti_value('custom_lti_message_encoded_base64', tool_provider)  

    if iso and int(iso) == 1: encoding = 'iso'
    if utf8 and int(utf8) == 1: encoding = 'utf8'
    if b64 and int(b64) == 1: encoding = 'base64'
    
    try: # attempt to validate request, if fails raises 403 Forbidden
        if tool_provider.valid_request(request) == False:
            raise PermissionDenied()
    except:
        print "LTI Exception:  Not a valid request."
        raise PermissionDenied() 
    
    """ RETRIEVE username, names, email and roles.  These may be specific to the consumer, 
    in order to change them from the default values:  see README.txt """
    first_name = get_lti_value(settings.LTI_FIRST_NAME, tool_provider, encoding=encoding)
    last_name = get_lti_value(settings.LTI_LAST_NAME, tool_provider, encoding=encoding)
    email = get_lti_value(settings.LTI_EMAIL, tool_provider, encoding=encoding)
    course = request.POST['context_label']
    print course
    # for s in dir(settings):
    #     print s, ':', getattr(settings, s)
    
#    avatar = tool_provider.custom_params['custom_photo'] 
    roles = get_lti_value(settings.LTI_ROLES, tool_provider, encoding=encoding)
    # uoc_roles = get_lti_value(settings.LTI_CUSTOM_UOC_ROLES, tool_provider, encoding=encoding)
    user_id = get_lti_value('user_id', tool_provider, encoding=encoding)
    test = get_lti_value('context_title', tool_provider, encoding=encoding)

    if not email or not user_id:
        if settings.LTI_DEBUG: print "Email and/or user_id wasn't found in post, return Permission Denied"
        raise PermissionDenied()    
    
    """ CHECK IF USER'S ROLES ALLOW ENTRY, IF RESTRICTION SET BY VELVET_ROLES SETTING """
    if settings.VELVET_ROLES:
        """ Roles allowed for entry into the application.  If these are not set in settings then we allow all roles to enter """
        if not roles and not uoc_roles:
            """ if roles is None, then setting for LTI_ROLES may be wrong, return 403 for user and print error to log """
            if settings.LTI_DEBUG: print "VELVET_ROLES is set but the roles for the user were not found.  Check that the setting for LTI_ROLES is correct."
            raise PermissionDenied()

        all_user_roles = []
        if roles:
            if not isinstance(roles, list): roles = (roles,)
            all_user_roles += roles
        if uoc_roles:
            if not isinstance(uoc_roles, list): uoc_roles = (uoc_roles,)
        all_user_roles += uoc_roles

        is_role_allowed = [m for velvet_role in settings.VELVET_ROLES for m in all_user_roles if velvet_role.lower()==m.lower()]

        if not is_role_allowed:
            if settings.LTI_DEBUG: print "User does not have accepted role for entry, roles: %s" % roles
            ctx = {'roles':roles, 'first_name':first_name, 'last_name':last_name, 'email':email, 'user_id':user_id}
            return render_to_response('lti_role_denied.html', ctx, context_instance=RequestContext(request))
        else:
            if settings.LTI_DEBUG: print "User has accepted role for entry, roles: %s" % roles
    
    """ GET OR CREATE NEW USER AND LTI_PROFILE """
    lti_username = '%s:user_%s' % (request.POST['oauth_consumer_key'], user_id) #create username with consumer_key and user_id
    try:
        """ Check if user already exists using email, if not create new """    
        user = User.objects.get(email=email)
        if user.username != lti_username:
            """ If the username is not in the format user_id, change it and save.  This could happen
            if there was a previously populated User table. """
            user.username = lti_username
            user.save()
        try:
            print "adding course"
            print('course is ' + course)
            print(type(course))
            c = Course.objects.get(course_code=course)
            if c not in user.reviewuser.courses.all():
                user.reviewuser.courses.add(c)
                user.save()
        except Course.DoesNotExist:
            # Make course and enrol user in it. 
            c = Course.objects.create(course_code=course)
            user.reviewuser.courses.add(c)
            user.save()
            print("New course created in CPRS")

    except User.DoesNotExist:
        """ first time entry, create new user """
        print lti_username, email
        user = User.objects.create_user(lti_username, email)
        user.set_unusable_password()
        if first_name: user.first_name = first_name
        if last_name: user.last_name = last_name
        user.save()
        ru = ReviewUser.objects.create(djangoUser=user)
        ru.save()
        try:
            print "adding course"
            c = Course.objects.get(course_code=course)
            ru.courses.add(c)
            ru.save()
        except Course.DoesNotExist:
            # Make course and enrol user in it. 
            c = Course.objects.create(course_code=course)
            ru.courses.add(c)
            ru.save()
            print("New course created in CPRS")

            
    except User.MultipleObjectsReturned:
        """ If the application is not requiring unique emails, multiple users may be returned if there was an existing
        User table before implementing this app with multiple users for the same email address.  Could add code to merge them, but for now we return 404 if 
        the user with the lti_username does not exist """    
        user = get_object_or_404(User, username=lti_username)
            
    """ CHECK IF ANY OF USER'S ROLES ARE IN THE VELVET_ADMIN_ROLES SETTING, IF SO MAKE SUPERUSER IF IS NOT ALREADY """
    if not user.is_superuser and settings.VELVET_ADMIN_ROLES:
        if [m for l in settings.VELVET_ADMIN_ROLES for m in roles if l.lower() in m.lower()]:
            user.is_superuser = True
            user.is_staff = True
            user.save()
    
    """ Save extra info to custom profile model (add/remove fields in models.py)""" 
    print "lti_userprofile"
    # lti_userpro = LTIProfile.objects.create(user=user)
    # lti_userpro.save()
    # lti_userprofile = LTIProfile.objects.get_or_create(user=user)
    # lti_userprofile.roles = (",").join(all_user_roles)
#    lti_userprofile.avatar = avatar  #TO BE ADDED:  function to grab user profile image if exists
    # lti_userprofile.save()
    
    """ Log in user and redirect to LOGIN_REDIRECT_URL defined in settings (default: accounts/profile) """
    user.backend = 'django.contrib.auth.backends.ModelBackend'
    login(request, user)

    # return HttpResponseRedirect(settings.LOGIN_REDIRECT_URL) 
    return HttpResponseRedirect('/review/')
    
