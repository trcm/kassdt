from django.contrib import admin
from help.models import Post


class PostAdmin(admin.ModelAdmin):
    """ 
    Admin representation for the Post model
    """
    model = Post
    list_display = ('title', 'by', 'created', 'open', 'resolved')

admin.site.register(Post, PostAdmin)
