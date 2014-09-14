from django.db import models
# from django.contrib.auth.models import User
from django_extensions.db.fields import UUIDField
from review.models import ReviewUser, SourceFolder  # , SourceFile


class Post(models.Model):
    """
    This model represents a post in the cprs help system
    Attributes:
        post_uuid (UUIDField) -- unique identifier for the post
        user (ForeignKey)
        Question
        datetime created
        datetime edited
        source folder
    
    Methods:
    

    """
    post_uuid = UUIDField()
    # user = models.ForeignKey(ReviewUser, related_name="posts")
    by = models.ForeignKey(ReviewUser, related_name="posts")
    title = models.CharField(max_length=100)
    question = models.TextField()
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    root_folder = models.OneToOneField(SourceFolder,
                                       blank=False,
                                       null=True,
                                       related_name="code")
    open = models.BooleanField(default=True)
    submission_repository = models.TextField()
    
    def __unicode__(self):
        return "%s by %s @ %s" % (self.title, self.by, self.created)
