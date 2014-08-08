from django.core.exceptions import PermissionDenied, ValidationError
from django.core.validators import MinValueValidator
from django.db import models
from django_extensions.db.fields import UUIDField
from django.contrib.auth.models import User as Django_User
from django.utils import timezone

c = lambda x: "<code>" + x + "</code>"
repo_format_format_vars = [
    ("user_uuid",
     "The user's UUID. This value is internal to this system.",
     c("23eab9a9-d588-44e5-b0e0-070e2de8cac3")
 ),
    ("username",
     "The username provided by LTI or the username to log into this website.",
     "<b>This varies between servers</b><br />E.G." + c("joe_blogs")
 )
]

repo_format_help_text = """
        Please enter a value that can be formatted using python formatting. To find out more about this
        format see the <a target="_blank" href="https://docs.python.org/2/library/string.html#format-string-syntax">
        Python documentation</a>. The following table lists the named
        variables available to the format string.
        <table>
        <thead><tr><td>Variable Name</td><td>Description</td><td>Examples</td></tr></thead>
        <tbody>
    """ + "\n".join(["<tr><td><code><pre>%s</pre></code></td><td>%s</td><td>%s</td></tr>" % v
                     for v in repo_format_format_vars]) + """
        </tbody></table>
        So, if you wanted to define the user's repositories as their username the following format:<br />
    """ + \
    c("https://www.source-hosting.com/{username}/ass1/") + """
        ; which will produce """ + c("https://www.source-hosting.com/joe_blogs/ass1/") + """ for the user "joe_blogs".
    """


class User(models.Model):
    user_uuid = UUIDField()
    djangoUser = models.OneToOneField(Django_User, unique=True)

    def __unicode__(self):
        return "%s" % (self.djangoUser.username,)


class SourceFolder(models.Model):
    folder_uuid = UUIDField()
    name = models.TextField(null=False, blank=False)
    parent = models.ForeignKey('self', null=True, related_name="folders")

    def __unicode__(self):
        return "(%s)%s" % (self.folder_uuid, self.name)

    def __repr__(self):
        return repr({
            "folder_uuid": self.folder_uuid,
            "name": self.name,
            "parent": self.parent,
        })


class SourceFile(models.Model):
    folder = models.ForeignKey(SourceFolder, null=False, blank=False, related_name="files")
    file_uuid = UUIDField()
    name = models.TextField(null=False, blank=False)
    file = models.FileField(upload_to="source-files/%Y-%m-%d/%H-%M/%S-%f/", null=False, blank=False)

    def __unicode__(self):
        return "(%s)%s" % (self.file_uuid, self.name)

    def __repr__(self):
        return repr({
            "file_uuid": self.file_uuid,
            "folder": self.folder,
            "name": self.name,
            "file": self.file,
        })

    @property
    def content(self):
        try:
            self.file.open("rU")
            return self.file.read()
        finally:
            self.file.close()




class SubmissionTestResults(models.Model):
    tests_completed = models.NullBooleanField()

    def overall_percentage(self):
        res = [test.get_result() for test in self.test_results.all()]
        return sum(res) / len(res) if len(res) != 0 else Fraction(0);

    def total_tests(self):
        return sum([test.test_count for test in self.test_results.all()])

    def total_passes(self):
        return sum([test.test_pass_count for test in self.test_results.all()])

    def total_failures(self):
        return sum([(test.test_count - test.test_pass_count) for test in self.test_results.all()])

    def __unicode__(self):
        return "Results: %d/%d" % (self.total_passes(), self.total_tests())


class SubmissionTest(models.Model):
    part_of = models.ForeignKey(SubmissionTestResults, related_name="test_results")
    test_name = models.TextField(null=False, blank=True)
    test_count = models.PositiveIntegerField(null=False, blank=False, validators=[MinValueValidator(1)])
    test_pass_count = models.PositiveIntegerField(null=False, blank=False)

    def clean(self):
        if self.test_count < self.test_pass_count:
            raise ValidationError("The number of passing tests(%s) cannot be larger than the number of tests(%s)." %
                                  (self.test_pass_count, self.test_count))
            super(SubmissionTest, self).clean()

    def get_result(self):
        return Fraction(self.test_pass_count, self.test_count)

    def __unicode__(self):
        return "%s(%d/%d)" % (self.test_name, self.test_pass_count, self.test_count)


class Assignment(models.Model):
    assignment_uuid = UUIDField()
    name = models.TextField()

    repository_format = models.TextField(help_text=repo_format_help_text)

    first_display_date = models.DateTimeField(default=lambda: timezone.now())

    submission_open_date = models.DateTimeField(default=lambda: timezone.now())
    submission_close_date = models.DateTimeField()

    review_open_date = models.DateTimeField(default=lambda: timezone.now())
    review_close_date = models.DateTimeField()

    def __unicode__(self):
        return "(%s)%s" % (self.assignment_uuid, self.name)

    def __repr__(self):
        return repr({
            "assignment_uuid": self.assignment_uuid,
            "name": self.name,
            "repository_format": self.repository_format,
            "first_display_date": self.first_display_date,
            "submission_open_date": self.submission_open_date,
            "submission_close_date": self.submission_close_date,
            "review_open_date": self.review_open_date,
            "review_close_date": self.review_close_date,
        })


class AssignmentSubmission(models.Model):
    submission_uuid = UUIDField()
    submission_date = models.DateTimeField(default=lambda: timezone.now())
    by = models.ForeignKey(User)
    submission_repository = models.TextField()
    submission_for = models.ForeignKey(Assignment, related_name="submissions")
    error_occurred = models.BooleanField(default=False)
    root_folder = models.OneToOneField(SourceFolder, blank=False, null=True, related_name="assignment")
    test_results = models.OneToOneField(SubmissionTestResults, blank=False, null=True, related_name="assignment")

    def __unicode__(self):
        return "(%s)%s @ %s" % (self.submission_uuid, self.submission_for.name, self.submission_date)

    def __repr__(self):
        return repr({
            "submission_uuid": self.submission_uuid,
            "submission_date": self.submission_date,
            "by": self.by,
            "submission_repository": self.submission_repository,
            "submission_for": self.submission_for,
            "error_occurred": self.error_occurred,
            "root_folder": self.root_folder,
        })


### BEGIN ANNOTATION STORAGE ###


class SourceAnnotation(models.Model):
    annotation_uuid = UUIDField()

    user = models.ForeignKey(User)
    source = models.ForeignKey(SourceFile)

    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    text = models.TextField()
    quote = models.TextField()

    def __str__(self):
        return '"%s" on "%s" by %s in (%s).' % (self.text, self.quote, self.user, self.source)


class SourceAnnotationRange(models.Model):
    range_annotation = models.ForeignKey(SourceAnnotation, related_name="ranges")

    start = models.TextField()
    end = models.TextField()
    startOffset = models.PositiveIntegerField()
    endOffset = models.PositiveIntegerField()


class SourceAnnotationTag(models.Model):
    tag_annotation = models.ForeignKey(SourceAnnotation, related_name="tags")

    tag = models.TextField()

class FakeTestModel(models.Model):
    attrb = models.TextField()

## Utility Methods ##

def get_user_for_django_user(usr):
    """

    :param usr: django.contrib.auth.models.AbstractBaseUser
    """

    if not usr.is_authenticated():
        raise PermissionDenied()

    model_user = User.objects.get_or_create(djangoUser=usr)

    return model_user[0]

