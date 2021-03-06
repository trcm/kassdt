"""
forms.py - 
This file contains all the custom forms used throughout the application.
"""

from django.forms import ModelForm, DateTimeField, DateTimeInput, Textarea, SplitDateTimeWidget, PasswordInput, IntegerField
# from django.contrib.auth.forms import SetPasswordForm
# from django.forms import *
from django.forms.extras.widgets import SelectDateWidget
from django.forms import *
from models import *

class AllocateReviewsForm(ModelForm):
    '''
    Form for allowing course administrator to allocate assignments to review
    to students.
    '''

    class Meta:
        model = Assignment
        fields = ['reviews_per_student', 'min_annotations']

class AssignmentSubmissionForm(ModelForm):
    '''
    Form for submitting assignments.
    '''

    # The address of the remote repository to clone from; http or ssh
    submission_repository = forms.CharField(label='repo_address', required=False)
    
    # The username for this repository
    repoUsername = forms.CharField(label='repo_username', required=False)
    
    # The password for this repository
    repoPassword = forms.CharField(widget=forms.PasswordInput(), label='repo_password',
                               required=False)

    def clean_url(self):
        cleaned_data = self.cleaned_data
    class Meta:
        model = AssignmentSubmission
        fields = ['submission_repository']

class AssignmentForm(ModelForm):
    """
    Forms for creating a new assignment
    """
    class Meta:
        model = Assignment
        fields = ['course_code', 'name', 'repository_format',
                  'first_display_date', 'submission_open_date',
                  'submission_close_date', 'review_open_date',
                  'review_close_date']
        widgets = {
            'name': TextInput(),
            'repository_format': TextInput(),
            'first_display_date': SplitDateTimeWidget(),
            'submission_open_date': SplitDateTimeWidget(),
            'submission_close_date': SplitDateTimeWidget(),
            'review_open_date': SplitDateTimeWidget(),
            'review_close_date': SplitDateTimeWidget()
        }


class AssignmentTestForm(ModelForm):

    class Meta:
        model = SubmissionTest
        fields = ['test_count', 'test_file',
                  'test_command' ]
        
        
class uploadFile(ModelForm):
    """
    Dummy form for uploading files during testing
    """
    class Meta:
        model = SourceFile


class annotationForm(ModelForm):
    """
    This is paired with the form below when creating annotations on a source 
    file.
    """
    class Meta:
        model = SourceAnnotation
        fields = ['text']


class annotationRangeForm(ModelForm):
    """
    Creates a range object
    """
    class Meta:
        model = SourceAnnotationRange
        # fields = ['start', 'end']
        fields = ['start']
        labels = {
            'start': 'Line',
        }
        widgets = {
            'start': NumberInput(),
            # 'end': NumberInput()
        }


class editAnnotationForm(ModelForm):
    class Meta:
        model = SourceAnnotation
        fields = ['text']
        
# Can these be deleted? They don't seem to be in use anymore

        
class UserCreationForm(ModelForm):
    class Meta:
        model = User
        fields = ('username',
                  'first_name',
                  'last_name',
                  'email',
                  'password',
                  'is_staff')

        widgets = {
            'password': PasswordInput(),
            'is_staff': forms.CheckboxInput()
        }


class createUserForm(User):
    username = forms.CharField(max_length=20, min_length=6)
    first_name = forms.CharField()
    last_name = forms.CharField()
    password1 = forms.CharField(max_length=100, widget=forms.PasswordInput())
    password2 = forms.CharField(max_length=30, widget=forms.PasswordInput())
    email = forms.EmailField(required=False)

    def clean_username(self): # check if username dos not exist before
        try:
            User.objects.get(username=self.clean) #get user from user model
        except User.DoesNotExist :
            return username.clean

        raise forms.ValidationError("this user exist already")

    def clean(self): # check if password 1 and password2 match each other
        if 'password1' and 'password2':#check if both pass first validation
            if self.clean != self.clean: # check if they match each other
                raise forms.ValidationError("passwords dont match each other")

            return 'password1'

    def save(self):
        new_user = User.objects.create_user(username = self.clean_username,
                                            email=self.clean, first_name=self.clean,
                                            last_name=self.clean, password=self.clean,
        )
        return new_user
