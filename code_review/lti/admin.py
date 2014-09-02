from django.contrib import admin
from LTI.models import LTIProfile

class LTIProfileAdmin(admin.ModelAdmin):
    pass


admin.site.register(LTIProfile, LTIProfileAdmin)
