from django.contrib import admin

from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from review.models import ReviewUser

class ReviewUserInline(admin.StackedInline):
        model = ReviewUser
        list_display = ("user_uuid", "djangoUser")
        verbose_name_plural = 'user'

class UserAdmin(admin.ModelAdmin):

        inlines = (ReviewUserInline, )    
       
        
admin.site.unregister(User)
admin.site.register(User, UserAdmin)

admin.site.register(ReviewUser)
