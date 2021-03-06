# Routes file for the Help system application

from django.conf.urls import patterns, include, url
from help import views
from review.views import deleteAnnotation

urlpatterns = patterns('',
                       url(r'create_post/(?P<course_code>[A-Z]{4}[0-9]{4})/$',
                           views.createPost, name="create_post"),
                       url(r'new_post/(?P<course_code>[A-Z]{4}[0-9]{4})/$',
                           views.newPost, name="new_post"),
                       url(r'(?P<course_code>[A-Z]{4}[0-9]{4})/$',
                           views.index,
                           name='help'),
                       url(r'view/(?P<post_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/',
                           views.viewPost, name="view_post"),
                       url(r'file/(?P<post_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/(?P<file_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/',
                           views.viewPostFile, name="view_post_file"),
                       url(r'delete/(?P<course_code>[A-Z]{4}[0-9]{4})/(?P<post_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/$',
                           views.deletePost, name="delete_post"),
                       url(r'update/(?P<post_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/$',
                           views.updatePost, name="update_post"),
                       url(r'resolve/(?P<course_code>[A-Z]{4}[0-9]{4})/(?P<post_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/$',
                           views.resolvePost, name="resolve_post"),
                       url(r'delete/(?P<submissionUuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/(?P<fileUuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/(?P<annoteId>\d+)/$',
                           deleteAnnotation, name="delete_post_annotation"),

)
