-- MySQL dump 10.13  Distrib 8.0.23, for osx10.15 (x86_64)
--
-- Host: localhost    Database: instamg
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(2000) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `comment_id_id` int DEFAULT NULL,
  `post_id_id` int NOT NULL,
  `user_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_comment_id_id_b44c7549_fk_comments_id` (`comment_id_id`),
  KEY `comments_post_id_id_bc1cd48b_fk_posts_id` (`post_id_id`),
  KEY `comments_user_id_id_059ba06b_fk_users_id` (`user_id_id`),
  CONSTRAINT `comments_comment_id_id_b44c7549_fk_comments_id` FOREIGN KEY (`comment_id_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `comments_post_id_id_bc1cd48b_fk_posts_id` FOREIGN KEY (`post_id_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `comments_user_id_id_059ba06b_fk_users_id` FOREIGN KEY (`user_id_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direct_message_attach_files`
--

DROP TABLE IF EXISTS `direct_message_attach_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direct_message_attach_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_type` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `path` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `thumbnail_path` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `direct_message_id_id` int NOT NULL,
  `user_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `direct_message_attac_direct_message_id_id_4dae6d34_fk_direct_me` (`direct_message_id_id`),
  KEY `direct_message_attach_files_user_id_id_92f2d7f4_fk_users_id` (`user_id_id`),
  CONSTRAINT `direct_message_attac_direct_message_id_id_4dae6d34_fk_direct_me` FOREIGN KEY (`direct_message_id_id`) REFERENCES `direct_messages` (`id`),
  CONSTRAINT `direct_message_attach_files_user_id_id_92f2d7f4_fk_users_id` FOREIGN KEY (`user_id_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direct_message_attach_files`
--

LOCK TABLES `direct_message_attach_files` WRITE;
/*!40000 ALTER TABLE `direct_message_attach_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `direct_message_attach_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direct_messages`
--

DROP TABLE IF EXISTS `direct_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direct_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(2000) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `received_user_id_id` int NOT NULL,
  `send_user_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `direct_messages_received_user_id_id_5b310718_fk_users_id` (`received_user_id_id`),
  KEY `direct_messages_send_user_id_id_6db1727f_fk_users_id` (`send_user_id_id`),
  CONSTRAINT `direct_messages_received_user_id_id_5b310718_fk_users_id` FOREIGN KEY (`received_user_id_id`) REFERENCES `users` (`id`),
  CONSTRAINT `direct_messages_send_user_id_id_6db1727f_fk_users_id` FOREIGN KEY (`send_user_id_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direct_messages`
--

LOCK TABLES `direct_messages` WRITE;
/*!40000 ALTER TABLE `direct_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `direct_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'stories','0001_initial','2021-02-27 06:39:39.512429'),(2,'posts','0001_initial','2021-02-27 06:39:39.577740'),(3,'users','0001_initial','2021-02-27 06:39:39.678118'),(4,'posts','0002_auto_20210227_1539','2021-02-27 06:40:21.128951'),(5,'stories','0002_auto_20210227_1539','2021-02-27 06:40:45.250748'),(6,'direct_messages','0001_initial','2021-02-27 06:41:23.231803');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows` (
  `id` int NOT NULL AUTO_INCREMENT,
  `followed_user_id_id` int NOT NULL,
  `follower_user_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `follows_followed_user_id_id_78e7d91d_fk_users_id` (`followed_user_id_id`),
  KEY `follows_follower_user_id_id_2f0179bc_fk_users_id` (`follower_user_id_id`),
  CONSTRAINT `follows_followed_user_id_id_78e7d91d_fk_users_id` FOREIGN KEY (`followed_user_id_id`) REFERENCES `users` (`id`),
  CONSTRAINT `follows_follower_user_id_id_2f0179bc_fk_users_id` FOREIGN KEY (`follower_user_id_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=391 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
INSERT INTO `follows` VALUES (1,11,25),(2,10,8),(3,29,1),(4,29,45),(5,45,2),(6,46,19),(7,14,7),(8,8,44),(9,6,32),(10,26,44),(11,24,37),(12,30,21),(13,13,27),(14,22,20),(15,50,47),(16,3,44),(17,45,44),(18,27,13),(19,50,16),(20,11,19),(21,23,46),(22,37,29),(23,19,7),(24,13,37),(25,2,14),(26,2,9),(27,19,30),(28,43,18),(29,34,29),(30,43,48),(31,45,21),(32,33,47),(33,10,34),(34,6,3),(35,37,22),(36,36,16),(37,6,37),(38,3,36),(39,33,50),(40,14,30),(41,4,14),(42,20,46),(43,7,28),(44,50,34),(45,5,39),(46,31,30),(47,7,5),(48,31,22),(49,13,25),(50,10,33),(51,29,26),(52,25,4),(53,48,28),(54,33,48),(55,41,32),(56,30,33),(57,10,25),(58,48,14),(59,14,17),(60,25,20),(61,7,8),(62,6,39),(63,13,34),(64,39,11),(65,25,38),(66,19,4),(67,13,48),(68,47,10),(69,38,1),(70,49,32),(71,31,48),(72,8,9),(73,48,20),(74,39,45),(75,42,28),(76,7,24),(77,33,43),(78,2,45),(79,15,5),(80,31,8),(81,15,29),(82,34,41),(83,28,44),(84,21,34),(85,11,2),(86,21,47),(87,34,39),(88,40,37),(89,42,23),(90,15,7),(91,26,4),(92,19,42),(93,10,37),(94,7,35),(95,41,38),(96,26,22),(97,6,47),(98,13,2),(99,49,26),(100,44,3),(101,17,7),(102,44,47),(103,46,16),(104,45,32),(105,18,6),(106,20,35),(107,4,43),(108,42,3),(109,24,46),(110,11,13),(111,38,27),(112,32,15),(113,46,17),(114,28,40),(115,21,20),(116,3,31),(117,28,46),(118,15,37),(119,48,15),(120,25,17),(121,28,13),(122,37,48),(123,25,47),(124,47,18),(125,10,44),(126,1,17),(127,10,43),(128,35,31),(129,26,29),(130,19,27),(131,50,44),(132,34,28),(133,40,3),(134,13,11),(135,6,18),(136,42,12),(137,12,50),(138,39,46),(139,12,34),(140,20,24),(141,30,38),(142,33,31),(143,40,15),(144,17,9),(145,29,14),(146,29,34),(147,42,34),(148,34,13),(149,47,20),(150,20,32),(151,17,43),(152,23,49),(153,21,40),(154,22,43),(155,2,44),(156,46,31),(157,7,38),(158,23,25),(159,35,1),(160,47,4),(161,39,50),(162,50,37),(163,3,19),(164,39,47),(165,18,27),(166,29,41),(167,27,30),(168,50,2),(169,13,2),(170,13,50),(171,46,40),(172,30,17),(173,36,20),(174,49,6),(175,6,25),(176,38,35),(177,3,8),(178,1,41),(179,23,24),(180,21,14),(181,20,35),(182,21,33),(183,23,43),(184,49,22),(185,2,6),(186,34,33),(187,46,16),(188,2,7),(189,47,13),(190,12,35),(191,6,1),(192,3,13),(193,34,20),(194,33,9),(195,13,10),(196,44,8),(197,49,45),(198,42,50),(199,5,16),(200,47,31),(201,39,22),(202,23,45),(203,29,8),(204,17,38),(205,19,18),(206,19,18),(207,17,20),(208,18,32),(209,30,4),(210,40,31),(211,10,34),(212,19,49),(213,43,42),(214,41,11),(215,48,42),(216,23,2),(217,5,6),(218,8,5),(219,9,30),(220,7,29),(221,36,1),(222,8,26),(223,19,8),(224,47,46),(225,14,9),(226,26,12),(227,47,31),(228,18,48),(229,38,16),(230,36,42),(231,15,46),(232,18,19),(233,47,31),(234,43,41),(235,13,25),(236,29,10),(237,18,13),(238,7,10),(239,36,46),(240,47,34),(241,33,50),(242,43,42),(243,49,6),(244,17,27),(245,31,35),(246,27,32),(247,49,26),(248,6,7),(249,50,40),(250,44,15),(251,21,27),(252,28,26),(253,4,10),(254,46,1),(255,6,25),(256,25,26),(257,30,48),(258,41,13),(259,34,30),(260,6,8),(261,32,5),(262,27,31),(263,5,19),(264,11,36),(265,25,46),(266,35,33),(267,47,14),(268,7,15),(269,31,24),(270,37,13),(271,15,33),(272,50,27),(273,7,49),(274,49,14),(275,29,19),(276,11,36),(277,11,23),(278,40,18),(279,36,15),(280,38,22),(281,24,3),(282,15,23),(283,17,22),(284,48,25),(285,8,48),(286,50,16),(287,23,17),(288,4,48),(289,21,13),(290,44,2),(291,3,13),(292,23,12),(293,40,5),(294,32,1),(295,40,47),(296,5,21),(297,17,23),(298,34,46),(299,23,24),(300,14,43),(301,18,3),(302,22,44),(303,38,3),(304,41,32),(305,33,37),(306,49,15),(307,10,30),(308,49,18),(309,22,7),(310,4,11),(311,50,33),(312,21,13),(313,38,7),(314,24,38),(315,36,20),(316,25,9),(317,26,12),(318,23,4),(319,41,6),(320,41,42),(321,48,35),(322,22,14),(323,8,17),(324,37,47),(325,6,35),(326,37,35),(327,12,16),(328,46,17),(329,49,11),(330,46,8),(331,10,6),(332,32,37),(333,39,29),(334,13,45),(335,14,46),(336,39,30),(337,23,36),(338,20,5),(339,17,9),(340,33,13),(341,21,19),(342,28,11),(343,30,39),(344,24,41),(345,35,36),(346,49,16),(347,12,34),(348,13,22),(349,35,26),(350,19,15),(351,15,7),(352,8,32),(353,37,44),(354,50,23),(355,21,17),(356,39,47),(357,40,23),(358,6,24),(359,35,41),(360,29,2),(361,28,37),(362,30,17),(363,8,43),(364,5,24),(365,7,44),(366,2,31),(367,22,40),(368,1,21),(369,7,44),(370,4,25),(371,26,46),(372,27,6),(373,2,15),(374,7,11),(375,33,21),(376,8,28),(377,28,30),(378,13,25),(379,18,1),(380,43,10),(381,15,43),(382,48,26),(383,33,12),(384,31,19),(385,8,3),(386,25,8),(387,38,1),(388,30,45),(389,42,19),(390,49,40);
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment_id_id` int DEFAULT NULL,
  `post_id_id` int DEFAULT NULL,
  `user_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `likes_comment_id_id_8e9d0520_fk_comments_id` (`comment_id_id`),
  KEY `likes_post_id_id_2d862ffc_fk_posts_id` (`post_id_id`),
  KEY `likes_user_id_id_3b2f65b4_fk_users_id` (`user_id_id`),
  CONSTRAINT `likes_comment_id_id_8e9d0520_fk_comments_id` FOREIGN KEY (`comment_id_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `likes_post_id_id_2d862ffc_fk_posts_id` FOREIGN KEY (`post_id_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `likes_user_id_id_3b2f65b4_fk_users_id` FOREIGN KEY (`user_id_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_attach_files`
--

DROP TABLE IF EXISTS `post_attach_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_attach_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `view_count` int NOT NULL,
  `file_type` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `path` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `thumbnail_path` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `post_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_attach_files_post_id_id_f6a07ce0_fk_posts_id` (`post_id_id`),
  CONSTRAINT `post_attach_files_post_id_id_f6a07ce0_fk_posts_id` FOREIGN KEY (`post_id_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_attach_files`
--

LOCK TABLES `post_attach_files` WRITE;
/*!40000 ALTER TABLE `post_attach_files` DISABLE KEYS */;
INSERT INTO `post_attach_files` VALUES (1,0,'image','files/20210227/babysarang2.jpeg','media/thumbnail/babysarang2.jpeg',1),(2,0,'image','files/20210227/lazysarang.jpeg','media/thumbnail/lazysarang.jpeg',2),(3,0,'image','files/20210227/sarangsnow.jpeg','media/thumbnail/sarangsnow.jpeg',3),(4,0,'image','files/20210227/sarangsnow2.jpeg','media/thumbnail/sarangsnow2.jpeg',3),(5,0,'image','files/20210227/278DA516-202B-4DC6-9CD1-0A042F3354EB.jpeg','media/thumbnail/278DA516-202B-4DC6-9CD1-0A042F3354EB.jpeg',4),(6,0,'image','files/20210227/FE09C758-6696-4351-9A0C-9BD503EBCE0F.jpeg','media/thumbnail/FE09C758-6696-4351-9A0C-9BD503EBCE0F.jpeg',4),(7,0,'image','files/20210227/2268B577-7661-4EF8-BCEE-4A4966DA2EE5.jpeg','media/thumbnail/2268B577-7661-4EF8-BCEE-4A4966DA2EE5.jpeg',4),(8,0,'image','files/20210227/2C5332A5-6838-47BE-B8C5-1AEA6243084F.jpeg','media/thumbnail/2C5332A5-6838-47BE-B8C5-1AEA6243084F.jpeg',5),(9,0,'image','files/20210227/2FD0C7CF-B1E1-4142-BE67-6DBAB0CCED4C.jpeg','media/thumbnail/2FD0C7CF-B1E1-4142-BE67-6DBAB0CCED4C.jpeg',6),(10,0,'image','files/20210227/25830712-F544-4E83-8E04-2D4BFDCF23B3.jpeg','media/thumbnail/25830712-F544-4E83-8E04-2D4BFDCF23B3.jpeg',7),(11,0,'image','files/20210227/B31787A4-653E-47F5-A360-026D35AE36BF.jpeg','media/thumbnail/B31787A4-653E-47F5-A360-026D35AE36BF.jpeg',8),(12,0,'image','files/20210227/BB5351B7-B323-44AC-9FAA-9CB528CCD02C.jpeg','media/thumbnail/BB5351B7-B323-44AC-9FAA-9CB528CCD02C.jpeg',8),(13,0,'image','files/20210227/BDDA1859-6E3B-4FC3-B644-CD50E74AF58B.heic','media/thumbnail/BDDA1859-6E3B-4FC3-B644-CD50E74AF58B.heic',8),(14,0,'image','files/20210227/A133AAF4-4A8C-4664-B9DE-6348A457E64E.heic','media/thumbnail/A133AAF4-4A8C-4664-B9DE-6348A457E64E.heic',9),(15,0,'image','files/20210227/42AA073B-C3C4-40C4-A23E-ED5B9B618C37.heic','media/thumbnail/42AA073B-C3C4-40C4-A23E-ED5B9B618C37.heic',9),(16,0,'image','files/20210227/ACCB61FA-1D5C-47A9-AD6B-8F275126A8E3.heic','media/thumbnail/ACCB61FA-1D5C-47A9-AD6B-8F275126A8E3.heic',9),(17,0,'image','files/20210227/614C853B-E997-4615-B134-9BD55CBD07A6.heic','media/thumbnail/614C853B-E997-4615-B134-9BD55CBD07A6.heic',9),(18,0,'image','files/20210227/07652658-DC3E-4057-8FF7-9B46E1220269.jpeg','media/thumbnail/07652658-DC3E-4057-8FF7-9B46E1220269.jpeg',10),(19,0,'image','files/20210227/DC545B50-7807-42E2-8B8B-256391AC5110.jpeg','media/thumbnail/DC545B50-7807-42E2-8B8B-256391AC5110.jpeg',11),(20,0,'image','files/20210227/D55C5F9B-FE2F-4DCD-8AA6-27EBFE00C7CA.jpeg','media/thumbnail/D55C5F9B-FE2F-4DCD-8AA6-27EBFE00C7CA.jpeg',11),(21,0,'image','files/20210227/BB5351B7-B323-44AC-9FAA-9CB528CCD02C_LyAsphw.jpeg','media/thumbnail/BB5351B7-B323-44AC-9FAA-9CB528CCD02C_LyAsphw.jpeg',11),(22,0,'video','files/20210227/1.mp4','media/thumbnail/1.mp4',12),(23,0,'image','files/20210227/IMG_4677_.JPG','media/thumbnail/IMG_4677_.JPG',13),(24,0,'image','files/20210227/IMG_5862.JPG','media/thumbnail/IMG_5862.JPG',13),(25,0,'image','files/20210227/IMG_5866.JPG','media/thumbnail/IMG_5866.JPG',13),(26,0,'image','files/20210227/IMG_7178__.JPG','media/thumbnail/IMG_7178__.JPG',13),(27,0,'image','files/20210227/IMG_3614.JPG','media/thumbnail/IMG_3614.JPG',14),(28,0,'image','files/20210227/IMG_3616.JPG','media/thumbnail/IMG_3616.JPG',14),(29,0,'image','files/20210227/2.jpg','media/thumbnail/2.jpg',15),(30,0,'video','files/20210227/5.mp4','media/thumbnail/5.mp4',16),(31,0,'image','files/20210227/wepicker.jpg','media/thumbnail/wepicker.jpg',17),(32,0,'image','files/20210227/ag.jpg','media/thumbnail/ag.jpg',18),(33,0,'video','files/20210227/IMG_1941.MOV','media/thumbnail/IMG_1941.MOV',19),(34,0,'image','files/20210227/032.png','media/thumbnail/032.png',20),(35,0,'video','files/20210227/4.mp4','media/thumbnail/4.mp4',21),(36,0,'image','files/20210228/insatam.jpg','media/thumbnail/insatam.jpg',22),(37,0,'image','files/20210228/insta.jpg','media/thumbnail/insta.jpg',22),(38,0,'image','files/20210228/instamg.jpg','media/thumbnail/instamg.jpg',22),(39,0,'image','files/20210228/sarangcute.jpeg','media/thumbnail/sarangcute.jpeg',23),(40,0,'image','files/20210228/5.png','media/thumbnail/5.png',24),(41,0,'image','files/20210228/907BE5CE-C2E9-412D-AF99-612019DF84B6.jpeg','media/thumbnail/907BE5CE-C2E9-412D-AF99-612019DF84B6.jpeg',25),(42,0,'image','files/20210228/20210225_144302.jpg','media/thumbnail/20210225_144302.jpg',26),(43,0,'image','files/20210228/TIL.png','media/thumbnail/TIL.png',27),(44,0,'image','files/20210228/sarangsleep2.jpeg','media/thumbnail/sarangsleep2.jpeg',28),(45,0,'image','files/20210228/wecode.png','media/thumbnail/wecode.png',29),(46,0,'image','files/20210228/wecode_dAFYxsu.png','media/thumbnail/wecode_dAFYxsu.png',30),(47,0,'video','files/20210228/5.mp4','media/thumbnail/5.mp4',31),(48,0,'video','files/20210228/3.MOV','media/thumbnail/3.MOV',32),(49,0,'image','files/20210228/4.jpg','media/thumbnail/4.jpg',32),(50,0,'video','files/20210228/2.MOV','media/thumbnail/2.MOV',33),(51,0,'video','files/20210228/3_csqTTis.MOV','media/thumbnail/3_csqTTis.MOV',33),(52,0,'image','files/20210228/4_wZ2IBTD.jpg','media/thumbnail/4_wZ2IBTD.jpg',33),(53,0,'image','files/20210228/8B4BAC77-4804-40D5-9FDC-1A021CEF3B81.jpeg','media/thumbnail/8B4BAC77-4804-40D5-9FDC-1A021CEF3B81.jpeg',34),(54,0,'image','files/20210228/sarang1.jpeg','media/thumbnail/sarang1.jpeg',35),(55,0,'image','files/20210228/sarang2.jpeg','media/thumbnail/sarang2.jpeg',35),(56,0,'image','files/20210228/sarangcantsee.jpeg','media/thumbnail/sarangcantsee.jpeg',36),(57,0,'image','files/20210228/A240A715-7B11-4C31-84DE-D6824860E5DA.jpeg','media/thumbnail/A240A715-7B11-4C31-84DE-D6824860E5DA.jpeg',37),(58,0,'image','files/20210228/mandu.png','media/thumbnail/mandu.png',38),(59,0,'image','files/20210228/mew.jpg','media/thumbnail/mew.jpg',39),(60,0,'image','files/20210228/insatam_2oM2V3D.jpg','media/thumbnail/insatam_2oM2V3D.jpg',40),(61,0,'image','files/20210228/bono.png','media/thumbnail/bono.png',41),(62,0,'image','files/20210228/fakebono.png','media/thumbnail/fakebono.png',42),(63,0,'image','files/20210228/061.png','media/thumbnail/061.png',43),(64,0,'image','files/20210228/71FF99E0-5AD5-44B5-985A-9D6C0A200395.jpeg','media/thumbnail/71FF99E0-5AD5-44B5-985A-9D6C0A200395.jpeg',44),(65,0,'image','files/20210228/IMG_7178__.JPG','media/thumbnail/IMG_7178__.JPG',45),(66,0,'image','files/20210228/513CC3AC-B875-4AE0-B079-64C0809C9712.jpeg','media/thumbnail/513CC3AC-B875-4AE0-B079-64C0809C9712.jpeg',46),(67,0,'image','files/20210228/IMG_7522_.JPG','media/thumbnail/IMG_7522_.JPG',47),(68,0,'image','files/20210228/IMG_7523_.JPG','media/thumbnail/IMG_7523_.JPG',47),(69,0,'image','files/20210228/au.png','media/thumbnail/au.png',48),(70,0,'image','files/20210228/j.png','media/thumbnail/j.png',49),(71,0,'image','files/20210228/j_KSrubtH.png','media/thumbnail/j_KSrubtH.png',50),(72,0,'image','files/20210228/IMG_9819.JPG','media/thumbnail/IMG_9819.JPG',51),(73,0,'image','files/20210228/0962061D-8BE5-4DEB-889C-59CCAFA01E4D.jpeg','media/thumbnail/0962061D-8BE5-4DEB-889C-59CCAFA01E4D.jpeg',52),(74,0,'image','files/20210228/birthday.jpg','media/thumbnail/birthday.jpg',53),(75,0,'image','files/20210228/masksarang.jpeg','media/thumbnail/masksarang.jpeg',54),(76,0,'image','files/20210228/P20160117_131854000_E8C62326-C6FE-47C6-AA08-26F606A98A4A.JPG','media/thumbnail/P20160117_131854000_E8C62326-C6FE-47C6-AA08-26F606A98A4A.JPG',54),(77,0,'image','files/20210228/g.jpg','media/thumbnail/g.jpg',55),(78,0,'image','files/20210228/wecode_0ISNl7A.png','media/thumbnail/wecode_0ISNl7A.png',56),(79,0,'image','files/20210228/20210225_144302_xGZLsym.jpg','media/thumbnail/20210225_144302_xGZLsym.jpg',57),(80,0,'image','files/20210228/sarang8.jpeg','media/thumbnail/sarang8.jpeg',58),(81,0,'image','files/20210228/saranginthehouse.jpeg','media/thumbnail/saranginthehouse.jpeg',59),(82,0,'image','files/20210228/sarangsleep.jpeg','media/thumbnail/sarangsleep.jpeg',60),(83,0,'image','files/20210228/w.jpg','media/thumbnail/w.jpg',61),(84,0,'image','files/20210228/w2.jpg','media/thumbnail/w2.jpg',61),(85,0,'video','files/20210228/2_XI5ozTK.MOV','media/thumbnail/2_XI5ozTK.MOV',62),(86,0,'video','files/20210228/IMG_9772.MOV','media/thumbnail/IMG_9772.MOV',63),(87,0,'image','files/20210228/wecode_r3j7NXx.png','media/thumbnail/wecode_r3j7NXx.png',64),(88,0,'image','files/20210228/wecode_9iWGixr.png','media/thumbnail/wecode_9iWGixr.png',65),(89,0,'image','files/20210228/sarangbaby.jpeg','media/thumbnail/sarangbaby.jpeg',66),(90,0,'image','files/20210228/birthday_mXUZPka.jpg','media/thumbnail/birthday_mXUZPka.jpg',67),(91,0,'image','files/20210228/j_rDrntl9.png','media/thumbnail/j_rDrntl9.png',68),(92,0,'image','files/20210228/IMG_9736_.JPG','media/thumbnail/IMG_9736_.JPG',69),(93,0,'image','files/20210228/wecode_BSmgD9q.png','media/thumbnail/wecode_BSmgD9q.png',70),(94,0,'image','files/20210228/jy.png','media/thumbnail/jy.png',71),(95,0,'image','files/20210228/907BE5CE-C2E9-412D-AF99-612019DF84B6_f43SwH3.jpeg','media/thumbnail/907BE5CE-C2E9-412D-AF99-612019DF84B6_f43SwH3.jpeg',72),(96,0,'image','files/20210228/A240A715-7B11-4C31-84DE-D6824860E5DA_RiqmB33.jpeg','media/thumbnail/A240A715-7B11-4C31-84DE-D6824860E5DA_RiqmB33.jpeg',73),(97,0,'image','files/20210228/A240A715-7B11-4C31-84DE-D6824860E5DA_p34kokC.jpeg','media/thumbnail/A240A715-7B11-4C31-84DE-D6824860E5DA_p34kokC.jpeg',74),(98,0,'image','files/20210228/0962061D-8BE5-4DEB-889C-59CCAFA01E4D_0v61ESn.jpeg','media/thumbnail/0962061D-8BE5-4DEB-889C-59CCAFA01E4D_0v61ESn.jpeg',75),(99,0,'image','files/20210228/IMG_9755.JPG','media/thumbnail/IMG_9755.JPG',76),(100,0,'image','files/20210228/IMG_9819_VcQqhbb.JPG','media/thumbnail/IMG_9819_VcQqhbb.JPG',77),(101,0,'image','files/20210228/me.JPG','media/thumbnail/me.JPG',78),(102,0,'image','files/20210228/wecode_jFF7ipm.png','media/thumbnail/wecode_jFF7ipm.png',79),(103,0,'image','files/20210228/sarang11.jpeg','media/thumbnail/sarang11.jpeg',80),(104,0,'image','files/20210228/20210225_144302_BadwpfK.jpg','media/thumbnail/20210225_144302_BadwpfK.jpg',81),(105,0,'image','files/20210228/IMG_9819_U6P4SWJ.JPG','media/thumbnail/IMG_9819_U6P4SWJ.JPG',82),(106,0,'image','files/20210228/mustcommit.png','media/thumbnail/mustcommit.png',83),(107,0,'image','files/20210228/KakaoTalk_Photo_2021-02-21-02-49-47.jpeg','media/thumbnail/KakaoTalk_Photo_2021-02-21-02-49-47.jpeg',84),(108,0,'image','files/20210228/beauty_1612160985766.jpeg','media/thumbnail/beauty_1612160985766.jpeg',85),(109,0,'image','files/20210228/KakaoTalk_Photo_2021-02-21-02-49-56.jpeg','media/thumbnail/KakaoTalk_Photo_2021-02-21-02-49-56.jpeg',86),(110,0,'image','files/20210228/KakaoTalk_Photo_2021-02-21-02-50-11.jpeg','media/thumbnail/KakaoTalk_Photo_2021-02-21-02-50-11.jpeg',87),(111,0,'image','files/20210228/beauty_1612161312683.jpeg','media/thumbnail/beauty_1612161312683.jpeg',88),(112,0,'image','files/20210228/beauty_1612161784848.jpeg','media/thumbnail/beauty_1612161784848.jpeg',89),(113,0,'image','files/20210228/IMG_0622.JPG','media/thumbnail/IMG_0622.JPG',90),(114,0,'image','files/20210228/beauty_1612160985766_I9FalDG.jpeg','media/thumbnail/beauty_1612160985766_I9FalDG.jpeg',91),(115,0,'image','files/20210228/beauty_1612161312683_0jVVrHK.jpeg','media/thumbnail/beauty_1612161312683_0jVVrHK.jpeg',91),(116,0,'image','files/20210228/beauty_1612161774806.jpeg','media/thumbnail/beauty_1612161774806.jpeg',91),(117,0,'image','files/20210228/beauty_1612161784848_4sEvY52.jpeg','media/thumbnail/beauty_1612161784848_4sEvY52.jpeg',92),(118,0,'image','files/20210228/beauty_1612161799603.jpeg','media/thumbnail/beauty_1612161799603.jpeg',92),(119,0,'video','files/20210228/5_0lTegm8.mp4','media/thumbnail/5_0lTegm8.mp4',93),(120,0,'image','files/20210228/IMG_5866.JPG','media/thumbnail/IMG_5866.JPG',94),(121,0,'image','files/20210228/insatam_9iE3TL4.jpg','media/thumbnail/insatam_9iE3TL4.jpg',95),(122,0,'image','files/20210228/sarang10.jpeg','media/thumbnail/sarang10.jpeg',96),(123,0,'image','files/20210228/sarang7.jpeg','media/thumbnail/sarang7.jpeg',97),(124,0,'image','files/20210228/birthday_GX6osuQ.jpg','media/thumbnail/birthday_GX6osuQ.jpg',98),(125,0,'image','files/20210228/wecode_UPjMTB0.png','media/thumbnail/wecode_UPjMTB0.png',99),(126,0,'image','files/20210228/p.jpeg','media/thumbnail/p.jpeg',100),(127,0,'image','files/20210228/b.png','media/thumbnail/b.png',101),(128,0,'image','files/20210228/IMG_9272.MP4','media/thumbnail/IMG_9272.MP4',102),(129,0,'image','files/20210228/beauty_1612161774806_yhlQtTU.jpeg','media/thumbnail/beauty_1612161774806_yhlQtTU.jpeg',103),(130,0,'image','files/20210228/IMG_7522__LErwRBV.JPG','media/thumbnail/IMG_7522__LErwRBV.JPG',104),(131,0,'image','files/20210228/IMG_9934_.JPG','media/thumbnail/IMG_9934_.JPG',105),(132,0,'image','files/20210228/907BE5CE-C2E9-412D-AF99-612019DF84B6_5165uCZ.jpeg','media/thumbnail/907BE5CE-C2E9-412D-AF99-612019DF84B6_5165uCZ.jpeg',106),(133,0,'image','files/20210228/061_Ks4m3hs.png','media/thumbnail/061_Ks4m3hs.png',107),(134,0,'image','files/20210228/09E271F0-25DA-4790-9948-98D065E22FF2.jpeg','media/thumbnail/09E271F0-25DA-4790-9948-98D065E22FF2.jpeg',108),(135,0,'image','files/20210228/IMG_5862.JPG','media/thumbnail/IMG_5862.JPG',109),(136,0,'image','files/20210228/IMG_0245.JPG','media/thumbnail/IMG_0245.JPG',110),(137,0,'image','files/20210228/IMG_9870_.JPG','media/thumbnail/IMG_9870_.JPG',111),(138,0,'image','files/20210228/IMG_9819_6PUCq60.JPG','media/thumbnail/IMG_9819_6PUCq60.JPG',112),(139,0,'image','files/20210228/7A502B37-C0CF-40B3-A2E0-7C4C5EF008D3.jpeg','media/thumbnail/7A502B37-C0CF-40B3-A2E0-7C4C5EF008D3.jpeg',113),(140,0,'image','files/20210228/babysarang2.jpeg','media/thumbnail/babysarang2.jpeg',114),(141,0,'image','files/20210228/babysarang3.jpeg','media/thumbnail/babysarang3.jpeg',114),(142,0,'image','files/20210228/0962061D-8BE5-4DEB-889C-59CCAFA01E4D_4iBZ6RA.jpeg','media/thumbnail/0962061D-8BE5-4DEB-889C-59CCAFA01E4D_4iBZ6RA.jpeg',115),(143,0,'image','files/20210228/IMG_5866_ZtVrMu5.JPG','media/thumbnail/IMG_5866_ZtVrMu5.JPG',116),(144,0,'image','files/20210228/KakaoTalk_Photo_2021-02-21-02-50-11_l96iYLS.jpeg','media/thumbnail/KakaoTalk_Photo_2021-02-21-02-50-11_l96iYLS.jpeg',117),(145,0,'image','files/20210228/insatam_AzitlcG.jpg','media/thumbnail/insatam_AzitlcG.jpg',118),(146,0,'image','files/20210228/wepicker.jpg','media/thumbnail/wepicker.jpg',119),(147,0,'video','files/20210228/sarangnyamnyam.mp4','media/thumbnail/sarangnyamnyam.mp4',120),(148,0,'image','files/20210228/sarang6.jpeg','media/thumbnail/sarang6.jpeg',121),(149,0,'image','files/20210228/sarang3.jpeg','media/thumbnail/sarang3.jpeg',122),(150,0,'image','files/20210228/sarangcute_jvyf1lg.jpeg','media/thumbnail/sarangcute_jvyf1lg.jpeg',122),(151,0,'image','files/20210228/sarang1_y2e5pad.jpeg','media/thumbnail/sarang1_y2e5pad.jpeg',123),(152,0,'image','files/20210228/lazysarang.jpeg','media/thumbnail/lazysarang.jpeg',124),(153,0,'image','files/20210228/sarang7_CpF7ha1.jpeg','media/thumbnail/sarang7_CpF7ha1.jpeg',125),(154,0,'image','files/20210228/fakebono_a8B27hX.png','media/thumbnail/fakebono_a8B27hX.png',126),(155,0,'image','files/20210228/beauty_1612161784848_7i4EFtJ.jpeg','media/thumbnail/beauty_1612161784848_7i4EFtJ.jpeg',127),(156,0,'video','files/20210228/2_4rbAKNE.MOV','media/thumbnail/2_4rbAKNE.MOV',128),(157,0,'image','files/20210228/1.png','media/thumbnail/1.png',129),(158,0,'image','files/20210228/8B4BAC77-4804-40D5-9FDC-1A021CEF3B81_jh4thAv.jpeg','media/thumbnail/8B4BAC77-4804-40D5-9FDC-1A021CEF3B81_jh4thAv.jpeg',130),(159,0,'image','files/20210228/09E271F0-25DA-4790-9948-98D065E22FF2_PwE5xgz.jpeg','media/thumbnail/09E271F0-25DA-4790-9948-98D065E22FF2_PwE5xgz.jpeg',130),(160,0,'image','files/20210228/71FF99E0-5AD5-44B5-985A-9D6C0A200395_zH6mFHE.jpeg','media/thumbnail/71FF99E0-5AD5-44B5-985A-9D6C0A200395_zH6mFHE.jpeg',130),(161,0,'image','files/20210228/IMG_9736__oxQZdJT.JPG','media/thumbnail/IMG_9736__oxQZdJT.JPG',131),(162,0,'image','files/20210228/0962061D-8BE5-4DEB-889C-59CCAFA01E4D_Km33iYD.jpeg','media/thumbnail/0962061D-8BE5-4DEB-889C-59CCAFA01E4D_Km33iYD.jpeg',132),(163,0,'image','files/20210228/IMG_0623.JPG','media/thumbnail/IMG_0623.JPG',133),(164,0,'image','files/20210228/A240A715-7B11-4C31-84DE-D6824860E5DA_uVWY4E3.jpeg','media/thumbnail/A240A715-7B11-4C31-84DE-D6824860E5DA_uVWY4E3.jpeg',134),(165,0,'video','files/20210228/IMG_9772_KihrzDe.MOV','media/thumbnail/IMG_9772_KihrzDe.MOV',135),(166,0,'image','files/20210228/IMG_3614.JPG','media/thumbnail/IMG_3614.JPG',136),(167,0,'image','files/20210228/IMG_3616.JPG','media/thumbnail/IMG_3616.JPG',136),(168,0,'image','files/20210228/513CC3AC-B875-4AE0-B079-64C0809C9712_687CDyd.jpeg','media/thumbnail/513CC3AC-B875-4AE0-B079-64C0809C9712_687CDyd.jpeg',137),(169,0,'image','files/20210228/IMG_9934__Be7qxyy.JPG','media/thumbnail/IMG_9934__Be7qxyy.JPG',138),(170,0,'image','files/20210228/IMG_9790.JPG','media/thumbnail/IMG_9790.JPG',139),(171,0,'image','files/20210228/IMG_9819_SCPVbus.JPG','media/thumbnail/IMG_9819_SCPVbus.JPG',139),(172,0,'image','files/20210228/IMG_0245_fSs4055.JPG','media/thumbnail/IMG_0245_fSs4055.JPG',140),(173,0,'image','files/20210228/IMG_1327.JPG','media/thumbnail/IMG_1327.JPG',140);
/*!40000 ALTER TABLE `post_attach_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_reads`
--

DROP TABLE IF EXISTS `post_reads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_reads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id_id` int NOT NULL,
  `user_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_reads_post_id_id_a063f144_fk_posts_id` (`post_id_id`),
  KEY `post_reads_user_id_id_633ca547_fk_users_id` (`user_id_id`),
  CONSTRAINT `post_reads_post_id_id_a063f144_fk_posts_id` FOREIGN KEY (`post_id_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `post_reads_user_id_id_633ca547_fk_users_id` FOREIGN KEY (`user_id_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_reads`
--

LOCK TABLES `post_reads` WRITE;
/*!40000 ALTER TABLE `post_reads` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_reads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(3000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `like_count` int NOT NULL,
  `user_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `posts_user_id_id_4b5677ec_fk_users_id` (`user_id_id`),
  CONSTRAINT `posts_user_id_id_4b5677ec_fk_users_id` FOREIGN KEY (`user_id_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'사랑이는 산책중 ~ ','2021-02-27 08:39:59.832676',0,1),(2,'드르렁 푸~사랑쓰 ','2021-02-27 08:45:44.323804',0,1),(3,'눈와서 신난 사랑이 ','2021-02-27 08:47:12.400449',0,1),(4,'파슷하 냠쩝~ 맛있어 또와야지^^','2021-02-27 08:50:49.467175',0,1),(5,'나시고랭 만들어봄','2021-02-27 08:51:54.215138',0,1),(6,'멋있어....당신....','2021-02-27 08:52:23.722510',0,1),(7,'삼계죽 냠쩝~','2021-02-27 08:53:29.358690',0,1),(8,'행복한 하루><','2021-02-27 08:56:40.371236',0,1),(9,'친구가 만들어준 에어팟키링 ❤️','2021-02-27 08:58:34.682565',0,1),(10,'어디일까요?','2021-02-27 08:59:45.256217',0,1),(11,'피크닉~','2021-02-27 09:00:58.731041',0,1),(12,'동영상입니다!','2021-02-27 09:05:04.294785',0,2),(13,'여행가고싶다~!','2021-02-27 09:06:15.165311',0,2),(14,'멋있따!!!!','2021-02-27 09:07:10.102100',0,2),(15,'브이~><','2021-02-27 09:07:36.264543',0,2),(16,'즐거운 위코드데이!','2021-02-27 09:08:08.780725',0,2),(17,'1차 프로젝트 위피커팀!','2021-02-27 09:09:24.225383',0,2),(18,'아거스떼와 위피커의 만남','2021-02-27 09:19:27.687417',0,2),(19,'우잉????','2021-02-27 09:20:29.660499',0,2),(20,'귯귯귯!!!','2021-02-27 09:21:09.385747',0,2),(21,'첫 게시물은 동영상!','2021-02-27 14:59:27.140008',0,4),(22,'기업협업 instamg 파이팅!!!','2021-02-27 15:00:29.258468',0,4),(23,'패쪼입은 사랑이','2021-02-27 15:01:21.254677',0,4),(24,'갓재현!!','2021-02-27 15:01:51.142445',0,4),(25,'버거냠쩝','2021-02-27 15:02:41.545717',0,4),(26,'연우님이 그린 그림~','2021-02-27 15:03:40.068359',0,4),(27,'til','2021-02-27 15:04:27.549928',0,4),(28,'꿀잠자는 사랑이','2021-02-27 15:04:56.365024',0,4),(29,'위코드 16기 화이팅!','2021-02-27 15:05:36.285776',0,4),(30,'위코드 16기 수료일까지 화이팅!!!','2021-02-27 15:07:54.942588',0,5),(31,'위코드데이때 찍은 영상!','2021-02-27 15:08:26.140997',0,5),(32,'희진님과 연우님ㅎ','2021-02-27 15:09:51.051925',0,5),(33,'사진과 영상 같이 업로드~','2021-02-27 15:10:46.705811',0,5),(34,'도쿄 하라주','2021-02-27 15:11:30.927690',0,5),(35,'사랑이 너무 귀여워><','2021-02-27 15:12:18.620483',0,5),(36,'사랑이❤️','2021-02-27 15:13:16.026157',0,5),(37,'스타벅스','2021-02-27 15:13:51.701348',0,5),(38,'만두집 사장님...?','2021-02-27 15:14:31.948524',0,5),(39,'연우님 멋져멋져!!!','2021-02-27 15:15:16.678080',0,5),(40,'instamg팀 파이팅~!!!','2021-02-27 15:16:37.333752',0,5),(41,'지원님...?','2021-02-27 15:19:14.240017',0,6),(42,'보노보노','2021-02-27 15:19:39.608621',0,6),(43,'gooood!!!!!','2021-02-27 15:22:59.403151',0,7),(44,'cute!!!!','2021-02-27 15:23:21.968223',0,7),(45,'멋있는 하늘...','2021-02-27 15:23:47.120413',0,7),(46,'한적한 샤쿠지공원','2021-02-27 15:24:36.602616',0,7),(47,'너무 귀여워,,,ㅠㅠ','2021-02-27 15:26:26.909569',0,8),(48,'멋있다!','2021-02-27 15:27:03.455156',0,8),(49,'응애베어~','2021-02-27 15:27:27.060926',0,8),(50,'응애베어좌니~','2021-02-27 15:28:34.186477',0,9),(51,'예쁜튤립','2021-02-27 15:29:00.328467',0,9),(52,'우리집 앞 풍경','2021-02-27 15:29:25.648333',0,9),(53,'좌니~생파~','2021-02-27 15:30:09.089353',0,9),(54,'강아지는 다 귀여워ㅜ','2021-02-27 15:30:54.007568',0,9),(55,'끄적끄적','2021-02-27 15:31:22.131887',0,9),(56,'위코드 화이팅!!!','2021-02-27 15:32:35.740942',0,10),(57,'연우님이 그린 그림들ㅎㅎ','2021-02-27 15:33:03.701441',0,10),(58,'사랑이!','2021-02-27 15:34:14.572157',0,11),(59,'사랑이!너무귀엽잖아!!!','2021-02-27 15:35:09.649523',0,11),(60,'쿨쿨 사랑이~','2021-02-27 15:35:34.608249',0,11),(61,'연우님 민선님 소원 이루어지게 해주세요~','2021-02-27 15:37:10.158002',0,12),(62,'헤이 펌킨','2021-02-27 15:37:36.506862',0,12),(63,'기차여행','2021-02-27 15:39:02.713682',0,13),(64,'16기 화이팅!!!','2021-02-27 15:39:25.870462',0,13),(65,'16기 화이팅!!!모두 취뽀하게 해주세요!!!','2021-02-27 15:40:24.575950',0,14),(66,'아기 사랑이','2021-02-27 15:41:10.595451',0,14),(67,'생일파티..위코드 16기 동기들과 함께..','2021-02-27 15:42:48.645779',0,15),(68,'응애','2021-02-27 15:43:13.924964',0,15),(69,'냠쩝~','2021-02-27 15:44:46.543272',0,16),(70,'16기!!!!최고!!!!','2021-02-27 15:45:12.752040',0,16),(71,'재윤님','2021-02-27 15:46:46.425201',0,17),(72,'에비스에서 냠쩝','2021-02-27 15:48:21.407547',0,18),(73,'키치죠지 스타벅스','2021-02-27 15:48:53.578527',0,18),(74,'키치죠지 스타벅스!!!','2021-02-27 15:49:57.541534',0,19),(75,'하늘...바람....','2021-02-27 15:50:35.309345',0,19),(76,'또 가고 싶다','2021-02-27 15:51:13.101317',0,19),(77,'튤립','2021-02-27 15:52:26.245553',0,20),(78,'왕발 연우님~ㅎㅎ','2021-02-27 15:53:44.775754',0,21),(79,'16기!귯!!!!','2021-02-27 15:54:11.025347',0,21),(80,'공부 방해중인 사랑이','2021-02-27 15:55:24.051550',0,22),(81,'스마일~^_^','2021-02-27 15:56:40.406457',0,23),(82,'튤립','2021-02-27 15:57:17.549069',0,23),(83,'앗!!!ㅋㅋㅋ','2021-02-27 16:08:48.817120',0,23),(84,'데스트리','2021-02-27 16:09:59.030294',0,24),(85,'열코딩중인 연우님!','2021-02-27 16:11:15.248828',0,25),(86,'데스플랜트....','2021-02-27 16:12:16.332838',0,26),(87,'열코딩중인 팀원들+_+','2021-02-27 16:13:26.484340',0,27),(88,'중간발표중','2021-02-27 16:14:40.505458',0,28),(89,'발표중인 지원님','2021-02-27 16:15:56.240660',0,29),(90,'코로나 끝났으면 좋겠다...여행가고싶어..','2021-02-27 16:17:25.470016',0,30),(91,'bearbnb팀 중간발표','2021-02-27 16:19:00.563306',0,31),(92,'보노보노 아니 지원님^^','2021-02-27 16:19:53.321846',0,31),(93,'목요일은 위코드데이','2021-02-27 16:21:00.984059',0,32),(94,'멋져!','2021-02-27 16:22:23.673530',0,33),(95,'화이팅!','2021-02-27 16:23:04.745427',0,33),(96,'사랑아 뭘 먹은게야..!ㅋㅋ','2021-02-27 16:24:21.083672',0,34),(97,'토실토실 사랑이❤️','2021-02-27 16:25:01.122358',0,34),(98,'성현님 생일파티!!!','2021-02-27 16:26:22.618203',0,35),(99,'위코드 16기 짱짱!','2021-02-27 16:27:01.189714',0,35),(100,'뀨~','2021-02-27 16:28:06.343541',0,36),(101,'?뭐하시는거죠??ㅋㅋㅋ','2021-02-27 16:28:41.695594',0,36),(102,'필통 귀엽쥬~?','2021-02-27 16:30:16.186545',0,37),(103,'뭔가 심각쓰...ㅋ','2021-02-27 16:30:56.849281',0,37),(104,'댕댕쓰 너무 귀엽자너,,','2021-02-27 16:32:27.501576',0,38),(105,'또 먹고 싶다..배고파','2021-02-27 16:33:35.264790',0,39),(106,'버거가 최고야','2021-02-27 16:34:03.331461',0,39),(107,'cooool~','2021-02-27 16:35:19.013788',0,40),(108,'배고파서 무작정 들어갔는데 역시나 맛없었다..','2021-02-27 16:36:05.000593',0,40),(109,'우리집 앞....이면 좋겠다..','2021-02-27 16:38:44.183350',0,41),(110,'2021','2021-02-27 16:39:38.814984',0,41),(111,'2017','2021-02-27 16:40:18.085741',0,41),(112,'튤립','2021-02-27 16:42:05.314006',0,42),(113,'도쿄여행','2021-02-27 16:43:01.484415',0,43),(114,'사랑이 아기시절','2021-02-27 16:44:12.152118',0,44),(115,'맑은하늘','2021-02-27 16:44:51.547505',0,44),(116,'여행가고싶다','2021-02-27 16:45:18.024371',0,44),(117,'우리팀 화이팅!','2021-02-27 16:46:24.178606',0,45),(118,'우리팀 화이팅!','2021-02-27 16:46:52.671281',0,45),(119,'우리팀 화이팅!','2021-02-27 16:47:48.576483',0,46),(120,'뭐하냐구!!!ㅋㅋ','2021-02-27 16:48:46.932449',0,46),(121,'냠쪕중인 사랑쓰','2021-02-27 16:49:17.722190',0,46),(122,'패쪼입은 사랑이ㅎㅎ','2021-02-27 16:50:46.147575',0,47),(123,'복실복실 사랑쓰','2021-02-27 16:51:22.011816',0,47),(124,'사랑쓰 고정석','2021-02-27 16:51:47.993605',0,47),(125,'돼지사랑쓰','2021-02-27 16:52:24.488292',0,47),(126,'보노보노 입니다~','2021-02-27 16:53:21.400425',0,48),(127,'보노보노 입니다~','2021-02-27 16:53:39.521120',0,48),(128,'ㅋㅋㅋㅋㅋㅋ','2021-02-27 16:54:50.085828',0,49),(129,'위코드~','2021-02-27 16:55:11.869011',0,49),(130,'도쿄여행','2021-02-27 16:55:49.498958',0,49),(131,'친구랑 브런치','2021-02-27 16:56:37.526593',0,49),(132,'웃자','2021-02-27 16:58:26.648584',0,50),(133,'올해는 좋은일만 생길거야','2021-02-27 16:59:00.014975',0,50),(134,'산책','2021-02-27 16:59:20.992362',0,50),(135,'기차여행','2021-02-27 16:59:43.810837',0,50),(136,'에메랄드 빛','2021-02-27 17:00:46.149108',0,50),(137,'낚시금지','2021-02-27 17:01:21.311020',0,50),(138,'꿀맛','2021-02-27 17:02:26.294308',0,50),(139,'튤립','2021-02-27 17:02:53.529792',0,50),(140,'예술이란 무엇일까','2021-02-27 17:03:36.557415',0,50);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stories`
--

DROP TABLE IF EXISTS `stories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `story_profile` tinyint(1) NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stories_user_id_id_8dd7b4ed_fk_users_id` (`user_id_id`),
  CONSTRAINT `stories_user_id_id_8dd7b4ed_fk_users_id` FOREIGN KEY (`user_id_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stories`
--

LOCK TABLES `stories` WRITE;
/*!40000 ALTER TABLE `stories` DISABLE KEYS */;
/*!40000 ALTER TABLE `stories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `story_attach_files`
--

DROP TABLE IF EXISTS `story_attach_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `story_attach_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_type` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `path` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `thumbnail_path` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `story_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `story_attach_files_story_id_id_7973d794_fk_stories_id` (`story_id_id`),
  CONSTRAINT `story_attach_files_story_id_id_7973d794_fk_stories_id` FOREIGN KEY (`story_id_id`) REFERENCES `stories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `story_attach_files`
--

LOCK TABLES `story_attach_files` WRITE;
/*!40000 ALTER TABLE `story_attach_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `story_attach_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `story_reads`
--

DROP TABLE IF EXISTS `story_reads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `story_reads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `story_id_id` int NOT NULL,
  `user_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `story_reads_story_id_id_6a24c507_fk_stories_id` (`story_id_id`),
  KEY `story_reads_user_id_id_b9752d02_fk_users_id` (`user_id_id`),
  CONSTRAINT `story_reads_story_id_id_6a24c507_fk_stories_id` FOREIGN KEY (`story_id_id`) REFERENCES `stories` (`id`),
  CONSTRAINT `story_reads_user_id_id_b9752d02_fk_users_id` FOREIGN KEY (`user_id_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `story_reads`
--

LOCK TABLES `story_reads` WRITE;
/*!40000 ALTER TABLE `story_reads` DISABLE KEYS */;
/*!40000 ALTER TABLE `story_reads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagged_users`
--

DROP TABLE IF EXISTS `tagged_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tagged_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment_id_id` int DEFAULT NULL,
  `post_id_id` int DEFAULT NULL,
  `story_id_id` int DEFAULT NULL,
  `user_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tagged_users_comment_id_id_9882f522_fk_comments_id` (`comment_id_id`),
  KEY `tagged_users_post_id_id_63d21dae_fk_posts_id` (`post_id_id`),
  KEY `tagged_users_story_id_id_d212b999_fk_stories_id` (`story_id_id`),
  KEY `tagged_users_user_id_id_da70c18c_fk_users_id` (`user_id_id`),
  CONSTRAINT `tagged_users_comment_id_id_9882f522_fk_comments_id` FOREIGN KEY (`comment_id_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `tagged_users_post_id_id_63d21dae_fk_posts_id` FOREIGN KEY (`post_id_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `tagged_users_story_id_id_d212b999_fk_stories_id` FOREIGN KEY (`story_id_id`) REFERENCES `stories` (`id`),
  CONSTRAINT `tagged_users_user_id_id_da70c18c_fk_users_id` FOREIGN KEY (`user_id_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagged_users`
--

LOCK TABLES `tagged_users` WRITE;
/*!40000 ALTER TABLE `tagged_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `tagged_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(2000) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(130) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `profile_photo` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `thumbnail_path` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `profile_message` varchar(5000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'burgerqueen','$2b$12$3fb75lo70gwm.8mzwcsLj.9MrHI5qHxtg.gYe3CO4Ju.M6kmqIHuG','010-2222-1616','kelly@wecode.com','files/20210227/slackselfi_peYABw5.jpeg','thumbnail/slackselfi_zPwpVQY.jpeg','안녕하세요~반갑습니다^^','2021-02-27 06:43:25.659744'),(2,'harley','$2b$12$rsxGWTn0lURgecOf3c3tZurEwFwFBzkKuqL/kZNTJzlDaBoJER9tK','010-1111-2222','harley@wecode.com','files/20210227/gumsarang_5Fyo19d.jpeg','thumbnail/gumsarang_me0V45Q.jpeg','(｀･ω-)▄︻┻┳═一','2021-02-27 06:43:41.278500'),(3,'pumpkin_young','$2b$12$y51trOx9AtHWFIjcw3sZYOEWbsyH1hlqE/p8JZNgfh4eXBH9X3t4e','01029101701','pumpkin@naver.com','files/20210227/iOS_이미지.jpg','thumbnail/iOS_이미지.jpg','나는 pumpkin영~!!!!','2021-02-27 06:44:05.376583'),(4,'hannah','$2b$12$vVVxbHOUddgzSM8za08qJ.pS75zPqh2fTR14.jaGwRJ2t/.mUnEiO','010-1111-1616','hannah@wecode.com','files/20210227/sarang1.jpeg','thumbnail/sarang1.jpeg','안녕~나는 헤나~프론트개발자입니다!','2021-02-27 06:44:23.975834'),(5,'kate','$2b$12$FAihoSVPuqAhkhmbYeMx2.8oCxAhcUd3zCNUTjR8lIpt0HAVXjGS2','010-1234-1616','kate@wecode.com','','','프론트개발자입니다! 화이팅!','2021-02-27 06:44:32.125304'),(6,'Sherri','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','3283569484','frubio@miller-calhoun.com','','','Religious hair sense than color.','1986-10-10 14:50:26.000000'),(7,'Katie','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','095-265-6995x94476','melindabaldwin@miller-olson.com','','','Most everything early edge.','1981-01-20 13:54:23.000000'),(8,'Carla','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','(267)661-1036','xmosley@garcia.net','','','Economy community because program news.','1979-11-24 02:44:43.000000'),(9,'David','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','+1-168-170-1160x973','ilambert@russell.info','','','Stage former state space front.','1999-06-14 12:36:11.000000'),(10,'Cynthia','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','001-802-003-0293x404','christopherrogers@williams.com','','','Keep assume born fight space author charge.','1971-02-16 06:17:19.000000'),(11,'John','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','001-391-1939x040','connermichael@rich-barrett.biz','','','Republican economy care describe social me phone.','1976-12-10 10:40:18.000000'),(12,'Kimberly','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','493.750.9638x044','clarkmelissa@hotmail.com','','','Government week yes summer similar.','2002-04-01 23:32:06.000000'),(13,'Madison','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','(458)152-2913x4849','gibsonderek@jensen.com','','','Hotel its process occur community painting.','1973-03-16 01:56:29.000000'),(14,'Michael','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','126-778-3789','rodriguezadam@yahoo.com','','','None set road exist television white property.','1989-08-26 00:47:58.000000'),(15,'Johnny','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','+1-504-940-1075','willisadam@hotmail.com','','','Person dream rate gas fill.','2005-07-08 06:50:18.000000'),(16,'Caitlin','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','424-902-4538x0391','cunninghamblake@hotmail.com','','','Sign relationship both picture.','2007-03-18 22:57:49.000000'),(17,'Marvin','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','681.102.4355x33064','cbrown@hill-weaver.com','','','As bring southern southern see give whether.','1991-11-05 13:24:25.000000'),(18,'Ashley','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','6195143701','shannonmunoz@gmail.com','','','Rule father go including student drop quickly.','2007-12-10 13:30:58.000000'),(19,'Heather','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','443.079.8492x977','david87@hotmail.com','','','That visit sing dog she.','2015-02-11 00:12:00.000000'),(20,'William','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','001-334-712-0245x616','jwatson@white-duncan.com','','','Tonight trial loss field mother sport painting.','2018-02-03 21:37:24.000000'),(21,'Robert','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','+1-714-230-7814x981','escott@nelson-ward.com','','','Court class blue interesting piece trip her.','2017-10-26 06:42:05.000000'),(22,'Nicole','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','5937629825','nholt@olson-horton.com','','','Security chair spring guy rise machine.','1984-01-03 01:16:13.000000'),(23,'Anna','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','001-031-402-8520x86234','hopkinsroger@gmail.com','','','Especially range plant well spring tax stay let.','1981-05-31 23:15:04.000000'),(24,'Beth','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','(050)280-9281','amber46@leblanc-davis.biz','','','Month often woman realize fast social.','1991-08-28 00:13:49.000000'),(25,'George','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','(950)336-7109','timothyrobinson@bennett.com','','','Way environment security party many often market dog.','1999-02-15 02:05:50.000000'),(26,'Jesus','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','977-042-6681','destinyvasquez@murphy-phillips.org','','','Car senior practice mouth.','2002-12-31 18:00:29.000000'),(27,'Kyle','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','148-250-5512','andrewsmith@welch.net','','','International sometimes home.','2020-01-07 01:26:35.000000'),(28,'Kathleen','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','001-806-747-5068','kennethclark@lawson-wallace.com','','','High get west value scene.','1991-07-13 03:44:26.000000'),(29,'Dawn','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','+1-301-823-8956x7009','jonathan88@hotmail.com','','','Now same natural clear.','1978-02-06 22:28:50.000000'),(30,'Stephanie','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','(599)021-9199x3087','matthewbaldwin@hotmail.com','','','Whole create president born attack every.','1996-06-20 21:47:30.000000'),(31,'Barbara','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','(228)483-1665x21426','heathanna@gilmore-sparks.com','','','Sell response space school.','1976-06-04 22:24:58.000000'),(32,'Darren','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','(659)751-3467x53177','tina75@yahoo.com','','','Card realize almost produce seat offer.','1988-02-01 13:53:50.000000'),(33,'Andrew','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','4558895357','juanwiggins@martin.com','','','Dream institution social require lay yes go.','1970-05-18 17:22:42.000000'),(34,'Brett','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','001-777-573-5174x08028','robingarcia@mueller.org','','','Force condition worker.','1991-09-27 22:13:08.000000'),(35,'Cathy','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','612.022.9910x11339','keith15@williams.com','','','Growth toward lay book ability full professional.','2012-09-17 07:14:04.000000'),(36,'Mary','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','228-947-8039x554','marcus20@bennett.org','','','Middle thank player receive establish research.','1993-01-23 01:53:01.000000'),(37,'Matthew','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','395-144-7805x9390','edwardlong@bryant-paul.com','','','Feel under field you message price eye.','1975-08-07 16:33:38.000000'),(38,'Nathaniel','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','761.361.1979x15454','brian46@armstrong.org','','','Decision past I blue against.','1981-01-05 10:30:37.000000'),(39,'Russell','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','001-626-448-2457x86464','sherryhinton@yahoo.com','','','Beautiful box no medical the must bar go.','2017-11-26 13:40:02.000000'),(40,'Steven','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','+1-520-876-9955x643','alexis59@larson-scott.com','','','Rock those attack world.','1992-07-14 20:23:42.000000'),(41,'Elizabeth','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','(274)555-4038x845','robert26@vargas-bennett.com','','','History hear any however kind.','2011-04-13 18:50:58.000000'),(42,'Jill','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','+1-315-521-5461x5511','jameskevin@hotmail.com','','','Top since drug ball bar best choice professor.','1971-09-20 22:31:08.000000'),(43,'Walter','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','967-371-6280x047','zrobinson@hotmail.com','','','Cell environmental opportunity same American.','1996-06-10 05:34:32.000000'),(44,'Christopher','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','(944)745-5789','margaretbrown@rodriguez-burns.info','','','Season nation leave health choice.','1990-09-23 22:58:30.000000'),(45,'Janice','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','329.893.3274x37029','apeters@gmail.com','','','Seven owner piece magazine play.','1986-05-16 20:45:15.000000'),(46,'Melissa','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','295.012.8944x005','thomas01@ali-warner.com','','','Sit standard reason door left bit fall.','2000-12-14 14:27:23.000000'),(47,'Karen','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','001-078-660-6254x161','jameseaton@torres.com','','','Answer moment indeed paper kid thought.','1979-09-22 22:55:23.000000'),(48,'Eugene','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','477-268-9841x233','thomascolon@vargas.org','','','Enough situation between blood spring move.','2020-08-04 13:07:44.000000'),(49,'Joseph','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','001-318-828-7092x4922','andrea01@yahoo.com','','','Forget character individual choose really.','2000-12-06 05:41:38.000000'),(50,'Kayla','$2b$12$G2Ce.akiEVHYwXUIhZ9p2uEXQD3W/2IRmbTsJX/WNZWICvqP58Ony','276-914-4250x36922','jessicastrong@galloway.com','','','Need indicate certain magazine cost idea.','2000-09-11 14:26:24.000000');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-28  2:08:56
