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

from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.utils.translation import ugettext_lazy as _

class LTIProfile(models.Model):
    
    """Represents a user who logs in with an associated account in an LMS
    
    User profile model. This profile can be retrieved by calling
    get_profile() on the User model

    Attributes:
        user (OneToOneField) -- the CPRS User corresponding to this user.
        roles (CharField) -- the role of this user (e.g. student)

    Methods:
        get_absolute_url(self) -- return the absolute 
    """
    
    user = models.OneToOneField(User, null=True)
    roles = models.CharField(max_length=255, blank=True, null=True, verbose_name=_("Roles"))
    
    @models.permalink
    def get_absolute_url(self):
        """Helpful one line summary.

        Returns:
            helpful description.
        """

        return ('view_profile', None, {'username': self.user.username})

    def __unicode__(self):
        return self.user.username

    class Meta:
        verbose_name = _("User Profile")

def user_post_save(sender, instance, created, **kwargs):
    """Create a user profile when a new user account is created"""
    if created == True:
        p = LTIProfile()
        p.user = instance
        p.save()

post_save.connect(user_post_save, sender=User)
