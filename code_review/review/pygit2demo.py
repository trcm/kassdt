from pygit2 import *

url = 'https://alex_hs_lee@bitbucket.org/alex_hs_lee/cs-253.git'
dir = './testpygit2'

#try:
#    repo = clone_repository(url, dir)
#
#except GitError as err:
#    if(err.message == 'authentication required but no callback set'):
#        print 'Give me password!!!'

#try:
#    credentials = UserPass("alex_hs_lee", "ehlswkdWlro12@")
#    repo = clone_repository(url, dir, credentials=credentials)
#except Exception as argh:
#    print 'nothing was supposed to go wrong here'

#repo = clone_repository('git@github.com:avadendas/private_test_repo.git', './sshtest')
#repo = clone_repository('https://github.com/avadendas/public_test_repo.git', './pubrepo')

try:
#    creds = UserPass("alex_hs_lee", "adfadfaj")
#    repo = clone_repository(url, './wrongcreds', credentials=creds)
    repo = clone_repository('https://blahblahblah.com/notarepo.git', './wrongurl')
except GitError as ge:
    print ge.message

#repo = Repository(dir)

