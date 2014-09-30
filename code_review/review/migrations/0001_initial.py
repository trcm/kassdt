# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'Course'
        db.create_table(u'review_course', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('course_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('course_code', self.gf('django.db.models.fields.CharField')(default='ABCD1234', max_length=10)),
            ('course_name', self.gf('django.db.models.fields.CharField')(default='Intro to learning', max_length=100)),
        ))
        db.send_create_signal(u'review', ['Course'])

        # Adding M2M table for field students on 'Course'
        m2m_table_name = db.shorten_name(u'review_course_students')
        db.create_table(m2m_table_name, (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('course', models.ForeignKey(orm[u'review.course'], null=False)),
            ('reviewuser', models.ForeignKey(orm[u'review.reviewuser'], null=False))
        ))
        db.create_unique(m2m_table_name, ['course_id', 'reviewuser_id'])

        # Adding model 'ReviewUser'
        db.create_table(u'review_reviewuser', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('user_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('djangoUser', self.gf('django.db.models.fields.related.OneToOneField')(to=orm['auth.User'], unique=True)),
            ('isStaff', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('firstLogin', self.gf('django.db.models.fields.BooleanField')(default=True)),
        ))
        db.send_create_signal(u'review', ['ReviewUser'])

        # Adding M2M table for field courses on 'ReviewUser'
        m2m_table_name = db.shorten_name(u'review_reviewuser_courses')
        db.create_table(m2m_table_name, (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('reviewuser', models.ForeignKey(orm[u'review.reviewuser'], null=False)),
            ('course', models.ForeignKey(orm[u'review.course'], null=False))
        ))
        db.create_unique(m2m_table_name, ['reviewuser_id', 'course_id'])

        # Adding model 'Enrol'
        db.create_table(u'review_enrol', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(related_name='enrolment', to=orm['review.ReviewUser'])),
            ('course', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['review.Course'])),
            ('student', self.gf('django.db.models.fields.BooleanField')(default=True)),
            ('tutor', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('staff', self.gf('django.db.models.fields.BooleanField')(default=False)),
        ))
        db.send_create_signal(u'review', ['Enrol'])

        # Adding model 'SourceFolder'
        db.create_table(u'review_sourcefolder', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('folder_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('name', self.gf('django.db.models.fields.TextField')()),
            ('parent', self.gf('django.db.models.fields.related.ForeignKey')(related_name='folders', null=True, to=orm['review.SourceFolder'])),
        ))
        db.send_create_signal(u'review', ['SourceFolder'])

        # Adding model 'SourceFile'
        db.create_table(u'review_sourcefile', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('folder', self.gf('django.db.models.fields.related.ForeignKey')(related_name='files', to=orm['review.SourceFolder'])),
            ('file_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('name', self.gf('django.db.models.fields.TextField')()),
            ('file', self.gf('django.db.models.fields.files.FileField')(max_length=1000)),
            ('submission', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['review.AssignmentSubmission'], null=True)),
        ))
        db.send_create_signal(u'review', ['SourceFile'])

        # Adding model 'SubmissionTestResults'
        db.create_table(u'review_submissiontestresults', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('tests_completed', self.gf('django.db.models.fields.NullBooleanField')(null=True, blank=True)),
            ('part_of', self.gf('django.db.models.fields.related.ForeignKey')(related_name='test_results', to=orm['review.SubmissionTest'])),
        ))
        db.send_create_signal(u'review', ['SubmissionTestResults'])

        # Adding model 'SubmissionTest'
        db.create_table(u'review_submissiontest', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('for_assignment', self.gf('django.db.models.fields.related.ForeignKey')(related_name='assignment_tests', to=orm['review.Assignment'])),
            ('test_name', self.gf('django.db.models.fields.TextField')(blank=True)),
            ('test_count', self.gf('django.db.models.fields.PositiveIntegerField')()),
            ('test_pass_count', self.gf('django.db.models.fields.PositiveIntegerField')(default=0)),
            ('test_file', self.gf('django.db.models.fields.files.FileField')(max_length=1000, null=True, blank=True)),
            ('test_command', self.gf('django.db.models.fields.CharField')(max_length=200)),
        ))
        db.send_create_signal(u'review', ['SubmissionTest'])

        # Adding model 'Assignment'
        db.create_table(u'review_assignment', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('course_code', self.gf('django.db.models.fields.related.ForeignKey')(related_name='assignments', to=orm['review.Course'])),
            ('assignment_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('name', self.gf('django.db.models.fields.TextField')()),
            ('repository_format', self.gf('django.db.models.fields.TextField')()),
            ('first_display_date', self.gf('django.db.models.fields.DateTimeField')(default=datetime.datetime(2014, 9, 30, 0, 0))),
            ('submission_open_date', self.gf('django.db.models.fields.DateTimeField')(default=datetime.datetime(2014, 9, 30, 0, 0))),
            ('submission_close_date', self.gf('django.db.models.fields.DateTimeField')()),
            ('review_open_date', self.gf('django.db.models.fields.DateTimeField')(default=datetime.datetime(2014, 9, 30, 0, 0))),
            ('review_close_date', self.gf('django.db.models.fields.DateTimeField')()),
            ('multiple_submissions', self.gf('django.db.models.fields.BooleanField')(default=True)),
            ('reviews_per_student', self.gf('django.db.models.fields.PositiveIntegerField')(default=0)),
            ('min_annotations', self.gf('django.db.models.fields.PositiveIntegerField')(default=0)),
        ))
        db.send_create_signal(u'review', ['Assignment'])

        # Adding model 'AssignmentSubmission'
        db.create_table(u'review_assignmentsubmission', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('submission_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('submission_date', self.gf('django.db.models.fields.DateTimeField')(default=datetime.datetime(2014, 9, 30, 0, 0))),
            ('by', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['review.ReviewUser'])),
            ('submission_repository', self.gf('django.db.models.fields.TextField')()),
            ('submission_for', self.gf('django.db.models.fields.related.ForeignKey')(related_name='submissions', to=orm['review.Assignment'])),
            ('error_occurred', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('root_folder', self.gf('django.db.models.fields.related.OneToOneField')(related_name='assignment', unique=True, null=True, to=orm['review.SourceFolder'])),
        ))
        db.send_create_signal(u'review', ['AssignmentSubmission'])

        # Adding model 'SourceAnnotation'
        db.create_table(u'review_sourceannotation', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('annotation_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['review.ReviewUser'])),
            ('source', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['review.SourceFile'])),
            ('submission', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['review.AssignmentSubmission'], null=True)),
            ('created', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
            ('updated', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
            ('text', self.gf('django.db.models.fields.TextField')()),
            ('quote', self.gf('django.db.models.fields.TextField')()),
        ))
        db.send_create_signal(u'review', ['SourceAnnotation'])

        # Adding model 'SourceAnnotationRange'
        db.create_table(u'review_sourceannotationrange', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('range_annotation', self.gf('django.db.models.fields.related.ForeignKey')(related_name='ranges', to=orm['review.SourceAnnotation'])),
            ('start', self.gf('django.db.models.fields.PositiveIntegerField')()),
            ('end', self.gf('django.db.models.fields.PositiveIntegerField')()),
            ('startOffset', self.gf('django.db.models.fields.PositiveIntegerField')()),
            ('endOffset', self.gf('django.db.models.fields.PositiveIntegerField')()),
        ))
        db.send_create_signal(u'review', ['SourceAnnotationRange'])

        # Adding model 'AssignmentReview'
        db.create_table(u'review_assignmentreview', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('review_uuid', self.gf('django.db.models.fields.CharField')(max_length=36, blank=True)),
            ('by', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['review.ReviewUser'])),
            ('assignment', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['review.Assignment'], null=True)),
        ))
        db.send_create_signal(u'review', ['AssignmentReview'])

        # Adding M2M table for field submissions on 'AssignmentReview'
        m2m_table_name = db.shorten_name(u'review_assignmentreview_submissions')
        db.create_table(m2m_table_name, (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('assignmentreview', models.ForeignKey(orm[u'review.assignmentreview'], null=False)),
            ('assignmentsubmission', models.ForeignKey(orm[u'review.assignmentsubmission'], null=False))
        ))
        db.create_unique(m2m_table_name, ['assignmentreview_id', 'assignmentsubmission_id'])

        # Adding model 'SourceAnnotationTag'
        db.create_table(u'review_sourceannotationtag', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('tag_annotation', self.gf('django.db.models.fields.related.ForeignKey')(related_name='tags', to=orm['review.SourceAnnotation'])),
            ('tag', self.gf('django.db.models.fields.TextField')()),
        ))
        db.send_create_signal(u'review', ['SourceAnnotationTag'])


    def backwards(self, orm):
        # Deleting model 'Course'
        db.delete_table(u'review_course')

        # Removing M2M table for field students on 'Course'
        db.delete_table(db.shorten_name(u'review_course_students'))

        # Deleting model 'ReviewUser'
        db.delete_table(u'review_reviewuser')

        # Removing M2M table for field courses on 'ReviewUser'
        db.delete_table(db.shorten_name(u'review_reviewuser_courses'))

        # Deleting model 'Enrol'
        db.delete_table(u'review_enrol')

        # Deleting model 'SourceFolder'
        db.delete_table(u'review_sourcefolder')

        # Deleting model 'SourceFile'
        db.delete_table(u'review_sourcefile')

        # Deleting model 'SubmissionTestResults'
        db.delete_table(u'review_submissiontestresults')

        # Deleting model 'SubmissionTest'
        db.delete_table(u'review_submissiontest')

        # Deleting model 'Assignment'
        db.delete_table(u'review_assignment')

        # Deleting model 'AssignmentSubmission'
        db.delete_table(u'review_assignmentsubmission')

        # Deleting model 'SourceAnnotation'
        db.delete_table(u'review_sourceannotation')

        # Deleting model 'SourceAnnotationRange'
        db.delete_table(u'review_sourceannotationrange')

        # Deleting model 'AssignmentReview'
        db.delete_table(u'review_assignmentreview')

        # Removing M2M table for field submissions on 'AssignmentReview'
        db.delete_table(db.shorten_name(u'review_assignmentreview_submissions'))

        # Deleting model 'SourceAnnotationTag'
        db.delete_table(u'review_sourceannotationtag')


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
            'course_code': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'assignments'", 'to': u"orm['review.Course']"}),
            'first_display_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 9, 30, 0, 0)'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'min_annotations': ('django.db.models.fields.PositiveIntegerField', [], {'default': '0'}),
            'multiple_submissions': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'name': ('django.db.models.fields.TextField', [], {}),
            'repository_format': ('django.db.models.fields.TextField', [], {}),
            'review_close_date': ('django.db.models.fields.DateTimeField', [], {}),
            'review_open_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 9, 30, 0, 0)'}),
            'reviews_per_student': ('django.db.models.fields.PositiveIntegerField', [], {'default': '0'}),
            'submission_close_date': ('django.db.models.fields.DateTimeField', [], {}),
            'submission_open_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 9, 30, 0, 0)'})
        },
        u'review.assignmentreview': {
            'Meta': {'object_name': 'AssignmentReview'},
            'assignment': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.Assignment']", 'null': 'True'}),
            'by': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.ReviewUser']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'review_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'}),
            'submissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['review.AssignmentSubmission']", 'null': 'True', 'symmetrical': 'False'})
        },
        u'review.assignmentsubmission': {
            'Meta': {'object_name': 'AssignmentSubmission'},
            'by': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.ReviewUser']"}),
            'error_occurred': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'root_folder': ('django.db.models.fields.related.OneToOneField', [], {'related_name': "'assignment'", 'unique': 'True', 'null': 'True', 'to': u"orm['review.SourceFolder']"}),
            'submission_date': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2014, 9, 30, 0, 0)'}),
            'submission_for': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'submissions'", 'to': u"orm['review.Assignment']"}),
            'submission_repository': ('django.db.models.fields.TextField', [], {}),
            'submission_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'})
        },
        u'review.course': {
            'Meta': {'object_name': 'Course'},
            'course_code': ('django.db.models.fields.CharField', [], {'default': "'ABCD1234'", 'max_length': '10'}),
            'course_name': ('django.db.models.fields.CharField', [], {'default': "'Intro to learning'", 'max_length': '100'}),
            'course_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'students': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['review.ReviewUser']", 'symmetrical': 'False'})
        },
        u'review.enrol': {
            'Meta': {'object_name': 'Enrol'},
            'course': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.Course']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'staff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'student': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'tutor': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'enrolment'", 'to': u"orm['review.ReviewUser']"})
        },
        u'review.reviewuser': {
            'Meta': {'object_name': 'ReviewUser'},
            'courses': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['review.Course']", 'symmetrical': 'False'}),
            'djangoUser': ('django.db.models.fields.related.OneToOneField', [], {'to': u"orm['auth.User']", 'unique': 'True'}),
            'firstLogin': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
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
            'submission': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.AssignmentSubmission']", 'null': 'True'}),
            'text': ('django.db.models.fields.TextField', [], {}),
            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.ReviewUser']"})
        },
        u'review.sourceannotationrange': {
            'Meta': {'object_name': 'SourceAnnotationRange'},
            'end': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'endOffset': ('django.db.models.fields.PositiveIntegerField', [], {}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'range_annotation': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'ranges'", 'to': u"orm['review.SourceAnnotation']"}),
            'start': ('django.db.models.fields.PositiveIntegerField', [], {}),
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
            'file': ('django.db.models.fields.files.FileField', [], {'max_length': '1000'}),
            'file_uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'blank': 'True'}),
            'folder': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'files'", 'to': u"orm['review.SourceFolder']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.TextField', [], {}),
            'submission': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['review.AssignmentSubmission']", 'null': 'True'})
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
            'for_assignment': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'assignment_tests'", 'to': u"orm['review.Assignment']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'test_command': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'test_count': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'test_file': ('django.db.models.fields.files.FileField', [], {'max_length': '1000', 'null': 'True', 'blank': 'True'}),
            'test_name': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'test_pass_count': ('django.db.models.fields.PositiveIntegerField', [], {'default': '0'})
        },
        u'review.submissiontestresults': {
            'Meta': {'object_name': 'SubmissionTestResults'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'part_of': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'test_results'", 'to': u"orm['review.SubmissionTest']"}),
            'tests_completed': ('django.db.models.fields.NullBooleanField', [], {'null': 'True', 'blank': 'True'})
        }
    }

    complete_apps = ['review']