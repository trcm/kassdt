from django.conf.urls import patterns, include, url

from review import views

urlpatterns = patterns('',
                       url(r'^$', views.index, name='index'),
                       url(r'login/$', views.loginUser, name='login'),
                       url(r'login_redirect/$', 'django.contrib.auth.views.login', {'template_name':  'login.djhtml'}, name='login_redirect'),
                       
)
