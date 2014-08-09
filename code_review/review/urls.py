from django.conf.urls import patterns, include, url

from review import views

urlpatterns = patterns('',
                       # Default view, routes to the index page
                       url(r'^$', views.index, name='index'),
                       # will redirect to the login_redirect if the user isn't
                       #authenticated.  This can probably be removed 
                       url(r'login/$', views.loginUser, name='login'),
                       # the user gets redirected to this page if they
                       # aren't logged in. Uses django's 
                       url(r'login_redirect/$', 'django.contrib.auth.views.login',
                           {'template_name':  'login.html'},
                           name='login_redirect'),
                       # Uses djangos logout view to logout the user and redirect them to
                       # the index page
                       url(r'logout/$', 'django.contrib.auth.views.logout',
                           {'next_page': '/review/'}, name='logout'),
                       # Furture route to register new users.  This probably won't be used
                       url(r'reigster/$', views.index, name='register'),
                       
)