-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 192.168.56.102    Database: Eleccions_Generals_GrupB
-- ------------------------------------------------------
-- Server version	8.0.17-8

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
-- Table structure for table `eleccions`
--

DROP TABLE IF EXISTS `eleccions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eleccions` (
  `eleccio_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  `data` date NOT NULL COMMENT 'Data (dia mes i any) de quan s''han celebrat les eleccions',
  `any` year(4) GENERATED ALWAYS AS (year(`data`)) VIRTUAL COMMENT 'any el qual s''han celebrat les eleccions',
  `mes` tinyint(4) GENERATED ALWAYS AS (month(`data`)) STORED COMMENT 'El mes que s''han celebrat les eleccions',
  PRIMARY KEY (`eleccio_id`),
  UNIQUE KEY `uk_eleccions_data` (`data`),
  UNIQUE KEY `uk_eleccions_any_mes` (`any`,`mes`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eleccions`
--

LOCK TABLES `eleccions` WRITE;
/*!40000 ALTER TABLE `eleccions` DISABLE KEYS */;
INSERT INTO `eleccions` (`eleccio_id`, `nom`, `data`) VALUES (1,'Elecciones al Congreso de los Diputados','2019-04-01');
/*!40000 ALTER TABLE `eleccions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-03 12:41:55
