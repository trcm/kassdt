from review.models import *
import random

def get_latest(course, asmt, submissions, users):
    latestSubmissions = []

    # Filter submissions by student
    for user in users:
        userSubs = submissions.objects.filter(by=user)
        latestSubmissions.append(userSubs.latest())

    return latestSubmissions

def assign_reviews(asmt, perStudent):
    """Randomly allocate reviews to students. 
    
    Arguments:
        asmt (Assignment) -- the assignment for which we want to allocate
        reviews to students. 

        perStudent (int) -- number of submissions to assign to each user.

    Returns:
        Nothing. 

    Precondition: 
        numberOfSubmissions >= perStudent
    """

    # Get all submissions for this assignment.
    subs = AssignmentSubmission.objects.filter(submission_for=asmt)
    course = asmt.course_code
    users = Course.objects.filter(course_code=course.course_code)
    numUsers = len(users)
    subs = get_latest(course, asmt, subs, users)
    numSubs = len(subs)

    for user in users:
        review = SubmissionReview.objects.create(by=user, assignment=asmt)
        for i in range(perStudent):
            index = random.randint(0, numSubs-1)
            review.submissions.add(subs[index])

    return


