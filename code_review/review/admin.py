from django.contrib import admin
from review.models import User

class UserAdmin(admin.ModelAdmin):
    list_display = ("user_uuid", "djangoUser")
    

admin.site.register(User, UserAdmin)

