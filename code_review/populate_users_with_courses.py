"""
This script imports a csv filled with user information into the application's database.

This will be used if the non-LTI user authentication system is implemented.
"""
import os
import csv
import sys

os.environ['DJANGO_SETTINGS_MODULE'] = 'code_review.settings'

from review.models import Course, User, ReviewUser

users = []
rUser = None

# Get lines from the csv file
if sys.argv.__len__() > 1:
    with open(sys.argv[1], 'r') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        for row in reader:
            users.append(row)

print users

for r in users:
    # Create a new user from the csv
    newUser = User.objects.get_or_create(username=r[0])
    print newUser

    # Set passowrds and create a reviewUser for the current user
    if newUser[1] == True:
        newUser[0].set_password(r[1])
        newUser[0].is_staff=False
        rUser = ReviewUser.objects.create(djangoUser=newUser[0],
                isStaff=False)
        try:
            newUser[0].save()
            rUser.save()
        except Exceptions as e:
            print e.args
            break

        # Enrol the current user in the listed courses
        for x in range(2, r.__len__()):
            print r[x]
            toAdd = Course.objects.get(course_code=r[x].upper())
            try:
                rUser.courses.add(toAdd)
                rUser.save()
            except Exception as e:
                print e.args
                print e.message
                break
    else:
        print newUser[0].username
    
