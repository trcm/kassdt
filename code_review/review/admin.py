from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.forms import UserChangeForm, PasswordChangeForm

from django.contrib.auth.models import User
from review.models import *
# from django import forms

class ReviewUserInline(admin.StackedInline):
    model = ReviewUser
    readonly_fields = ('user_uuid', )
    fields = ("djangoUser", 'user_uuid', 'courses')
    verbose_name_plural = 'user'
    filter_horizontal = ('courses',)

    def callable(self, ru):
        return ru.user_uuid


class UserAdmin(UserAdmin):
    #    list_ldisplay = ("user_uuid", "djangoUser")
    model = User
    form = UserChangeForm
    inlines = (ReviewUserInline, )
    list_display = ("username", "email", "is_staff", "is_superuser")


class ReviewUserAdmin(admin.ModelAdmin):
    model = ReviewUser
    readonly_fields = ('user_uuid', )
    fields = ("djangoUser", 'user_uuid', 'courses')
    list_display = ('djangoUser', 'user_uuid', 'isStaff')
    filter_horizontal = ('courses', )


class CourseAdmin(admin.ModelAdmin):
    model = Course
    list_display = ('course_code', 'course_name')
    fields = ('course_code', 'course_name', 'students')
    search_fields = ('course_code', )

# adds models for editing in the admin page
admin.site.unregister(User)

# admin.site.register(createUserForm, UserAdmin)
admin.site.register(User, UserAdmin)
admin.site.register(ReviewUser, ReviewUserAdmin)
admin.site.register(Course, CourseAdmin)

admin.site.register(SourceFolder)
admin.site.register(SourceFile)
admin.site.register(SubmissionTest)
admin.site.register(SubmissionTestResults)
admin.site.register(Assignment)
admin.site.register(AssignmentSubmission)
admin.site.register(SourceAnnotation)
admin.site.register(SourceAnnotationRange)
admin.site.register(SourceAnnotationTag)
