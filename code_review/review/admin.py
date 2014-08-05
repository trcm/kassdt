from django.contrib import admin

from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from review.models import ReviewUser

class ReviewUserInline(admin.StackedInline):
	model = ReviewUser
	verbose_name_plural = 'user'

class UserAdmin(admin.ModelAdmin):
#    list_ldisplay = ("user_uuid", "djangoUser")
	# inlintes = (ReviewUserInline, )    
        pass
        
admin.site.unregister(User)
admin.site.register(User, UserAdmin)

