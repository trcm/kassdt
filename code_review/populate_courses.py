
import os

os.environ['DJANGO_SETTINGS_MODULE'] = 'code_review.settings'

from review.models import Course

f = open('courses.in', 'r')

courses = {}

for line in f:
    s = line.split(" ", 1)
    s[1] = s[1].strip()

    Course.objects.create(course_code=s[0], course_name=s[1])

    
