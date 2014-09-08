# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding M2M table for field courses on 'ReviewUser'
        m2m_table_name = db.shorten_name(u'review_reviewuser_courses')
        db.create_table(m2m_table_name, (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('reviewuser', models.ForeignKey(orm[u'review.reviewuser'], null=False)),
            ('course', models.ForeignKey(orm[u'review.course'], null=False))
        ))
        db.create_unique(m2m_table_name, ['reviewuser_id', 'course_id'])


    def backwards(self, orm):
        # Removing M2M table for field courses on 'ReviewUser'
        db.delete_table(db.shorten_name(u'review_reviewuser_courses'))


    models = {
        u'auth.group': {
            'Meta': {'object_name': 'Group'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '80'}),
            'permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'})
        },
        u'auth.permission': {
            'Meta': {'ordering': "(u'content_type__app_label', u'content_type__model', u'codename')", 'unique_together': "((u'content_type', u'codename'),)", 'object_name': 'Permission'},
            'codename': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'content_type': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['contenttypes.ContentType']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        u'auth.user': {
            'Meta': {'object_name': 'User'},
            'date_joined': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'groups': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'related_name': "u'user_set'", 'blank': 'True', 'to': u"orm['auth.Group']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'is_staff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'is_superuser': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'last_login': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'password': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'user_permissions': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'related_name': "u'user_set'", 'blank': 'True', 'to': u"orm['auth.Permission']"}),
            'username': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '30'})
        },
        u'contenttypes.contenttype': {
            'Meta': {'ordering': "('name',)", 'unique_together': "(('app_label', 'model'),)", 'object_name': 'ContentType', 'db_table': "'django_content_type'"},
            'app_label': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'model': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        },
        u'review.assignment': {
            'Meta': {'object_name': 'Assignment'},
            'assignment_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'}),
            'course_code': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.Course']"}),
            'first_display_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 8, 8, 0, 0)'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.TextField', [], {}),
            'repository_format': ('django.db.models.fields.TextField', [], {}),
            'review_close_date': ('django.db.models.fields.DateTimeField', [], {}),
            'review_open_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 8, 8, 0, 0)'}),
            'submission_close_date': ('django.db.models.fields.DateTimeField', [], {}),
            'submission_open_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 8, 8, 0, 0)'})
        },
        u'review.assignmentsubmission': {
            'Meta': {'object_name': 'AssignmentSubmission'},
            'by': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.ReviewUser']"}),
            'error_occurred': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'root_folder': ('django.db.models.fields.related.OneToOneField', [], {'related_name': "'assignment'", 'unique': 'True', 'null': 'True', 'to': u"orm['review.SourceFolder']"}),
            'submission_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 8, 8, 0, 0)'}),
            'submission_for': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'submissions'", 'to': u"orm['review.Assignment']"}),
            'submission_repository': ('django.db.models.fields.TextField', [], {}),
            'submission_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'}),
            'test_results': ('django.db.models.fields.related.OneToOneField', [], {'related_name': "'assignment'", 'unique': 'True', 'null': 'True', 'to': u"orm['review.SubmissionTestResults']"})
        },
        u'review.course': {
            'Meta': {'object_name': 'Course'},
            'course_code': ('django.db.models.fields.CharField', [], {'default': "'ABCD1234'", 'max_length': '10'}),
            'course_name': ('django.db.models.fields.CharField', [], {'default': "'Intro to learning'", 'max_length': '50'}),
            'course_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'})
        },
        u'review.reviewuser': {
            'Meta': {'object_name': 'ReviewUser'},
            'courses': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['review.Course']", 'symmetrical': 'False'}),
            'djangoUser': ('django.db.models.fields.related.OneToOneField', [], {'to': u"orm['auth.User']", 'unique': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'isStaff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'user_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'})
        },
        u'review.sourceannotation': {
            'Meta': {'object_name': 'SourceAnnotation'},
            'annotation_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'}),
            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'quote': ('django.db.models.fields.TextField', [], {}),
            'source': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.SourceFile']"}),
            'text': ('django.db.models.fields.TextField', [], {}),
            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.ReviewUser']"})
        },
        u'review.sourceannotationrange': {
            'Meta': {'object_name': 'SourceAnnotationRange'},
            'end': ('django.db.models.fields.TextField', [], {}),
            'endOffset': ('django.db.models.fields.PositiveIntegerField', [], {}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'range_annotation': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'ranges'", 'to': u"orm['review.SourceAnnotation']"}),
            'start': ('django.db.models.fields.TextField', [], {}),
            'startOffset': ('django.db.models.fields.PositiveIntegerField', [], {})
        },
        u'review.sourceannotationtag': {
            'Meta': {'object_name': 'SourceAnnotationTag'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'tag': ('django.db.models.fields.TextField', [], {}),
            'tag_annotation': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'tags'", 'to': u"orm['review.SourceAnnotation']"})
        },
        u'review.sourcefile': {
            'Meta': {'object_name': 'SourceFile'},
            'file': ('django.db.models.fields.files.FileField', [], {'max_length': '100'}),
            'file_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'}),
            'folder': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'files'", 'to': u"orm['review.SourceFolder']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.TextField', [], {})
        },
        u'review.sourcefolder': {
            'Meta': {'object_name': 'SourceFolder'},
            'folder_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.TextField', [], {}),
            'parent': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'folders'", 'null': 'True', 'to': u"orm['review.SourceFolder']"})
        },
        u'review.submissiontest': {
            'Meta': {'object_name': 'SubmissionTest'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'part_of': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'test_results'", 'to': u"orm['review.SubmissionTestResults']"}),
            'test_count': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'test_name': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'test_pass_count': ('django.db.models.fields.PositiveIntegerField', [], {})
        },
        u'review.submissiontestresults': {
            'Meta': {'object_name': 'SubmissionTestResults'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'tests_completed': ('django.db.models.fields.NullBooleanField', [], {'null': 'True', 'blank': 'True'})
        }
    }

    complete_apps = ['review']