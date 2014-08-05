# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Deleting model 'Test'
        db.delete_table(u'review_test')

        # Adding model 'User'
        db.create_table(u'review_user', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('user_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('djangoUser', self.gf('django.db.models.fields.related.OneToOneField')(to=orm['auth.User'], unique=True)),
        ))
        db.send_create_signal(u'review', ['User'])

        # Adding model 'SourceAnnotation'
        db.create_table(u'review_sourceannotation', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('annotation_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['review.User'])),
            ('source', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['review.SourceFile'])),
            ('created', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
            ('updated', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
            ('text', self.gf('django.db.models.fields.TextField')()),
            ('quote', self.gf('django.db.models.fields.TextField')()),
        ))
        db.send_create_signal(u'review', ['SourceAnnotation'])

        # Adding model 'SourceFile'
        db.create_table(u'review_sourcefile', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('folder', self.gf('django.db.models.fields.related.ForeignKey')(related_name='files', to=orm['review.SourceFolder'])),
            ('file_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('name', self.gf('django.db.models.fields.TextField')()),
            ('file', self.gf('django.db.models.fields.files.FileField')(max_length=100)),
        ))
        db.send_create_signal(u'review', ['SourceFile'])

        # Adding model 'SourceAnnotationRange'
        db.create_table(u'review_sourceannotationrange', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('range_annotation', self.gf('django.db.models.fields.related.ForeignKey')(related_name='ranges', to=orm['review.SourceAnnotation'])),
            ('start', self.gf('django.db.models.fields.TextField')()),
            ('end', self.gf('django.db.models.fields.TextField')()),
            ('startOffset', self.gf('django.db.models.fields.PositiveIntegerField')()),
            ('endOffset', self.gf('django.db.models.fields.PositiveIntegerField')()),
        ))
        db.send_create_signal(u'review', ['SourceAnnotationRange'])

        # Adding model 'SubmissionTest'
        db.create_table(u'review_submissiontest', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('part_of', self.gf('django.db.models.fields.related.ForeignKey')(related_name='test_results', to=orm['review.SubmissionTestResults'])),
            ('test_name', self.gf('django.db.models.fields.TextField')(blank=True)),
            ('test_count', self.gf('django.db.models.fields.PositiveIntegerField')()),
            ('test_pass_count', self.gf('django.db.models.fields.PositiveIntegerField')()),
        ))
        db.send_create_signal(u'review', ['SubmissionTest'])

        # Adding model 'SubmissionTestResults'
        db.create_table(u'review_submissiontestresults', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('tests_completed', self.gf('django.db.models.fields.NullBooleanField')(null=True, blank=True)),
        ))
        db.send_create_signal(u'review', ['SubmissionTestResults'])

        # Adding model 'SourceAnnotationTag'
        db.create_table(u'review_sourceannotationtag', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('tag_annotation', self.gf('django.db.models.fields.related.ForeignKey')(related_name='tags', to=orm['review.SourceAnnotation'])),
            ('tag', self.gf('django.db.models.fields.TextField')()),
        ))
        db.send_create_signal(u'review', ['SourceAnnotationTag'])

        # Adding model 'AssignmentSubmission'
        db.create_table(u'review_assignmentsubmission', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('submission_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('submission_date', self.gf('django.db.models.fields.DateTimeField')(default=datetime.datetime(2014, 8, 5, 0, 0))),
            ('by', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['review.User'])),
            ('submission_repository', self.gf('django.db.models.fields.TextField')()),
            ('submission_for', self.gf('django.db.models.fields.related.ForeignKey')(related_name='submissions', to=orm['review.Assignment'])),
            ('error_occurred', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('root_folder', self.gf('django.db.models.fields.related.OneToOneField')(related_name='assignment', unique=True, null=True, to=orm['review.SourceFolder'])),
            ('test_results', self.gf('django.db.models.fields.related.OneToOneField')(related_name='assignment', unique=True, null=True, to=orm['review.SubmissionTestResults'])),
        ))
        db.send_create_signal(u'review', ['AssignmentSubmission'])

        # Adding model 'Assignment'
        db.create_table(u'review_assignment', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('assignment_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('name', self.gf('django.db.models.fields.TextField')()),
            ('repository_format', self.gf('django.db.models.fields.TextField')()),
            ('first_display_date', self.gf('django.db.models.fields.DateTimeField')(default=datetime.datetime(2014, 8, 5, 0, 0))),
            ('submission_open_date', self.gf('django.db.models.fields.DateTimeField')(default=datetime.datetime(2014, 8, 5, 0, 0))),
            ('submission_close_date', self.gf('django.db.models.fields.DateTimeField')()),
            ('review_open_date', self.gf('django.db.models.fields.DateTimeField')(default=datetime.datetime(2014, 8, 5, 0, 0))),
            ('review_close_date', self.gf('django.db.models.fields.DateTimeField')()),
        ))
        db.send_create_signal(u'review', ['Assignment'])

        # Adding model 'SourceFolder'
        db.create_table(u'review_sourcefolder', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('folder_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('name', self.gf('django.db.models.fields.TextField')()),
            ('parent', self.gf('django.db.models.fields.related.ForeignKey')(related_name='folders', null=True, to=orm['review.SourceFolder'])),
        ))
        db.send_create_signal(u'review', ['SourceFolder'])


    def backwards(self, orm):
        # Adding model 'Test'
        db.create_table(u'review_test', (
            ('Name', self.gf('django.db.models.fields.CharField')(max_length=50)),
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
        ))
        db.send_create_signal(u'review', ['Test'])

        # Deleting model 'User'
        db.delete_table(u'review_user')

        # Deleting model 'SourceAnnotation'
        db.delete_table(u'review_sourceannotation')

        # Deleting model 'SourceFile'
        db.delete_table(u'review_sourcefile')

        # Deleting model 'SourceAnnotationRange'
        db.delete_table(u'review_sourceannotationrange')

        # Deleting model 'SubmissionTest'
        db.delete_table(u'review_submissiontest')

        # Deleting model 'SubmissionTestResults'
        db.delete_table(u'review_submissiontestresults')

        # Deleting model 'SourceAnnotationTag'
        db.delete_table(u'review_sourceannotationtag')

        # Deleting model 'AssignmentSubmission'
        db.delete_table(u'review_assignmentsubmission')

        # Deleting model 'Assignment'
        db.delete_table(u'review_assignment')

        # Deleting model 'SourceFolder'
        db.delete_table(u'review_sourcefolder')


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
            'first_display_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 8, 5, 0, 0)'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.TextField', [], {}),
            'repository_format': ('django.db.models.fields.TextField', [], {}),
            'review_close_date': ('django.db.models.fields.DateTimeField', [], {}),
            'review_open_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 8, 5, 0, 0)'}),
            'submission_close_date': ('django.db.models.fields.DateTimeField', [], {}),
            'submission_open_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 8, 5, 0, 0)'})
        },
        u'review.assignmentsubmission': {
            'Meta': {'object_name': 'AssignmentSubmission'},
            'by': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.User']"}),
            'error_occurred': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'root_folder': ('django.db.models.fields.related.OneToOneField', [], {'related_name': "'assignment'", 'unique': 'True', 'null': 'True', 'to': u"orm['review.SourceFolder']"}),
            'submission_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 8, 5, 0, 0)'}),
            'submission_for': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'submissions'", 'to': u"orm['review.Assignment']"}),
            'submission_repository': ('django.db.models.fields.TextField', [], {}),
            'submission_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'}),
            'test_results': ('django.db.models.fields.related.OneToOneField', [], {'related_name': "'assignment'", 'unique': 'True', 'null': 'True', 'to': u"orm['review.SubmissionTestResults']"})
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
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.User']"})
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
        },
        u'review.user': {
            'Meta': {'object_name': 'User'},
            'djangoUser': ('django.db.models.fields.related.OneToOneField', [], {'to': u"orm['auth.User']", 'unique': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'user_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'})
        }
    }

    complete_apps = ['review']