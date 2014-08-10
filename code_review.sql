-- MySQL dump 10.13  Distrib 5.5.37, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: code_review
-- ------------------------------------------------------
-- Server version	5.5.37-1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'staff'),(2,'student');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,1,46),(47,1,47),(48,1,48),(49,1,49),(50,1,50),(51,1,51),(52,2,22),(53,2,23),(54,2,24),(55,2,25),(56,2,26),(57,2,27),(58,2,28),(59,2,29),(60,2,30),(61,2,31),(62,2,32),(63,2,33),(64,2,34),(65,2,35),(66,2,36),(67,2,37),(68,2,38),(69,2,39),(70,2,40),(71,2,41),(72,2,42),(73,2,43),(74,2,44),(75,2,45),(76,2,46),(77,2,47),(78,2,48),(79,2,49),(80,2,50),(81,2,51);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add migration history',7,'add_migrationhistory'),(20,'Can change migration history',7,'change_migrationhistory'),(21,'Can delete migration history',7,'delete_migrationhistory'),(22,'Can add review user',8,'add_reviewuser'),(23,'Can change review user',8,'change_reviewuser'),(24,'Can delete review user',8,'delete_reviewuser'),(25,'Can add source folder',9,'add_sourcefolder'),(26,'Can change source folder',9,'change_sourcefolder'),(27,'Can delete source folder',9,'delete_sourcefolder'),(28,'Can add source file',10,'add_sourcefile'),(29,'Can change source file',10,'change_sourcefile'),(30,'Can delete source file',10,'delete_sourcefile'),(31,'Can add submission test results',11,'add_submissiontestresults'),(32,'Can change submission test results',11,'change_submissiontestresults'),(33,'Can delete submission test results',11,'delete_submissiontestresults'),(34,'Can add submission test',12,'add_submissiontest'),(35,'Can change submission test',12,'change_submissiontest'),(36,'Can delete submission test',12,'delete_submissiontest'),(37,'Can add assignment',13,'add_assignment'),(38,'Can change assignment',13,'change_assignment'),(39,'Can delete assignment',13,'delete_assignment'),(40,'Can add assignment submission',14,'add_assignmentsubmission'),(41,'Can change assignment submission',14,'change_assignmentsubmission'),(42,'Can delete assignment submission',14,'delete_assignmentsubmission'),(43,'Can add source annotation',15,'add_sourceannotation'),(44,'Can change source annotation',15,'change_sourceannotation'),(45,'Can delete source annotation',15,'delete_sourceannotation'),(46,'Can add source annotation range',16,'add_sourceannotationrange'),(47,'Can change source annotation range',16,'change_sourceannotationrange'),(48,'Can delete source annotation range',16,'delete_sourceannotationrange'),(49,'Can add source annotation tag',17,'add_sourceannotationtag'),(50,'Can change source annotation tag',17,'change_sourceannotationtag'),(51,'Can delete source annotation tag',17,'delete_sourceannotationtag');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$ft9nYbLk98nz$0jWFRw0hFevhaVj0FP1DhB2uorhv54jMJ8F5lipjiZI=','2014-08-06 02:56:34',1,'admin','','','',1,1,'2014-08-05 07:24:02'),(4,'tom','2014-08-06 02:22:51',0,'tom','','','',0,1,'2014-08-06 02:22:51'),(5,'thing','2014-08-06 02:40:07',1,'thing','','','',1,1,'2014-08-06 02:40:07'),(7,'pbkdf2_sha256$12000$8CNDmYGUqF6D$LnOpb9lNw+ByOjwXaKouu3LIXPSHeTNiEeG2195X5O8=','2014-08-06 02:55:44',0,'test','','','',0,1,'2014-08-06 02:55:05');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (10,1,1),(11,4,1),(8,5,2),(12,7,2);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,1,46),(47,1,47),(48,1,48),(49,1,49),(50,1,50),(51,1,51);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-08-06 02:17:45',1,8,'1','tom',3,''),(2,'2014-08-06 02:17:54',1,8,'2','tom',1,''),(3,'2014-08-06 02:22:36',1,4,'2','tom',3,''),(4,'2014-08-06 02:23:43',1,4,'4','tom',2,'No fields changed.'),(5,'2014-08-06 02:25:54',1,3,'1','staff',1,''),(6,'2014-08-06 02:26:57',1,3,'2','student',1,''),(7,'2014-08-06 02:30:23',1,8,'3','tom',1,''),(8,'2014-08-06 02:32:38',1,4,'1','admin',2,'Changed groups.'),(9,'2014-08-06 02:32:48',1,4,'4','tom',2,'Changed groups.'),(10,'2014-08-06 02:40:19',1,4,'5','thing',1,''),(11,'2014-08-06 02:41:23',1,4,'5','thing',2,'Changed is_superuser.'),(12,'2014-08-06 02:41:55',1,4,'5','thing',2,'Changed is_staff.'),(13,'2014-08-06 02:42:41',1,4,'4','tom',2,'Changed groups.'),(14,'2014-08-06 02:53:42',1,4,'1','admin',2,'Changed user_permissions.'),(15,'2014-08-06 02:53:52',1,4,'4','tom',2,'No fields changed.'),(16,'2014-08-06 02:55:34',1,4,'7','test',2,'Changed groups.');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'migration history','south','migrationhistory'),(8,'review user','review','reviewuser'),(9,'source folder','review','sourcefolder'),(10,'source file','review','sourcefile'),(11,'submission test results','review','submissiontestresults'),(12,'submission test','review','submissiontest'),(13,'assignment','review','assignment'),(14,'assignment submission','review','assignmentsubmission'),(15,'source annotation','review','sourceannotation'),(16,'source annotation range','review','sourceannotationrange'),(17,'source annotation tag','review','sourceannotationtag');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('289ujrkd3typaycohu13oa1jx8gdnkxs','MzI0OGYzZGYxMDA1MGRmY2M5YjM5MTE5ZjJhYjY2MTVmMzQwYTY5MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-08-19 07:24:39'),('attvjf62rganh21v2d12eb65x6b6jccw','YWQ4MWU2MDRjZmJhYWQ3NDZjOTZkYmFiM2QyMWIxMjkwOTlmNjA5MTp7fQ==','2014-08-20 02:59:37');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_assignment`
--

DROP TABLE IF EXISTS `review_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assignment_uuid` varchar(36) NOT NULL,
  `name` longtext NOT NULL,
  `repository_format` longtext NOT NULL,
  `first_display_date` datetime NOT NULL,
  `submission_open_date` datetime NOT NULL,
  `submission_close_date` datetime NOT NULL,
  `review_open_date` datetime NOT NULL,
  `review_close_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_assignment`
--

LOCK TABLES `review_assignment` WRITE;
/*!40000 ALTER TABLE `review_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_assignmentsubmission`
--

DROP TABLE IF EXISTS `review_assignmentsubmission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_assignmentsubmission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submission_uuid` varchar(36) NOT NULL,
  `submission_date` datetime NOT NULL,
  `by_id` int(11) NOT NULL,
  `submission_repository` longtext NOT NULL,
  `submission_for_id` int(11) NOT NULL,
  `error_occurred` tinyint(1) NOT NULL,
  `root_folder_id` int(11) DEFAULT NULL,
  `test_results_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `root_folder_id` (`root_folder_id`),
  UNIQUE KEY `test_results_id` (`test_results_id`),
  KEY `review_assignmentsubmission_e48e5091` (`by_id`),
  KEY `review_assignmentsubmission_e7178437` (`submission_for_id`),
  CONSTRAINT `by_id_refs_id_a4fcd4d1` FOREIGN KEY (`by_id`) REFERENCES `review_reviewuser` (`id`),
  CONSTRAINT `root_folder_id_refs_id_55a751b9` FOREIGN KEY (`root_folder_id`) REFERENCES `review_sourcefolder` (`id`),
  CONSTRAINT `submission_for_id_refs_id_8d20aaf0` FOREIGN KEY (`submission_for_id`) REFERENCES `review_assignment` (`id`),
  CONSTRAINT `test_results_id_refs_id_ff4abb0b` FOREIGN KEY (`test_results_id`) REFERENCES `review_submissiontestresults` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_assignmentsubmission`
--

LOCK TABLES `review_assignmentsubmission` WRITE;
/*!40000 ALTER TABLE `review_assignmentsubmission` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_assignmentsubmission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_reviewuser`
--

DROP TABLE IF EXISTS `review_reviewuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_reviewuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_uuid` varchar(36) NOT NULL,
  `djangoUser_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `djangoUser_id` (`djangoUser_id`),
  CONSTRAINT `djangoUser_id_refs_id_ce92d1c6` FOREIGN KEY (`djangoUser_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_reviewuser`
--

LOCK TABLES `review_reviewuser` WRITE;
/*!40000 ALTER TABLE `review_reviewuser` DISABLE KEYS */;
INSERT INTO `review_reviewuser` VALUES (3,'b931cb73-a66e-43fd-b49f-cdc182554b7e',4);
/*!40000 ALTER TABLE `review_reviewuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_sourceannotation`
--

DROP TABLE IF EXISTS `review_sourceannotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_sourceannotation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `annotation_uuid` varchar(36) NOT NULL,
  `user_id` int(11) NOT NULL,
  `source_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `text` longtext NOT NULL,
  `quote` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_sourceannotation_6340c63c` (`user_id`),
  KEY `review_sourceannotation_a34b03a6` (`source_id`),
  CONSTRAINT `source_id_refs_id_ff216b20` FOREIGN KEY (`source_id`) REFERENCES `review_sourcefile` (`id`),
  CONSTRAINT `user_id_refs_id_c5e486c3` FOREIGN KEY (`user_id`) REFERENCES `review_reviewuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourceannotation`
--

LOCK TABLES `review_sourceannotation` WRITE;
/*!40000 ALTER TABLE `review_sourceannotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_sourceannotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_sourceannotationrange`
--

DROP TABLE IF EXISTS `review_sourceannotationrange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_sourceannotationrange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `range_annotation_id` int(11) NOT NULL,
  `start` longtext NOT NULL,
  `end` longtext NOT NULL,
  `startOffset` int(10) unsigned NOT NULL,
  `endOffset` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_sourceannotationrange_e92f1259` (`range_annotation_id`),
  CONSTRAINT `range_annotation_id_refs_id_2e0dc21e` FOREIGN KEY (`range_annotation_id`) REFERENCES `review_sourceannotation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourceannotationrange`
--

LOCK TABLES `review_sourceannotationrange` WRITE;
/*!40000 ALTER TABLE `review_sourceannotationrange` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_sourceannotationrange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_sourceannotationtag`
--

DROP TABLE IF EXISTS `review_sourceannotationtag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_sourceannotationtag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_annotation_id` int(11) NOT NULL,
  `tag` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_sourceannotationtag_afe05e8a` (`tag_annotation_id`),
  CONSTRAINT `tag_annotation_id_refs_id_1d6bf2d6` FOREIGN KEY (`tag_annotation_id`) REFERENCES `review_sourceannotation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourceannotationtag`
--

LOCK TABLES `review_sourceannotationtag` WRITE;
/*!40000 ALTER TABLE `review_sourceannotationtag` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_sourceannotationtag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_sourcefile`
--

DROP TABLE IF EXISTS `review_sourcefile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_sourcefile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folder_id` int(11) NOT NULL,
  `file_uuid` varchar(36) NOT NULL,
  `name` longtext NOT NULL,
  `file` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_sourcefile_3aef490b` (`folder_id`),
  CONSTRAINT `folder_id_refs_id_64e8f40a` FOREIGN KEY (`folder_id`) REFERENCES `review_sourcefolder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourcefile`
--

LOCK TABLES `review_sourcefile` WRITE;
/*!40000 ALTER TABLE `review_sourcefile` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_sourcefile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_sourcefolder`
--

DROP TABLE IF EXISTS `review_sourcefolder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_sourcefolder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folder_uuid` varchar(36) NOT NULL,
  `name` longtext NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `review_sourcefolder_410d0aac` (`parent_id`),
  CONSTRAINT `parent_id_refs_id_49b8a727` FOREIGN KEY (`parent_id`) REFERENCES `review_sourcefolder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourcefolder`
--

LOCK TABLES `review_sourcefolder` WRITE;
/*!40000 ALTER TABLE `review_sourcefolder` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_sourcefolder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_submissiontest`
--

DROP TABLE IF EXISTS `review_submissiontest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_submissiontest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `part_of_id` int(11) NOT NULL,
  `test_name` longtext NOT NULL,
  `test_count` int(10) unsigned NOT NULL,
  `test_pass_count` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_submissiontest_f740f564` (`part_of_id`),
  CONSTRAINT `part_of_id_refs_id_f31b377e` FOREIGN KEY (`part_of_id`) REFERENCES `review_submissiontestresults` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_submissiontest`
--

LOCK TABLES `review_submissiontest` WRITE;
/*!40000 ALTER TABLE `review_submissiontest` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_submissiontest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_submissiontestresults`
--

DROP TABLE IF EXISTS `review_submissiontestresults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_submissiontestresults` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tests_completed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_submissiontestresults`
--

LOCK TABLES `review_submissiontestresults` WRITE;
/*!40000 ALTER TABLE `review_submissiontestresults` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_submissiontestresults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `south_migrationhistory`
--

DROP TABLE IF EXISTS `south_migrationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `south_migrationhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) NOT NULL,
  `migration` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `south_migrationhistory`
--

LOCK TABLES `south_migrationhistory` WRITE;
/*!40000 ALTER TABLE `south_migrationhistory` DISABLE KEYS */;
INSERT INTO `south_migrationhistory` VALUES (1,'review','0001_initial','2014-08-05 07:24:11'),(2,'review','0002_auto__del_test__add_user__add_sourceannotation__add_sourcefile__add_so','2014-08-05 07:24:12'),(3,'review','0003_auto__del_user__add_reviewuser__chg_field_sourceannotation_user__chg_f','2014-08-05 07:24:12');
/*!40000 ALTER TABLE `south_migrationhistory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-08-06 16:20:50
