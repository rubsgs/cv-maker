-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: cv-maker
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addressName` varchar(80) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastChange` timestamp NULL DEFAULT NULL,
  `idCountry` int(10) unsigned NOT NULL,
  `address` tinytext NOT NULL,
  `number` varchar(80) NOT NULL,
  `complement` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Address_idCountry_idx` (`idCountry`),
  CONSTRAINT `fk_address_idCountry` FOREIGN KEY (`idCountry`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_city`
--

DROP TABLE IF EXISTS `address_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_city` (
  `idAddress` int(10) unsigned NOT NULL,
  `idCity` int(10) unsigned NOT NULL,
  `cityName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idAddress`),
  KEY `fk_address_city_idCity_idx` (`idCity`),
  CONSTRAINT `fk_address_city_idAddress` FOREIGN KEY (`idAddress`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_city_idCity` FOREIGN KEY (`idCity`) REFERENCES `city` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_city`
--

LOCK TABLES `address_city` WRITE;
/*!40000 ALTER TABLE `address_city` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_state`
--

DROP TABLE IF EXISTS `address_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_state` (
  `idAddress` int(10) unsigned NOT NULL,
  `idState` int(10) unsigned NOT NULL,
  `sateName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idAddress`),
  KEY `fk_address_state_idState_idx` (`idState`),
  CONSTRAINT `fk_address_state_idAddress` FOREIGN KEY (`idAddress`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_state_idState` FOREIGN KEY (`idState`) REFERENCES `state` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_state`
--

LOCK TABLES `address_state` WRITE;
/*!40000 ALTER TABLE `address_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idCountry` int(10) unsigned DEFAULT NULL,
  `idState` int(10) unsigned DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_city_idCountry_idx` (`idCountry`),
  KEY `fk_city_idState_idx` (`idState`),
  CONSTRAINT `fk_city_idCountry` FOREIGN KEY (`idCountry`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_city_idState` FOREIGN KEY (`idState`) REFERENCES `state` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (0,0,0,'Foreign City',1),(1,1,1,'São Paulo',1);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Brazil',1);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cv`
--

DROP TABLE IF EXISTS `cv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cv` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cvName` varchar(80) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastChange` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cv`
--

LOCK TABLES `cv` WRITE;
/*!40000 ALTER TABLE `cv` DISABLE KEYS */;
/*!40000 ALTER TABLE `cv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cv_applicant_description`
--

DROP TABLE IF EXISTS `cv_applicant_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cv_applicant_description` (
  `idCv` int(10) unsigned NOT NULL,
  `description` tinytext NOT NULL,
  PRIMARY KEY (`idCv`),
  CONSTRAINT `fk_cv_applicant_description_idCv` FOREIGN KEY (`idCv`) REFERENCES `cv` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cv_applicant_description`
--

LOCK TABLES `cv_applicant_description` WRITE;
/*!40000 ALTER TABLE `cv_applicant_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `cv_applicant_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cv_header`
--

DROP TABLE IF EXISTS `cv_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cv_header` (
  `idCv` int(10) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `idAddress` int(10) unsigned NOT NULL,
  `email` tinytext NOT NULL,
  `siteUrl` tinytext,
  `phone1` varchar(50) DEFAULT NULL,
  `idTypePhone1` int(10) unsigned DEFAULT NULL,
  `phone2` varchar(50) DEFAULT NULL,
  `idTypePhone2` int(10) unsigned DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  PRIMARY KEY (`idCv`),
  KEY `fk_cv_header_idAddress_idx` (`idAddress`),
  KEY `fk_cv_header_idTypePhone1_idx` (`idTypePhone1`),
  KEY `fk_cv_header_idTypePhone2_idx` (`idTypePhone2`),
  CONSTRAINT `fk_cv_header_idAddress` FOREIGN KEY (`idAddress`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cv_header_idCv` FOREIGN KEY (`idCv`) REFERENCES `cv` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cv_header_idTypePhone1` FOREIGN KEY (`idTypePhone1`) REFERENCES `phone_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cv_header_idTypePhone2` FOREIGN KEY (`idTypePhone2`) REFERENCES `phone_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cv_header`
--

LOCK TABLES `cv_header` WRITE;
/*!40000 ALTER TABLE `cv_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `cv_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cv_skill`
--

DROP TABLE IF EXISTS `cv_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cv_skill` (
  `idCv` int(10) unsigned NOT NULL,
  `idSkill` int(10) unsigned NOT NULL,
  `idSkillLevel` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idCv`,`idSkill`,`idSkillLevel`),
  KEY `fk_cv_skill_idSkill_idx` (`idSkill`),
  KEY `fk_cv_skill_idSkillLevel_idx` (`idSkillLevel`),
  CONSTRAINT `fk_cv_skill_idCv` FOREIGN KEY (`idCv`) REFERENCES `cv` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cv_skill_idSkill` FOREIGN KEY (`idSkill`) REFERENCES `skill` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cv_skill_idSkillLevel` FOREIGN KEY (`idSkillLevel`) REFERENCES `skill_level` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cv_skill`
--

LOCK TABLES `cv_skill` WRITE;
/*!40000 ALTER TABLE `cv_skill` DISABLE KEYS */;
/*!40000 ALTER TABLE `cv_skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experience`
--

DROP TABLE IF EXISTS `experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experience` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idCompany` int(10) unsigned NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `jobTitle` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `idCv` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_experiences_idCv_idx` (`idCv`),
  KEY `fk_experiences_idCompany_idx` (`idCompany`),
  CONSTRAINT `fk_experiences_idCompany` FOREIGN KEY (`idCompany`) REFERENCES `company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiences_idCv` FOREIGN KEY (`idCv`) REFERENCES `cv` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experience`
--

LOCK TABLES `experience` WRITE;
/*!40000 ALTER TABLE `experience` DISABLE KEYS */;
/*!40000 ALTER TABLE `experience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_type`
--

DROP TABLE IF EXISTS `phone_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_type`
--

LOCK TABLES `phone_type` WRITE;
/*!40000 ALTER TABLE `phone_type` DISABLE KEYS */;
INSERT INTO `phone_type` VALUES (1,'Work',1),(2,'Home',1),(3,'Cellphone',1);
/*!40000 ALTER TABLE `phone_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill`
--

DROP TABLE IF EXISTS `skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `skillName` varchar(200) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `idSkillType` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_skill_idSkillType_idx` (`idSkillType`),
  CONSTRAINT `fk_skill_idSkillType` FOREIGN KEY (`idSkillType`) REFERENCES `skill_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill`
--

LOCK TABLES `skill` WRITE;
/*!40000 ALTER TABLE `skill` DISABLE KEYS */;
INSERT INTO `skill` VALUES (1,'PHP',1,1),(2,'Javascript',1,1),(3,'HTML',1,1),(4,'CSS',1,1),(5,'Python',1,1),(6,'Java',1,1),(7,'English',1,2),(8,'Portuguese',1,2);
/*!40000 ALTER TABLE `skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_level`
--

DROP TABLE IF EXISTS `skill_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill_level` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `displayedText` varchar(45) NOT NULL,
  `fillPercentage` decimal(10,2) DEFAULT NULL,
  `idSkillType` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_skill_level_idSkillType_idx` (`idSkillType`),
  CONSTRAINT `fk_skill_level_idSkillType` FOREIGN KEY (`idSkillType`) REFERENCES `skill_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_level`
--

LOCK TABLES `skill_level` WRITE;
/*!40000 ALTER TABLE `skill_level` DISABLE KEYS */;
INSERT INTO `skill_level` VALUES (1,'0',0.00,1),(2,'1',10.00,1),(3,'2',20.00,1),(4,'3',30.00,1),(5,'4',40.00,1),(6,'5',50.00,1),(7,'6',60.00,1),(8,'7',70.00,1),(9,'8',80.00,1),(10,'9',90.00,1),(11,'10',100.00,1),(12,'Beginner',0.00,2),(13,'Intermidiate',33.33,2),(14,'Advanced',66.66,2),(15,'Fluent',100.00,2);
/*!40000 ALTER TABLE `skill_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_type`
--

DROP TABLE IF EXISTS `skill_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_type`
--

LOCK TABLES `skill_type` WRITE;
/*!40000 ALTER TABLE `skill_type` DISABLE KEYS */;
INSERT INTO `skill_type` VALUES (1,'Technical Skills',1),(2,'Language Skills',1);
/*!40000 ALTER TABLE `skill_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idCountry` int(10) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_state_idCountry_idx` (`idCountry`),
  CONSTRAINT `fk_state_idCountry` FOREIGN KEY (`idCountry`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES (0,0,'Foreign State',1),(1,1,'São Paulo',1);
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-28 19:44:18
