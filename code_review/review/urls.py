from django.conf.urls import patterns, include, url

from review import views

urlpatterns = patterns('',
                       url(r'^$', views.index, name='index'),
                       url(r'login/$', views.loginUser, name='login'),
                       url(r'login_redirect/$', 'django.contrib.auth.views.login',
                           # {'template_name':  'login.djhtml'},
                           name='login_redirect'),
                       url(r'logout/$', 'django.contrib.auth.views.logout',
                           {'next_page': '/review/'}, name='logout'),
                       url(r'reigster/$', views.index, name='register'),
                       
)
