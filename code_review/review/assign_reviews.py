'''
assign_reviews.py

Helper functions for assigning reviews to students. 
The course administrator can specify how many peer submissions 
each student must review, and how many annotations they must make 
per submission. The system then randomly assigns submissions to 
students. 

Methods: 
    get_errors(course, asmt, numReviews) -- 
    Check we can assign numReviews reviews per student, return error message otherwise.

    get_latest(course, asmt, submissions, users) -- 
    Return the latest submission of each student for this assignment.

     distribute_reviews(asmt, perStudent) -- randomly allocate perStudent review
     to students, for the assigment asmt. 

'''

from review.models import *
import random
from operator import itemgetter 

def get_errors(course, asmt, numReviews):
    """Check we can assign numReviews reviews per student, return error message otherwise.

    Check if we are able to assign numReviews submission to each student by
    making sure there are enough submissions (e.g. if there are only 4 submissions
    then clearly students cannot review 5 submission each). Return an 
    appropriate error message otherwise. 

    Arguments:
        course (Course) -- the course to which the assignment belongs 
        asmt (Assignment) -- the assignment for which we want to assign reviews
        numReviews (int) -- the number of reviews each student should complete.

    Returns:
        An empty string is there are no errors (as described above), or an 
        error message.

    """

    # Check that there are enough submissions for each user to get
    # numReviews each; this means there should be at least numReviews+1
    # submissions. 
    allSubs = AssignmentSubmission.objects.filter(submission_for=asmt)
    users = ReviewUser.objects.filter(courses=course)
    latest = get_latest(course, asmt, allSubs, users)
    numSubs = len(latest)
    if(numSubs < numReviews + 1):
        return "There are not enough submissions to be able to assign %d reviews; need %d submissions but only have %d" %(numReviews, numReviews+1, numSubs)
    if(numReviews < 0):
        return "Must have 0 or more reviews per student!"

    return ""
        
def get_latest(course, asmt, submissions, users):
    """Return the latest submission of each student for this assignment.

    Arguments:
        course (Course) -- the course to which the assignment belongs.
        asmt (Assignment) -- the assignment for which we want to get the 
        latest submissions.
        submissions (AssignmentSubmission) -- all the submissions for this
        assignment
        users (QuerySet<ReviewUser>) -- all the users enrolled in course
    
    Returns:
        A list of the latest submission for asmt for each user.

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
    #print subs
    course = asmt.course_code
    users = ReviewUser.objects.filter(courses=course)
    numUsers = len(users)
    latestSubmissions = get_latest(course, asmt, subs, users)
    # print 'filtered subs are ', latestSubmissions
    numSubs = len(latestSubmissions)
    print 'number of submissions: ', numSubs
    asmt.reviews_per_student = perStudent
    
    for user in users:
        print user
        # Don't want to make staff review stuff.
        if(user.djangoUser.is_staff or user.djangoUser.is_superuser):
            continue

        review = AssignmentReview.objects.get_or_create(by=user, assignment=asmt)[0]
        reviewsAssigned = len(review.submissions.all())
        # In case lecturer assigns reviews multiple times, or number of reviews changes. 
        print ("reviewsAssigned", reviewsAssigned)
        if(reviewsAssigned < perStudent):
            for i in range(perStudent-reviewsAssigned):
                index = random.randint(0, numSubs-1)
                submission = latestSubmissions[index]
                
                # Make sure user isn't assigned to review their own submission
                # NB in the amazing edge case where this user is the only person who 
                # submitted the assignment, we get an infinite loopevi
                # Also don't want student to be assigned same submission twice.
                while((submission.by == user) or (submission in review.submissions.all())):
                    print submission.by == user
                    #print review.submissions.all()
                    #print "in the while loop"
                    index = random.randint(0, numSubs-1)
                    print index
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


