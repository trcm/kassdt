"""
    NB silly Alex did not realise you can't just run django stuff with
    Python... need to start the shell with python manage.py shell
    Then inside the shell, run execfile("filename").
"""

from git import *
from review.models import *
import os.path
from django.db import models 

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
    Given an AssignmentSubmission object, generate a name for the 
    root folder using the student's id, assignment, and submission number.
    
    Right now it's just spitting out hardcoded name. 
"""
def root_folder_name(asmtSubmission):
   return "test_submission"

def add_source_folder(name, parent):
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
    f = models.FileField(upload_to=srcPath)
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
    repo, relative to MEDIA_ROOT.
"""
def populate_db(asmtSubmission, directory):
    rootFolderName = root_folder_name(asmtSubmission)
    rootFolderPath = os.path.join(directory, rootFolderName)

    repo = clone(asmtSubmission.submission_repository, rootFolderPath)
    
    # Get the root tree, which has all the folders.
    root = repo.tree()
    # Name the source folder something like assignment-student-submission#
    rootFolder = add_source_folder(rootFolderName, None)[0]

    # Now make the rest of the SourceFolder and SourceFile objects.
    traverse_tree(root, rootFolder, directory)
