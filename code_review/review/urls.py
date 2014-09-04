from django.conf.urls import patterns, include, url

from review import views

urlpatterns = patterns('',
                       # Default view, routes to the index page
                       url(r'^$', views.index, name='index'),

                       # will redirect to the login_redirect if the user isn't
                       # authenticated.  This can probably be removed
                       # url(r'login/$', views.loginUser, name='login'),
                       # the user gets redirected to this page if they
                       # aren't logged in. Uses django's
                       url(r'login_redirect/$',
                           'django.contrib.auth.views.login',
                           {'template_name':  'login.html'},
                           name='login_redirect'),

                       # Uses djangos logout view to logout the user and redirect them to
                       # the index page

                       url(r'logout/$', 'django.contrib.auth.views.logout',
                           {'next_page': '/review/'}, name='logout'),
                       # Furture route to register new users.  This probably won't be used
                       url(r'register/$', views.index, name='register'),


                       # routes for viewing users and courses for superuser
                       url(r'courses/$', views.courseAdmin, name='courseList'),
                       url(r'users/$', views.userAdmin, name='userList'),

                       # course administration routes

                       url(r'course_admin/$', views.index, name='default'),

                       # individual course pages
                       url(r'course/(?P<course_code>[A-Z]{4}[0-9]{4})/$',
                           views.coursePage, name='coursePage'),

                       # Assignment creation and validation
                       url(r'create_assignment/(?P<course_code>[A-Z]{4}[0-9]{4})/$',
                           views.create_assignment, name='create_assignment'),

                       url(r'generate_assignment/$',
                           views.validateAssignment,
                           name='generate_assignment'),

                       # creation urls
                       # User and course creation
                       url(r'create/user/$', views.createUser, name='create_user'),
                       url(r'validateUser/$', views.validateUser, name='validate_user'),
                       url(r'student_homepage/$', views.student_homepage, name= 'student_homepage'),

                       # Assignment submission
                       url(r'course/(?P<course_code>[A-Z]{4}[0-9]{4})/(?P<asmt>.+)/submit/$',
                           views.submit_assignment, name='submit_assignment'),


                       # Assignment page
                       url(r'course/(?P<course_code>[A-Z]{4}[0-9]{4})/(?P<asmt>.+)/$',
                           views.assignment_page, name='assignment_page'),

                       # Annotation
                       # These urls handle the viewing of assignments and the creation of annotations
                       # Used to create the annnotation, redirects back to the file view
                       url(r'annotation/create/(?P<submission_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/(?P<file_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/$',
                           views.createAnnotation, name="create_annotation"),
                       # Used to view a specific file for reviewing
                       url(r'file/(?P<submissionUuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/(?P<file_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/$',
                           views.reviewFile, name="review_file"),
                       # Views a particular submission
                       url(r'submission/(?P<submissionUuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/',
                           views.review, name="submission"),

                       # Testing views
                       url(r'upload', views.upload, name='upload'),
)
