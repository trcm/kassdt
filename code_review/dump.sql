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
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add migration history',7,'add_migrationhistory'),(20,'Can change migration history',7,'change_migrationhistory'),(21,'Can delete migration history',7,'delete_migrationhistory'),(22,'Can add review user',8,'add_reviewuser'),(23,'Can change review user',8,'change_reviewuser'),(24,'Can delete review user',8,'delete_reviewuser'),(25,'Can add course',9,'add_course'),(26,'Can change course',9,'change_course'),(27,'Can delete course',9,'delete_course'),(28,'Can add source folder',10,'add_sourcefolder'),(29,'Can change source folder',10,'change_sourcefolder'),(30,'Can delete source folder',10,'delete_sourcefolder'),(31,'Can add source file',11,'add_sourcefile'),(32,'Can change source file',11,'change_sourcefile'),(33,'Can delete source file',11,'delete_sourcefile'),(34,'Can add submission test results',12,'add_submissiontestresults'),(35,'Can change submission test results',12,'change_submissiontestresults'),(36,'Can delete submission test results',12,'delete_submissiontestresults'),(37,'Can add submission test',13,'add_submissiontest'),(38,'Can change submission test',13,'change_submissiontest'),(39,'Can delete submission test',13,'delete_submissiontest'),(40,'Can add assignment',14,'add_assignment'),(41,'Can change assignment',14,'change_assignment'),(42,'Can delete assignment',14,'delete_assignment'),(43,'Can add assignment submission',15,'add_assignmentsubmission'),(44,'Can change assignment submission',15,'change_assignmentsubmission'),(45,'Can delete assignment submission',15,'delete_assignmentsubmission'),(46,'Can add source annotation',16,'add_sourceannotation'),(47,'Can change source annotation',16,'change_sourceannotation'),(48,'Can delete source annotation',16,'delete_sourceannotation'),(49,'Can add source annotation range',17,'add_sourceannotationrange'),(50,'Can change source annotation range',17,'change_sourceannotationrange'),(51,'Can delete source annotation range',17,'delete_sourceannotationrange'),(52,'Can add source annotation tag',18,'add_sourceannotationtag'),(53,'Can change source annotation tag',18,'change_sourceannotationtag'),(54,'Can delete source annotation tag',18,'delete_sourceannotationtag'),(58,'Can add enrol',20,'add_enrol'),(59,'Can change enrol',20,'change_enrol'),(60,'Can delete enrol',20,'delete_enrol'),(61,'Can add assignment review',21,'add_assignmentreview'),(62,'Can change assignment review',21,'change_assignmentreview'),(63,'Can delete assignment review',21,'delete_assignmentreview'),(64,'Can add submission review',22,'add_submissionreview'),(65,'Can change submission review',22,'change_submissionreview'),(66,'Can delete submission review',22,'delete_submissionreview'),(67,'Can add post',23,'add_post'),(68,'Can change post',23,'change_post'),(69,'Can delete post',23,'delete_post'),(70,'Can add task state',24,'add_taskmeta'),(71,'Can change task state',24,'change_taskmeta'),(72,'Can delete task state',24,'delete_taskmeta'),(73,'Can add saved group result',25,'add_tasksetmeta'),(74,'Can change saved group result',25,'change_tasksetmeta'),(75,'Can delete saved group result',25,'delete_tasksetmeta'),(76,'Can add interval',26,'add_intervalschedule'),(77,'Can change interval',26,'change_intervalschedule'),(78,'Can delete interval',26,'delete_intervalschedule'),(79,'Can add crontab',27,'add_crontabschedule'),(80,'Can change crontab',27,'change_crontabschedule'),(81,'Can delete crontab',27,'delete_crontabschedule'),(82,'Can add periodic tasks',28,'add_periodictasks'),(83,'Can change periodic tasks',28,'change_periodictasks'),(84,'Can delete periodic tasks',28,'delete_periodictasks'),(85,'Can add periodic task',29,'add_periodictask'),(86,'Can change periodic task',29,'change_periodictask'),(87,'Can delete periodic task',29,'delete_periodictask'),(88,'Can add worker',30,'add_workerstate'),(89,'Can change worker',30,'change_workerstate'),(90,'Can delete worker',30,'delete_workerstate'),(91,'Can add task',31,'add_taskstate'),(92,'Can change task',31,'change_taskstate'),(93,'Can delete task',31,'delete_taskstate');
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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'bcrypt_sha256$$2a$12$kr4w2xy4gVheC7r8llLFwOdAFsqXBCtLruqM37jdZ4cZnwmUM00EK','2014-09-24 05:44:29',1,'TESTING:user_2','Super','User','admin@admin.com',1,1,'2014-08-09 12:38:53'),(2,'bcrypt_sha256$$2a$12$AzLkJ1hp5Bz2zwnUd4bYjuag7PbJ7dQtUPud08QndaObKB7MbXStC','2014-09-30 00:29:12',0,'tom','Tom','Midson','midson.trc@gmail.com',0,1,'2014-08-09 12:44:45'),(3,'bcrypt_sha256$$2a$12$888KxgQek4HpX2tAoHZqgOdwcnNHBBmzReRCoJaA5LW8ozeF1qUhO','2014-08-15 05:12:05',0,'kieran','Kieran','Eames','eames@eames.com',0,1,'2014-08-15 05:12:05'),(8,'fdsa','2014-08-15 13:22:48',0,'fdsa','fdsa','fdsa','amin@admin.com',1,1,'2014-08-15 13:22:48'),(23,'bcrypt_sha256$$2a$12$Kc/fCWI6cotD9kjPP1g6WuR4QuREeksTOZ1q4UCeurDx4sk1sxOXW','2014-09-18 12:32:45',0,'s0123456','','','',0,1,'2014-08-15 14:29:12'),(24,'bcrypt_sha256$$2a$12$/A1SnnWyjPTnXJ0/UDDKS.ZtIQxG6HYtQpKDnrHdRuiwYCMMDnjrW','2014-09-18 12:33:48',0,'s1234567','','','',0,1,'2014-08-15 14:29:13'),(25,'bcrypt_sha256$$2a$12$jZX81G.on4s1DrGeik6HOeL.JRG1Zj82mcEd5ZVHXEZmlt85.80qm','2014-08-20 11:17:56',0,'test1','test','test','test@test.com',1,1,'2014-08-18 01:09:32'),(26,'bcrypt_sha256$$2a$12$XwrqAL.d7Lby1DU/yb6JBec3fmFPfwArkaYy99NCwzCr8/.YK27u2','2014-08-25 04:01:52',0,'staff','','','',1,1,'2014-08-25 04:01:20'),(27,'bcrypt_sha256$$2a$12$451LmIBfWe.PLvazS63lpOk9aKlkRKsMD8vJWo15ThIP2NFrt8X7O','2014-08-28 11:43:53',0,'annote','','','',0,1,'2014-08-28 11:43:37'),(28,'bcrypt_sha256$$2a$12$zfOtKeobhkZRXiuIwQxfdOCfz6fXst5JwJVl3cC8BHrl8YnjtEkGO','2014-09-18 12:33:17',0,'s111110','jimmy','staff','',0,1,'2014-09-18 11:13:39'),(53,'bcrypt_sha256$$2a$12$rdQLCMeuO0Qlun5a3Rn3C.WxmvAFuvX//zwLhkywj6cUW7k2gVyaO','2014-09-20 09:50:04',0,'naoise','','','',0,1,'2014-09-18 11:15:14'),(54,'!01261yoKEZfwtybEdQfPogK9X4n4N35zCfLuoBsY','2014-09-22 03:57:31',0,'TESTING:user_3','Test','Student','test@student.com',0,1,'2014-09-22 03:57:17'),(55,'bcrypt_sha256$$2a$12$mmoD8ccabLw4Qyzzg0BctOe7eFD3.V01i8dXBDH9iTNLd3eElPfIi','2014-09-26 05:13:36',1,'sudo','','','',1,1,'2014-09-26 05:13:36');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
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
-- Table structure for table `celery_taskmeta`
--

DROP TABLE IF EXISTS `celery_taskmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `celery_taskmeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `result` longtext,
  `date_done` datetime NOT NULL,
  `traceback` longtext,
  `hidden` tinyint(1) NOT NULL,
  `meta` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `celery_taskmeta_2ff6b945` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `celery_taskmeta`
--

LOCK TABLES `celery_taskmeta` WRITE;
/*!40000 ALTER TABLE `celery_taskmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `celery_taskmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `celery_tasksetmeta`
--

DROP TABLE IF EXISTS `celery_tasksetmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `celery_tasksetmeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskset_id` varchar(255) NOT NULL,
  `result` longtext NOT NULL,
  `date_done` datetime NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `taskset_id` (`taskset_id`),
  KEY `celery_tasksetmeta_2ff6b945` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `celery_tasksetmeta`
--

LOCK TABLES `celery_tasksetmeta` WRITE;
/*!40000 ALTER TABLE `celery_tasksetmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `celery_tasksetmeta` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-08-09 12:45:38',1,3,'1','staff',1,''),(2,'2014-08-09 12:46:21',1,3,'2','student',1,''),(3,'2014-08-09 12:46:36',1,4,'2','tom',1,''),(4,'2014-08-10 02:44:38',1,14,'1','(cfafd9e3-8555-416e-a42e-583b9a405d61)Learning 1',1,''),(5,'2014-08-10 10:24:17',1,14,'3','(dd48420a-cfc9-4007-9c3e-9ae68552c488)fdsa',3,''),(6,'2014-08-10 10:24:17',1,14,'2','(2fbf28d6-c2eb-43ad-9115-0fe053d02f37)fdsa',3,''),(7,'2014-08-11 05:08:30',1,4,'2','tom',2,'Changed password.'),(8,'2014-08-11 05:30:37',1,8,'2','admin',1,''),(9,'2014-08-13 11:50:01',1,8,'2','admin',2,'Changed courses.'),(10,'2014-08-14 05:30:47',1,4,'2','tom',2,'Changed password.'),(11,'2014-08-14 05:31:45',1,4,'2','tom',2,'No fields changed.'),(12,'2014-08-14 05:34:18',1,4,'2','tom',2,'No fields changed.'),(13,'2014-08-14 05:36:37',1,4,'2','tom',2,'No fields changed.'),(14,'2014-08-14 05:41:37',1,4,'2','tom',2,'No fields changed.'),(15,'2014-08-14 05:42:36',1,4,'2','tom',2,'No fields changed.'),(16,'2014-08-14 05:42:43',1,4,'2','tom',2,'Changed password.'),(17,'2014-08-14 06:33:16',1,4,'1','admin',2,'Changed courses for review user \"admin\".'),(18,'2014-08-14 06:33:23',1,4,'1','admin',2,'Changed courses for review user \"admin\".'),(19,'2014-08-15 05:11:10',1,4,'2','tom',2,'Changed password.'),(20,'2014-08-15 05:11:45',1,4,'2','tom',2,'Changed password.'),(21,'2014-08-15 05:12:06',1,4,'3','kieran',1,''),(22,'2014-08-15 07:44:18',1,4,'2','tom',2,'Changed email.'),(23,'2014-08-15 07:44:46',1,4,'3','kieran',2,'Changed first_name, last_name and email.'),(24,'2014-08-15 07:44:58',1,4,'1','admin',2,'Changed first_name, last_name and email.'),(25,'2014-08-15 13:19:23',1,4,'4','fdsa',3,''),(26,'2014-08-15 13:21:07',1,4,'5','fdsa',3,''),(27,'2014-08-15 13:21:44',1,4,'6','fdsa',3,''),(28,'2014-08-15 13:22:45',1,4,'7','fdsa',3,''),(29,'2014-08-15 14:17:19',1,4,'9','s0123456',3,''),(30,'2014-08-15 14:17:19',1,4,'10','s1234567',3,''),(31,'2014-08-15 14:20:04',1,4,'11','s0123456',3,''),(32,'2014-08-15 14:20:04',1,4,'12','s1234567',3,''),(33,'2014-08-15 14:21:02',1,4,'15','s0123456',3,''),(34,'2014-08-15 14:21:02',1,4,'16','s1234567',3,''),(35,'2014-08-15 14:24:55',1,4,'17','s0123456',3,''),(36,'2014-08-15 14:24:55',1,4,'18','s1234567',3,''),(37,'2014-08-15 14:26:17',1,8,'11','s0123456',3,''),(38,'2014-08-15 14:26:28',1,4,'19','s0123456',3,''),(39,'2014-08-15 14:26:28',1,4,'20','s1234567',3,''),(40,'2014-08-15 14:29:02',1,4,'21','s0123456',3,''),(41,'2014-08-15 14:29:02',1,4,'22','s1234567',3,''),(42,'2014-08-20 11:00:32',1,8,'2','admin',2,'Changed firstLogin.'),(43,'2014-08-20 11:17:25',1,4,'25','test1',2,'Changed password.'),(44,'2014-08-25 04:01:21',1,4,'26','staff',1,''),(45,'2014-08-25 04:01:38',1,4,'26','staff',2,'Changed is_staff.'),(46,'2014-08-27 06:27:22',1,15,'1','(3936d9bd-278f-4105-aa81-a8575912cf53)Learning 1 @ 2014-08-27 06:25:14+00:00',1,''),(47,'2014-08-28 04:56:28',1,11,'1','(772c7e9c-6382-4564-81e3-a8a2fc8beb8d)manage.py',3,''),(48,'2014-08-28 06:17:35',1,14,'4','(bdf53f3e-b8df-4d28-bd36-93af08b22639)fdasasdfas',2,'Changed submission_open_date and submission_close_date.'),(49,'2014-08-28 06:18:08',1,14,'4','(bdf53f3e-b8df-4d28-bd36-93af08b22639)fdasasdfas',2,'Changed first_display_date, submission_open_date, submission_close_date, review_open_date and review_close_date.'),(50,'2014-08-28 06:28:51',1,15,'11','(cb70426a-15c4-4f6b-b007-91b03eba0a38)fdasasdfas @ 2014-08-28 06:27:48+00:00',3,''),(51,'2014-08-28 06:28:51',1,15,'10','(c0ee6713-9b2f-4b51-b103-fd33086f5602)fdasasdfas @ 2014-08-28 06:20:25+00:00',3,''),(52,'2014-08-28 06:28:51',1,15,'9','(814ab1be-77c4-4006-94cd-26c68eae8ada)fdasasdfas @ 2014-08-28 06:18:56+00:00',3,''),(53,'2014-08-28 06:28:51',1,15,'8','(2dd29bb2-57ad-4c52-a7b0-d1482fc07ef8)fdasasdfas @ 2014-08-28 06:18:20+00:00',3,''),(54,'2014-08-28 06:28:51',1,15,'7','(2798320b-b827-45a0-87bf-4f151a7b388f)fdasasdfas @ 2014-08-28 06:16:38+00:00',3,''),(55,'2014-08-28 06:28:51',1,15,'6','(456e05cb-5add-4ec9-856c-5a586266d9be)fdasasdfas @ 2014-08-28 06:16:30+00:00',3,''),(56,'2014-08-28 06:28:51',1,15,'5','(71a766dd-fa49-490e-b5c6-8c481d9c1616)fdasasdfas @ 2014-08-28 06:16:06+00:00',3,''),(57,'2014-08-28 07:08:58',1,16,'1','\"fdsafdsafdsafdsa\" on \"fdsafdsafdsafsa\" by tom in ((d36a774c-5bc8-40f9-9710-2a3fbdc660f9)rootfile.txt).',1,''),(58,'2014-08-28 07:09:20',1,17,'1','SourceAnnotationRange object',1,''),(59,'2014-08-28 07:11:19',1,15,'15','(ae0106f7-c538-4c52-8d62-c2199ceece12)fdasasdfas @ 2014-08-28 06:47:25+00:00',3,''),(60,'2014-08-28 07:11:19',1,15,'14','(f163f793-3730-4b22-910c-e2c4e6b2cd25)fdasasdfas @ 2014-08-28 06:47:13+00:00',3,''),(61,'2014-08-28 07:11:19',1,15,'13','(e15cca91-be8a-4e9e-81ce-657661487fb5)fdasasdfas @ 2014-08-28 06:46:43+00:00',3,''),(62,'2014-08-28 07:11:46',1,11,'10','(59ef2046-4eb0-4aa8-8614-d88727c2bb5d)folder2_testfile.py',3,''),(63,'2014-08-28 07:11:46',1,11,'9','(2c5cf06e-660b-4c60-bf82-9bee784bd1dc)folder1-sub-testfile.py',3,''),(64,'2014-08-28 07:11:46',1,11,'8','(24341c24-671a-4888-92ee-dac596a61547)folder1_testfile.txt',3,''),(65,'2014-08-28 07:11:46',1,11,'7','(b3883201-dd63-447d-9623-7c0fb36c1bdd)rootfile.txt',3,''),(66,'2014-08-28 07:12:21',1,15,'12','(8b520c46-c26f-42cd-8956-1536f1f8cc26)fdasasdfas @ 2014-08-28 06:29:04+00:00',3,''),(67,'2014-08-28 07:13:30',1,11,'6','(b79c3114-f066-4110-9f5b-b96a10770ffe)folder2_testfile.py',3,''),(68,'2014-08-28 07:13:30',1,11,'5','(fe87beab-912e-4679-8eab-617f448f53ec)folder1-sub-testfile.py',3,''),(69,'2014-08-28 07:13:30',1,11,'4','(6afb7463-5717-471c-81fb-0512ab925183)folder1_testfile.txt',3,''),(70,'2014-08-28 07:13:30',1,11,'3','(d36a774c-5bc8-40f9-9710-2a3fbdc660f9)rootfile.txt',3,''),(71,'2014-08-28 07:14:01',1,16,'2','\"fdsafsda\" on \"fdsa\" by tom in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',1,''),(72,'2014-08-28 08:21:56',1,17,'2','SourceAnnotationRange object',1,''),(73,'2014-08-28 11:43:37',1,4,'27','annote',1,''),(74,'2014-08-29 01:54:34',1,16,'3','\"43242\" on \"43242\" by admin in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',3,''),(75,'2014-08-29 01:58:04',1,16,'5','\"43242\" on \"43242\" by admin in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',3,''),(76,'2014-08-29 02:01:52',1,16,'8','\"textest\" on \"textest\" by admin in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',3,''),(77,'2014-08-29 02:01:52',1,16,'7','\"textest\" on \"textest\" by admin in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',3,''),(78,'2014-08-29 02:01:52',1,16,'6','\"textest\" on \"textest\" by admin in ((8e299c63-5706-4423-95e2-9e69431c99ac)folder2_testfile.py).',3,''),(79,'2014-08-29 02:03:26',1,16,'9','\"textest\" on \"textest\" by admin in ((c914afba-c8e4-4554-9ae8-c9fc8618a617)rootfile.txt).',3,''),(80,'2014-08-29 06:09:26',1,16,'18','\"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" on \"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" by admin in ((8e299c63-5706-4423-95e2-9e694',3,''),(81,'2014-08-29 06:09:26',1,16,'17','\"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" on \"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" by admin in ((8e299c63-5706-4423-95e2-9e694',3,''),(82,'2014-08-29 06:09:26',1,16,'16','\"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" on \"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" by admin in ((8e299c63-5706-4423-95e2-9e694',3,''),(83,'2014-08-29 06:09:26',1,16,'15','\"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" on \"<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\n321312</textarea>\" by admin in ((8e299c63-5706-4423-95e2-9e694',3,''),(84,'2014-08-29 06:09:26',1,16,'14','\"<textarea cols=\"40\" id=\"id_annotation_text\" name=\"annotation_text\" rows=\"10\">\r\n</textarea>\" on \"<textarea cols=\"40\" id=\"id_annotation_text\" name=\"annotation_text\" rows=\"10\">\r\n</textarea>\" by admin in',3,''),(85,'2014-08-29 06:09:26',1,16,'13','\"<textarea cols=\"40\" id=\"id_annotation_text\" name=\"annotation_text\" rows=\"10\">\r\n</textarea>\" on \"<textarea cols=\"40\" id=\"id_annotation_text\" name=\"annotation_text\" rows=\"10\">\r\n</textarea>\" by admin in',3,''),(86,'2014-09-18 11:10:36',1,4,'23','s0123456',2,'Changed courses for review user \"s0123456\".'),(87,'2014-09-18 11:14:19',1,4,'33','s000000',2,'Changed courses for review user \"s000000\".'),(88,'2014-09-18 11:14:35',1,4,'34','s000001',2,'Changed courses for review user \"s000001\".'),(89,'2014-09-18 11:14:59',1,4,'43','s0000010',2,'Changed courses for review user \"s0000010\".'),(90,'2014-09-18 11:15:14',1,4,'53','naoise',1,''),(91,'2014-09-18 11:17:19',1,14,'5','(14513aed-5d95-4b3d-aa93-2e07f29c4f22)ASMT1',1,''),(92,'2014-09-18 11:17:51',1,14,'6','(7b9924ef-befb-4b02-8001-899a8f0117aa)SingleSubmit',1,''),(93,'2014-09-18 11:18:25',1,14,'7','(16bd0aa6-a9ec-4db8-9776-abd4a70ec7db)ReviewNotOpen',1,''),(94,'2014-09-18 11:24:18',1,15,'17','(a1883f5f-3913-4e36-95f7-ea98b92a0020)ASMT1 @ 2014-09-18 11:20:29+00:00',3,''),(95,'2014-09-18 11:40:44',1,16,'26','\"And another!\" on \"And another!\" by admin in ((8e2245f3-c712-4658-b503-a28160c7a79d)folder1_testfile.txt).',3,''),(96,'2014-09-18 11:40:53',1,16,'27','\"Argh, yer mighty annotation\" on \"Argh, yer mighty annotation\" by admin in ((c671ae21-279f-4bc6-ac31-eb980e292de1)folder2_testfile.py).',3,''),(97,'2014-09-18 11:40:53',1,16,'25','\"This be an annotation\" on \"This be an annotation\" by admin in ((8e2245f3-c712-4658-b503-a28160c7a79d)folder1_testfile.txt).',3,''),(98,'2014-09-18 11:42:38',1,16,'30','\"Yer mighty annotations be here.\r\n\" on \"Yer mighty annotations be here.\r\n\" by admin in ((8e2245f3-c712-4658-b503-a28160c7a79d)folder1_testfile.txt).',3,''),(99,'2014-09-18 11:42:38',1,16,'29','\"This be yet another annotation! YARGH\" on \"This be yet another annotation! YARGH\" by admin in ((c671ae21-279f-4bc6-ac31-eb980e292de1)folder2_testfile.py).',3,''),(100,'2014-09-18 11:42:38',1,16,'28','\"THis be an annotation!!!\" on \"THis be an annotation!!!\" by admin in ((c671ae21-279f-4bc6-ac31-eb980e292de1)folder2_testfile.py).',3,''),(101,'2014-09-18 12:24:45',1,4,'33','s000000',3,''),(102,'2014-09-18 12:24:45',1,4,'34','s000001',3,''),(103,'2014-09-18 12:24:45',1,4,'43','s0000010',3,''),(104,'2014-09-18 12:24:45',1,4,'44','s0000011',3,''),(105,'2014-09-18 12:24:45',1,4,'45','s0000012',3,''),(106,'2014-09-18 12:24:45',1,4,'46','s0000013',3,''),(107,'2014-09-18 12:24:45',1,4,'47','s0000014',3,''),(108,'2014-09-18 12:24:45',1,4,'48','s0000015',3,''),(109,'2014-09-18 12:24:45',1,4,'49','s0000016',3,''),(110,'2014-09-18 12:24:45',1,4,'50','s0000017',3,''),(111,'2014-09-18 12:24:45',1,4,'51','s0000018',3,''),(112,'2014-09-18 12:24:45',1,4,'52','s0000019',3,''),(113,'2014-09-18 12:24:45',1,4,'35','s000002',3,''),(114,'2014-09-18 12:24:45',1,4,'36','s000003',3,''),(115,'2014-09-18 12:24:45',1,4,'37','s000004',3,''),(116,'2014-09-18 12:24:45',1,4,'38','s000005',3,''),(117,'2014-09-18 12:24:45',1,4,'39','s000006',3,''),(118,'2014-09-18 12:24:45',1,4,'40','s000007',3,''),(119,'2014-09-18 12:24:45',1,4,'41','s000008',3,''),(120,'2014-09-18 12:24:45',1,4,'42','s000009',3,''),(121,'2014-09-18 12:24:45',1,4,'29','s111111',3,''),(122,'2014-09-18 12:24:45',1,4,'30','s111112',3,''),(123,'2014-09-18 12:24:45',1,4,'31','s111113',3,''),(124,'2014-09-18 12:24:45',1,4,'32','s111114',3,''),(125,'2014-09-18 12:26:24',1,4,'27','annote',2,'Changed password.'),(126,'2014-09-18 12:28:36',1,4,'3','kieran',2,'Changed courses for review user \"kieran\".'),(127,'2014-09-18 12:28:43',1,4,'23','s0123456',2,'No fields changed.'),(128,'2014-09-18 12:28:50',1,4,'28','s111110',2,'Added review user \"s111110\".'),(129,'2014-09-18 12:29:02',1,4,'24','s1234567',2,'No fields changed.'),(130,'2014-09-18 12:29:12',1,4,'24','s1234567',2,'Changed courses for review user \"s1234567\".'),(131,'2014-09-18 12:30:15',1,4,'27','annote',2,'Changed password.'),(132,'2014-09-18 12:31:25',1,4,'27','annote',2,'Changed courses for review user \"annote\".'),(133,'2014-09-18 12:31:48',1,4,'23','s0123456',2,'Changed password.'),(134,'2014-09-18 12:32:04',1,4,'28','s111110',2,'Changed password.'),(135,'2014-09-18 12:32:10',1,4,'28','s111110',2,'No fields changed.'),(136,'2014-09-18 12:32:19',1,4,'24','s1234567',2,'Changed password.'),(137,'2014-09-18 13:43:16',1,14,'5','(14513aed-5d95-4b3d-aa93-2e07f29c4f22)ASMT1',2,'Changed min_annotations.'),(138,'2014-09-20 09:49:16',1,14,'8','(103e76f4-2f56-490c-85b3-f6b2bb6f252d)Unsubmitted',1,''),(139,'2014-09-26 05:13:36',1,4,'55','sudo',1,''),(140,'2014-09-26 05:13:50',1,4,'55','sudo',2,'Changed is_staff and is_superuser.');
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'migration history','south','migrationhistory'),(8,'review user','review','reviewuser'),(9,'course','review','course'),(10,'source folder','review','sourcefolder'),(11,'source file','review','sourcefile'),(12,'submission test results','review','submissiontestresults'),(13,'submission test','review','submissiontest'),(14,'assignment','review','assignment'),(15,'assignment submission','review','assignmentsubmission'),(16,'source annotation','review','sourceannotation'),(17,'source annotation range','review','sourceannotationrange'),(18,'source annotation tag','review','sourceannotationtag'),(20,'enrol','review','enrol'),(21,'assignment review','review','assignmentreview'),(22,'submission review','review','submissionreview'),(23,'post','help','post'),(24,'task state','djcelery','taskmeta'),(25,'saved group result','djcelery','tasksetmeta'),(26,'interval','djcelery','intervalschedule'),(27,'crontab','djcelery','crontabschedule'),(28,'periodic tasks','djcelery','periodictasks'),(29,'periodic task','djcelery','periodictask'),(30,'worker','djcelery','workerstate'),(31,'task','djcelery','taskstate');
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
INSERT INTO `django_session` VALUES ('1r0igqhe4h9tm4ks0v1plunf58kuz4lg','MWQ5ZTM2NmI5MTBmYTQ2NzI1OTAyMmMzMmY2ZWI2ODlmZjAxMTE1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-10-09 04:27:07'),('4jvlacqtks4q6jvqxe0la14so9tm6d9k','YjIzZTM0Y2NiZDhkZGYxMzI4NDNlZTU1Nzg2NWMzNWY0MmVkNTkwODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NTN9','2014-10-04 09:50:04'),('6e674mu8w0mtr20hfouss75leyzy819n','YWQ4MWU2MDRjZmJhYWQ3NDZjOTZkYmFiM2QyMWIxMjkwOTlmNjA5MTp7fQ==','2014-08-24 10:07:30'),('6qrca0zlo65te9j4es4ib0ac4rvt2v3x','MWQ5ZTM2NmI5MTBmYTQ2NzI1OTAyMmMzMmY2ZWI2ODlmZjAxMTE1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-10-13 23:56:56'),('7qyo1bvlje81cv94ax7ou3y8f5q5mksj','YWQ4MWU2MDRjZmJhYWQ3NDZjOTZkYmFiM2QyMWIxMjkwOTlmNjA5MTp7fQ==','2014-09-03 11:18:04'),('8dlu3ihbpt1v1u9v30xqumzgc2wx5iq6','MWQ5ZTM2NmI5MTBmYTQ2NzI1OTAyMmMzMmY2ZWI2ODlmZjAxMTE1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-10-13 23:59:00'),('b3pwstbflm2jkkzrl0501r7z64j4aebu','MWQ5ZTM2NmI5MTBmYTQ2NzI1OTAyMmMzMmY2ZWI2ODlmZjAxMTE1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-10-13 23:51:27'),('c1vflloinflxa37qfcveltqen46px4nb','MzI0OGYzZGYxMDA1MGRmY2M5YjM5MTE5ZjJhYjY2MTVmMzQwYTY5MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-09-11 11:44:07'),('cxfex8ee9u5qb8tmy7021nye8t49k6em','MWQ5ZTM2NmI5MTBmYTQ2NzI1OTAyMmMzMmY2ZWI2ODlmZjAxMTE1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-10-14 00:29:12'),('due7bwjkvh7vylyxwi5k4yzizn6s2946','YWQ4MWU2MDRjZmJhYWQ3NDZjOTZkYmFiM2QyMWIxMjkwOTlmNjA5MTp7fQ==','2014-10-06 03:45:41'),('ein0uddfyvwxcwl1ygr32hvkqbna1hjm','YWQ4MWU2MDRjZmJhYWQ3NDZjOTZkYmFiM2QyMWIxMjkwOTlmNjA5MTp7fQ==','2014-08-23 12:58:42'),('eycgolh6ktj32h20imnzgqvmp6w2bd9s','MWQ5ZTM2NmI5MTBmYTQ2NzI1OTAyMmMzMmY2ZWI2ODlmZjAxMTE1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-10-06 03:58:44'),('jla89sk2c2werwkjioj8937ej1v3ejv4','MWQ5ZTM2NmI5MTBmYTQ2NzI1OTAyMmMzMmY2ZWI2ODlmZjAxMTE1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-10-13 23:44:44'),('mu7py5v1ooht3onc7xwhaw5xmekpzbl4','YWQ4MWU2MDRjZmJhYWQ3NDZjOTZkYmFiM2QyMWIxMjkwOTlmNjA5MTp7fQ==','2014-10-06 01:26:41'),('n6m7k0heydb5599lez4pjkb8x1zam2uq','MWQ5ZTM2NmI5MTBmYTQ2NzI1OTAyMmMzMmY2ZWI2ODlmZjAxMTE1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-10-14 00:15:00'),('n7k98336mti0p2eg30d4mqmb6t8u53vu','MzI0OGYzZGYxMDA1MGRmY2M5YjM5MTE5ZjJhYjY2MTVmMzQwYTY5MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-08-24 02:00:02'),('sfv28hzywnbilhdwmyxzs4771qki9kc1','MWQ5ZTM2NmI5MTBmYTQ2NzI1OTAyMmMzMmY2ZWI2ODlmZjAxMTE1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-10-14 00:19:33'),('zieo99vdpubeob9es2s786zgv5pip22u','YjIzZTM0Y2NiZDhkZGYxMzI4NDNlZTU1Nzg2NWMzNWY0MmVkNTkwODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NTN9','2014-10-04 09:12:00');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_crontabschedule`
--

DROP TABLE IF EXISTS `djcelery_crontabschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_crontabschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minute` varchar(64) NOT NULL,
  `hour` varchar(64) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  `day_of_month` varchar(64) NOT NULL,
  `month_of_year` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_crontabschedule`
--

LOCK TABLES `djcelery_crontabschedule` WRITE;
/*!40000 ALTER TABLE `djcelery_crontabschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_crontabschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_intervalschedule`
--

DROP TABLE IF EXISTS `djcelery_intervalschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_intervalschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_intervalschedule`
--

LOCK TABLES `djcelery_intervalschedule` WRITE;
/*!40000 ALTER TABLE `djcelery_intervalschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_intervalschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_periodictask`
--

DROP TABLE IF EXISTS `djcelery_periodictask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_periodictask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `interval_id` int(11) DEFAULT NULL,
  `crontab_id` int(11) DEFAULT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime DEFAULT NULL,
  `total_run_count` int(10) unsigned NOT NULL,
  `date_changed` datetime NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `djcelery_periodictask_8905f60d` (`interval_id`),
  KEY `djcelery_periodictask_7280124f` (`crontab_id`),
  CONSTRAINT `crontab_id_refs_id_286da0d1` FOREIGN KEY (`crontab_id`) REFERENCES `djcelery_crontabschedule` (`id`),
  CONSTRAINT `interval_id_refs_id_1829f358` FOREIGN KEY (`interval_id`) REFERENCES `djcelery_intervalschedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_periodictask`
--

LOCK TABLES `djcelery_periodictask` WRITE;
/*!40000 ALTER TABLE `djcelery_periodictask` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_periodictask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_periodictasks`
--

DROP TABLE IF EXISTS `djcelery_periodictasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_periodictasks`
--

LOCK TABLES `djcelery_periodictasks` WRITE;
/*!40000 ALTER TABLE `djcelery_periodictasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_periodictasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_taskstate`
--

DROP TABLE IF EXISTS `djcelery_taskstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_taskstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(64) NOT NULL,
  `task_id` varchar(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `tstamp` datetime NOT NULL,
  `args` longtext,
  `kwargs` longtext,
  `eta` datetime DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `result` longtext,
  `traceback` longtext,
  `runtime` double DEFAULT NULL,
  `retries` int(11) NOT NULL,
  `worker_id` int(11) DEFAULT NULL,
  `hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `djcelery_taskstate_5654bf12` (`state`),
  KEY `djcelery_taskstate_4da47e07` (`name`),
  KEY `djcelery_taskstate_abaacd02` (`tstamp`),
  KEY `djcelery_taskstate_cac6a03d` (`worker_id`),
  KEY `djcelery_taskstate_2ff6b945` (`hidden`),
  CONSTRAINT `worker_id_refs_id_6fd8ce95` FOREIGN KEY (`worker_id`) REFERENCES `djcelery_workerstate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_taskstate`
--

LOCK TABLES `djcelery_taskstate` WRITE;
/*!40000 ALTER TABLE `djcelery_taskstate` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_taskstate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `djcelery_workerstate`
--

DROP TABLE IF EXISTS `djcelery_workerstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `djcelery_workerstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) NOT NULL,
  `last_heartbeat` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `djcelery_workerstate_11e400ef` (`last_heartbeat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `djcelery_workerstate`
--

LOCK TABLES `djcelery_workerstate` WRITE;
/*!40000 ALTER TABLE `djcelery_workerstate` DISABLE KEYS */;
/*!40000 ALTER TABLE `djcelery_workerstate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_post`
--

DROP TABLE IF EXISTS `help_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_uuid` varchar(36) NOT NULL,
  `title` varchar(100) NOT NULL,
  `question` longtext NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `root_folder_id` int(11) DEFAULT NULL,
  `open` tinyint(1) NOT NULL,
  `submission_repository` longtext NOT NULL,
  `by_id` int(11) NOT NULL,
  `course_code_id` int(11) NOT NULL,
  `resolved` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `root_folder_id` (`root_folder_id`),
  KEY `help_post_e48e5091` (`by_id`),
  KEY `help_post_f4b0fac7` (`course_code_id`),
  CONSTRAINT `by_id_refs_id_b4ec1fc6` FOREIGN KEY (`by_id`) REFERENCES `review_reviewuser` (`id`),
  CONSTRAINT `course_code_id_refs_id_3bcf2890` FOREIGN KEY (`course_code_id`) REFERENCES `review_course` (`id`),
  CONSTRAINT `root_folder_id_refs_id_25ba46d5` FOREIGN KEY (`root_folder_id`) REFERENCES `review_sourcefolder` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_post`
--

LOCK TABLES `help_post` WRITE;
/*!40000 ALTER TABLE `help_post` DISABLE KEYS */;
INSERT INTO `help_post` VALUES (1,'5d600349-823b-40b8-8c77-6be7b7debb98','123','fdsaas','2014-09-24 05:50:17','2014-09-24 06:08:43',77,1,'https://github.com/avadendas/public_test_repo.git',2,1,1),(2,'7a00196e-0d95-4baf-aaf4-ecbff575c5a2','fdsa','fdsafsadfas','2014-09-24 06:08:54','2014-09-24 06:08:56',81,1,'https://github.com/avadendas/public_test_repo.git',2,1,0),(3,'b10550a2-68eb-476e-9a3b-3dcd6b9825c1','','','2014-09-29 01:07:20','2014-09-29 01:07:20',NULL,1,'',1,1,0),(4,'dfe7d2fc-da39-41c7-b6ea-ec78b8265374','1','1','2014-09-29 01:15:39','2014-09-29 01:15:42',NULL,1,'',1,1,0),(5,'dc8f76fb-6266-438c-8163-778d3d45aadc','','','2014-09-29 01:18:14','2014-09-29 01:18:16',NULL,1,'',1,1,0);
/*!40000 ALTER TABLE `help_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lti_ltiprofile`
--

DROP TABLE IF EXISTS `lti_ltiprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lti_ltiprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `roles` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_refs_id_7d1a1c0b` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lti_ltiprofile`
--

LOCK TABLES `lti_ltiprofile` WRITE;
/*!40000 ALTER TABLE `lti_ltiprofile` DISABLE KEYS */;
INSERT INTO `lti_ltiprofile` VALUES (1,27,NULL),(2,28,NULL),(33,53,NULL),(34,54,NULL),(35,55,NULL);
/*!40000 ALTER TABLE `lti_ltiprofile` ENABLE KEYS */;
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
  `multiple_submissions` tinyint(1) NOT NULL,
  `reviews_per_student` int(10) unsigned NOT NULL,
  `min_annotations` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_assignment_f4b0fac7` (`course_code_id`),
  CONSTRAINT `course_code_id_refs_id_2bfd7468` FOREIGN KEY (`course_code_id`) REFERENCES `review_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_assignment`
--

LOCK TABLES `review_assignment` WRITE;
/*!40000 ALTER TABLE `review_assignment` DISABLE KEYS */;
INSERT INTO `review_assignment` VALUES (1,'cfafd9e3-8555-416e-a42e-583b9a405d61','Learning 1','https://www.source-hosting.com/{username}/ass1/ ','2014-08-10 02:43:57','2014-08-10 02:43:57','2014-08-10 12:44:34','2014-08-10 02:43:57','2014-08-10 12:44:36',1,1,0,0),(4,'bdf53f3e-b8df-4d28-bd36-93af08b22639','fdasasdfas','asdfasd','2014-08-28 18:30:00','2014-08-27 10:40:00','2014-08-31 11:00:00','2014-08-28 10:40:00','2014-08-28 02:00:00',1,1,0,0),(5,'14513aed-5d95-4b3d-aa93-2e07f29c4f22','ASMT1','adlkfjadf','2014-09-18 11:16:29','2014-09-18 11:16:29','2014-12-31 21:16:51','2014-09-18 11:16:29','2015-01-01 21:17:12',1,1,3,4),(6,'7b9924ef-befb-4b02-8001-899a8f0117aa','SingleSubmit','adlkfjadlfkj','2014-09-18 11:17:25','2014-09-18 11:17:25','2014-12-31 21:17:37','2014-09-18 11:17:25','2014-12-31 21:17:47',1,1,3,0),(7,'16bd0aa6-a9ec-4db8-9776-abd4a70ec7db','ReviewNotOpen','dafadfadf','2014-09-18 11:17:58','2014-09-18 11:17:58','2014-11-30 21:18:09','2014-12-01 11:17:58','2014-12-31 21:18:17',1,1,2,0),(8,'103e76f4-2f56-490c-85b3-f6b2bb6f252d','Unsubmitted','aldkfjaldkfj','2014-09-20 09:48:41','2014-09-20 09:48:41','2014-12-31 19:49:00','2014-09-20 09:48:41','2014-12-31 19:49:11',1,1,0,0),(9,'6cc111f1-3b43-4613-8576-e53ad8450d12','test_tests','git','2014-09-24 08:10:02','2014-09-24 08:10:02','2014-09-28 01:30:00','2014-09-24 08:10:02','2014-09-28 02:30:00',1,1,0,0);
/*!40000 ALTER TABLE `review_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_assignmentreview`
--

DROP TABLE IF EXISTS `review_assignmentreview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_assignmentreview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `review_uuid` varchar(36) NOT NULL,
  `by_id` int(11) NOT NULL,
  `assignment_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `review_assignmentreview_e48e5091` (`by_id`),
  KEY `review_assignmentreview_52f7e0e7` (`assignment_id`),
  CONSTRAINT `assignment_id_refs_id_2ba15c2f` FOREIGN KEY (`assignment_id`) REFERENCES `review_assignment` (`id`),
  CONSTRAINT `by_id_refs_id_6d4be5b0` FOREIGN KEY (`by_id`) REFERENCES `review_reviewuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_assignmentreview`
--

LOCK TABLES `review_assignmentreview` WRITE;
/*!40000 ALTER TABLE `review_assignmentreview` DISABLE KEYS */;
INSERT INTO `review_assignmentreview` VALUES (1,'81c73f67-ee5f-4b4d-8adb-798d1afaaef3',1,5),(2,'13d38c90-0cc9-4ac7-8598-9fca20180ae5',2,5),(3,'d2fcf27e-55f4-4196-9a5f-ab023bc4ab83',18,5),(4,'15262398-5ae0-47cd-8ba6-7b5fc812cbaa',15,5),(5,'35de8ee7-9a46-442a-882d-2a28c90becfe',40,5),(6,'ed2cd1cb-36e5-4154-9825-12bb24f5919a',41,5),(7,'7c1e059d-7af8-432d-9f84-9bc99c1c475e',16,5);
/*!40000 ALTER TABLE `review_assignmentreview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_assignmentreview_submissions`
--

DROP TABLE IF EXISTS `review_assignmentreview_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_assignmentreview_submissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assignmentreview_id` int(11) NOT NULL,
  `assignmentsubmission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `review_assignmentrevi_assignmentreview_id_1610f4a55088b381_uniq` (`assignmentreview_id`,`assignmentsubmission_id`),
  KEY `review_assignmentreview_submissions_2d40173c` (`assignmentreview_id`),
  KEY `review_assignmentreview_submissions_2c3d191b` (`assignmentsubmission_id`),
  CONSTRAINT `assignmentreview_id_refs_id_70d2f230` FOREIGN KEY (`assignmentreview_id`) REFERENCES `review_assignmentreview` (`id`),
  CONSTRAINT `assignmentsubmission_id_refs_id_a2deca7c` FOREIGN KEY (`assignmentsubmission_id`) REFERENCES `review_assignmentsubmission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_assignmentreview_submissions`
--

LOCK TABLES `review_assignmentreview_submissions` WRITE;
/*!40000 ALTER TABLE `review_assignmentreview_submissions` DISABLE KEYS */;
INSERT INTO `review_assignmentreview_submissions` VALUES (22,1,24),(23,1,25),(1,1,26),(4,2,23),(25,2,25),(24,2,26),(31,3,23),(30,3,24),(18,3,26),(27,4,24),(26,4,25),(6,4,26),(7,5,23),(33,5,25),(32,5,26),(35,6,23),(34,6,24),(8,6,26),(28,7,23),(29,7,24),(15,7,25);
/*!40000 ALTER TABLE `review_assignmentreview_submissions` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `root_folder_id` (`root_folder_id`),
  KEY `review_assignmentsubmission_e48e5091` (`by_id`),
  KEY `review_assignmentsubmission_e7178437` (`submission_for_id`),
  CONSTRAINT `by_id_refs_id_a4fcd4d1` FOREIGN KEY (`by_id`) REFERENCES `review_reviewuser` (`id`),
  CONSTRAINT `root_folder_id_refs_id_55a751b9` FOREIGN KEY (`root_folder_id`) REFERENCES `review_sourcefolder` (`id`),
  CONSTRAINT `submission_for_id_refs_id_8d20aaf0` FOREIGN KEY (`submission_for_id`) REFERENCES `review_assignment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_assignmentsubmission`
--

LOCK TABLES `review_assignmentsubmission` WRITE;
/*!40000 ALTER TABLE `review_assignmentsubmission` DISABLE KEYS */;
INSERT INTO `review_assignmentsubmission` VALUES (1,'3936d9bd-278f-4105-aa81-a8575912cf53','2014-08-27 06:25:14',1,'fdsafsa',1,0,1),(16,'8951dd83-fb1b-4abd-bdcf-4bc45691ae27','2014-08-28 07:13:43',2,'https://github.com/avadendas/public_test_repo.git',4,0,13),(20,'07394121-a571-4680-b92d-c9602cddca4e','2014-09-18 11:22:02',15,'https://github.com/avadendas/public_test_repo.git',6,0,17),(21,'abeafb27-01f3-4eab-b349-6d3191bd320b','2014-09-18 11:24:40',15,'https://github.com/avadendas/public_test_repo.git',5,0,21),(22,'31b5a3b5-b40b-47ff-8d19-10aa8f701f1e','2014-09-18 11:25:33',15,'https://github.com/avadendas/private_test_repo.git',5,0,NULL),(23,'d1ee5fd9-e00b-49da-bf1e-f7e5662c1771','2014-09-18 11:27:07',15,'git@github.com:avadendas/private_test_repo.git',5,0,25),(24,'24637e52-9f88-4571-a174-9bd050af261a','2014-09-18 12:31:03',40,'git@github.com:avadendas/private_test_repo.git',5,0,29),(25,'c51271c5-6758-4310-b713-b7a211ff884b','2014-09-18 12:33:24',41,'git@github.com:avadendas/private_test_repo.git',5,0,33),(26,'95c907a2-f944-453f-8a1b-e3222977b734','2014-09-18 12:33:53',16,'git@github.com:avadendas/private_test_repo.git',5,0,37),(27,'2c5d1507-6892-4d92-872c-8759800d6016','2014-09-22 01:28:07',2,'https://github.com/avadendas/public_test_repo.git',5,0,46),(28,'cc04176b-21dc-410a-bdd3-b2d01acb16fe','2014-09-22 04:16:12',1,'https://github.com/avadendas/public_test_repo.git',6,0,54),(29,'96964638-8bac-4fc8-9db6-6000691aa7d5','2014-09-24 05:12:16',1,'https://github.com/avadendas/public_test_repo.git',5,0,58),(30,'46b26379-3267-4ea6-9eb7-61a8979679f7','2014-09-24 05:45:09',2,'https://github.com/avadendas/public_test_repo.git',6,0,62),(31,'f33360d9-2435-498f-9d93-d2435899201f','2014-09-24 05:45:32',2,'https://github.com/avadendas/public_test_repo.git',7,0,66),(32,'5e177ea8-d9be-40bd-9feb-54b3a2bd9d87','2014-09-24 05:48:41',2,'https://github.com/avadendas/public_test_repo.git',7,0,69),(33,'e78cd5a9-ccf2-48f1-9063-6a03c5db8570','2014-09-24 05:48:50',2,'https://github.com/avadendas/public_test_repo.git',7,0,73);
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
-- Table structure for table `review_enrol`
--

DROP TABLE IF EXISTS `review_enrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_enrol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `student` tinyint(1) NOT NULL,
  `tutor` tinyint(1) NOT NULL,
  `staff` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_enrol_6340c63c` (`user_id`),
  KEY `review_enrol_6234103b` (`course_id`),
  CONSTRAINT `course_id_refs_id_7b893f9d` FOREIGN KEY (`course_id`) REFERENCES `review_course` (`id`),
  CONSTRAINT `user_id_refs_id_22326da7` FOREIGN KEY (`user_id`) REFERENCES `review_reviewuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_enrol`
--

LOCK TABLES `review_enrol` WRITE;
/*!40000 ALTER TABLE `review_enrol` DISABLE KEYS */;
INSERT INTO `review_enrol` VALUES (1,2,53,0,1,0),(2,2,53,0,1,0);
/*!40000 ALTER TABLE `review_enrol` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_reviewuser`
--

LOCK TABLES `review_reviewuser` WRITE;
/*!40000 ALTER TABLE `review_reviewuser` DISABLE KEYS */;
INSERT INTO `review_reviewuser` VALUES (1,'99ffcc68-a9c4-450d-b74c-8acc976b206d',2,0,0),(2,'1bd5f565-47fc-4a12-ae32-22d8188b93ae',1,0,0),(3,'be808ac9-0bc8-4b2f-909a-2332fe4d4149',3,0,1),(4,'9cafb4e6-3a2a-4f2c-bbe8-9659ee9f69ad',8,1,1),(15,'9403e793-8dcf-4378-81df-ae777abe4051',23,0,1),(16,'f108a046-484d-4d4d-b120-ca5bf332a60f',24,0,1),(17,'439c4bee-f2f3-4f84-a43d-eea6e27174c1',25,1,0),(18,'32005413-971d-4756-8c4c-b9086424fa26',26,0,1),(19,'d43dc24c-3184-4df0-b17b-2ec1e0af0ebd',27,0,1),(40,'d36e557c-fb24-4b08-9958-9d3ef587ef6b',53,0,1),(41,'07df2849-33a0-437c-868f-4af10dde1f5f',28,0,1),(42,'93c8443d-37fc-48d9-90b0-60a5405c8dcb',54,0,1),(43,'2e9d72e5-73dd-4485-a36d-a86a45e8d061',55,0,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=2837 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_reviewuser_courses`
--

LOCK TABLES `review_reviewuser_courses` WRITE;
/*!40000 ALTER TABLE `review_reviewuser_courses` DISABLE KEYS */;
INSERT INTO `review_reviewuser_courses` VALUES (1,1,1),(617,2,1),(618,2,2),(619,2,3),(620,2,4),(621,2,5),(622,2,6),(623,2,7),(624,2,8),(625,2,9),(626,2,10),(627,2,11),(628,2,12),(629,2,13),(630,2,14),(631,2,15),(632,2,16),(633,2,17),(634,2,18),(635,2,19),(636,2,20),(637,2,21),(638,2,22),(639,2,23),(640,2,24),(641,2,25),(642,2,26),(643,2,27),(644,2,28),(645,2,29),(646,2,30),(647,2,31),(648,2,32),(649,2,33),(650,2,34),(651,2,35),(652,2,36),(653,2,37),(654,2,38),(655,2,39),(656,2,40),(657,2,41),(658,2,42),(659,2,43),(660,2,44),(661,2,45),(662,2,46),(663,2,47),(664,2,48),(665,2,49),(666,2,50),(667,2,51),(668,2,52),(669,2,53),(670,2,54),(671,2,55),(672,2,56),(673,2,57),(674,2,58),(675,2,59),(676,2,60),(677,2,61),(678,2,62),(679,2,63),(680,2,64),(681,2,65),(682,2,66),(683,2,67),(684,2,68),(685,2,69),(686,2,70),(687,2,71),(688,2,72),(689,2,73),(690,2,74),(691,2,75),(692,2,76),(693,2,77),(694,2,78),(695,2,79),(696,2,80),(697,2,81),(698,2,82),(699,2,83),(700,2,84),(701,2,85),(702,2,86),(703,2,87),(704,2,88),(705,2,89),(706,2,90),(707,2,91),(708,2,92),(709,2,93),(710,2,94),(711,2,95),(712,2,96),(713,2,97),(714,2,98),(715,2,99),(716,2,100),(717,2,101),(718,2,102),(719,2,103),(720,2,104),(721,2,105),(722,2,106),(723,2,107),(724,2,108),(725,2,109),(726,2,110),(727,2,111),(728,2,112),(729,2,113),(730,2,114),(731,2,115),(732,2,116),(733,2,117),(734,2,118),(735,2,119),(736,2,120),(737,2,121),(738,2,122),(739,2,123),(740,2,124),(741,2,125),(742,2,126),(743,2,127),(744,2,128),(745,2,129),(746,2,130),(747,2,131),(748,2,132),(749,2,133),(750,2,134),(751,2,135),(752,2,136),(753,2,137),(754,2,138),(755,2,139),(756,2,140),(757,2,141),(758,2,142),(759,2,143),(760,2,144),(761,2,145),(762,2,146),(763,2,147),(764,2,148),(765,2,149),(766,2,150),(767,2,151),(768,2,152),(769,2,153),(770,2,154),(771,2,155),(772,2,156),(773,2,157),(774,2,158),(775,2,159),(776,2,160),(777,2,161),(778,2,162),(779,2,163),(780,2,164),(781,2,165),(782,2,166),(783,2,167),(784,2,168),(785,2,169),(786,2,170),(787,2,171),(788,2,172),(789,2,173),(790,2,174),(791,2,175),(792,2,176),(793,2,177),(794,2,178),(795,2,179),(796,2,180),(797,2,181),(798,2,182),(799,2,183),(800,2,184),(801,2,185),(802,2,186),(803,2,187),(804,2,188),(805,2,189),(806,2,190),(807,2,191),(808,2,192),(809,2,193),(810,2,194),(811,2,195),(812,2,196),(813,2,197),(814,2,198),(815,2,199),(816,2,200),(1225,3,2),(1226,3,3),(1227,3,4),(1228,3,5),(1229,3,6),(1230,3,7),(1231,3,8),(1232,3,9),(1233,3,10),(1234,3,11),(1235,3,12),(1236,3,13),(1237,3,14),(1238,3,15),(1239,3,16),(1240,3,17),(1241,3,18),(1242,3,19),(1243,3,20),(1244,3,21),(1245,3,22),(1246,3,23),(1247,3,24),(1248,3,25),(1249,3,26),(1250,3,27),(1251,3,28),(1252,3,29),(1253,3,30),(1254,3,31),(1255,3,32),(1256,3,33),(1257,3,34),(1258,3,35),(1259,3,36),(1260,3,37),(1261,3,38),(1262,3,39),(1263,3,40),(1264,3,41),(1265,3,42),(1266,3,43),(1267,3,44),(1268,3,45),(1269,3,46),(1270,3,47),(1271,3,48),(1272,3,49),(1273,3,50),(1274,3,51),(1275,3,52),(1276,3,53),(1277,3,54),(1278,3,55),(1279,3,56),(1280,3,57),(1281,3,58),(1282,3,59),(1283,3,60),(1284,3,61),(1285,3,62),(1286,3,63),(1287,3,64),(1288,3,65),(1289,3,66),(1290,3,67),(1291,3,68),(1292,3,69),(1293,3,70),(1294,3,71),(1295,3,72),(1296,3,73),(1297,3,74),(1298,3,75),(1299,3,76),(1300,3,77),(1301,3,78),(1302,3,79),(1303,3,80),(1304,3,81),(1305,3,82),(1306,3,83),(1307,3,84),(1308,3,85),(1309,3,86),(1310,3,87),(1311,3,88),(1312,3,89),(1313,3,90),(1314,3,91),(1315,3,92),(1316,3,93),(1317,3,94),(1318,3,95),(1319,3,96),(1320,3,97),(1321,3,98),(1322,3,99),(1323,3,100),(1324,3,101),(1325,3,102),(1326,3,103),(1327,3,104),(1328,3,105),(1329,3,106),(1330,3,107),(1331,3,108),(1332,3,109),(1333,3,110),(1334,3,111),(1335,3,112),(1336,3,113),(1337,3,114),(1338,3,115),(1339,3,116),(1340,3,117),(1341,3,118),(1342,3,119),(1343,3,120),(1344,3,121),(1345,3,122),(1346,3,123),(1347,3,124),(1348,3,125),(1349,3,126),(1350,3,127),(1351,3,128),(1352,3,129),(1353,3,130),(1354,3,131),(1355,3,132),(1356,3,133),(1357,3,134),(1358,3,135),(1359,3,136),(1360,3,137),(1361,3,138),(1362,3,139),(1363,3,140),(1364,3,141),(1365,3,142),(1366,3,143),(1367,3,144),(1368,3,145),(1369,3,146),(1370,3,147),(1371,3,148),(1372,3,149),(1373,3,150),(1374,3,151),(1375,3,152),(1376,3,153),(1377,3,154),(1378,3,155),(1379,3,156),(1380,3,157),(1381,3,158),(1382,3,159),(1383,3,160),(1384,3,161),(1385,3,162),(1386,3,163),(1387,3,164),(1388,3,165),(1389,3,166),(1390,3,167),(1391,3,168),(1392,3,169),(1393,3,170),(1394,3,171),(1395,3,172),(1396,3,173),(1397,3,174),(1398,3,175),(1399,3,176),(1400,3,177),(1401,3,178),(1402,3,179),(1403,3,180),(1404,3,181),(1405,3,182),(1406,3,183),(1407,3,184),(1408,3,185),(1409,3,186),(1410,3,187),(1411,3,188),(1412,3,189),(1413,3,190),(1414,3,191),(1415,3,192),(1416,3,193),(1417,3,194),(1418,3,195),(1419,3,196),(1420,3,197),(1421,3,198),(1422,3,199),(1423,3,200),(1217,15,1),(1218,15,5),(1219,15,53),(1425,16,1),(1426,16,50),(1427,16,53),(817,18,1),(818,18,2),(819,18,3),(820,18,4),(821,18,5),(822,18,6),(823,18,7),(824,18,8),(825,18,9),(826,18,10),(827,18,11),(828,18,12),(829,18,13),(830,18,14),(831,18,15),(832,18,16),(833,18,17),(834,18,18),(835,18,19),(836,18,20),(837,18,21),(838,18,22),(839,18,23),(840,18,24),(841,18,25),(842,18,26),(843,18,27),(844,18,28),(845,18,29),(846,18,30),(847,18,31),(848,18,32),(849,18,33),(850,18,34),(851,18,35),(852,18,36),(853,18,37),(854,18,38),(855,18,39),(856,18,40),(857,18,41),(858,18,42),(859,18,43),(860,18,44),(861,18,45),(862,18,46),(863,18,47),(864,18,48),(865,18,49),(866,18,50),(867,18,51),(868,18,52),(869,18,53),(870,18,54),(871,18,55),(872,18,56),(873,18,57),(874,18,58),(875,18,59),(876,18,60),(877,18,61),(878,18,62),(879,18,63),(880,18,64),(881,18,65),(882,18,66),(883,18,67),(884,18,68),(885,18,69),(886,18,70),(887,18,71),(888,18,72),(889,18,73),(890,18,74),(891,18,75),(892,18,76),(893,18,77),(894,18,78),(895,18,79),(896,18,80),(897,18,81),(898,18,82),(899,18,83),(900,18,84),(901,18,85),(902,18,86),(903,18,87),(904,18,88),(905,18,89),(906,18,90),(907,18,91),(908,18,92),(909,18,93),(910,18,94),(911,18,95),(912,18,96),(913,18,97),(914,18,98),(915,18,99),(916,18,100),(917,18,101),(918,18,102),(919,18,103),(920,18,104),(921,18,105),(922,18,106),(923,18,107),(924,18,108),(925,18,109),(926,18,110),(927,18,111),(928,18,112),(929,18,113),(930,18,114),(931,18,115),(932,18,116),(933,18,117),(934,18,118),(935,18,119),(936,18,120),(937,18,121),(938,18,122),(939,18,123),(940,18,124),(941,18,125),(942,18,126),(943,18,127),(944,18,128),(945,18,129),(946,18,130),(947,18,131),(948,18,132),(949,18,133),(950,18,134),(951,18,135),(952,18,136),(953,18,137),(954,18,138),(955,18,139),(956,18,140),(957,18,141),(958,18,142),(959,18,143),(960,18,144),(961,18,145),(962,18,146),(963,18,147),(964,18,148),(965,18,149),(966,18,150),(967,18,151),(968,18,152),(969,18,153),(970,18,154),(971,18,155),(972,18,156),(973,18,157),(974,18,158),(975,18,159),(976,18,160),(977,18,161),(978,18,162),(979,18,163),(980,18,164),(981,18,165),(982,18,166),(983,18,167),(984,18,168),(985,18,169),(986,18,170),(987,18,171),(988,18,172),(989,18,173),(990,18,174),(991,18,175),(992,18,176),(993,18,177),(994,18,178),(995,18,179),(996,18,180),(997,18,181),(998,18,182),(999,18,183),(1000,18,184),(1001,18,185),(1002,18,186),(1003,18,187),(1004,18,188),(1005,18,189),(1006,18,190),(1007,18,191),(1008,18,192),(1009,18,193),(1010,18,194),(1011,18,195),(1012,18,196),(1013,18,197),(1014,18,198),(1015,18,199),(1016,18,200),(1428,19,2),(1429,19,3),(1430,19,4),(1431,19,5),(1432,19,6),(1433,19,7),(1434,19,8),(1435,19,9),(1436,19,10),(1437,19,11),(1438,19,12),(1439,19,13),(1440,19,14),(1441,19,15),(1442,19,16),(1443,19,17),(1444,19,18),(1445,19,19),(1446,19,20),(1447,19,21),(1448,19,22),(1449,19,23),(1450,19,24),(1451,19,25),(1452,19,26),(1453,19,27),(1454,19,28),(1455,19,29),(1456,19,30),(1457,19,31),(1458,19,32),(1459,19,33),(1460,19,34),(1461,19,35),(1462,19,36),(1463,19,37),(1464,19,38),(1465,19,39),(1466,19,40),(1467,19,41),(1468,19,42),(1469,19,43),(1470,19,44),(1471,19,45),(1472,19,46),(1473,19,47),(1474,19,48),(1475,19,49),(1476,19,50),(1477,19,51),(1478,19,52),(1479,19,53),(1480,19,54),(1481,19,55),(1482,19,56),(1483,19,57),(1484,19,58),(1485,19,59),(1486,19,60),(1487,19,61),(1488,19,62),(1489,19,63),(1490,19,64),(1491,19,65),(1492,19,66),(1493,19,67),(1494,19,68),(1495,19,69),(1496,19,70),(1497,19,71),(1498,19,72),(1499,19,73),(1500,19,74),(1501,19,75),(1502,19,76),(1503,19,77),(1504,19,78),(1505,19,79),(1506,19,80),(1507,19,81),(1508,19,82),(1509,19,83),(1510,19,84),(1511,19,85),(1512,19,86),(1513,19,87),(1514,19,88),(1515,19,89),(1516,19,90),(1517,19,91),(1518,19,92),(1519,19,93),(1520,19,94),(1521,19,95),(1522,19,96),(1523,19,97),(1524,19,98),(1525,19,99),(1526,19,100),(1527,19,101),(1528,19,102),(1529,19,103),(1530,19,104),(1531,19,105),(1532,19,106),(1533,19,107),(1534,19,108),(1535,19,109),(1536,19,110),(1537,19,111),(1538,19,112),(1539,19,113),(1540,19,114),(1541,19,115),(1542,19,116),(1543,19,117),(1544,19,118),(1545,19,119),(1546,19,120),(1547,19,121),(1548,19,122),(1549,19,123),(1550,19,124),(1551,19,125),(1552,19,126),(1553,19,127),(1554,19,128),(1555,19,129),(1556,19,130),(1557,19,131),(1558,19,132),(1559,19,133),(1560,19,134),(1561,19,135),(1562,19,136),(1563,19,137),(1564,19,138),(1565,19,139),(1566,19,140),(1567,19,141),(1568,19,142),(1569,19,143),(1570,19,144),(1571,19,145),(1572,19,146),(1573,19,147),(1574,19,148),(1575,19,149),(1576,19,150),(1577,19,151),(1578,19,152),(1579,19,153),(1580,19,154),(1581,19,155),(1582,19,156),(1583,19,157),(1584,19,158),(1585,19,159),(1586,19,160),(1587,19,161),(1588,19,162),(1589,19,163),(1590,19,164),(1591,19,165),(1592,19,166),(1593,19,167),(1594,19,168),(1595,19,169),(1596,19,170),(1597,19,171),(1598,19,172),(1599,19,173),(1600,19,174),(1601,19,175),(1602,19,176),(1603,19,177),(1604,19,178),(1605,19,179),(1606,19,180),(1607,19,181),(1608,19,182),(1609,19,183),(1610,19,184),(1611,19,185),(1612,19,186),(1613,19,187),(1614,19,188),(1615,19,189),(1616,19,190),(1617,19,191),(1618,19,192),(1619,19,193),(1620,19,194),(1621,19,195),(1622,19,196),(1623,19,197),(1624,19,198),(1625,19,199),(1626,19,200),(1223,40,1),(1224,40,3),(1424,41,1),(1627,42,53),(1628,43,1),(1629,43,2),(1630,43,3),(1631,43,4),(1632,43,5),(1633,43,6),(1634,43,7),(1635,43,8),(1636,43,9),(1637,43,10),(1638,43,11),(1639,43,12),(1640,43,13),(1641,43,14),(1642,43,15),(1643,43,16),(1644,43,17),(1645,43,18),(1646,43,19),(1647,43,20),(1648,43,21),(1649,43,22),(1650,43,23),(1651,43,24),(1652,43,25),(1653,43,26),(1654,43,27),(1655,43,28),(1656,43,29),(1657,43,30),(1658,43,31),(1659,43,32),(1660,43,33),(1661,43,34),(1662,43,35),(1663,43,36),(1664,43,37),(1665,43,38),(1666,43,39),(1667,43,40),(1668,43,41),(1669,43,42),(1670,43,43),(1671,43,44),(1672,43,45),(1673,43,46),(1674,43,47),(1675,43,48),(1676,43,49),(1677,43,50),(1678,43,51),(1679,43,52),(1680,43,53),(1681,43,54),(1682,43,55),(1683,43,56),(1684,43,57),(1685,43,58),(1686,43,59),(1687,43,60),(1688,43,61),(1689,43,62),(1690,43,63),(1691,43,64),(1692,43,65),(1693,43,66),(1694,43,67),(1695,43,68),(1696,43,69),(1697,43,70),(1698,43,71),(1699,43,72),(1700,43,73),(1701,43,74),(1702,43,75),(1703,43,76),(1704,43,77),(1705,43,78),(1706,43,79),(1707,43,80),(1708,43,81),(1709,43,82),(1710,43,83),(1711,43,84),(1712,43,85),(1713,43,86),(1714,43,87),(1715,43,88),(1716,43,89),(1717,43,90),(1718,43,91),(1719,43,92),(1720,43,93),(1721,43,94),(1722,43,95),(1723,43,96),(1724,43,97),(1725,43,98),(1726,43,99),(1727,43,100),(1728,43,101),(1729,43,102),(1730,43,103),(1731,43,104),(1732,43,105),(1733,43,106),(1734,43,107),(1735,43,108),(1736,43,109),(1737,43,110),(1738,43,111),(1739,43,112),(1740,43,113),(1741,43,114),(1742,43,115),(1743,43,116),(1744,43,117),(1745,43,118),(1746,43,119),(1747,43,120),(1748,43,121),(1749,43,122),(1750,43,123),(1751,43,124),(1752,43,125),(1753,43,126),(1754,43,127),(1755,43,128),(1756,43,129),(1757,43,130),(1758,43,131),(1759,43,132),(1760,43,133),(1761,43,134),(1762,43,135),(1763,43,136),(1764,43,137),(1765,43,138),(1766,43,139),(1767,43,140),(1768,43,141),(1769,43,142),(1770,43,143),(1771,43,144),(1772,43,145),(1773,43,146),(1774,43,147),(1775,43,148),(1776,43,149),(1777,43,150),(1778,43,151),(1779,43,152),(1780,43,153),(1781,43,154),(1782,43,155),(1783,43,156),(1784,43,157),(1785,43,158),(1786,43,159),(1787,43,160),(1788,43,161),(1789,43,162),(1790,43,163),(1791,43,164),(1792,43,165),(1793,43,166),(1794,43,167),(1795,43,168),(1796,43,169),(1797,43,170),(1798,43,171),(1799,43,172),(1800,43,173),(1801,43,174),(1802,43,175),(1803,43,176),(1804,43,177),(1805,43,178),(1806,43,179),(1807,43,180),(1808,43,181),(1809,43,182),(1810,43,183),(1811,43,184),(1812,43,185),(1813,43,186),(1814,43,187),(1815,43,188),(1816,43,189),(1817,43,190),(1818,43,191),(1819,43,192),(1820,43,193),(1821,43,194),(1822,43,195),(1823,43,196),(1824,43,197),(1825,43,198),(1826,43,199),(1827,43,200);
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
  `submission_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `review_sourceannotation_6340c63c` (`user_id`),
  KEY `review_sourceannotation_a34b03a6` (`source_id`),
  KEY `review_sourceannotation_efe1f810` (`submission_id`),
  CONSTRAINT `source_id_refs_id_ff216b20` FOREIGN KEY (`source_id`) REFERENCES `review_sourcefile` (`id`),
  CONSTRAINT `submission_id_refs_id_4d2ce0e1` FOREIGN KEY (`submission_id`) REFERENCES `review_assignmentsubmission` (`id`),
  CONSTRAINT `user_id_refs_id_c5e486c3` FOREIGN KEY (`user_id`) REFERENCES `review_reviewuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourceannotation`
--

LOCK TABLES `review_sourceannotation` WRITE;
/*!40000 ALTER TABLE `review_sourceannotation` DISABLE KEYS */;
INSERT INTO `review_sourceannotation` VALUES (2,'81acc48c-3cb7-4f68-ae16-c851ff7f2f0a',1,11,'2014-08-28 07:14:01','2014-08-28 07:14:01','fdsafsda','fdsa',NULL),(4,'2af5e58d-b727-49dd-9c4c-dda9f36cd207',2,14,'2014-08-29 01:54:02','2014-08-29 01:54:02','43242','43242',NULL),(10,'599ed2d2-f56a-4c23-9ed2-e8be6aed33ed',2,11,'2014-08-29 02:03:06','2014-08-29 02:03:06','textest','textest',NULL),(11,'0a3a64a5-010b-4953-8ec9-a75cedb3e13a',2,11,'2014-08-29 02:04:50','2014-08-29 02:04:50','test','test',NULL),(12,'d3210b47-074c-49a1-b187-2c96991f24bb',2,11,'2014-08-29 02:10:33','2014-08-29 02:10:33','testajax','testajax',NULL),(19,'c9dc6a87-2343-4f85-bd50-3e36222ed567',2,11,'2014-08-29 06:09:46','2014-08-29 06:09:46','<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\ntestestes</textarea>','<textarea cols=\"40\" id=\"id_text\" name=\"text\" rows=\"10\">\r\ntestestes</textarea>',NULL),(20,'3d2774e1-fa48-4e61-bf2f-cd37411dc28c',2,11,'2014-08-29 06:10:31','2014-08-29 06:10:31','testestes','testestes',NULL),(21,'7c6ff312-44ab-46d2-8138-44b331d96214',2,11,'2014-08-29 06:11:03','2014-08-29 06:11:03','stuff','stuff',NULL),(22,'b0922f85-e55f-4c2c-a300-c01f695f4bf7',2,14,'2014-08-29 06:11:35','2014-08-29 06:11:35','This code is bullshit','This code is bullshit',NULL),(23,'8fce94b8-f1c1-4e68-a6a3-8cbfaaf3a4b4',2,14,'2014-08-29 06:23:00','2014-08-29 06:23:00','two','two',NULL),(24,'9992c393-a883-4c46-8628-59ff71173380',2,11,'2014-08-29 06:25:24','2014-08-29 06:25:24','fdnsabcoiadngi43hb80rvjq3','fdnsabcoiadngi43hb80rvjq3',NULL),(31,'dc13d3f3-9cfa-4424-8b16-19cccbb2b463',2,23,'2014-09-18 11:42:50','2014-09-18 11:42:50','This be a mighty annotation!!!','This be a mighty annotation!!!',23),(32,'9ede6b76-35ff-404f-acf9-9d137a702dbf',2,25,'2014-09-18 11:42:57','2014-09-18 11:42:57','Arrrr\r\n','Arrrr\r\n',23),(33,'58dd1732-b0d1-46cc-ac1f-07a519891bc4',2,25,'2014-09-18 11:43:06','2014-09-18 11:43:06','This be a quality critique!','This be a quality critique!',23),(34,'f0e5db0e-71cd-44d8-85f6-8b2e548b87d8',40,23,'2014-09-18 13:47:43','2014-09-18 13:47:43','adfadf','adfadf',23),(35,'82dcb97a-3992-4ac7-b839-40790787ffe2',40,23,'2014-09-18 13:47:52','2014-09-18 13:47:52','2nd annotation','2nd annotation',23),(36,'c858183c-09ff-4084-9563-07c4e7d8a39c',40,23,'2014-09-18 13:48:02','2014-09-18 13:48:02','THird annotation\r\n','THird annotation\r\n',23),(37,'7950e707-389e-44e2-9899-a4f921324995',40,23,'2014-09-18 13:48:08','2014-09-18 13:48:08','4th annotation','4th annotation',23),(38,'fda8c777-65ec-4696-8450-995fec3a0925',40,31,'2014-09-20 09:23:53','2014-09-20 09:23:53','This is annotation 1','This is annotation 1',25),(41,'b74d1137-c076-42ad-9d54-b94dd58d0b8d',1,2,'2014-09-22 04:02:47','2014-09-22 04:02:47','asfsa','asfsa',NULL),(79,'ac716650-307e-4465-a17a-c7e28b4ba908',1,50,'2014-09-23 12:58:54','2014-09-23 12:58:54','fda','fda',NULL),(80,'e13138a9-ea4b-472a-a447-e0701947db01',1,50,'2014-09-23 12:59:46','2014-09-23 12:59:46','gfds','gfds',NULL),(82,'63395f03-2919-4eea-82ba-5d8a6975017c',1,50,'2014-09-23 13:05:12','2014-09-23 13:05:12','fdsafas\r\n\r\n','fdsafas\r\n\r\n',NULL),(84,'9e10a4fc-c4ea-46eb-9534-ca46e25d0152',1,50,'2014-09-23 13:15:38','2014-09-23 13:15:38','fsdafsa','fsdafsa',NULL),(85,'307eac0c-d42b-47f4-8f2a-6fad9c85544f',1,50,'2014-09-24 01:22:59','2014-09-24 01:22:59','fdsafdsafdsafasd','fdsafdsafdsafasd',NULL),(86,'728d70cd-34de-4752-98b5-3a340a433df7',1,50,'2014-09-24 01:23:58','2014-09-24 01:23:58','dasdsafdsa','dasdsafdsa',NULL),(90,'0a4ae01e-719a-4088-aa81-77b0fe482d92',1,47,'2014-09-24 05:42:34','2014-09-24 05:42:34','fdsafdsa','fdsafdsa',28),(108,'748008bd-59a6-4fce-a5a6-4c12d7a8c1fc',2,13,'2014-09-25 04:24:15','2014-09-25 04:24:15','fdsa','fdsa',16),(109,'2591d04e-173d-4364-9d07-1a16986d5695',2,13,'2014-09-25 04:24:21','2014-09-25 04:24:21','fdsa','fdsa',16),(111,'bbfb85f3-c81a-496f-a536-ff9f5b2df2e9',1,49,'2014-09-25 04:59:52','2014-09-25 04:59:52','fjdsklafjkdlsa','fjdsklafjkdlsa',28),(112,'3e8a91e8-b759-4e78-9a72-b99a87d6f020',1,49,'2014-09-25 05:03:32','2014-09-25 05:03:32','ghfggh','ghfggh',28),(113,'e52f89af-3cae-4007-a3aa-b7cee13caaa4',1,49,'2014-09-25 05:03:37','2014-09-25 05:03:37','cghfjgfghf','cghfjgfghf',28),(114,'a0f7437c-b872-4f53-92f6-3ad8067f4492',2,74,'2014-09-25 08:11:15','2014-09-25 08:11:15','fsda','fsda',NULL),(115,'e85727f2-09ef-405a-9367-cdfd5546d28c',2,42,'2014-09-25 08:11:34','2014-09-25 08:11:34','fsa','fsa',27),(116,'4372596e-7daa-4b77-aac8-be5e03185c8b',2,77,'2014-09-25 08:12:00','2014-09-25 08:12:00','fdas','fdas',NULL),(120,'ec63a137-899a-438b-8149-5855e990eb38',2,41,'2014-09-25 10:40:29','2014-09-25 10:40:29','fdsa','fdsa',27);
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
  `start` int(10) unsigned NOT NULL,
  `end` int(10) unsigned NOT NULL,
  `startOffset` int(10) unsigned NOT NULL,
  `endOffset` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_sourceannotationrange_e92f1259` (`range_annotation_id`),
  CONSTRAINT `range_annotation_id_refs_id_2e0dc21e` FOREIGN KEY (`range_annotation_id`) REFERENCES `review_sourceannotation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourceannotationrange`
--

LOCK TABLES `review_sourceannotationrange` WRITE;
/*!40000 ALTER TABLE `review_sourceannotationrange` DISABLE KEYS */;
INSERT INTO `review_sourceannotationrange` VALUES (2,2,1,2,1,2),(3,4,1,2,1,2),(9,10,3213,1342134,3213,1342134),(10,11,1,4,1,4),(11,12,1,4,1,4),(15,19,1,2,1,2),(16,20,1,2,1,2),(17,21,2,423,2,423),(18,22,3,4,3,4),(19,23,1,2,1,2),(20,24,3123,2143215,3123,2143215),(27,31,1,0,1,0),(28,32,1,0,1,0),(29,33,1,0,1,0),(30,34,1,0,1,0),(31,35,1,0,1,0),(32,36,1,0,1,0),(33,37,1,0,1,0),(34,38,1,0,1,0),(37,41,1,0,1,0),(75,79,4,0,4,0),(76,80,6,0,6,0),(78,82,3,0,3,0),(80,84,1,0,1,0),(81,85,5,0,5,0),(82,86,4,0,4,0),(86,90,1,0,1,0),(104,108,3,0,3,0),(105,109,4,0,4,0),(107,111,3,0,3,0),(108,112,2,0,2,0),(109,113,4,0,4,0),(110,114,2,0,2,0),(111,115,1,0,1,0),(112,116,1,0,1,0),(116,120,5,0,5,0);
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
  `file` varchar(1000) NOT NULL,
  `submission_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `review_sourcefile_3aef490b` (`folder_id`),
  KEY `review_sourcefile_efe1f810` (`submission_id`),
  CONSTRAINT `folder_id_refs_id_64e8f40a` FOREIGN KEY (`folder_id`) REFERENCES `review_sourcefolder` (`id`),
  CONSTRAINT `submission_id_refs_id_f0663b5b` FOREIGN KEY (`submission_id`) REFERENCES `review_assignmentsubmission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourcefile`
--

LOCK TABLES `review_sourcefile` WRITE;
/*!40000 ALTER TABLE `review_sourcefile` DISABLE KEYS */;
INSERT INTO `review_sourcefile` VALUES (2,1,'55380bab-58c1-49a5-b4e9-7bd7a5e55dea','urls','source-files/2014-08-27/05-06/10-236115/urls.py',NULL),(11,13,'c914afba-c8e4-4554-9ae8-c9fc8618a617','rootfile.txt','ABCD1234/fdasasdfas/admin_2014-08-28_07-13-43/rootfile.txt',NULL),(12,14,'90488735-a8af-4282-82ce-f3e59a55a5e3','folder1_testfile.txt','ABCD1234/fdasasdfas/admin_2014-08-28_07-13-43/folder1/folder1_testfile.txt',NULL),(13,15,'7eae9f3b-bf54-481c-a7a1-0ff897a66e20','folder1-sub-testfile.py','ABCD1234/fdasasdfas/admin_2014-08-28_07-13-43/folder1/folder1-sub/folder1-sub-testfile.py',NULL),(14,16,'8e299c63-5706-4423-95e2-9e69431c99ac','folder2_testfile.py','ABCD1234/fdasasdfas/admin_2014-08-28_07-13-43/folder2/folder2_testfile.py',NULL),(15,17,'45721683-4db7-437a-961c-01467c06a852','rootfile.txt','ABCD1234/SingleSubmit/s0123456_2014-09-18_11-22-02/rootfile.txt',20),(16,18,'bdb6f6fa-f481-4d5e-99fe-4ca908a33ca4','folder1_testfile.txt','ABCD1234/SingleSubmit/s0123456_2014-09-18_11-22-02/folder1/folder1_testfile.txt',20),(17,19,'1f5c6d6c-7dd1-4934-9caa-8fd3bd9641a6','folder1-sub-testfile.py','ABCD1234/SingleSubmit/s0123456_2014-09-18_11-22-02/folder1/folder1-sub/folder1-sub-testfile.py',20),(18,20,'9c03a196-6c48-434a-a413-62dfba9d1772','folder2_testfile.py','ABCD1234/SingleSubmit/s0123456_2014-09-18_11-22-02/folder2/folder2_testfile.py',20),(19,21,'57000403-0d52-4ded-96d2-cd8ceb2feedf','rootfile.txt','ABCD1234/ASMT1/s0123456_2014-09-18_11-24-40/rootfile.txt',21),(20,22,'2fb7d8b4-6f5d-49d3-aef4-920303c4209e','folder1_testfile.txt','ABCD1234/ASMT1/s0123456_2014-09-18_11-24-40/folder1/folder1_testfile.txt',21),(21,23,'8a77fb53-4eb5-4d72-bf5a-8caf27a18e02','folder1-sub-testfile.py','ABCD1234/ASMT1/s0123456_2014-09-18_11-24-40/folder1/folder1-sub/folder1-sub-testfile.py',21),(22,24,'c71af725-dfe6-4e12-95fe-4a2d1abd8338','folder2_testfile.py','ABCD1234/ASMT1/s0123456_2014-09-18_11-24-40/folder2/folder2_testfile.py',21),(23,26,'8e2245f3-c712-4658-b503-a28160c7a79d','folder1_testfile.txt','ABCD1234/ASMT1/s0123456_2014-09-18_11-27-07/folder1/folder1_testfile.txt',23),(24,27,'bc62232f-9f90-4ad5-8048-4fd3cbd999e3','folder1-sub-testfile.py','ABCD1234/ASMT1/s0123456_2014-09-18_11-27-07/folder1/folder1-sub/folder1-sub-testfile.py',23),(25,28,'c671ae21-279f-4bc6-ac31-eb980e292de1','folder2_testfile.py','ABCD1234/ASMT1/s0123456_2014-09-18_11-27-07/folder2/folder2_testfile.py',23),(26,30,'21190c58-5770-4666-a594-91fe902287a8','folder1_testfile.txt','ABCD1234/ASMT1/naoise_2014-09-18_12-31-03/folder1/folder1_testfile.txt',24),(27,31,'097a8ef6-c792-425f-b877-46aa5cb149b7','folder1-sub-testfile.py','ABCD1234/ASMT1/naoise_2014-09-18_12-31-03/folder1/folder1-sub/folder1-sub-testfile.py',24),(28,32,'d1c17ee4-0dd1-46ac-aa78-5d28439b1ed6','folder2_testfile.py','ABCD1234/ASMT1/naoise_2014-09-18_12-31-03/folder2/folder2_testfile.py',24),(29,34,'00af6f04-572a-43af-85d8-3721fe72222b','folder1_testfile.txt','ABCD1234/ASMT1/s111110_2014-09-18_12-33-24/folder1/folder1_testfile.txt',25),(30,35,'dd416956-4843-4723-8d7c-84ad62878fcf','folder1-sub-testfile.py','ABCD1234/ASMT1/s111110_2014-09-18_12-33-24/folder1/folder1-sub/folder1-sub-testfile.py',25),(31,36,'07036227-2f1e-4185-9edd-0f1c903ac346','folder2_testfile.py','ABCD1234/ASMT1/s111110_2014-09-18_12-33-24/folder2/folder2_testfile.py',25),(32,38,'2fd9b6f9-a33e-4e35-9539-cd573811b62a','folder1_testfile.txt','ABCD1234/ASMT1/s1234567_2014-09-18_12-33-53/folder1/folder1_testfile.txt',26),(33,39,'41bb1e4d-3dd9-4e10-8369-c9bf4723b3b0','folder1-sub-testfile.py','ABCD1234/ASMT1/s1234567_2014-09-18_12-33-53/folder1/folder1-sub/folder1-sub-testfile.py',26),(34,40,'961fff43-1f00-4b66-ad57-7febddae6fd8','folder2_testfile.py','ABCD1234/ASMT1/s1234567_2014-09-18_12-33-53/folder2/folder2_testfile.py',26),(35,42,'5b77432d-2476-4fbd-b9d9-5b82d00a02d0','rootfile.txt','help/naoise/naoise_2014-09-20_11-13-18/rootfile.txt',NULL),(36,43,'333fd869-f871-4fc8-a226-b201e1846b07','folder1_testfile.txt','help/naoise/naoise_2014-09-20_11-13-18/folder1/folder1_testfile.txt',NULL),(37,44,'ec2a4931-55c7-4703-8412-43cbcebb034c','folder1-sub-testfile.py','help/naoise/naoise_2014-09-20_11-13-18/folder1/folder1-sub/folder1-sub-testfile.py',NULL),(38,45,'1508d305-a7fe-4915-8c25-18f108b99f24','folder2_testfile.py','help/naoise/naoise_2014-09-20_11-13-18/folder2/folder2_testfile.py',NULL),(39,46,'0e6d8de5-ec4b-4a22-b6d0-c2079de51fb2','rootfile.txt','ABCD1234/ASMT1/admin_2014-09-22_01-28-07/rootfile.txt',27),(40,47,'4438652b-a720-4f86-a6aa-8d2960e47c93','folder1_testfile.txt','ABCD1234/ASMT1/admin_2014-09-22_01-28-07/folder1/folder1_testfile.txt',27),(41,48,'8abf2e82-df3f-4e80-9455-313c9f9f90a2','folder1-sub-testfile.py','ABCD1234/ASMT1/admin_2014-09-22_01-28-07/folder1/folder1-sub/folder1-sub-testfile.py',27),(42,49,'ccd250a1-0e2c-4317-8189-dfaf3677ef6e','folder2_testfile.py','ABCD1234/ASMT1/admin_2014-09-22_01-28-07/folder2/folder2_testfile.py',27),(43,50,'c019d4ca-50ea-4656-94d1-157f3fbe7803','rootfile.txt','help/TESTING:user_3/TESTING:user_3_2014-09-22_03-57-43/rootfile.txt',NULL),(44,51,'db5dba02-583c-4cf4-92ae-c0a8653a1a1b','folder1_testfile.txt','help/TESTING:user_3/TESTING:user_3_2014-09-22_03-57-43/folder1/folder1_testfile.txt',NULL),(45,52,'72fdb76b-62cb-42cc-b977-8448475a20f9','folder1-sub-testfile.py','help/TESTING:user_3/TESTING:user_3_2014-09-22_03-57-43/folder1/folder1-sub/folder1-sub-testfile.py',NULL),(46,53,'7d10abba-795f-4cb1-9568-752beecea11b','folder2_testfile.py','help/TESTING:user_3/TESTING:user_3_2014-09-22_03-57-43/folder2/folder2_testfile.py',NULL),(47,54,'19deb3bb-ee0c-49f4-bb8f-828366aaeba9','rootfile.txt','ABCD1234/SingleSubmit/tom_2014-09-22_04-16-12/rootfile.txt',28),(48,55,'e115b31e-a66f-492d-87eb-e747379d2468','folder1_testfile.txt','ABCD1234/SingleSubmit/tom_2014-09-22_04-16-12/folder1/folder1_testfile.txt',28),(49,56,'a97e7c37-945b-4f62-9260-ed609dcde72f','folder1-sub-testfile.py','ABCD1234/SingleSubmit/tom_2014-09-22_04-16-12/folder1/folder1-sub/folder1-sub-testfile.py',28),(50,57,'5335970c-1616-49fb-b914-6edbc9279ebd','folder2_testfile.py','ABCD1234/SingleSubmit/tom_2014-09-22_04-16-12/folder2/folder2_testfile.py',28),(51,58,'5912c3ef-dfca-4064-8a20-a7f0c1741653','rootfile.txt','ABCD1234/ASMT1/tom_2014-09-24_05-12-16/rootfile.txt',29),(52,59,'7ddd5d05-b2f6-4859-b02e-b784e98dc251','folder1_testfile.txt','ABCD1234/ASMT1/tom_2014-09-24_05-12-16/folder1/folder1_testfile.txt',29),(53,60,'fe3ec0c2-2987-4e61-b12c-2a07b81ab671','folder1-sub-testfile.py','ABCD1234/ASMT1/tom_2014-09-24_05-12-16/folder1/folder1-sub/folder1-sub-testfile.py',29),(54,61,'c04e1799-259e-405c-9bbc-0c927f89c1d0','folder2_testfile.py','ABCD1234/ASMT1/tom_2014-09-24_05-12-16/folder2/folder2_testfile.py',29),(55,62,'f24201c9-c386-4f8a-86ca-672ac737b911','rootfile.txt','ABCD1234/SingleSubmit/TESTING:user_2_2014-09-24_05-45-09/rootfile.txt',30),(56,63,'3e77d71a-6c5b-496c-8356-624e52baa8f0','folder1_testfile.txt','ABCD1234/SingleSubmit/TESTING:user_2_2014-09-24_05-45-09/folder1/folder1_testfile.txt',30),(57,64,'e9d1c943-605c-45b1-8cd3-ea9f967a005d','folder1-sub-testfile.py','ABCD1234/SingleSubmit/TESTING:user_2_2014-09-24_05-45-09/folder1/folder1-sub/folder1-sub-testfile.py',30),(58,65,'665e67b3-2c86-4c54-95a8-18005aa5b70d','folder2_testfile.py','ABCD1234/SingleSubmit/TESTING:user_2_2014-09-24_05-45-09/folder2/folder2_testfile.py',30),(59,66,'38f1636a-fd6d-45ea-9dc2-927140429211','rootfile.txt','ABCD1234/ReviewNotOpen/TESTING:user_2_2014-09-24_05-45-32/rootfile.txt',31),(60,67,'6aeb766f-c6b3-478a-ad8f-5874dc4e42c3','folder1_testfile.txt','ABCD1234/ReviewNotOpen/TESTING:user_2_2014-09-24_05-45-32/folder1/folder1_testfile.txt',31),(62,69,'4262caf6-99c9-4e3c-9a8b-82904b3e2311','rootfile.txt','ABCD1234/ReviewNotOpen/TESTING:user_2_2014-09-24_05-48-41/rootfile.txt',32),(63,70,'baee2cf9-4dfe-4bc9-b728-69f395be6896','folder1_testfile.txt','ABCD1234/ReviewNotOpen/TESTING:user_2_2014-09-24_05-48-41/folder1/folder1_testfile.txt',32),(64,71,'c0016fcf-f478-4c84-8be9-a5fbd41f3c47','folder1-sub-testfile.py','ABCD1234/ReviewNotOpen/TESTING:user_2_2014-09-24_05-48-41/folder1/folder1-sub/folder1-sub-testfile.py',32),(65,72,'4e7d557b-11e1-47ee-9015-7669047b4f4a','folder2_testfile.py','ABCD1234/ReviewNotOpen/TESTING:user_2_2014-09-24_05-48-41/folder2/folder2_testfile.py',32),(66,73,'14316dc2-530d-4a1d-945c-64349d144e3d','rootfile.txt','ABCD1234/ReviewNotOpen/TESTING:user_2_2014-09-24_05-48-50/rootfile.txt',33),(67,74,'30bc5e92-89f9-4233-a1f5-bcc45269788d','folder1_testfile.txt','ABCD1234/ReviewNotOpen/TESTING:user_2_2014-09-24_05-48-50/folder1/folder1_testfile.txt',33),(68,75,'b7a0e8fe-f930-41df-a15a-208afda7731a','folder1-sub-testfile.py','ABCD1234/ReviewNotOpen/TESTING:user_2_2014-09-24_05-48-50/folder1/folder1-sub/folder1-sub-testfile.py',33),(69,76,'dce64b53-50e5-4d27-8017-4491e3bef995','folder2_testfile.py','ABCD1234/ReviewNotOpen/TESTING:user_2_2014-09-24_05-48-50/folder2/folder2_testfile.py',33),(70,77,'f65c44e3-4834-49a6-89a7-f6dcc7d53e0e','rootfile.txt','help/TESTING:user_2/TESTING:user_2_2014-09-24_05-50-17/rootfile.txt',NULL),(71,78,'23a997d4-13b2-477b-97fc-f7ff8dd29d4d','folder1_testfile.txt','help/TESTING:user_2/TESTING:user_2_2014-09-24_05-50-17/folder1/folder1_testfile.txt',NULL),(72,79,'523fb723-306b-43a4-bb72-16b6d5790bda','folder1-sub-testfile.py','help/TESTING:user_2/TESTING:user_2_2014-09-24_05-50-17/folder1/folder1-sub/folder1-sub-testfile.py',NULL),(73,80,'7973be4b-b735-4cbf-a3cb-94c4a1e7951e','folder2_testfile.py','help/TESTING:user_2/TESTING:user_2_2014-09-24_05-50-17/folder2/folder2_testfile.py',NULL),(74,81,'efcf73b7-abd5-4a49-9575-534231ca7853','rootfile.txt','help/TESTING:user_2/TESTING:user_2_2014-09-24_06-08-54/rootfile.txt',NULL),(75,82,'a00544e6-a920-4e1d-b26f-0c09444de499','folder1_testfile.txt','help/TESTING:user_2/TESTING:user_2_2014-09-24_06-08-54/folder1/folder1_testfile.txt',NULL),(76,83,'70ae16ad-30a4-48e3-8791-32194f4119a0','folder1-sub-testfile.py','help/TESTING:user_2/TESTING:user_2_2014-09-24_06-08-54/folder1/folder1-sub/folder1-sub-testfile.py',NULL),(77,84,'c33395ef-651b-4130-8669-9c0be44a7afe','folder2_testfile.py','help/TESTING:user_2/TESTING:user_2_2014-09-24_06-08-54/folder2/folder2_testfile.py',NULL),(78,85,'2e3da3b7-d320-464c-903a-73da681d4cfd','rootfile.txt','help/tom/tom_2014-09-25_05-07-58/rootfile.txt',NULL),(79,86,'f4c4bbfe-58c6-4f42-a957-b3f47d7b71ac','folder1_testfile.txt','help/tom/tom_2014-09-25_05-07-58/folder1/folder1_testfile.txt',NULL),(80,87,'8ac72f76-20cb-440c-b4a9-a674183c7608','folder1-sub-testfile.py','help/tom/tom_2014-09-25_05-07-58/folder1/folder1-sub/folder1-sub-testfile.py',NULL),(81,88,'94dd3756-835d-49a9-a6a1-fcb060c6b42b','folder2_testfile.py','help/tom/tom_2014-09-25_05-07-58/folder2/folder2_testfile.py',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_sourcefolder`
--

LOCK TABLES `review_sourcefolder` WRITE;
/*!40000 ALTER TABLE `review_sourcefolder` DISABLE KEYS */;
INSERT INTO `review_sourcefolder` VALUES (1,'4f0dad34-d6bc-43a6-ae2a-894d9211eb0c','csse2310',NULL),(2,'25696ebc-7f8c-48c7-a292-86d7db6d3759','admin_2014-08-28_06-27-48',NULL),(3,'89a65f7f-f684-4a0a-9658-2d2444820881','folder1',2),(4,'a5234335-811c-42b9-bd1f-714966cb33b6','folder1-sub',3),(5,'d5840a38-a391-49e9-9495-5e15f0f3aee7','folder2',2),(6,'ae4f4fea-95fb-43a8-8f2b-ac4120bf1627','admin_2014-08-28_06-29-04',NULL),(7,'e4eea010-c154-40dd-bafd-b900a1d6811c','folder1',6),(8,'9b31837a-ae4f-49f3-9d15-7232eaf3366f','folder1-sub',7),(9,'1b10ad81-5a81-4f26-9350-3a07ddb7cfd5','folder2',6),(10,'ce6704c0-3f1f-40f8-8287-38d2522f0a70','admin_2014-08-28_06-46-43',NULL),(11,'c6e63a4e-b5d1-4bfe-83d5-d81b23ff6a09','admin_2014-08-28_06-47-13',NULL),(12,'f94d7350-05a3-4b1f-ae7e-a1200f3ff153','admin_2014-08-28_06-47-25',NULL),(13,'2dbdaebc-0768-4e9c-8920-8de3f04251e9','admin_2014-08-28_07-13-43',NULL),(14,'1190c04e-9b22-439c-87d7-0ee41e38b36b','folder1',13),(15,'aacd3e15-13d8-4b8e-9c9b-54a3afb5887f','folder1-sub',14),(16,'81f463e5-b328-4d27-8eb7-e80e4a6570ac','folder2',13),(17,'526a83bc-c4ef-4558-b424-75f5e11799b7','s0123456_2014-09-18_11-22-02',NULL),(18,'275a9039-424d-41fe-a7a9-8435c76539dc','folder1',17),(19,'977f886b-98dd-45d8-91c9-f04aabb170f3','folder1-sub',18),(20,'72a9eff7-9635-4245-9b76-156eb3c4be71','folder2',17),(21,'feeb5c62-8ba9-4519-ad9b-f91d42bc3339','s0123456_2014-09-18_11-24-40',NULL),(22,'7e98330c-85ea-4e39-b302-e2e91671e4b8','folder1',21),(23,'b0609679-eb4f-48ae-bde0-19fa7a9354ee','folder1-sub',22),(24,'f20464a1-acd1-4860-9060-fe75deaff951','folder2',21),(25,'f70c7266-393e-4928-bc29-c3aca8c74045','s0123456_2014-09-18_11-27-07',NULL),(26,'6a338fb7-3015-43f0-a13e-b72d18099bb1','folder1',25),(27,'46e9b6fc-6660-4b16-87ef-2b1a1f30b6e9','folder1-sub',26),(28,'6c761e45-636a-4996-a696-e9b6d41adce1','folder2',25),(29,'9767c919-deb6-4c48-a309-5299ca3726f1','naoise_2014-09-18_12-31-03',NULL),(30,'0dbfff13-ea9d-4f21-89d6-54035de96a15','folder1',29),(31,'90e5ad11-e80b-49a2-9862-c42dba7e89a0','folder1-sub',30),(32,'db199ef6-9257-4386-b8c4-26a021100495','folder2',29),(33,'82ac3eb8-5bc6-4022-9e30-69efb5be1b3e','s111110_2014-09-18_12-33-24',NULL),(34,'9a48d396-e970-4ea3-9033-36b9a18c09a2','folder1',33),(35,'7b178e21-b60e-4a25-82e4-50186d613b9f','folder1-sub',34),(36,'1e415191-9d02-4bee-90cc-c2281dc3c792','folder2',33),(37,'165ab483-8240-4531-9ae6-e9806b9ab375','s1234567_2014-09-18_12-33-53',NULL),(38,'77d0d2e2-c20f-409e-b248-771c3d7be033','folder1',37),(39,'85ba4ff6-e87f-4fe2-89e3-91c9cc69a799','folder1-sub',38),(40,'0da00574-2c78-48e6-a64b-8698d5927af8','folder2',37),(41,'919ab2d0-4e12-4659-ad29-ab97b6a2cf67','naoise_2014-09-18_14-03-06',NULL),(42,'6197de7e-2555-4a01-adb6-bcec7598ef93','naoise_2014-09-20_11-13-18',NULL),(43,'53c29616-a78e-48ee-8a16-1f0e4aad91d9','folder1',42),(44,'4cadd65f-1557-432f-b1c1-e4e0337bda7a','folder1-sub',43),(45,'b5223f89-04b8-4989-856e-31c2bc8c0f93','folder2',42),(46,'aca11dc9-d6bf-43b9-9b2d-e508a7c1add1','admin_2014-09-22_01-28-07',NULL),(47,'e4634265-0aca-49ff-a39c-5ee25e95a6b1','folder1',46),(48,'75865493-b795-4ce2-8fe6-a0a5999efec9','folder1-sub',47),(49,'4a4c35d5-ddae-434e-ade1-6035040ab971','folder2',46),(50,'8c22da8a-b1f1-4b2a-bfe1-a2d3595e444e','TESTING:user_3_2014-09-22_03-57-43',NULL),(51,'637bfd9b-9332-4ab6-8045-d6661bb1ec84','folder1',50),(52,'271726a9-9305-4a60-87b6-b4f784c8858d','folder1-sub',51),(53,'9495c12f-d09d-4dfc-912d-28e28bd661a7','folder2',50),(54,'4c80502a-1475-4591-8e19-1cb515de6d5d','tom_2014-09-22_04-16-12',NULL),(55,'5bf6f186-2119-442a-b14f-62b04a2127f0','folder1',54),(56,'497ac2ce-7fc7-439c-bd52-50d7db614141','folder1-sub',55),(57,'1689ae84-0d19-4c34-be45-b66ae07d5f3b','folder2',54),(58,'a14e7c1d-2e4f-4301-b58d-4251d9db7e79','tom_2014-09-24_05-12-16',NULL),(59,'436c87dd-c4c7-4a08-9331-cd56dfe207e0','folder1',58),(60,'6660c402-cfc2-4269-b9c6-75ac2ef5f3d8','folder1-sub',59),(61,'d21bf25c-85d2-405b-93b5-9ca838f1c2a2','folder2',58),(62,'35474a8f-7eb1-4de3-ba9c-025475de7d4f','TESTING:user_2_2014-09-24_05-45-09',NULL),(63,'2e493291-1883-48f8-912d-f053769da4b1','folder1',62),(64,'ea2f860f-028d-4427-b9f1-8a1d30f99ea2','folder1-sub',63),(65,'bfd7bc85-6f9d-4dd2-9280-d5ae579c46ea','folder2',62),(66,'211bf62f-b75b-4423-8b97-dcaa9a7d4adf','TESTING:user_2_2014-09-24_05-45-32',NULL),(67,'b4c482f3-8f95-4c51-99d4-19b99c9ce58b','folder1',66),(68,'695a3d72-91c8-4bdc-bc4f-c911feb5dc91','folder1-sub',67),(69,'6b6c1f44-23ce-4af7-b016-47c59c5310fd','TESTING:user_2_2014-09-24_05-48-41',NULL),(70,'efd02e5f-e798-48ce-8dcc-664951693b74','folder1',69),(71,'420d5219-6971-4925-bab1-f3fc8276f268','folder1-sub',70),(72,'4dfa91c8-6163-497b-9a14-4cfe71627c91','folder2',69),(73,'6a447132-397e-492c-988e-66e64818ebc5','TESTING:user_2_2014-09-24_05-48-50',NULL),(74,'28834978-9049-4cbe-8cb4-0d5a6ba631dd','folder1',73),(75,'c36791de-ac84-4a91-bc8b-58ec551ff7ba','folder1-sub',74),(76,'e135d023-5842-43fe-9f92-c006945bb13c','folder2',73),(77,'2207d165-90a9-48f1-8df1-8ab8eb772dfe','TESTING:user_2_2014-09-24_05-50-17',NULL),(78,'dbc18a96-4fb3-48c6-a71f-541fcad85e30','folder1',77),(79,'994270e5-da51-49c0-bec1-12377d1890f2','folder1-sub',78),(80,'0d9cbd7d-c8af-4c2d-99f5-82891f6fd6cd','folder2',77),(81,'f9a84b2f-3da7-48e1-84f1-316d0a62f5a3','TESTING:user_2_2014-09-24_06-08-54',NULL),(82,'7364a974-befe-41bf-8e84-51ffb9c781bd','folder1',81),(83,'5489aacd-33cc-4733-8597-d19ef341be1e','folder1-sub',82),(84,'120464e2-a338-4fb9-a846-dcccff0c5b92','folder2',81),(85,'84674093-69ab-4d2e-b8fd-ce078454f01d','tom_2014-09-25_05-07-58',NULL),(86,'76955a08-a1f1-4d7e-ba0c-29061e887b66','folder1',85),(87,'a403dcc5-0b79-4cb6-a987-6e8f06802a3d','folder1-sub',86),(88,'b3b5f9cd-021e-4a59-90a7-f07cd7a31bc8','folder2',85);
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
  `test_name` longtext NOT NULL,
  `test_count` int(10) unsigned NOT NULL,
  `test_pass_count` int(10) unsigned NOT NULL,
  `for_assignment_id` int(11) NOT NULL,
  `test_file` varchar(1000),
  `test_command` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_submissiontest_1df128bb` (`for_assignment_id`),
  CONSTRAINT `for_assignment_id_refs_id_0c29c6c6` FOREIGN KEY (`for_assignment_id`) REFERENCES `review_assignment` (`id`)
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
  `part_of_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_submissiontestresults_f740f564` (`part_of_id`),
  CONSTRAINT `part_of_id_refs_id_b375723b` FOREIGN KEY (`part_of_id`) REFERENCES `review_submissiontest` (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `south_migrationhistory`
--

LOCK TABLES `south_migrationhistory` WRITE;
/*!40000 ALTER TABLE `south_migrationhistory` DISABLE KEYS */;
INSERT INTO `south_migrationhistory` VALUES (1,'review','0001_initial','2014-08-09 12:39:02'),(2,'review','0002_auto__del_test__add_user__add_sourceannotation__add_sourcefile__add_so','2014-08-09 12:39:10'),(3,'review','0003_auto__del_user__add_reviewuser__chg_field_sourceannotation_user__chg_f','2014-08-09 12:39:11'),(4,'review','0004_auto__add_field_reviewuser_isStaff','2014-08-09 12:39:11'),(5,'review','0005_auto__add_course','2014-08-09 12:39:12'),(6,'review','0006_auto__add_field_course_course_code__add_field_course_course_name','2014-08-09 12:39:12'),(7,'review','0007_auto__add_field_assignment_course_code','2014-08-09 12:39:13'),(8,'review','0008_auto','2014-08-09 12:39:15'),(9,'review','0009_auto__chg_field_course_course_name','2014-08-09 12:39:15'),(10,'review','0010_auto','2014-08-09 12:39:16'),(11,'review','0011_auto__add_myuser','2014-08-14 05:33:54'),(12,'review','0012_auto__del_myuser__add_studentuser__add_createuserform','2014-08-15 13:19:09'),(13,'review','0013_auto__del_studentuser','2014-08-15 13:19:09'),(14,'review','0014_auto__del_createuserform','2014-08-15 13:19:09'),(15,'review','0015_auto__add_field_reviewuser_firstLogin','2014-08-15 13:54:20'),(16,'review','0016_auto__add_faketestmodel','2014-08-17 13:17:14'),(17,'review','0017_auto__del_faketestmodel','2014-08-17 13:17:14'),(18,'review','0011_auto__add_studentuser__add_createuserform','2014-08-27 06:27:02'),(19,'review','0018_auto__del_field_assignmentsubmission_root_folder','2014-08-27 06:27:02'),(20,'review','0019_auto__del_field_assignmentsubmission_test_results__add_field_assignmen','2014-08-27 06:27:18'),(21,'review','0020_auto__add_field_sourcefile_file_html','2014-08-28 06:46:20'),(22,'review','0021_auto__del_field_sourcefile_file_html','2014-08-28 06:48:24'),(23,'review','0022_auto__add_field_assignment_multiple_submissions','2014-09-18 11:03:17'),(28,'help','0001_initial','2014-09-24 05:42:29'),(29,'help','0002_auto__add_field_post_open','2014-09-24 05:42:29'),(30,'help','0003_auto__add_field_post_post_repo','2014-09-24 05:42:29'),(31,'help','0004_auto__del_field_post_post_repo__add_field_post_submission_repository','2014-09-24 05:42:30'),(32,'help','0005_auto__del_field_post_user__add_field_post_by','2014-09-24 05:42:30'),(33,'help','0006_auto__add_field_post_course_code','2014-09-24 05:42:30'),(34,'help','0007_auto__chg_field_post_course_code__add_unique_post_course_code','2014-09-24 05:42:30'),(35,'help','0008_auto__chg_field_post_course_code__del_unique_post_course_code','2014-09-24 05:42:30'),(36,'help','0009_auto__add_field_post_resolved','2014-09-24 05:42:53'),(37,'review','0028_auto__add_enrol__add_submissionreview__add_field_sourceannotation_subm','2014-09-24 05:48:35'),(38,'review','0029_auto__chg_field_sourcefile_file','2014-09-24 05:48:35'),(39,'review','0030_auto__chg_field_sourcefile_file','2014-09-24 05:48:35'),(40,'review','0031_auto__add_field_submissiontest_for_assignment__add_field_submissiontes','2014-09-24 08:06:33'),(41,'review','0032_auto__del_field_submissiontest_part_of__add_field_submissiontestresult','2014-09-24 08:21:42'),(42,'djcelery','0001_initial','2014-09-26 04:30:49'),(43,'djcelery','0002_v25_changes','2014-09-26 04:30:49'),(44,'djcelery','0003_v26_changes','2014-09-26 04:30:49'),(45,'djcelery','0004_v30_changes','2014-09-26 04:30:49'),(46,'djcelery','0005_initial','2014-09-26 04:43:49'),(47,'help','0010_auto__chg_field_post_title__chg_field_post_question','2014-09-29 01:14:53'),(48,'help','0011_auto__chg_field_post_title__chg_field_post_question','2014-09-29 01:17:57'),(49,'review','0033_auto__del_submissionreview__chg_field_submissiontest_test_file__chg_fi','2014-09-30 00:22:33');
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

-- Dump completed on 2014-09-30 10:30:23
