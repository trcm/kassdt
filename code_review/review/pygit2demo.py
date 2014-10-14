from pygit2 import *

url = 'https://alex_hs_lee@bitbucket.org/alex_hs_lee/cs-253.git'
dir = './testpygit2'

try:
    repo = clone_repository(url, dir)

except GitError as err:
    if(err.message == 'authentication required but no callback set'):
        print 'Give me password!!!'

try:
    credentials = UserPass("alex_hs_lee", "ehlswkdWlro12@")
    repo = clone_repository(url, dir, credentials=credentials)
except Exception as argh:
    print 'nothing was supposed to go wrong here'


