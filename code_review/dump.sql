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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,1,46),(47,1,47),(48,1,48),(49,1,49),(50,1,50),(51,1,51),(52,1,52),(53,1,53),(54,1,54),(55,2,16),(56,2,17),(57,2,18),(58,2,19),(59,2,20),(60,2,21),(61,2,28),(62,2,29),(63,2,30),(64,2,31),(65,2,32),(66,2,33),(67,2,34),(68,2,35),(69,2,36),(70,2,37),(71,2,38),(72,2,39),(73,2,43),(74,2,44),(75,2,45),(76,2,46),(77,2,47),(78,2,48),(79,2,49),(80,2,50),(81,2,51),(82,2,52),(83,2,53),(84,2,54);
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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add migration history',7,'add_migrationhistory'),(20,'Can change migration history',7,'change_migrationhistory'),(21,'Can delete migration history',7,'delete_migrationhistory'),(22,'Can add review user',8,'add_reviewuser'),(23,'Can change review user',8,'change_reviewuser'),(24,'Can delete review user',8,'delete_reviewuser'),(25,'Can add course',9,'add_course'),(26,'Can change course',9,'change_course'),(27,'Can delete course',9,'delete_course'),(28,'Can add source folder',10,'add_sourcefolder'),(29,'Can change source folder',10,'change_sourcefolder'),(30,'Can delete source folder',10,'delete_sourcefolder'),(31,'Can add source file',11,'add_sourcefile'),(32,'Can change source file',11,'change_sourcefile'),(33,'Can delete source file',11,'delete_sourcefile'),(34,'Can add submission test results',12,'add_submissiontestresults'),(35,'Can change submission test results',12,'change_submissiontestresults'),(36,'Can delete submission test results',12,'delete_submissiontestresults'),(37,'Can add submission test',13,'add_submissiontest'),(38,'Can change submission test',13,'change_submissiontest'),(39,'Can delete submission test',13,'delete_submissiontest'),(40,'Can add assignment',14,'add_assignment'),(41,'Can change assignment',14,'change_assignment'),(42,'Can delete assignment',14,'delete_assignment'),(43,'Can add assignment submission',15,'add_assignmentsubmission'),(44,'Can change assignment submission',15,'change_assignmentsubmission'),(45,'Can delete assignment submission',15,'delete_assignmentsubmission'),(46,'Can add source annotation',16,'add_sourceannotation'),(47,'Can change source annotation',16,'change_sourceannotation'),(48,'Can delete source annotation',16,'delete_sourceannotation'),(49,'Can add source annotation range',17,'add_sourceannotationrange'),(50,'Can change source annotation range',17,'change_sourceannotationrange'),(51,'Can delete source annotation range',17,'delete_sourceannotationrange'),(52,'Can add source annotation tag',18,'add_sourceannotationtag'),(53,'Can change source annotation tag',18,'change_sourceannotationtag'),(54,'Can delete source annotation tag',18,'delete_sourceannotationtag'),(55,'Can add user',19,'add_myuser'),(56,'Can change user',19,'change_myuser'),(57,'Can delete user',19,'delete_myuser');
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'bcrypt_sha256$$2a$12$kr4w2xy4gVheC7r8llLFwOdAFsqXBCtLruqM37jdZ4cZnwmUM00EK','2014-08-28 11:44:07',1,'admin','Super','User','admin@admin.com',1,1,'2014-08-09 12:38:53'),(2,'bcrypt_sha256$$2a$12$AzLkJ1hp5Bz2zwnUd4bYjuag7PbJ7dQtUPud08QndaObKB7MbXStC','2014-08-28 11:41:44',0,'tom','Tom','Midson','midson.trc@gmail.com',0,1,'2014-08-09 12:44:45'),(3,'bcrypt_sha256$$2a$12$888KxgQek4HpX2tAoHZqgOdwcnNHBBmzReRCoJaA5LW8ozeF1qUhO','2014-08-15 05:12:05',0,'kieran','Kieran','Eames','eames@eames.com',0,1,'2014-08-15 05:12:05'),(8,'fdsa','2014-08-15 13:22:48',0,'fdsa','fdsa','fdsa','amin@admin.com',1,1,'2014-08-15 13:22:48'),(23,'bcrypt_sha256$$2a$12$uAoe.99H/WdVlKFqJK81seHi9Ju6L4T9Gzwr4/a/WHeI5OKPUKJJ.','2014-08-15 14:29:12',0,'s0123456','','','',0,1,'2014-08-15 14:29:12'),(24,'bcrypt_sha256$$2a$12$vsjUw3/nk45U3X8c.roaR.ROjB6lroc4t3aY.FUpqKSS3iUzxEK7.','2014-08-15 14:29:13',0,'s1234567','','','',0,1,'2014-08-15 14:29:13'),(25,'bcrypt_sha256$$2a$12$jZX81G.on4s1DrGeik6HOeL.JRG1Zj82mcEd5ZVHXEZmlt85.80qm','2014-08-20 11:17:56',0,'test1','test','test','test@test.com',1,1,'2014-08-18 01:09:32'),(26,'bcrypt_sha256$$2a$12$XwrqAL.d7Lby1DU/yb6JBec3fmFPfwArkaYy99NCwzCr8/.YK27u2','2014-08-25 04:01:52',0,'staff','','','',1,1,'2014-08-25 04:01:20'),(27,'bcrypt_sha256$$2a$12$CZFV.CDP50UrQg1cUP77.eh1X0uvGgGEfgxVWaMRg9K2QuFAEHxBW','2014-08-28 11:43:53',0,'annote','','','',0,1,'2014-08-28 11:43:37');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (6,2,2);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-08-09 12:45:38',1,3,'1','staff',1,''),(2,'2014-08-09 12:46:21',1,3,'2','student',1,''),(3,'2014-08-09 12:46:36',1,4,'2','tom',1,''),(4,'2014-08-10 02:44:38',1,14,'1','(cfafd9e3-8555-416e-a42e-583b9a405d61)Learning 1',1,''),(5,'2014-08-10 10:24:17',1,14,'3','(dd48420a-cfc9-4007-9c3e-9ae68552c488)fdsa',3,''),(6,'2014-08-10 10:24:17',1,14,'2','(2fbf28d6-c2eb-43ad-9115-0fe053d02f37)fdsa',3,''),(7,'2014-08-11 05:08:30',1,4,'2','tom',2,'Changed password.'),(8,'2014-08-11 05:30:37',1,8,'2','admin',1,''),(9,'2014-08-13 11:50:01',1,8,'2','admin',2,'Changed courses.'),(10,'2014-08-14 05:30:47',1,4,'2','tom',2,'Changed password.'),(11,'2014-08-14 05:31:45',1,4,'2','tom',2,'No fields changed.'),(12,'2014-08-14 05:34:18',1,4,'2','tom',2,'No fields changed.'),(13,'2014-08-14 05:36:37',1,4,'2','tom',2,'No fields changed.'),(14,'2014-08-14 05:41:37',1,4,'2','tom',2,'No fields changed.'),(15,'2014-08-14 05:42:36',1,4,'2','tom',2,'No fields changed.'),(16,'2014-08-14 05:42:43',1,4,'2','tom',2,'Changed password.'),(17,'2014-08-14 06:33:16',1,4,'1','admin',2,'Changed courses for review user \"admin\".'),(18,'2014-08-14 06:33:23',1,4,'1','admin',2,'Changed courses for review user \"admin\".'),(19,'2014-08-15 05:11:10',1,4,'2','tom',2,'Changed password.'),(20,'2014-08-15 05:11:45',1,4,'2','tom',2,'Changed password.'),(21,'2014-08-15 05:12:06',1,4,'3','kieran',1,''),(22,'2014-08-15 07:44:18',1,4,'2','tom',2,'Changed email.'),(23,'2014-08-15 07:44:46',1,4,'3','kieran',2,'Changed first_name, last_name and email.'),(24,'2014-08-15 07:44:58',1,4,'1','admin',2,'Changed first_name, last_name and email.'),(25,'2014-08-15 13:19:23',1,4,'4','fdsa',3,''),(26,'2014-08-15 13:21:07',1,4,'5','fdsa',3,''),(27,'2014-08-15 13:21:44',1,4,'6','fdsa',3,''),(28,'2014-08-15 13:22:45',1,4,'7','fdsa',3,''),(29,'2014-08-15 14:17:19',1,4,'9','s0123456',3,''),(30,'2014-08-15 14:17:19',1,4,'10','s1234567',3,''),(31,'2014-08-15 14:20:04',1,4,'11','s0123456',3,''),(32,'2014-08-15 14:20:04',1,4,'12','s1234567',3,''),(33,'2014-08-15 14:21:02',1,4,'15','s0123456',3,''),(34,'2014-08-15 14:21:02',1,4,'16','s1234567',3,''),(35,'2014-08-15 14:24:55',1,4,'17','s0123456',3,''),(36,'2014-08-15 14:24:55',1,4,'18','s1234567',3,''),(37,'2014-08-15 14:26:17',1,8,'11','s0123456',3,''),(38,'2014-08-15 14:26:28',1,4,'19','s0123456',3,''),(39,'2014-08-15 14:26:28',1,4,'20','s1234567',3,''),(40,'2014-08-15 14:29:02',1,4,'21','s0123456',3,''),(41,'2014-08-15 14:29:02',1,4,'22','s1234567',3,''),(42,'2014-08-20 11:00:32',1,8,'2','admin',2,'Changed firstLogin.'),(43,'2014-08-20 11:17:25',1,4,'25','test1',2,'Changed password.'),(44,'2014-08-25 04:01:21',1,4,'26','staff',1,''),(45,'2014-08-25 04:01:38',1,4,'26','staff',2,'Changed is_staff.'),(46,'2014-08-27 06:27:22',1,15,'1','(3936d9bd-278f-4105-aa81-a8575912cf53)Learning 1 @ 2014-08-27 06:25:14+00:00',1,''),(47,'2014-08-28 04:56:28',1,11,'1','(772c7e9c-6382-4564-81e3-a8a2fc8beb8d)manage.py',3,''),(48,'2014-08-28 06:17:35',1,14,'4','(bdf53f3e-b8df-4d28-bd36-93af08b22639)fdasasdfas',2,'Changed submission_open_date and submission_close_date.'),(49,'2014-08-28 06:18:08',1,14,'4','(bdf53f3e-b8df-4d28-bd36-93af08b22639)fdasasdfas',2,'Changed first_display_date, submission_open_date, submission_close_date, review_open_date and review_close_date.'),(50,'2014-08-28 06:28:51',1,15,'11','(cb70426a-15c4-4f6b-b007-91b03eba0a38)fdasasdfas @ 2014-08-28 06:27:48+00:00',3,''),(51,'2014-08-28 06:28:51',1,15,'10','(c0ee6713-9b2f-4b51-b103-fd33086f5602)fdasasdfas @ 2014-08-28 06:20:25+00:00',3,''),(52,'2014-08-28 06:28:51',1,15,'9','(814ab1be-77c4-4006-94cd-26c68eae8ada)fdasasdfas @ 2014-08-28 06:18:56+00:00',3,''),(53,'2014-08-28 06:28:51',1,15,'8','(2dd29bb2-57ad-4c52-a7b0-d1482fc07ef8)fdasasdfas @ 2014-08-28 06:18:20+00:00',3,''),(54,'2014-08-28 06:28:51',1,15,'7','(2798320b-b827-45a0-87bf-4f151a7b388f)fdasasdfas @ 2014-08-28 06:16:38+00:00',3,''),(55,'2014-08-28 06:28:51',1,15,'6','(456e05cb-5add-4ec9-856c-5a586266d9be)fdasasdfas @ 2014-08-28 06:16:30+00:00',3,''),(56,'2014-08-28 06:28:51',1,15,'5','(71a766dd-fa49-490e-b5c6-8c481d9c1616)fdasasdfas @ 2014-08-28 06:16:06+00:00',3,''),(57,'2014-08-28 07:08:58',1,16,'1','\"fdsafdsafdsafdsa\" on \"fdsafdsafdsafsa\" by tom in ((d36a774c-5bc8-40f9-9710-2a3fbdc660f9)rootfile.txt).',1,''),(58,'2014-08-28 07:09:20',1,17,'1','SourceAnnotationRange object',1,''),(59,'2014-08-28 07:11:19',1,15,'15','(ae0106f7-c538-4c52-8d62-c2199ceece12)fdasasdfas @ 2014-08-28 06:47:25+00:00',3,''),(60,'2014-08-28 07:11:19',1,15,'14','(f163f793-3730-4b22-910c-e2c4e6b2cd25)fdasasdfas @ 2014-08-28 06:47:13+00:00',3,''),(61,'2014-08-28 07:11:19',1,15,'13','(e15cca91-be8a-4e9e-81ce-657661487fb5)fdasasdfas @ 2014-08-28 06:46:43+00:00',3,''),(62,'2014-08-28 07:11:46',1,11,'10','(59ef2046-4eb0-4aa8-8614-d88727c2bb5d)folder2_testfile.py',3,''),(63,'2014-08-28 07:11:46',1,11,'9','(2c5cf06e-660b-4c60-bf82-9bee784bd1dc)folder1-sub-testfile.py',3,''),(64,'2014-08-28 07:11:46',1,11,'8','(24341c24-671a-4888-92ee-dac596a61547)folder1_testfile.txt',3,''),(65,'2014-08-28 07:11:46',1,11,'7','(b3883201-dd63-447d-9623-7c0fb36c1bdd)rootfile.txt',3,''),(66,'2014-08-28 07:12:21',1,15,'12','(8b520c46-c26f-42cd-8956-1536f1f8cc26)fdasasdfas @ 2014-08-28 06:29:04+00:00',3,''),(67,'2014-08-28 07:13:30',1,11,'6','(b79c3114-f066-4110-9f5b-b96a10770ffe)folder2_testfile.py',3,''),(68,'2014-08-28 07:13:30',1,11,'5','(fe87beab-912e-4679-8eab-617f448f53ec)folder1-sub-testfile.py',3,''),(69,'2014-08-28 07:13:30',1,11,'4','(6afb7463-5717-471c-81fb-0512ab925183)folder1_testfile.txt',3,''),(70,'2014-08-28 07:13:30',1,11,'3','(d36a774c-5bc8-40f9-9710-2a3fbdc660f9)rootfile.txt',3,''),(71,'2014-08-28 07:14:01',1,16,'2','\"fdsafsda\" on \"fdsa\" by tom in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',1,''),(72,'2014-08-28 08:21:56',1,17,'2','SourceAnnotationRange object',1,''),(73,'2014-08-28 11:43:37',1,4,'27','annote',1,''),(74,'2014-08-29 01:54:34',1,16,'3','\"43242\" on \"43242\" by admin in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',3,''),(75,'2014-08-29 01:58:04',1,16,'5','\"43242\" on \"43242\" by admin in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',3,''),(76,'2014-08-29 02:01:52',1,16,'8','\"textest\" on \"textest\" by admin in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',3,''),(77,'2014-08-29 02:01:52',1,16,'7','\"textest\" on \"textest\" by admin in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',3,''),(78,'2014-08-29 02:01:52',1,16,'6','\"textest\" on \"textest\" by admin in ((8e299c63-5706-4423-95e2-9e69431c99ac)folder2_testfile.py).',3,''),(79,'2014-08-29 02:03:26',1,16,'9','\"textest\" on \"textest\" by admin in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',3,''),(80,'2014-08-29 06:09:26',1,16,'18','\"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" on \"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" by admin in ((8e299c63-5706-4423-95e2-9e694',3,''),(81,'2014-08-29 06:09:26',1,16,'17','\"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" on \"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" by admin in ((8e299c63-5706-4423-95e2-9e694',3,''),(82,'2014-08-29 06:09:26',1,16,'16','\"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" on \"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" by admin in ((8e299c63-5706-4423-95e2-9e694',3,''),(83,'2014-08-29 06:09:26',1,16,'15','\"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" on \"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" by admin in ((8e299c63-5706-4423-95e2-9e694',3,''),(84,'2014-08-29 06:09:26',1,16,'14','\"<textarea cols=\"40\" id=\"id_annotation_text\" name=\"annotation_text\" rows=\"10\">\r\n</textarea>\" on \"<textarea cols=\"40\" id=\"id_annotation_text\" name=\"annotation_text\" rows=\"10\">\r\n</textarea>\" by admin in',3,''),(85,'2014-08-29 06:09:26',1,16,'13','\"<textarea cols=\"40\" id=\"id_annotation_text\" name=\"annotation_text\" rows=\"10\">\r\n</textarea>\" on \"<textarea cols=\"40\" id=\"id_annotation_text\" name=\"annotation_text\" rows=\"10\">\r\n</textarea>\" by admin in',3,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'migration history','south','migrationhistory'),(8,'review user','review','reviewuser'),(9,'course','review','course'),(10,'source folder','review','sourcefolder'),(11,'source file','review','sourcefile'),(12,'submission test results','review','submissiontestresults'),(13,'submission test','review','submissiontest'),(14,'assignment','review','assignment'),(15,'assignment submission','review','assignmentsubmission'),(16,'source annotation','review','sourceannotation'),(17,'source annotation range','review','sourceannotationrange'),(18,'source annotation tag','review','sourceannotationtag'),(19,'user','review','myuser');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('6e674mu8w0mtr20hfouss75leyzy819n','YWQ4MWU2MDRjZmJhYWQ3NDZjOTZkYmFiM2QyMWIxMjkwOTlmNjA5MTp7fQ==','2014-08-24 10:07:30'),('7qyo1bvlje81cv94ax7ou3y8f5q5mksj','YWQ4MWU2MDRjZmJhYWQ3NDZjOTZkYmFiM2QyMWIxMjkwOTlmNjA5MTp7fQ==','2014-09-03 11:18:04'),('c1vflloinflxa37qfcveltqen46px4nb','MzI0OGYzZGYxMDA1MGRmY2M5YjM5MTE5ZjJhYjY2MTVmMzQwYTY5MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-09-11 11:44:07'),('ein0uddfyvwxcwl1ygr32hvkqbna1hjm','YWQ4MWU2MDRjZmJhYWQ3NDZjOTZkYmFiM2QyMWIxMjkwOTlmNjA5MTp7fQ==','2014-08-23 12:58:42'),('n7k98336mti0p2eg30d4mqmb6t8u53vu','MzI0OGYzZGYxMDA1MGRmY2M5YjM5MTE5ZjJhYjY2MTVmMzQwYTY5MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-08-24 02:00:02');
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
  `course_code_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_assignment_f4b0fac7` (`course_code_id`),
  CONSTRAINT `course_code_id_refs_id_2bfd7468` FOREIGN KEY (`course_code_id`) REFERENCES `review_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_assignment`
--

LOCK TABLES `review_assignment` WRITE;
/*!40000 ALTER TABLE `review_assignment` DISABLE KEYS */;
INSERT INTO `review_assignment` VALUES (1,'cfafd9e3-8555-416e-a42e-583b9a405d61','Learning 1','https://www.source-hosting.com/{username}/ass1/ ','2014-08-10 02:43:57','2014-08-10 02:43:57','2014-08-10 12:44:34','2014-08-10 02:43:57','2014-08-10 12:44:36',1),(4,'bdf53f3e-b8df-4d28-bd36-93af08b22639','fdasasdfas','asdfasd','2014-08-28 18:30:00','2014-08-27 10:40:00','2014-08-31 11:00:00','2014-08-28 10:40:00','2014-08-28 02:00:00',1);
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
  `root_folder_id` int(11),
  PRIMARY KEY (`id`),
  UNIQUE KEY `root_folder_id` (`root_folder_id`),
  KEY `review_assignmentsubmission_e48e5091` (`by_id`),
  KEY `review_assignmentsubmission_e7178437` (`submission_for_id`),
  CONSTRAINT `root_folder_id_refs_id_55a751b9` FOREIGN KEY (`root_folder_id`) REFERENCES `review_sourcefolder` (`id`),
  CONSTRAINT `by_id_refs_id_a4fcd4d1` FOREIGN KEY (`by_id`) REFERENCES `review_reviewuser` (`id`),
  CONSTRAINT `submission_for_id_refs_id_8d20aaf0` FOREIGN KEY (`submission_for_id`) REFERENCES `review_assignment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_assignmentsubmission`
--

LOCK TABLES `review_assignmentsubmission` WRITE;
/*!40000 ALTER TABLE `review_assignmentsubmission` DISABLE KEYS */;
INSERT INTO `review_assignmentsubmission` VALUES (1,'3936d9bd-278f-4105-aa81-a8575912cf53','2014-08-27 06:25:14',1,'fdsafsa',1,0,1),(16,'8951dd83-fb1b-4abd-bdcf-4bc45691ae27','2014-08-28 07:13:43',2,'https://github.com/avadendas/public_test_repo.git',4,0,13);
/*!40000 ALTER TABLE `review_assignmentsubmission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_course`
--

DROP TABLE IF EXISTS `review_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_uuid` varchar(36) NOT NULL,
  `course_code` varchar(10) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_course`
--

LOCK TABLES `review_course` WRITE;
/*!40000 ALTER TABLE `review_course` DISABLE KEYS */;
INSERT INTO `review_course` VALUES (1,'c0d0bf8a-b431-4c1a-9ace-2dfb4514e1b8','ABCD1234','Introduction to LearnIntro to learning'),(2,'ee80a762-96af-4033-804d-2249135220a3','AERO4200','Flight Mechanics & Avionics'),(3,'2d277953-f847-4fe9-8ae3-e3a2b8b10f75','COMP3301','Operating Systems Architecture'),(4,'4b0796e0-c07b-4365-9e88-a3ae21cda20b','COMP3506','Algorithms & Data Structures'),(5,'f5523d26-4cd3-496a-b442-3aa1e142e922','COMP3702','Artificial Intelligence'),(6,'a7c01423-6348-4eb3-a164-3eb72bbe6373','COMP4403','Compilers and Interpreters'),(7,'61b70fe7-5bee-496a-9f72-a6d832c0b060','COMP4500','Advanced Algorithms & Data Structures'),(8,'f1e09ee9-e5bf-49a1-8918-8db393134561','COMP4702','Machine Learning'),(9,'5cef10e9-ae92-4256-b9f7-1a243fa175a3','COMP6801','Computer Science Research Project'),(10,'fff2d4fd-8f3b-4a1a-b307-a6a741f7f559','COMP6803','Computer Science Research Project'),(11,'04fd1f7f-3afb-4f4a-b94e-4516d6f528ba','COMP6804','Computer Science Research Project'),(12,'da46ff03-a8ba-4bed-b6d2-6e126c5ffce1','COMP7308','Operating Systems Architecture'),(13,'56501d32-3677-4383-a0e3-dfced7d5a6c6','COMP7402','Compilers & Interpreters'),(14,'0601a3a2-a8e9-494e-8582-2cac931eef36','COMP7500','Advanced Algorithms & Data Structures'),(15,'7588446b-0c9d-4303-970e-1dedf29f5f65','COMP7505','Algorithms & Data Structures'),(16,'0ee54a91-b2f6-46d7-8947-b7451c3cfa80','COMP7702','Artificial Intelligence'),(17,'fd2158a9-15df-425f-a781-29ea3cd374bd','COMP7703','Machine Learning'),(18,'cc78cfe0-4d4f-4b33-b0eb-fffb0a1d891f','COMP7801','Computer Science Research Project'),(19,'560cb42b-12a7-4e16-bf4d-43b5ba205aad','COMP7802','Computer Science Research Project'),(20,'f87b4323-e86b-4249-9531-8374077baa86','COMP7840','Computer Science Research Project'),(21,'7d214426-9ea6-42ef-8c66-6a470d888cb8','COMP7860','Computer Science Research Project'),(22,'cc52fa95-299d-4a7c-a3a9-097aa5c4cb72','COMP7861','Computer Science Research Project'),(23,'c420384f-e7e9-4b06-bb60-5107e8dd5d90','COMP7862','Computer Science Research Project'),(24,'b6b14beb-b8f1-45b8-9d95-8fad0f4cf575','COMP7880','Computer Science Research Project'),(25,'2cdb9e0d-3a61-4d81-a9e6-135a8b24b506','COMP7881','Computer Science Research Project'),(26,'ae7e03f5-331b-4d76-b772-c2a7bb2d6f11','COMP7882','Computer Science Research Project'),(27,'b791aa0f-9c01-4a28-8ab1-b3bfd8d98f86','COMS3000','Information Security'),(28,'b0d5b0bb-b531-4a18-a2c7-50d610c39df8','COMS3200','Computer Networks I'),(29,'cbff2374-ed57-4935-bec0-84b1cf9e889a','COMS4103','Photonics'),(30,'f7292fb9-cd44-473b-9a73-4add20822ecc','COMS4104','Microwave Subsystems & Antennas'),(31,'b984a771-ecf1-4994-9ae8-d5718ac91188','COMS4105','Communication Systems'),(32,'ab685910-9c97-4932-8047-15524f59a622','COMS4200','Computer Networks II'),(33,'2c254ae3-672f-4b82-b5c4-be471c4658a7','COMS4507','Advanced Computer and Network Security'),(34,'0ae42139-e7fa-4ea2-a3b8-01b116532556','COMS7003','Information Security'),(35,'6858255e-0221-4eee-82d1-1797a9f58d08','COMS7104','Microwave Subsystems and Antennas'),(36,'3eeb1f78-8af3-4268-9727-01ceeac9df53','COMS7200','Computer Networks II	Moves to semester 2 from 2013.'),(37,'cad246b7-ff83-4488-b773-70b589a8f735','COMS7201','Computer Networks I	Moves to semester 1 from 2013.'),(38,'b812ced8-2d8d-42e7-ad4f-d5c25f03c8ed','COMS7305','Advanced Microwave Circuit Design'),(39,'957590f3-572a-456c-9d08-4f1405258fe2','COMS7306','Electromagnetic Design and Measurements in Microwaves and Photonics'),(40,'5bc6ea68-1925-40b1-a589-09a72d646796','COMS7307','Advanced Photonics'),(41,'9d5b8885-9a35-4c82-aef7-6a7a37fd6a69','COMS7308','Antenna Design'),(42,'c73735da-acd5-4b03-acda-93ca094484ca','COMS7309','Computational Techniques in Electromagnetics'),(43,'bfc42c3a-31e0-4165-a9fa-eb3e556b1d45','COMS7310','Radar and Electronic Warfare Fundamentals'),(44,'f9486af5-e083-4c89-9b88-55219748e61c','COMS7400','Photonics'),(45,'732ef465-7d61-4741-bb34-244e43c3a5ec','COMS7410','Communication Systems'),(46,'57798e66-89c2-4a18-8a2f-969df83dd5e9','COMS7507','Advanced Computer and Network Security'),(47,'7421665f-3b31-4e51-b646-c58e7c9b11bd','COSC2500','Numerical Methods in Computational Science'),(48,'cc363276-dbeb-4b79-b37d-e8808ab9de49','COSC3000','Visualization, Computer Graphics & Data Analysis'),(49,'cc01138b-fd2b-4e92-a15e-75c2687362ed','COSC3500','High-Performance Computing'),(50,'c3e94525-41de-4c07-921e-8f55afffeded','CSSE1001','Introduction to Software Engineering I'),(51,'44bd4863-77e7-40c0-b18b-bbeb363641c3','CSSE2002','Programming in the Large'),(52,'64d68a29-28e2-4c88-8917-0623aa239869','CSSE2010','Introduction to Computer Systems'),(53,'363cc6fe-0323-4fe5-ad25-35ffcef0ad65','CSSE2310','Computer Systems Principles and Programming'),(54,'346e126c-91ca-46f3-bd51-91355dec3c89','CSSE3002','The Software Process'),(55,'63557d6d-cf94-4efc-89bb-623365f7eb11','CSSE3005','Advanced Information Technology Project'),(56,'dc922a85-58a0-46c9-8be0-f6efa3788c87','CSSE3006','Special Projects in Computer Systems and Software Engineering'),(57,'7fa7f0e6-6d65-4bbf-b284-c87346f04ce4','CSSE3010','Embedded Systems Design & Interfacing'),(58,'3838fc2a-0122-4c35-b65e-3af928bd15d7','CSSE4004','Distributed Computing'),(59,'69d54858-4f75-41f9-a212-c7ab6f150055','CSSE4010','Digital System Design'),(60,'983989f4-47c8-4cd3-b800-6b54a75a6e39','CSSE4011','Advanced Embedded Systems'),(61,'71637208-dad0-4e31-8751-846d55d5cc29','CSSE4020','Wireless Sensor Networks'),(62,'7f77fbba-bd13-48dd-a2ac-8e4ae58c96cd','CSSE4603','Models of Software Systems'),(63,'c75672ae-5c07-4517-8e0a-6c5a6d7db623','CSSE7001','The Software Process'),(64,'164f8294-6d89-46c2-bc18-a686419a16bf','CSSE7014','Distributed Computing'),(65,'6ced6ab8-82c9-49f8-b243-383d1e364a62','CSSE7023','Advanced Software Engineering'),(66,'8572dbdc-ad4c-4b87-a14f-7e4d87a76611','CSSE7025','Advanced Information Technology Project'),(67,'338eea2f-945f-4d6e-8678-5d387b1dfa06','CSSE7030','Introduction to Software Engineering I'),(68,'cde7cbeb-c79e-4e36-a1fb-722d372f90dc','CSSE7032','Models of Software Systems'),(69,'be91ab0b-22a6-4f90-aef7-94602ee5c0c7','CSSE7034','Predictable Professional Performance'),(70,'ecfeed04-450d-4011-8e11-1de4c6daa766','CSSE7201','Introduction to Computer Systems'),(71,'7e847a99-9292-4bc9-8824-1a36062d7be9','CSSE7231','Computer Systems Principles and Programming'),(72,'9c2f17c7-ee88-4f49-92ef-c8f3e6aaa08f','CSSE7301','Embedded Systems Design & Interfacing'),(73,'f2e5e91d-7036-4c71-aaae-78f7d703ccb8','CSSE7306','Special Projects in Computer Systems and Software Engineering	#4'),(74,'951611cc-8a73-46dd-83a9-dc2f698b2683','CSSE7410','Digital System Design'),(75,'79fda2dc-1ef1-4407-8a3e-8315c5ab7354','CSSE7411','Advanced Embedded Systems'),(76,'655b55d2-f901-4a53-a937-f50792df84e8','CSSE7420','Wireless Sensor Networks'),(77,'40c450fa-8c1e-4120-bf0b-865349866ab4','CSSE7500','Modelling and Simulation'),(78,'df826bdb-d80c-40d8-9a15-29766d006a27','CSSE7510','Reconfigurable Embedded Systems - Concepts adn Practice'),(79,'28eaf276-2031-4cdf-95d7-731b50aa13eb','CSSE7520','Unmanned Aerial Vehicles - Avionics'),(80,'f7156da3-1ce4-4bc8-909e-3e0ef53f39f8','CSSE7530','VLSI Circuits and Systems'),(81,'db3aa0b6-f8c2-453e-864c-27edb97f4b9f','CSSE7610','Concurrency: Theory and Practice'),(82,'2a5a6443-1754-4061-a999-59aaf3044d96','DECO1100','Design Thinking'),(83,'593bd825-5c37-4b9f-a698-258272bb83ee','DECO1400','Introduction to Web Design'),(84,'f25a5b91-c843-404f-af11-3713aa0718bb','DECO1800','Design Computing Studio 1 - Interactive Technology'),(85,'5031c641-5bed-4e0d-b8a5-d22627433485','DECO2200','Graphic Design'),(86,'e20471d9-864c-41ad-9630-1123ec904bc3','DECO2300','Digital Prototyping'),(87,'33bcecb9-c8fb-4601-ab54-2be159da7122','DECO2500','Human-Computer Interaction'),(88,'b5249500-1916-41e0-b001-9ca00f682c72','DECO2800','Design Computing Studio 2 - Testing & Evaluation'),(89,'5b73329d-8e1e-40bc-b02a-2849864c66b7','DECO3500','Social and Mobile Computing'),(90,'edc567ae-23ee-4a0b-847a-ed30eb3fe160','DECO3800','Design Computing Studio 3 - Proposal'),(91,'12ee1599-5781-4947-a7ed-e919f65ac80e','DECO3801','Design Computing Studio 3 - Build'),(92,'7cd97c69-e6af-410b-8225-9babba88104e','DECO3850','Physical Computing & Interaction Design Studio'),(93,'292d71a4-c44d-461d-b000-42cbc7c9bdb4','DECO4500','Advanced Human-Computer Interaction'),(94,'b0c6c328-c440-475c-a43f-17f423d862c2','DECO6801','Design Computing Thesis'),(95,'d46844c3-6eb3-46e7-8db8-52afe165aa1c','DECO6802','Design Computing Thesis'),(96,'b0a3859b-9420-4ba7-86d2-16a8da6cc76f','DECO7110','Design Thinking'),(97,'7426376d-715f-4eac-923c-3ac5a9261a4d','DECO7140','Introduction to Web Design'),(98,'6b8f692f-0993-4015-ab42-72dbb4a00f92','DECO7180','Design Computing Studio 1 - Interactive Technology'),(99,'e6846b02-3c6b-4de2-b5d0-b41befc2c462','DECO7220','Graphic Design'),(100,'02a4eb51-e1f4-4d37-8b73-cd0f626c97c4','DECO7230','Digital Prototyping'),(101,'96cbde91-6f0e-47ca-bd5a-2666b0ea4b38','DECO7250','Human-Computer Interaction'),(102,'fa656eef-74ea-4bc6-a656-4bad70e62430','DECO7280','Design Computing Studio 2 - Testing & Evaluation'),(103,'8fa28fac-1304-40f5-ba37-aef93065167e','DECO7350','Social & Mobile Computing'),(104,'6a7f6e37-02b0-4eb8-be72-cce3e889f669','DECO7380','Design Computing Studio 3 - Proposal'),(105,'efbcf82a-f401-411e-8ad6-1e683b1aee7b','DECO7381','Design Computing Studio 3 - Build'),(106,'1d89351c-f04c-49b8-b5c6-2585fad07036','DECO7385','Physical Computing & Interaction Design Studio'),(107,'3594178c-adc7-43d4-aedf-0a8d80e92857','DECO7450','Advanced Human-Computer Interaction'),(108,'1ec55b02-012f-47dc-a7f6-8a7a56451bd4','DECO7860','Masters Thesis'),(109,'40a41921-f263-408b-8b68-26ad5d364108','DECO7861','Masters Thesis'),(110,'7bc0e558-470d-4e5f-be9e-1436806b29b1','DECO7862','Masters Thesis'),(111,'2bf78fed-eace-4f8f-9b57-f3351b7beda7','ELEC2003','Electromechanics & Electronics'),(112,'efe1f224-a4c8-4fc5-ae14-eb7af723bc54','ELEC2004','Circuits, Signals & Systems'),(113,'b3472ebb-f999-4c22-8fa3-b43e91d6bd2e','ELEC3004','Signals, Systems & Control'),(114,'a871b0d7-4206-438e-ae96-a05e23e84f41','ELEC3100','Fundamentals of Electromagnetic Fields & Waves'),(115,'b8bc7f7e-035a-43ec-87f5-37de0fe7dbac','ELEC3300','Electrical Energy Conversion & Utilisation'),(116,'3a54a237-e088-43f7-b02b-84f9c21cc1b2','ELEC3400','Electronic Circuits'),(117,'9853fccf-db2d-4326-8746-4efe25d7afc9','ELEC4300','Power Systems Analysis'),(118,'a0e2759a-dafc-4b75-8116-1cbbc994dc10','ELEC4302','Power System Protection'),(119,'157c3f61-7dd2-4c6e-9ff6-10cfba27b297','ELEC4320','Modern Asset Management and Condition Monitoring in Power System'),(120,'1e398080-c8c4-43e4-9ada-18d6ae226376','ELEC4400','Advanced Electronic & Power Electronics Design'),(121,'74fef6d7-9092-40f9-aa70-7446cb3ea96d','ELEC4403','Medical & Industrial Instrumentation'),(122,'a8fe3b3c-f62f-482f-842c-f9091bf742d8','ELEC4601','Medical Imaging I'),(123,'9400f134-59e2-4dc6-ad83-869b7dbf0ed8','ELEC4620','Digital Signal Processing'),(124,'4b3bb88b-5b9c-404e-a598-75371df9c41f','ELEC4630','Image Processing and Computer Vision'),(125,'7e5846a4-443f-4aa9-8126-e7c28ea39846','ELEC7050','Generator Technology Design & Application'),(126,'fc0c915b-d57f-4faa-b2cb-6199b69938e7','ELEC7051','Transformer Technology Design and Operation'),(127,'7b8b6c90-ad53-4570-b670-0506e800b2e1','ELEC7052','Plant Control Systems	Not offered after 2013.'),(128,'25a15631-cb99-43d8-a6f5-18e13ea6d32c','ELEC7101','Fundamentals of Electromagnetic Fields & Waves'),(129,'bc12b3f1-8de0-428c-aed9-4a8bc5ed1826','ELEC7302','Electrical Energy Conversion & Utilisation'),(130,'1effcb4e-ecaf-4747-9a38-f88d75614720','ELEC7303','Power Systems Analysis'),(131,'4295dd15-57b2-43a0-8145-95fb8afe39a1','ELEC7309','Power System Planning and Reliability'),(132,'e1dc45df-4f62-4772-b72c-da2718e4bca1','ELEC7310','Electricity Market Operation and Security'),(133,'91ae14eb-6272-49b0-b39d-be41a56db960','ELEC7311','Power System Protection'),(134,'7ee0008b-1075-4a08-8ef2-db15c628b501','ELEC7312','Signals, Systems & Control'),(135,'1cae4a5c-f047-4a37-9471-81476bdf6eb3','ELEC7313','Renewable Energy Integration: Technologies to Technical Challenges'),(136,'2e755568-ee0f-494f-81d5-8dd66b52c123','ELEC7401','Electronic Circuits'),(137,'5436736a-8bad-471e-93cd-83ac578a3a14','ELEC7402','Advanced Electronic & Power Electronics Design'),(138,'f2cbc465-07ff-4087-952e-5ef7f4665646','ELEC7403','Medical & Industrial Instrumentation'),(139,'b0b32aa3-021c-4403-b300-cb46f048a9ba','ELEC7420','Modern Asset Management and Condition Monitoring in Power System'),(140,'949a31b5-0b13-410a-b963-ed76691446f4','ELEC7462','Digital Signal Processing'),(141,'cc32b670-778b-4f8c-80f0-80bf261c29f4','ELEC7463','Image Processing and Computer Vision'),(142,'fc0af9f1-6a91-4015-a2dd-0a1c1f33944b','ELEC7606','Medical Imaging I'),(143,'6368cdfc-a467-44fc-a874-b8a948cd4f66','ELEC7901','Advanced Medical Device Engineering'),(144,'001c1d29-2461-4250-a761-5260f8c63f27','ELEC7902','Clinical Biomedical Signal Processing'),(145,'c376c8b2-9499-4c71-8941-69f2b88a7eb4','ELEC7903','Biomedical Engineering in Sports Medicine'),(146,'97199ea9-c22c-4bfc-b079-a082535b716a','ENGG1100','Introduction to Engineering Design'),(147,'49d5ace8-db4b-444e-bb24-04ac1baecc37','ENGG1200','Engineering Modelling & Problem Solving'),(148,'34ab6b46-01ff-4afa-b135-b95e145d8ecf','ENGG1300','Introduction to Electrical Systems'),(149,'720e90d9-54c3-4912-9464-8bb35dae8076','ENGG2800','Team Project I'),(150,'d5280563-4675-4879-8cb1-7a91007e1ab3','ENGG4000','Introduction to Systems Engineering'),(151,'e4c6cbfc-ef7b-4c00-bd83-51b008130cf4','ENGG4020','Systems Safety Engineering'),(152,'2c8a34a4-a181-411c-9081-958fc6ed66fb','ENGG4800','Project Management'),(153,'f3fc6651-5ee8-42fe-83fd-3f8587a67517','ENGG4801','Thesis Project (S1 start)'),(154,'242249f3-118e-4a0c-b6e9-f78391dbbb73','ENGG4802','Thesis Project (S2 start)'),(155,'a9328727-a0aa-4a94-82fa-7f4969c18727','ENGG4805','Thesis Project'),(156,'5faee042-c15d-4959-b09a-955e19c0c4b1','ENGG4810','Team Project II'),(157,'7362ce9d-3026-4dd7-8571-beec0291bff7','ENGG7000','Systems Engineering'),(158,'bedc8cc2-0e93-4234-b7ba-17a5cbf36cc1','ENGG7020','Systems Safety Engineering'),(159,'34be7ce0-5977-44ce-96ee-3525cfcd2c72','ENGG7302','Advanced Computational Techniques in Engineering'),(160,'1d20443c-5070-4147-a62c-97ec388d299f','ENGG7800','Engineering Project Management'),(161,'dd2b870b-5b66-4e51-a722-c182b266592c','ENGG7802','Engineering Postgraduate Project B'),(162,'530c26df-f751-4cde-96ab-d7d0957c7976','ENGG7803','Engineering Postgraduate Project B'),(163,'fa159bef-2c1b-451c-9231-b79167ba03a1','ENGG7804','Engineering Postgraduate Project B'),(164,'c664c37a-5e0c-4bcd-81fd-43948f170eb2','ENGG7806','Engineering Postgraduate Project D'),(165,'5ef0b0bd-2bb9-4a3e-a5dc-4b71444c6648','ENGG7807','Engineering Postgraduate Project D'),(166,'7dead654-0921-4112-a514-23d4461dc43b','ENGG7808','Engineering Postgraduate Project D'),(167,'298e12d7-084a-4779-8131-e8f1fe549061','ENGG7820','Engineering Thesis Project'),(168,'ad0e3fef-110e-4f31-8c80-27808ab95c03','ENGG7830','Engineering Placement Project'),(169,'68c129ca-3125-42ac-adfd-0b6f0450cb41','INFS1200','Introduction to Information Systems'),(170,'3ebc94f8-0c32-4164-8523-86bca545756e','INFS1300','The Web from the Inside Out - from Geeks to Google & Facebook'),(171,'ddcba88f-6379-4a68-8107-f2673ddf38dc','INFS2200','Relational Database Systems'),(172,'7316a0a6-a77c-45ff-89d5-495cc58caa8a','INFS3200','Advanced Database Systems'),(173,'f5773f54-c044-4e79-9f2c-cf1ab3a691ba','INFS3202','Web Information Systems'),(174,'7a2fa209-1df5-4794-8f00-fa0c08367e4b','INFS3204','Service-Oriented Architectures'),(175,'a01c304a-4345-4126-b96e-51d40fb7f6d4','INFS4203','Data Mining'),(176,'c958a74d-5623-442c-84e9-7a2c6eee7773','INFS4205','Spatial and Multimedia Databases'),(177,'9f1e1576-4214-4908-865d-f59ac00ee7be','INFS7130','The Web from the Inside Out - from Geeks to Google & Facebook'),(178,'2a0c3b0c-5cca-4d3b-8a58-a98a6b8c138d','INFS7202','Web Information Systems'),(179,'0f0f70f1-ffce-41b8-b93a-ba08a7835b8d','INFS7203','Data Mining'),(180,'dc90ef22-2ade-49bf-b7f9-d2b0825bf5cb','INFS7204','Service-Oriented Architectures'),(181,'c6f7c10e-1df8-48eb-a772-118f92c8617f','INFS7205','Spatial and Multimedia Databases'),(182,'ec97fa99-c019-41a5-a315-0b8a56b49704','INFS7410','Information Retrieval and Web Search'),(183,'912669b5-4c9f-4ac0-b167-f2d4ec6cfdb8','INFS7900','Information Systems'),(184,'9b1e99e5-7399-4afc-9602-07560c3e7759','INFS7903','Relational Database Systems'),(185,'882edca7-e3b1-4230-ac27-5e77150ef1f4','INFS7907','Advanced Database Systems'),(186,'1e356a22-651b-4ead-91f6-884f27ed7d3b','METR2800','Mechatronic System Design Project I'),(187,'da3b1093-f34f-4322-84d8-7c7f3ac1b97c','METR3100','Sensors & Actuators'),(188,'aa4b26e4-ef00-457f-ba83-635ea3e00a2e','METR3200','Introduction to Control Systems'),(189,'30f27d6e-0cbe-4367-94c4-7f2aed82151a','METR3800','Mechatronic System Design Project II'),(190,'9bd6aae6-22be-4812-83d4-8f2465b77a26','METR4201','Introduction to Control Systems'),(191,'e1a15a46-3420-4907-9a0c-2c2e06de7019','METR4202','Advanced Control & Robotics'),(192,'29b23002-b855-4653-bdc5-01082878ccb8','METR4810','Mechatronic System Design Project II'),(193,'5881986a-3367-444f-b7db-d0c758c72987','METR4900','Thesis/Design Project'),(194,'d2defe32-c93e-4779-9587-4251a3b403c3','METR4901','Thesis/Design Project'),(195,'f4fb5e6c-86e7-40c1-b25b-ea34c865c017','METR7200','Introduction to Control Systems'),(196,'a3f6f961-2c04-4213-aeaa-882075c0b2e3','METR7202','Advanced Control & Robotics'),(197,'5d8cf9c4-0e59-474a-b6ca-4c9fa9d4b125','METR7820','Engineering Thesis Project'),(198,'24ade3d5-a578-4549-ae9c-e548e6916ebe','METR7830','Engineering Placement Project'),(199,'61515066-2709-407b-aa75-7d7bfebe99ee','SCIE1000','Theory & Practice in Science'),(200,'1c4db223-4179-4023-af21-7dae43ba2efa','SCIE2100','1 Introduction to Bioinformatics');
/*!40000 ALTER TABLE `review_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_course_students`
--

DROP TABLE IF EXISTS `review_course_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_course_students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `reviewuser_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `review_course_students_course_id_33e15abeb9b928c7_uniq` (`course_id`,`reviewuser_id`),
  KEY `review_course_students_6234103b` (`course_id`),
  KEY `review_course_students_c6440f4a` (`reviewuser_id`),
  CONSTRAINT `course_id_refs_id_4df39490` FOREIGN KEY (`course_id`) REFERENCES `review_course` (`id`),
  CONSTRAINT `reviewuser_id_refs_id_23835d11` FOREIGN KEY (`reviewuser_id`) REFERENCES `review_reviewuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_course_students`
--

LOCK TABLES `review_course_students` WRITE;
/*!40000 ALTER TABLE `review_course_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_course_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_createuserform`
--

DROP TABLE IF EXISTS `review_createuserform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_createuserform` (
  `user_ptr_id` int(11) NOT NULL,
  PRIMARY KEY (`user_ptr_id`),
  CONSTRAINT `user_ptr_id_refs_id_ea09df13` FOREIGN KEY (`user_ptr_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_createuserform`
--

LOCK TABLES `review_createuserform` WRITE;
/*!40000 ALTER TABLE `review_createuserform` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_createuserform` ENABLE KEYS */;
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
  `isStaff` tinyint(1) NOT NULL,
  `firstLogin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `djangoUser_id` (`djangoUser_id`),
  CONSTRAINT `djangoUser_id_refs_id_ce92d1c6` FOREIGN KEY (`djangoUser_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_reviewuser`
--

LOCK TABLES `review_reviewuser` WRITE;
/*!40000 ALTER TABLE `review_reviewuser` DISABLE KEYS */;
INSERT INTO `review_reviewuser` VALUES (1,'99ffcc68-a9c4-450d-b74c-8acc976b206d',2,0,0),(2,'1bd5f565-47fc-4a12-ae32-22d8188b93ae',1,0,0),(3,'be808ac9-0bc8-4b2f-909a-2332fe4d4149',3,0,1),(4,'9cafb4e6-3a2a-4f2c-bbe8-9659ee9f69ad',8,1,1),(15,'9403e793-8dcf-4378-81df-ae777abe4051',23,0,1),(16,'f108a046-484d-4d4d-b120-ca5bf332a60f',24,0,1),(17,'439c4bee-f2f3-4f84-a43d-eea6e27174c1',25,1,0),(18,'32005413-971d-4756-8c4c-b9086424fa26',26,0,1),(19,'d43dc24c-3184-4df0-b17b-2ec1e0af0ebd',27,0,1);
/*!40000 ALTER TABLE `review_reviewuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_reviewuser_courses`
--

DROP TABLE IF EXISTS `review_reviewuser_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_reviewuser_courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reviewuser_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `review_reviewuser_courses_reviewuser_id_744e9d5e44593134_uniq` (`reviewuser_id`,`course_id`),
  KEY `review_reviewuser_courses_c6440f4a` (`reviewuser_id`),
  KEY `review_reviewuser_courses_6234103b` (`course_id`),
  CONSTRAINT `course_id_refs_id_e1fe2446` FOREIGN KEY (`course_id`) REFERENCES `review_course` (`id`),
  CONSTRAINT `reviewuser_id_refs_id_eca292ce` FOREIGN KEY (`reviewuser_id`) REFERENCES `review_reviewuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1217 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_reviewuser_courses`
--

LOCK TABLES `review_reviewuser_courses` WRITE;
/*!40000 ALTER TABLE `review_reviewuser_courses` DISABLE KEYS */;
INSERT INTO `review_reviewuser_courses` VALUES (1,1,1),(617,2,1),(618,2,2),(619,2,3),(620,2,4),(621,2,5),(622,2,6),(623,2,7),(624,2,8),(625,2,9),(626,2,10),(627,2,11),(628,2,12),(629,2,13),(630,2,14),(631,2,15),(632,2,16),(633,2,17),(634,2,18),(635,2,19),(636,2,20),(637,2,21),(638,2,22),(639,2,23),(640,2,24),(641,2,25),(642,2,26),(643,2,27),(644,2,28),(645,2,29),(646,2,30),(647,2,31),(648,2,32),(649,2,33),(650,2,34),(651,2,35),(652,2,36),(653,2,37),(654,2,38),(655,2,39),(656,2,40),(657,2,41),(658,2,42),(659,2,43),(660,2,44),(661,2,45),(662,2,46),(663,2,47),(664,2,48),(665,2,49),(666,2,50),(667,2,51),(668,2,52),(669,2,53),(670,2,54),(671,2,55),(672,2,56),(673,2,57),(674,2,58),(675,2,59),(676,2,60),(677,2,61),(678,2,62),(679,2,63),(680,2,64),(681,2,65),(682,2,66),(683,2,67),(684,2,68),(685,2,69),(686,2,70),(687,2,71),(688,2,72),(689,2,73),(690,2,74),(691,2,75),(692,2,76),(693,2,77),(694,2,78),(695,2,79),(696,2,80),(697,2,81),(698,2,82),(699,2,83),(700,2,84),(701,2,85),(702,2,86),(703,2,87),(704,2,88),(705,2,89),(706,2,90),(707,2,91),(708,2,92),(709,2,93),(710,2,94),(711,2,95),(712,2,96),(713,2,97),(714,2,98),(715,2,99),(716,2,100),(717,2,101),(718,2,102),(719,2,103),(720,2,104),(721,2,105),(722,2,106),(723,2,107),(724,2,108),(725,2,109),(726,2,110),(727,2,111),(728,2,112),(729,2,113),(730,2,114),(731,2,115),(732,2,116),(733,2,117),(734,2,118),(735,2,119),(736,2,120),(737,2,121),(738,2,122),(739,2,123),(740,2,124),(741,2,125),(742,2,126),(743,2,127),(744,2,128),(745,2,129),(746,2,130),(747,2,131),(748,2,132),(749,2,133),(750,2,134),(751,2,135),(752,2,136),(753,2,137),(754,2,138),(755,2,139),(756,2,140),(757,2,141),(758,2,142),(759,2,143),(760,2,144),(761,2,145),(762,2,146),(763,2,147),(764,2,148),(765,2,149),(766,2,150),(767,2,151),(768,2,152),(769,2,153),(770,2,154),(771,2,155),(772,2,156),(773,2,157),(774,2,158),(775,2,159),(776,2,160),(777,2,161),(778,2,162),(779,2,163),(780,2,164),(781,2,165),(782,2,166),(783,2,167),(784,2,168),(785,2,169),(786,2,170),(787,2,171),(788,2,172),(789,2,173),(790,2,174),(791,2,175),(792,2,176),(793,2,177),(794,2,178),(795,2,179),(796,2,180),(797,2,181),(798,2,182),(799,2,183),(800,2,184),(801,2,185),(802,2,186),(803,2,187),(804,2,188),(805,2,189),(806,2,190),(807,2,191),(808,2,192),(809,2,193),(810,2,194),(811,2,195),(812,2,196),(813,2,197),(814,2,198),(815,2,199),(816,2,200),(406,3,1),(407,3,2),(408,3,3),(409,3,4),(410,3,5),(411,3,6),(412,3,7),(413,3,8),(414,3,9),(415,3,10),(416,3,11),(417,3,12),(418,3,13),(419,3,14),(420,3,15),(421,3,16),(422,3,17),(423,3,18),(424,3,19),(425,3,20),(426,3,21),(427,3,22),(428,3,23),(429,3,24),(430,3,25),(431,3,26),(432,3,27),(433,3,28),(434,3,29),(435,3,30),(436,3,31),(437,3,32),(438,3,33),(439,3,34),(440,3,35),(441,3,36),(442,3,37),(443,3,38),(444,3,39),(445,3,40),(446,3,41),(447,3,42),(448,3,43),(449,3,44),(450,3,45),(451,3,46),(452,3,47),(453,3,48),(454,3,49),(455,3,50),(456,3,51),(457,3,52),(458,3,53),(459,3,54),(460,3,55),(461,3,56),(462,3,57),(463,3,58),(464,3,59),(465,3,60),(466,3,61),(467,3,62),(468,3,63),(469,3,64),(470,3,65),(471,3,66),(472,3,67),(473,3,68),(474,3,69),(475,3,70),(476,3,71),(477,3,72),(478,3,73),(479,3,74),(480,3,75),(481,3,76),(482,3,77),(483,3,78),(484,3,79),(485,3,80),(486,3,81),(487,3,82),(488,3,83),(489,3,84),(490,3,85),(491,3,86),(492,3,87),(493,3,88),(494,3,89),(495,3,90),(496,3,91),(497,3,92),(498,3,93),(499,3,94),(500,3,95),(501,3,96),(502,3,97),(503,3,98),(504,3,99),(505,3,100),(506,3,101),(507,3,102),(508,3,103),(509,3,104),(510,3,105),(511,3,106),(512,3,107),(513,3,108),(514,3,109),(515,3,110),(516,3,111),(517,3,112),(518,3,113),(519,3,114),(520,3,115),(521,3,116),(522,3,117),(523,3,118),(524,3,119),(525,3,120),(526,3,121),(527,3,122),(528,3,123),(529,3,124),(530,3,125),(531,3,126),(532,3,127),(533,3,128),(534,3,129),(535,3,130),(536,3,131),(537,3,132),(538,3,133),(539,3,134),(540,3,135),(541,3,136),(542,3,137),(543,3,138),(544,3,139),(545,3,140),(546,3,141),(547,3,142),(548,3,143),(549,3,144),(550,3,145),(551,3,146),(552,3,147),(553,3,148),(554,3,149),(555,3,150),(556,3,151),(557,3,152),(558,3,153),(559,3,154),(560,3,155),(561,3,156),(562,3,157),(563,3,158),(564,3,159),(565,3,160),(566,3,161),(567,3,162),(568,3,163),(569,3,164),(570,3,165),(571,3,166),(572,3,167),(573,3,168),(574,3,169),(575,3,170),(576,3,171),(577,3,172),(578,3,173),(579,3,174),(580,3,175),(581,3,176),(582,3,177),(583,3,178),(584,3,179),(585,3,180),(586,3,181),(587,3,182),(588,3,183),(589,3,184),(590,3,185),(591,3,186),(592,3,187),(593,3,188),(594,3,189),(595,3,190),(596,3,191),(597,3,192),(598,3,193),(599,3,194),(600,3,195),(601,3,196),(602,3,197),(603,3,198),(604,3,199),(605,3,200),(613,15,5),(614,15,53),(616,16,50),(615,16,53),(817,18,1),(818,18,2),(819,18,3),(820,18,4),(821,18,5),(822,18,6),(823,18,7),(824,18,8),(825,18,9),(826,18,10),(827,18,11),(828,18,12),(829,18,13),(830,18,14),(831,18,15),(832,18,16),(833,18,17),(834,18,18),(835,18,19),(836,18,20),(837,18,21),(838,18,22),(839,18,23),(840,18,24),(841,18,25),(842,18,26),(843,18,27),(844,18,28),(845,18,29),(846,18,30),(847,18,31),(848,18,32),(849,18,33),(850,18,34),(851,18,35),(852,18,36),(853,18,37),(854,18,38),(855,18,39),(856,18,40),(857,18,41),(858,18,42),(859,18,43),(860,18,44),(861,18,45),(862,18,46),(863,18,47),(864,18,48),(865,18,49),(866,18,50),(867,18,51),(868,18,52),(869,18,53),(870,18,54),(871,18,55),(872,18,56),(873,18,57),(874,18,58),(875,18,59),(876,18,60),(877,18,61),(878,18,62),(879,18,63),(880,18,64),(881,18,65),(882,18,66),(883,18,67),(884,18,68),(885,18,69),(886,18,70),(887,18,71),(888,18,72),(889,18,73),(890,18,74),(891,18,75),(892,18,76),(893,18,77),(894,18,78),(895,18,79),(896,18,80),(897,18,81),(898,18,82),(899,18,83),(900,18,84),(901,18,85),(902,18,86),(903,18,87),(904,18,88),(905,18,89),(906,18,90),(907,18,91),(908,18,92),(909,18,93),(910,18,94),(911,18,95),(912,18,96),(913,18,97),(914,18,98),(915,18,99),(916,18,100),(917,18,101),(918,18,102),(919,18,103),(920,18,104),(921,18,105),(922,18,106),(923,18,107),(924,18,108),(925,18,109),(926,18,110),(927,18,111),(928,18,112),(929,18,113),(930,18,114),(931,18,115),(932,18,116),(933,18,117),(934,18,118),(935,18,119),(936,18,120),(937,18,121),(938,18,122),(939,18,123),(940,18,124),(941,18,125),(942,18,126),(943,18,127),(944,18,128),(945,18,129),(946,18,130),(947,18,131),(948,18,132),(949,18,133),(950,18,134),(951,18,135),(952,18,136),(953,18,137),(954,18,138),(955,18,139),(956,18,140),(957,18,141),(958,18,142),(959,18,143),(960,18,144),(961,18,145),(962,18,146),(963,18,147),(964,18,148),(965,18,149),(966,18,150),(967,18,151),(968,18,152),(969,18,153),(970,18,154),(971,18,155),(972,18,156),(973,18,157),(974,18,158),(975,18,159),(976,18,160),(977,18,161),(978,18,162),(979,18,163),(980,18,164),(981,18,165),(982,18,166),(983,18,167),(984,18,168),(985,18,169),(986,18,170),(987,18,171),(988,18,172),(989,18,173),(990,18,174),(991,18,175),(992,18,176),(993,18,177),(994,18,178),(995,18,179),(996,18,180),(997,18,181),(998,18,182),(999,18,183),(1000,18,184),(1001,18,185),(1002,18,186),(1003,18,187),(1004,18,188),(1005,18,189),(1006,18,190),(1007,18,191),(1008,18,192),(1009,18,193),(1010,18,194),(1011,18,195),(1012,18,196),(1013,18,197),(1014,18,198),(1015,18,199),(1016,18,200),(1017,19,1),(1018,19,2),(1019,19,3),(1020,19,4),(1021,19,5),(1022,19,6),(1023,19,7),(1024,19,8),(1025,19,9),(1026,19,10),(1027,19,11),(1028,19,12),(1029,19,13),(1030,19,14),(1031,19,15),(1032,19,16),(1033,19,17),(1034,19,18),(1035,19,19),(1036,19,20),(1037,19,21),(1038,19,22),(1039,19,23),(1040,19,24),(1041,19,25),(1042,19,26),(1043,19,27),(1044,19,28),(1045,19,29),(1046,19,30),(1047,19,31),(1048,19,32),(1049,19,33),(1050,19,34),(1051,19,35),(1052,19,36),(1053,19,37),(1054,19,38),(1055,19,39),(1056,19,40),(1057,19,41),(1058,19,42),(1059,19,43),(1060,19,44),(1061,19,45),(1062,19,46),(1063,19,47),(1064,19,48),(1065,19,49),(1066,19,50),(1067,19,51),(1068,19,52),(1069,19,53),(1070,19,54),(1071,19,55),(1072,19,56),(1073,19,57),(1074,19,58),(1075,19,59),(1076,19,60),(1077,19,61),(1078,19,62),(1079,19,63),(1080,19,64),(1081,19,65),(1082,19,66),(1083,19,67),(1084,19,68),(1085,19,69),(1086,19,70),(1087,19,71),(1088,19,72),(1089,19,73),(1090,19,74),(1091,19,75),(1092,19,76),(1093,19,77),(1094,19,78),(1095,19,79),(1096,19,80),(1097,19,81),(1098,19,82),(1099,19,83),(1100,19,84),(1101,19,85),(1102,19,86),(1103,19,87),(1104,19,88),(1105,19,89),(1106,19,90),(1107,19,91),(1108,19,92),(1109,19,93),(1110,19,94),(1111,19,95),(1112,19,96),(1113,19,97),(1114,19,98),(1115,19,99),(1116,19,100),(1117,19,101),(1118,19,102),(1119,19,103),(1120,19,104),(1121,19,105),(1122,19,106),(1123,19,107),(1124,19,108),(1125,19,109),(1126,19,110),(1127,19,111),(1128,19,112),(1129,19,113),(1130,19,114),(1131,19,115),(1132,19,116),(1133,19,117),(1134,19,118),(1135,19,119),(1136,19,120),(1137,19,121),(1138,19,122),(1139,19,123),(1140,19,124),(1141,19,125),(1142,19,126),(1143,19,127),(1144,19,128),(1145,19,129),(1146,19,130),(1147,19,131),(1148,19,132),(1149,19,133),(1150,19,134),(1151,19,135),(1152,19,136),(1153,19,137),(1154,19,138),(1155,19,139),(1156,19,140),(1157,19,141),(1158,19,142),(1159,19,143),(1160,19,144),(1161,19,145),(1162,19,146),(1163,19,147),(1164,19,148),(1165,19,149),(1166,19,150),(1167,19,151),(1168,19,152),(1169,19,153),(1170,19,154),(1171,19,155),(1172,19,156),(1173,19,157),(1174,19,158),(1175,19,159),(1176,19,160),(1177,19,161),(1178,19,162),(1179,19,163),(1180,19,164),(1181,19,165),(1182,19,166),(1183,19,167),(1184,19,168),(1185,19,169),(1186,19,170),(1187,19,171),(1188,19,172),(1189,19,173),(1190,19,174),(1191,19,175),(1192,19,176),(1193,19,177),(1194,19,178),(1195,19,179),(1196,19,180),(1197,19,181),(1198,19,182),(1199,19,183),(1200,19,184),(1201,19,185),(1202,19,186),(1203,19,187),(1204,19,188),(1205,19,189),(1206,19,190),(1207,19,191),(1208,19,192),(1209,19,193),(1210,19,194),(1211,19,195),(1212,19,196),(1213,19,197),(1214,19,198),(1215,19,199),(1216,19,200);
/*!40000 ALTER TABLE `review_reviewuser_courses` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourceannotation`
--

LOCK TABLES `review_sourceannotation` WRITE;
/*!40000 ALTER TABLE `review_sourceannotation` DISABLE KEYS */;
INSERT INTO `review_sourceannotation` VALUES (2,'81acc48c-3cb7-4f68-ae16-c851ff7f2f0a',1,11,'2014-08-28 07:14:01','2014-08-28 07:14:01','fdsafsda','fdsa'),(4,'2af5e58d-b727-49dd-9c4c-dda9f36cd207',2,14,'2014-08-29 01:54:02','2014-08-29 01:54:02','43242','43242'),(10,'599ed2d2-f56a-4c23-9ed2-e8be6aed33ed',2,11,'2014-08-29 02:03:06','2014-08-29 02:03:06','textest','textest'),(11,'0a3a64a5-010b-4953-8ec9-a75cedb3e13a',2,11,'2014-08-29 02:04:50','2014-08-29 02:04:50','test','test'),(12,'d3210b47-074c-49a1-b187-2c96991f24bb',2,11,'2014-08-29 02:10:33','2014-08-29 02:10:33','testajax','testajax'),(19,'c9dc6a87-2343-4f85-bd50-3e36222ed567',2,11,'2014-08-29 06:09:46','2014-08-29 06:09:46','<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\ntestestes</textarea>','<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\ntestestes</textarea>'),(20,'3d2774e1-fa48-4e61-bf2f-cd37411dc28c',2,11,'2014-08-29 06:10:31','2014-08-29 06:10:31','testestes','testestes'),(21,'7c6ff312-44ab-46d2-8138-44b331d96214',2,11,'2014-08-29 06:11:03','2014-08-29 06:11:03','stuff','stuff'),(22,'b0922f85-e55f-4c2c-a300-c01f695f4bf7',2,14,'2014-08-29 06:11:35','2014-08-29 06:11:35','This code is bullshit','This code is bullshit'),(23,'8fce94b8-f1c1-4e68-a6a3-8cbfaaf3a4b4',2,14,'2014-08-29 06:23:00','2014-08-29 06:23:00','two','two'),(24,'9992c393-a883-4c46-8628-59ff71173380',2,11,'2014-08-29 06:25:24','2014-08-29 06:25:24','fdnsabcoiadngi43hb80rvjq3','fdnsabcoiadngi43hb80rvjq3');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourceannotationrange`
--

LOCK TABLES `review_sourceannotationrange` WRITE;
/*!40000 ALTER TABLE `review_sourceannotationrange` DISABLE KEYS */;
INSERT INTO `review_sourceannotationrange` VALUES (2,2,'1','2',1,2),(3,4,'1','2',1,2),(9,10,'3213','1342134',3213,1342134),(10,11,'1','4',1,4),(11,12,'1','4',1,4),(15,19,'1','2',1,2),(16,20,'1','2',1,2),(17,21,'2','423',2,423),(18,22,'3','4',3,4),(19,23,'1','2',1,2),(20,24,'3123','2143215',3123,2143215);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourcefile`
--

LOCK TABLES `review_sourcefile` WRITE;
/*!40000 ALTER TABLE `review_sourcefile` DISABLE KEYS */;
INSERT INTO `review_sourcefile` VALUES (2,1,'55380bab-58c1-49a5-b4e9-7bd7a5e55dea','urls','source-files/2014-08-27/05-06/10-236115/urls.py'),(11,13,'c914afba-c8e4-4554-9ae8-c9fc8618a617','rootfile.txt','ABCD1234/fdasasdfas/admin_2014-08-28_07-13-43/rootfile.txt'),(12,14,'90488735-a8af-4282-82ce-f3e59a55a5e3','folder1_testfile.txt','ABCD1234/fdasasdfas/admin_2014-08-28_07-13-43/folder1/folder1_testfile.txt'),(13,15,'7eae9f3b-bf54-481c-a7a1-0ff897a66e20','folder1-sub-testfile.py','ABCD1234/fdasasdfas/admin_2014-08-28_07-13-43/folder1/folder1-sub/folder1-sub-testfile.py'),(14,16,'8e299c63-5706-4423-95e2-9e69431c99ac','folder2_testfile.py','ABCD1234/fdasasdfas/admin_2014-08-28_07-13-43/folder2/folder2_testfile.py');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourcefolder`
--

LOCK TABLES `review_sourcefolder` WRITE;
/*!40000 ALTER TABLE `review_sourcefolder` DISABLE KEYS */;
INSERT INTO `review_sourcefolder` VALUES (1,'4f0dad34-d6bc-43a6-ae2a-894d9211eb0c','csse2310',NULL),(2,'25696ebc-7f8c-48c7-a292-86d7db6d3759','admin_2014-08-28_06-27-48',NULL),(3,'89a65f7f-f684-4a0a-9658-2d2444820881','folder1',2),(4,'a5234335-811c-42b9-bd1f-714966cb33b6','folder1-sub',3),(5,'d5840a38-a391-49e9-9495-5e15f0f3aee7','folder2',2),(6,'ae4f4fea-95fb-43a8-8f2b-ac4120bf1627','admin_2014-08-28_06-29-04',NULL),(7,'e4eea010-c154-40dd-bafd-b900a1d6811c','folder1',6),(8,'9b31837a-ae4f-49f3-9d15-7232eaf3366f','folder1-sub',7),(9,'1b10ad81-5a81-4f26-9350-3a07ddb7cfd5','folder2',6),(10,'ce6704c0-3f1f-40f8-8287-38d2522f0a70','admin_2014-08-28_06-46-43',NULL),(11,'c6e63a4e-b5d1-4bfe-83d5-d81b23ff6a09','admin_2014-08-28_06-47-13',NULL),(12,'f94d7350-05a3-4b1f-ae7e-a1200f3ff153','admin_2014-08-28_06-47-25',NULL),(13,'2dbdaebc-0768-4e9c-8920-8de3f04251e9','admin_2014-08-28_07-13-43',NULL),(14,'1190c04e-9b22-439c-87d7-0ee41e38b36b','folder1',13),(15,'aacd3e15-13d8-4b8e-9c9b-54a3afb5887f','folder1-sub',14),(16,'81f463e5-b328-4d27-8eb7-e80e4a6570ac','folder2',13);
/*!40000 ALTER TABLE `review_sourcefolder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_studentuser`
--

DROP TABLE IF EXISTS `review_studentuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_studentuser` (
  `user_ptr_id` int(11) NOT NULL,
  `char` varchar(100) NOT NULL,
  PRIMARY KEY (`user_ptr_id`),
  CONSTRAINT `user_ptr_id_refs_id_b3f6ba22` FOREIGN KEY (`user_ptr_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_studentuser`
--

LOCK TABLES `review_studentuser` WRITE;
/*!40000 ALTER TABLE `review_studentuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_studentuser` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `south_migrationhistory`
--

LOCK TABLES `south_migrationhistory` WRITE;
/*!40000 ALTER TABLE `south_migrationhistory` DISABLE KEYS */;
INSERT INTO `south_migrationhistory` VALUES (1,'review','0001_initial','2014-08-09 12:39:02'),(2,'review','0002_auto__del_test__add_user__add_sourceannotation__add_sourcefile__add_so','2014-08-09 12:39:10'),(3,'review','0003_auto__del_user__add_reviewuser__chg_field_sourceannotation_user__chg_f','2014-08-09 12:39:11'),(4,'review','0004_auto__add_field_reviewuser_isStaff','2014-08-09 12:39:11'),(5,'review','0005_auto__add_course','2014-08-09 12:39:12'),(6,'review','0006_auto__add_field_course_course_code__add_field_course_course_name','2014-08-09 12:39:12'),(7,'review','0007_auto__add_field_assignment_course_code','2014-08-09 12:39:13'),(8,'review','0008_auto','2014-08-09 12:39:15'),(9,'review','0009_auto__chg_field_course_course_name','2014-08-09 12:39:15'),(10,'review','0010_auto','2014-08-09 12:39:16'),(11,'review','0011_auto__add_myuser','2014-08-14 05:33:54'),(12,'review','0012_auto__del_myuser__add_studentuser__add_createuserform','2014-08-15 13:19:09'),(13,'review','0013_auto__del_studentuser','2014-08-15 13:19:09'),(14,'review','0014_auto__del_createuserform','2014-08-15 13:19:09'),(15,'review','0015_auto__add_field_reviewuser_firstLogin','2014-08-15 13:54:20'),(16,'review','0016_auto__add_faketestmodel','2014-08-17 13:17:14'),(17,'review','0017_auto__del_faketestmodel','2014-08-17 13:17:14'),(18,'review','0011_auto__add_studentuser__add_createuserform','2014-08-27 06:27:02'),(19,'review','0018_auto__del_field_assignmentsubmission_root_folder','2014-08-27 06:27:02'),(20,'review','0019_auto__del_field_assignmentsubmission_test_results__add_field_assignmen','2014-08-27 06:27:18'),(21,'review','0020_auto__add_field_sourcefile_file_html','2014-08-28 06:46:20'),(22,'review','0021_auto__del_field_sourcefile_file_html','2014-08-28 06:48:24');
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

-- Dump completed on 2014-08-30 11:51:33
