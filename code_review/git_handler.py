"""
git_python.py -- Helper functions to clone git repos.

Methods:
    clone(url, directory) -- clones the repo at url into directory.
    
    root_folder_name(asmtSubmission) -- generate a root folder name for 
    a given AssignmentSubmission. 
    
    add_source_folder(name, parent) -- add SourceFolder object to database
    with name name and parent folder parent. 


Dependencies:
    Install gitpython with pip install gitpython.
    Make sure gitpython is version 0.3.2RC1
"""

from git import *
from review.models import *
import os.path
from django.db import models
from django.conf import settings
from time import strftime
from pygments import *
from pygments.lexers import *
from pygments.formatters import *


def clone(url, directory):
    """
    Clone a repo from url to directory and
    return the Repo object.

    :url String
    :directory String absolute path to the directory to which
    to clone this repo; directory must be empty folder.
    """
    return Repo.clone_from(url, directory)



def root_folder_name(asmtSubmission):
    """Return the path of the root folder relative to MEDIA_ROOT.

    Given an AssignmentSubmission object, generate a path for the
    root folder using the student's id, assignment, and submission number.
    The intended use is that this the path to the local copy of the
    repository relative to MEDIA_ROOT.
    
    Arguments:
        asmtSubmission (AssignmentSubmission) -- the submission for which
        we want to create a root folder name. 

    Returns:
        The user's username concatenated with the UUID of the assignment
        submission in the format "<username>_<submission_uuid>" (String)

    """

    userID = asmtSubmission.by.djangoUser.username

    # If multiple submissions permitted, need to be able to distinguish
    # So add the current time down to the second.
    # We are not using assignment UUID because that truncates the file name.
    userID = userID + "_" + strftime("%Y-%m-%d_%H-%M-%S")

    return userID


def add_source_folder(name, parent):
    """Add a SourceFolder with name name and parent folder parent to the database.
    
    Arguments:
        name (String) -- the name of the folder 
        parent (SourceFolder) -- the folder in which this folder is contained. 

    Returns:
        A 2-tuple whose first entry is the SourceFolder object which was just
        created if it did not exist prior to the calling of this method, or the 
        SourceFolder object that was retrieved if it already existed. 
        The second entry in the tuple is True if the object was created or 
        False if it already existed and was retrieved. 
    """
    return SourceFolder.objects.get_or_create(name=name, parent=parent)


def add_source_file(name, folder, srcPath):
    """Add a SourceFile with name `name', in `folder', with the path `srcPath'.

    We note SourceFile has a FileField, which only stores the upload
    path; it will append the given path in the upload_to attribute to the
    root directory given by MEDIA_ROOT in settings.

    So once we clone the repo to some assignment directory, we simply
    look at the file structure within the repo to determine srcPath.
    
    Arguments:
        name (String) -- name of file
        folder (SourceFolder) -- the folder containing this file.
        srcPath (String) -- the path to this file, relative to MEDIA_ROOT.
    
    Returns:
        A 2-tuple (object, created) such that:
            - object is the SourceFile created if it didn't exist before, or
              the SourceFile retrieved if it did
            - created is True if SourceFile was created, False if retrieved.
    """
    f = srcPath
    return SourceFile.objects.get_or_create(name=name, folder=folder, file=f)


def traverse_tree(tree, thisFolder, path):
    """Traverse a git repo tree and populate the database appropriately.

    Recurvise tree traversal; creates the appropriate
    database objects (SourceFolder, SourceFile) 
    for all folders and files which are children of tree.

    To populate the database a particular assignment submission: get 
    the root Tree of the git repository by calling tree() on the Repo 
    object. Get the root folder for the submission. Get the path to the
    directory which contains this submission; this would generaly be the 
    root folder as created by root_folder_name(). 
    Call this method with these arguments. 
    
    Arguments:
        tree (git.objects.Tree) -- the Tree whose children we will add to the 
        database. 
        
        thisFolder (SourceFolder) -- the folder corresponding to tree; tree
        is always a Git object that represents a folder. 
        
        path (String) -- the path (relative to MEDIA_ROOT) to the folder represented
        by this tree; path does not contain this folder. When git clones, it makes a 
        root directory under which all the code is stored; and that root git directory
        is itself under some directory in our server. We want this path to be 
        that directory, rather than the root git directory. 
        E.g. path might be/courseABCD/assign1/s012345_<uuid> and the student 
        might have named their repository i_hate_this_course.  

    Returns:
        Nothing
    """

    # Get files directly underneath this folder.
    blobs = tree.blobs
    thisFolderName = tree.name

    # Add this folder to the path.
    path = os.path.join(path, thisFolderName)
    print(path)

    for blob in blobs:
        filepath = os.path.join(path, blob.name)
        add_source_file(blob.name, thisFolder, filepath)

    # Get folders directly underneath this folder.
    folders = tree.trees
    for folder in folders:
        srcFolderObj = add_source_folder(folder.name, thisFolder)[0]
        traverse_tree(folder, srcFolderObj, path)

    return

def populate_db(asmtSubmission, directory):
    """Store the folders and files associated with asmtSubmission to the database.
    
    This method clones the repository at the url/ssh specified by 
    asmtSubmission.submission_repository to a folder directly under 
    `directory' (the folder will usually be named with something involving the 
    submitter's username and the assignment submission's uuid for uniqueness). 
    It will then create appropriate SourceFolder and SourceFile objects to 
    correspond to the submitted code base. 

    Preconditions:
        asmtSubmission must have non-null values for by, submission_repository
        and submission_for. 

    Arguments:
        asmtSubmission (AssignmentSubmission) -- the student's submission;
        when this method is called it will have lots of nulls, e.g., it will
        not yet have a root folder. We will populate it by extracting info from it.

        directory (String) -- the path to which to clone this student's
        repo, relative to MEDIA_ROOT. This should be the directory in which
        the student assignments are stored, rather than this student's repo;
        i.e., directory should be something like "DECO3801/asmt1" rather than
        "DECO3801/asmt1/studentA_submission1"

    Returns:
        Nothing

    Raises:
        GitCommandErr -- if git failed to clone the repository (usually because
        the url is incorrect).
    """
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
