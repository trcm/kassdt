import os
import random
from django.db.utils import IntegrityError

os.environ['DJANGO_SETTINGS_MODULE'] = 'code_review.settings'

from review.models import Course, User, ReviewUser, AssignmentSubmission

names = ['joe', 'billy bob', 'terrance', 'jerome', 'jimmy', 'tom',
         'alex', ' sheldon', 'sherry', 'debbie', 'kieran']

# add 5 staff members

for i in range(0, 5):
    first_name = names[random.randint(0, len(names)-1)]
    last_name = 'staff'
    username = "s11111" + str(i)
    print first_name, last_name, username
    try:
        newStaff = User.objects.create(username=username,
                                       first_name=first_name,
                                       last_name=last_name)
        newStaff.save()
        newStaffRU = ReviewUser.objects.create(djangoUser=newStaff,
                                               isStaff=True,
        )
        newStaffRU.save()
    except IntegrityError as e:
        print e.args 
        print "oops"

for i in range(0, 20):
    first = names[random.randint(0, len(names)-1)]
    last = "student"
    username = "s00000" + str(i)
    print first, last, username
    try:
        newStudent = User.objects.create(username=username,
                                         first_name=first,
                                         last_name=last)
        newStudent.save()
        newStudentRU = ReviewUser.objects.create(djangoUser=newStudent,
                                                 isStaff=False)

        newStudentRU.save()
    except IntegrityError as e:
        print e.args
