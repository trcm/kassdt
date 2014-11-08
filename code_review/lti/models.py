"""
Code originally source from:
    https://pypi.python.org/pypi/django-uocLTI/0.1.2
lti/models.py -- this file contains the representations of database 
tables used in association with LTI integration. 
The unicode method in each class determines how the model's information
is displayed in Django admin.

Abbreviations, conventions:
    LMS = Learning Management System.

Classes:
    LTIProfile(models.Model) -- the user profile model, storing 
                                a CPRS User and their role.  

Methods:
    user_post_save(sender, instance, created, **kwargs) --
        creates an LTIProfile when a new user is created. 

"""


