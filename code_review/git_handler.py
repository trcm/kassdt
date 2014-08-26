"""
Helper functions to clone git repos.
Currently only tested on public repos. 

Install gitpython with pip install gitpython
to make this work. 
"""

from git import *
from review.models import *
import os.path
from django.db import models 
from django.conf import settings
from time import strftime

def clone(url, directory):
    """
	Clone a repo from url to directory and 
	return the Repo object.
	
	:url String 
	:directory String absolute path to the directory to which
	to clone this repo; directory must be empty folder.
    """
    return Repo.clone_from(url, directory)

"""
    Given an AssignmentSubmission object, generate a path for the 
    root folder using the student's id, assignment, and submission number.
    The intended use is that this the path to the local copy of the 
    repository relative to MEDIA_ROOT.

    Return "<user_uuid>_"%Y-%m-%d_%H-%M-%S"

    :asmtSubmission AssignmentSubmission
"""
def root_folder_name(asmtSubmission):
    ''''
    asmt = asmtSubmission.submission_for
    course = asmt.course_code
    courseCode = course.course_code
    '''
    
    userID = asmtSubmission.by.djangoUser.username
    
    # If multiple submissions permitted, need to be able to distinguish
    # So add the current time down to the second.
    userID = userID + "_" + strftime("%Y-%m-%d_%H-%M-%S")
    
    return userID 

def add_source_folder(name, parent):
    """
	:name String
	:parent SourceFolder
    """
    return SourceFolder.objects.get_or_create(name=name, parent=parent)

def add_source_file(name, folder, srcPath):
    """
	We note SourceFile has a FileField, which only stores the upload
	path; it will append the given path in the upload_to attribute to the
	root directory given by MEDIA_ROOT in settings. 
	
	So once we clone the repo to some assignment directory, we simply
	look at the file structure within the repo to determine srcPath. 

	:name String name of file
	:folder SourceFolder the folder containing thisfile. 
	:srcPath String the path to this file, relative to MEDIA_ROOT.
    """
    f = srcPath
    return SourceFile.objects.get_or_create(name=name, folder=folder, file=f)

def traverse_tree(tree, thisFolder, path):
    """
	Recurvise tree traversal; creates the appropriate
	database objects for all folders and files which are
	children of tree. 

	Need to create root folder then call traverse_tree
	on that.
	
	:tree git.objects.Tree the Tree to traverse. 
	:thisFolder SourceFolder corresponding to tree. 
	:path String the path (relative to MEDIA_ROOT) to the folder represented
	by this tree; path does not contain this folder.
    """

    # Get files directly underneath this folder.
    blobs = tree.blobs
    thisFolderName = tree.name
    # Add this folder to the path. 
    path = os.path.join(path, thisFolderName)
    print(path)

    for blob in blobs:
	add_source_file(blob.name, thisFolder, path)
    
    # Get folders directly underneath this folder.
    folders = tree.trees
    for folder in folders:
	srcFolderObj = add_source_folder(folder.name, thisFolder)[0]
	traverse_tree(folder, srcFolderObj, path)
    
    return 

"""
    :asmtSubmission AssignmentSubmission the student's submission; 
    when this method is called it will have lots of nulls. 
    We will populate it by extracting stuff from it. 
    At this stage we assume we just have:
	by, ReviewUser
	submission_repository
	submission_for

    :directory String the path to which to clone this student's
    repo, relative to MEDIA_ROOT. This should be the directory in which
    the student assignments are stored, rather than this student's repo;
    i.e., directory should be something like "DECO3801/asmt1" rather than
    "DECO3801/asmt1/studentA_submission1"
"""
def populate_db(asmtSubmission, directory):
    rootFolderName = root_folder_name(asmtSubmission)
    
    #  rootFolderPath is absolute path, necessary for cloning; 
    # to get this correct, we need to join to MEDIA_ROOT.
    rootFolderPath = os.path.join(directory, rootFolderName)
    rootFolderPath = os.path.join(settings.MEDIA_ROOT, rootFolderPath)
    print(rootFolderPath)

    repo = clone(asmtSubmission.submission_repository, rootFolderPath)
    
    # Get the root tree, which has all the folders.
    root = repo.tree()
    # Name the source folder something like assignment-student-submission#
    rootFolder = add_source_folder(rootFolderName, None)[0]
    # Update the repo folder in the AssignmentSubmission object.
    asmtSubmission.root_folder = rootFolder
    asmtSubmission.save()
    print("directory (rel to MEDIA_ROOT) is %s" %directory)
    # Get repo root directory relative to MEDIA_ROOT
    relativeRoot = os.path.join(directory, rootFolderName)
    # Now make the rest of the SourceFolder and SourceFile objects.
    traverse_tree(root, rootFolder, relativeRoot)
