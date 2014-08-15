from django.conf.urls import patterns, include, url

from review import views

urlpatterns = patterns('',
                       # Default view, routes to the index page
                       url(r'^$', views.index, name='index'),
                       # will redirect to the login_redirect if the user isn't
                       #authenticated.  This can probably be removed
                       # url(r'login/$', views.loginUser, name='login'),
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
                       url(r'register/$', views.index, name='register'),
                       url(r'password_change/$', 'django.contrib.auth.views.password_change',
                           name='password_change'),
                       url(r'password_change_done/$', 'django.contrib.auth.views.password_change_done',
                           name='password_change_done'),
                       url(r'course_admin/$', views.index, name='default'),
                       url(r'course_admin/(?P<course_code>[A-Z]{4}[0-9]{4})/$',
                           views.adminRedirect, name='adminRedirect'),
                       url(r'create_assignment/(?P<course_code>[A-Z]{4}[0-9]{4})/$',
                           views.create_assignment, name='create_assignment'),
                       url(r'generate_assignment/$', views.validateAssignment, name='generate_assignment'),
)
