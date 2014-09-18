from review.models import *
import random

def get_latest(course, asmt, submissions, users):
    """

    Arguments:
        users (QuerySet<ReviewUser>) 
    """
    latestSubmissions = []

    # Filter submissions by student
    for user in users:
        userSubs = submissions.filter(by=user)
        if userSubs:
            latestSubmissions.append(userSubs.latest())

    return latestSubmissions

def distribute_reviews(asmt, perStudent):
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
    print subs
    course = asmt.course_code
    users = ReviewUser.objects.filter(courses=course)
    numUsers = len(users)
    latestSubmissions = get_latest(course, asmt, subs, users)
    print 'filtered subs are ', latestSubmissions
    numSubs = len(latestSubmissions)
    print 'number of submissions: ', numSubs
    
    for user in users:
        # Don't want to make staff review stuff.
        if user.isStaff:
            continue

        review = AssignmentReview.objects.get_or_create(by=user, assignment=asmt)[0]
        for i in range(perStudent):
            index = random.randint(0, numSubs-1)
            submission = latestSubmissions[index]
            
            # Make sure user isn't assigned to review their own submission
            # NB in the amazing edge case where this user is the only person who 
            # submitted the assignment, we get an infinite loopevi
            while(submission.by == user):
                index = random.randint(0, numSubs-1)
                submission = latestSubmissions[index]
             
            review.submissions.add(submission)

    return


