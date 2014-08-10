from django.forms import ModelForm, DateTimeField, DateTimeInput, Textarea, CharField
from django.forms.extras.widgets import SelectDateWidget
from models import *


class AssignmentForm(ModelForm):
    class Meta:
        model = Assignment
        fields = ['course_code', 'name', 'repository_format',
                  'first_display_date', 'submission_open_date',
                  'submission_close_date', 'review_open_date',
                  'review_close_date']

