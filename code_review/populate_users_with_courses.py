import os
import csv
import sys


os.environ['DJANGO_SETTINGS_MODULE'] = 'code_review.settings'

from review.models import Course, User, ReviewUser

users = []

if sys.argv.__len__() > 1:
    with open(sys.argv[1], 'r') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        for row in reader:
            users.append(row)

for r in users:
    print r[0], r[1]
    for x in range(2, r.__len__()):
        print r[x]
