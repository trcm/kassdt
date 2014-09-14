from django.conf.urls import patterns, include, url
from help import views
urlpatterns = patterns('',
                       url(r'^$', views.index, name='help'),
                       url(r'^new_post/$', views.newPost, name="new_post"),
                       url(r'^create_post/$', views.createPost, name="create_post"),
                       url(r'file/(?P<post_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/(?P<file_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/$',
                           views.viewPostFile, name="view_post_file"),
                       url(r'view/(?P<post_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})/',
                           views.viewPost, name="view_post"),
                       url(r'delete/(?P<post_uuid>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})',
                           views.deletePost, name="delete_post"),
)
