-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: smeg
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `me_id` varchar(15) NOT NULL,
  `me_pw` varchar(255) NOT NULL,
  `me_gender` varchar(2) NOT NULL,
  `me_birth` datetime NOT NULL,
  `me_calendar` varchar(2) NOT NULL,
  `me_email` varchar(30) NOT NULL,
  `me_authority` varchar(5) NOT NULL DEFAULT 'USER',
  `me_postcode` int NOT NULL,
  `me_address` longtext NOT NULL,
  `me_detail_address` longtext NOT NULL,
  `me_phone` varchar(14) NOT NULL,
  `me_name` varchar(10) NOT NULL,
  `me_cookie` varchar(255) DEFAULT NULL,
  `me_cookie_limit` datetime DEFAULT NULL,
  PRIMARY KEY (`me_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('ask','ask','여자','1990-01-02 00:00:00','양력','ask@naver.com','USER',5362,'서울 양천구 오목로 지하 342','타타','010-2545-6432','차수현',NULL,NULL),('axc','axc','여자','2021-02-24 00:00:00','양력','asdf@naver.com','USER',1235,'서울 양천구 오목로 지하 342','부조','010-6245-6432','김수민',NULL,NULL),('Babo','Babo','남자','1995-12-23 00:00:00','양력','Babo@naver.com','USER',1666,'서울 양천구 오목로 지하 342','나나','010-2235-6432','박한솔',NULL,NULL),('best','best','남자','1234-01-11 00:00:00','양력','best@naver.com','USER',1363,'서울 양천구 오목로 지하 342','개조','010-5345-6432','김현중',NULL,NULL),('e','e','남자','2024-01-01 00:00:00','양력','ok@naver.com','USER',8006,'서울 양천구 오목로 지하 342','판교 관리자','010-2335-6432','지미엽',NULL,NULL),('for','for','여자','1732-09-23 00:00:00','양력','for@naver.com','USER',2231,'서울 양천구 오목로 지하 342','봐봐','010-2125-6432','지민수',NULL,NULL),('goat','goat','여자','1993-01-23 00:00:00','양력','goat@naver.com','USER',2345,'서울 양천구 오목로 지하 342','수조','010-5345-6432','김수현',NULL,NULL),('gogo','gogo','여자','2000-01-02 00:00:00','양력','gogo@naver.com','USER',6364,'서울 양천구 오목로 지하 342','아아','010-4443-6432','박한나',NULL,NULL),('goto','goto','여자','1532-10-03 00:00:00','양력','goto@naver.com','USER',3263,'서울 양천구 오목로 지하 342','가가','010-6335-6432','지동수',NULL,NULL),('gow','gow','남자','2020-01-23 00:00:00','양력','gow@naver.com','USER',6743,'서울 양천구 오목로 지하 342','상조','010-7345-6432','김나현',NULL,NULL),('jim','jim','남자','2023-12-05 00:00:00','양력','qasd@naver.com','USER',5555,'서울 양천구 오목로 지하 342','육교','010-2555-6432','이수지',NULL,NULL),('kim','kim','여자','2022-11-03 00:00:00','양력','tjrgnsdx2@naver.com','USER',5232,'서울 양천구 오목로 지하 342','칠교','010-3345-6432','이현조',NULL,NULL),('ok','ok','남자','1989-11-22 00:00:00','양력','ok@naver.com','USER',4456,'서울 양천구 오목로 지하 342','파파','010-6665-6432','지동엽',NULL,NULL),('q','q','남자','2024-01-01 00:00:00','양력','ok@naver.com','USER',8006,'서울 양천구 오목로 지하 342','판교 관리자','010-2335-6432','지상엽',NULL,NULL),('qw','qw','남자','2024-01-01 00:00:00','양력','ok@naver.com','USER',8006,'서울 양천구 오목로 지하 342','판교 관리자','010-2335-6432','지부엽',NULL,NULL),('r','r','남자','2024-01-01 00:00:00','양력','ok@naver.com','USER',8006,'서울 양천구 오목로 지하 342','판교 관리자','010-2335-6432','지피엽',NULL,NULL),('smegadmin','$2a$10$nVODneOMX.7r/szTYkRiKO2qcGJNZtUAvkPJAuAZIq3scjmXce2Iu','남자','2024-01-01 00:00:00','양력','tjrgnsdx1@naver.com','ADMIN',13480,'경기 성남시 분당구 대왕판교로 477','판교 관리자','010-2324-3252','관리자','9A4D5CF85044A8019BE98BEE61641D73','2024-05-27 15:18:41'),('te','te','남자','2024-01-01 00:00:00','양력','ok@naver.com','USER',8006,'서울 양천구 오목로 지하 342','판교 관리자','010-2335-6432','지지엽',NULL,NULL),('tjrgnsdx','$2a$10$.oNadj9l35iRC/npMtBjRujroRV2IfxgEjQcPZ/eyyHD5oF8BVkAu','남자','2024-01-01 00:00:00','양력','tjrgnsdx1@naver.com','USER',8006,'서울 양천구 오목로 지하 342','팔교','010-2335-6432','박석훈',NULL,NULL),('w','w','남자','2024-01-01 00:00:00','양력','ok@naver.com','USER',8006,'서울 양천구 오목로 지하 342','판교 관리자','010-2335-6432','지지엽',NULL,NULL),('we','we','남자','2024-01-01 00:00:00','양력','ok@naver.com','USER',8006,'서울 양천구 오목로 지하 342','판교 관리자','010-2335-6432','지미엽',NULL,NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-20 16:14:48
