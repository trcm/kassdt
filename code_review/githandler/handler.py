"""
    NB silly Alex did not realise you can't just run django stuff with
    Python... need to start the shell with python manage.py shell
    Then inside the shell, run execfile("filename").
"""

from git import *
from review.models import *

def clone(url, directory):
    """
	Clone a repo from url to directory and 
	return the Repo object.
	
	:url String 
	:directory String 
    """
    return Repo.clone_from(url, directory)

"""
    Given an AssignmentSubmission object, generate a name for the 
    root folder using the student's id, assignment, and submission number.
    
    Right now it's just spitting out hardcoded name. 
"""
def root_folder_name(asmtSubmission):
   return "test_submission"

"""
    :asmtSubmission AssignmentSubmission the student's submission; 
    when this method is called it will have lots of nulls. 
    We will populate it by extracting stuff from it. 
    At this stage we assume we just have:
	by, ReviewUser
	submission_repository
	submission_for

    :directory String the path to which to clone this student's
    repo.
"""
def populate_db(asmtSubmission, directory):

    repo = clone(asmtSubmission.submission_repository, directory)
    
    # Get the root tree, which has all the folders.
    root = repo.tree()
    # Name the source folder something like assignment-student-submission#
    SourceFolder.objects.get_or_create(name=root_folder_name(asmtSubmission), parent='')

    # Iterate over folders, create corresponding SourceFolder objects.
    # There should be an easy, existing method to iterate over them.
    # Iterate over files, create corresponding SourceFile objects.
    # traverse() method without arguments does a breadth first.
    # To make it do depth first, use argument branch_first=False.
    # See git.objects.util.Traversable for more info. 
    traversable = folders.traverse(branch_first=False)
    
    parent_folder = asmtSubmission.root_folder
    for node in traversable:
	# Folder
	if node.type == "tree":
	    print("Currently processing folder %s\n", %(node.name)) 
	    SourceFolder.objects.get_or_create(name=node.name, parent=parent_folder)
	else if node.type == 'blob':
	    print("Currently processing file %s\n", %(node.name))
	    # TODO workout how to convert blob object into something FileField is going to like.
	    SourceFile.objects.get_or_create(folder=parent_folder, name=blob.name, file=...)

