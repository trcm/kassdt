"""
urls.py
Overarching routes file for the project
"""
from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('django.contrib.auth.views',
                       url(r'^$', include('review.urls')),
                       url(r'^u/', include('unfriendly.urls')),
                       url(r'^review/', include('review.urls')),
                       url(r'^admin/', include(admin.site.urls)),
                       url(r'^lti/', include('lti.urls')),
                       url(r'^help/', include('help.urls')),
)
