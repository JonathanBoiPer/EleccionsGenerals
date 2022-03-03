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
-- Table structure for table `vots_candidatures_ca`
--

DROP TABLE IF EXISTS `vots_candidatures_ca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vots_candidatures_ca` (
  `comunitat_autonoma_id` tinyint(3) unsigned NOT NULL,
  `candidatura_id` int(10) unsigned NOT NULL,
  `vots` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`comunitat_autonoma_id`,`candidatura_id`),
  KEY `fk_comunitats_autonomes_has_candidatures_candidatures1_idx` (`candidatura_id`),
  KEY `fk_comunitats_autonomes_has_candidatures_comunitats_autonom_idx` (`comunitat_autonoma_id`),
  CONSTRAINT `fk_comunitats_autonomes_has_candidatures_candidatures1` FOREIGN KEY (`candidatura_id`) REFERENCES `candidatures` (`candidatura_id`),
  CONSTRAINT `fk_comunitats_autonomes_has_candidatures_comunitats_autonomes1` FOREIGN KEY (`comunitat_autonoma_id`) REFERENCES `comunitats_autonomes` (`comunitat_aut_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vots_candidatures_ca`
--

LOCK TABLES `vots_candidatures_ca` WRITE;
/*!40000 ALTER TABLE `vots_candidatures_ca` DISABLE KEYS */;
INSERT INTO `vots_candidatures_ca` VALUES (1,16,207530),(1,44,11088),(1,47,325),(1,51,224),(1,54,266),(1,57,277),(1,59,56),(1,63,120747),(1,69,269125),(1,80,384461),(1,83,1226),(1,87,2026),(1,95,181444),(2,16,32181),(2,22,385),(2,44,1394),(2,63,21331),(2,69,47947),(2,74,2098),(2,80,57307),(2,83,199),(2,86,275),(2,95,16255),(3,16,155576),(3,22,3372),(3,34,785),(3,41,47),(3,44,6934),(3,51,765),(3,54,589),(3,63,102930),(3,69,143242),(3,80,240540),(3,83,993),(3,85,835),(3,86,1825),(3,91,28),(3,95,92388),(4,16,4546),(4,63,1838),(4,69,8147),(4,80,13800),(4,83,87),(4,86,157),(4,95,9092),(5,15,6857),(5,16,4351),(5,63,1292),(5,69,8087),(5,80,6989),(5,83,39),(5,86,99),(5,95,5807),(6,3,25191),(6,16,90340),(6,28,11692),(6,44,8864),(6,46,796),(6,60,92477),(6,69,87352),(6,81,136698),(6,83,686),(6,86,1197),(6,95,58567),(7,16,792203),(7,44,50909),(7,46,19208),(7,51,2038),(7,54,2329),(7,58,3456),(7,63,613911),(7,69,705119),(7,80,1031534),(7,83,5221),(7,87,7512),(7,95,524176),(8,2,932),(8,16,104688),(8,44,6670),(8,46,4554),(8,54,1359),(8,58,480),(8,68,107426),(8,72,112180),(8,80,207586),(8,83,777),(8,86,1133),(8,95,72018),(9,26,46765),(9,36,22309),(9,42,107619),(9,44,3325),(9,65,68393),(9,80,94551),(9,83,1203),(9,86,1295),(9,95,17771),(10,4,7332),(10,14,173821),(10,16,483068),(10,31,4236),(10,33,222),(10,44,37286),(10,51,3216),(10,59,973),(10,62,382798),(10,69,498680),(10,80,746486),(10,83,302),(10,86,3976),(10,92,4473),(10,95,322870),(11,16,54361),(11,22,427),(11,44,3049),(11,51,286),(11,54,260),(11,59,187),(11,63,36784),(11,69,77902),(11,75,52266),(11,80,90534),(11,83,274),(11,86,332),(11,95,40139),(12,11,2150),(12,16,118035),(12,19,308),(12,44,4662),(12,46,1488),(12,63,62544),(12,69,140473),(12,80,250180),(12,83,442),(12,86,856),(12,95,70793),(13,7,94433),(13,8,73),(13,16,184045),(13,18,2760),(13,24,886),(13,29,17899),(13,44,17213),(13,47,1814),(13,56,1648),(13,61,238061),(13,69,451300),(13,78,528195),(13,83,213),(13,86,2846),(13,94,335),(13,95,87047),(14,13,2541),(14,16,479374),(14,25,615665),(14,30,1020392),(14,35,113807),(14,38,2791),(14,40,500787),(14,44,63895),(14,50,3373),(14,53,2353),(14,69,200841),(14,77,962257),(14,82,417),(14,86,6944),(14,95,148844),(15,10,459),(15,16,287468),(15,33,424),(15,44,11319),(15,46,623),(15,47,184),(15,51,313),(15,54,1789),(15,63,158535),(15,69,395866),(15,73,2663),(15,76,2190),(15,80,453339),(15,83,2428),(15,87,2701),(15,93,490),(15,95,186882),(16,16,150289),(16,20,504),(16,38,712),(16,44,10611),(16,47,1162),(16,51,663),(16,63,80053),(16,69,180163),(16,80,190540),(16,86,1406),(16,90,4976),(16,95,143234),(17,6,11407),(17,12,1081),(17,16,811562),(17,22,1324),(17,37,257),(17,39,876),(17,44,62027),(17,46,3567),(17,47,5645),(17,48,4697),(17,54,2278),(17,67,654944),(17,69,787384),(17,80,1568682),(17,83,4326),(17,86,7826),(17,88,190),(17,95,612921),(18,1,3037),(18,9,137664),(18,16,155682),(18,32,571),(18,43,36225),(18,44,17826),(18,49,1486),(18,58,559),(18,63,166911),(18,69,164804),(18,80,295474),(18,83,1419),(18,86,2651),(18,95,69614),(19,16,40366),(19,21,395884),(19,23,678),(19,26,212882),(19,44,11227),(19,55,1151),(19,66,224505),(19,69,95041),(19,79,253989),(19,83,1611),(19,86,2306),(19,89,528),(19,95,28230);
/*!40000 ALTER TABLE `vots_candidatures_ca` ENABLE KEYS */;
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
