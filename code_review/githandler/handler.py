from git import *

def clone(url, directory):
    """
	Clone a repo from url to directory and 
	return the Repo object.
	
	:url String 
	:directory String 
    """
    return Repo.clone_from(url, directory)

def populate_db(repo):
    """
	Populate the database with the source files from the repo.

	:repo Repo (gitpython object) 
    """

    # Get the root tree, which has all the folders.
    root = repo.tree()

    # Obtain folders in the repo as a list of Tree objects
    folders = root.trees

    # Iterate over folders, create corresponding SourceFolder objects.
    # There should be an easy, existing method to iterate over them.

    # Iterate over files, create corresponding SourceFile objects.

