from django.conf.urls import patterns, include, url

urlpatterns = patterns('',
       url(r'^launch_lti', 'lti.views.launch_lti', name="launch_lti"),
)
