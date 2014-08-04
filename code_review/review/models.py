from django.db import models

class Test(models.Model):
    Name = models.CharField(max_length=50)
    def __unicode__(self):
        return self.Name
