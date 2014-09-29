from review.models import *
import random
from operator import itemgetter 

def get_errors(course, asmt, numReviews):
    
    """
    Arguments:
        course (Course)
        asmt (Assignment)
        numReviews (int) 
    """
    # Check that there are enough submissions for each user to get
    # numReviews each; this means there should be at least numReviews+1
    # submissions. 
    allSubs = AssignmentSubmission.objects.all()
    users = ReviewUser.objects.filter(courses=course)
    latest = get_latest(course, asmt, allSubs, users)
    numSubs = len(latest)
    if(numSubs < numReviews + 1):
        return "There are not enough submissions to be able to assign %d reviews; need %d submissions but only have %d" %(numReviews, numReviews+1, numSubs)
    
    return ""
        
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
        numberOfSubmissions >= perStudent+1
    """

    # Get all submissions for this assignment.
    subs = AssignmentSubmission.objects.filter(submission_for=asmt)
    print subs
    course = asmt.course_code
    users = ReviewUser.objects.filter(courses=course)
    numUsers = len(users)
    latestSubmissions = get_latest(course, asmt, subs, users)
    # print 'filtered subs are ', latestSubmissions
    numSubs = len(latestSubmissions)
    print 'number of submissions: ', numSubs
    
    for user in users:
        # Don't want to make staff review stuff.
        if(user.djangoUser.is_staff or user.djangoUser.is_superuser):
            continue

        review = AssignmentReview.objects.get_or_create(by=user, assignment=asmt)[0]
        reviewsAssigned = len(review.submissions.all())
        # In case lecturer assigns reviews multiple times, or number of reviews changes. 
        # TODO also need to cater for situation where reviewsAssigned > perStudent.
        if(reviewsAssigned < perStudent):
            for i in range(perStudent-reviewsAssigned):
                index = random.randint(0, numSubs-1)
                submission = latestSubmissions[index]
                
                # Make sure user isn't assigned to review their own submission
                # NB in the amazing edge case where this user is the only person who 
                # submitted the assignment, we get an infinite loopevi
                # Also don't want student to be assigned same submission twice.
                while(submission.by == user or submission in review.submissions.all()):
                    index = random.randint(0, numSubs-1)
                    submission = latestSubmissions[index]
                 
                review.submissions.add(submission)
        # Lecturer has reduced number of reviews per user 
        elif(reviewsAssigned > perStudent):
            # Number of submissions we want to de-assign
            deassign = reviewsAssigned - perStudent 
            # Get all the submissions the student has not yet completed.
            incomplete = []
            for sub in review.submissions.all():
                annotationsDone = AssignmentReview.numAnnotations(review, sub)
                if(annotationsDone < asmt.min_annotations):
                    incomplete.append((sub, annotationsDone))

            # Choose the least-complete deassign submission reviews to remove.
            # Ascending list 
            sortedList = sorted(incomplete, key=itemgetter(1))
            removeFromIncomplete = min(deassign, len(sortedList))
            for i in range(removeFromIncomplete):
                 review.submissions.remove(sortedList[i][0])    
            
            if deassign > len(sortedList):
                for i in range(deassign):
                    review.submissions.remove(reviews.submissions.all()[i])
        else: # nothing to assign or remove
            return 
            
    return


