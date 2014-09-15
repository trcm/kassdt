"""
forms.py - 
This file contains all the custom forms used throughout the application.
"""
from django.forms.extras.widgets import SelectDateWidget
from django.forms import *

from help.models import Post


class postForm(ModelForm):
    
    """
    Form for creating a new help system post.
    """
    class Meta:
        model = Post
        fields = ['title', 'question', 'submission_repository']
        widgets = {'submission_repository': TextInput(), }


class editForm(ModelForm):
    
    """
    Form for editing a post via the modal on the view_post template
    """
    class Meta:
        model = Post
        fields = ['title', 'question']
