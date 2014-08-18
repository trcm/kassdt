from ims_lti_py import *
from django.http import HttpResponse

def index(request):
    #Add here the requests from ims_lti_py to create /autehnticate users
    #So none of this will work until we have permissions
    tool = ToolProvider('consumer_key', 'consumer_secret', 'params={}')
    print(tool);


    return HttpResponse()
