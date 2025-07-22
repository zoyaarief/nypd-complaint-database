CREATE DATABASE  IF NOT EXISTS `nypd_database1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `nypd_database1`;
-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: localhost    Database: nypd_database1
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `borough`
--

DROP TABLE IF EXISTS `borough`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borough` (
  `borough_name` varchar(50) NOT NULL,
  PRIMARY KEY (`borough_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borough`
--

LOCK TABLES `borough` WRITE;
/*!40000 ALTER TABLE `borough` DISABLE KEYS */;
INSERT INTO `borough` VALUES ('Bronx'),('Brooklyn'),('Manhattan'),('Queens'),('Staten Island');
/*!40000 ALTER TABLE `borough` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captain`
--

DROP TABLE IF EXISTS `captain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `captain` (
  `employee_id` varchar(50) NOT NULL,
  `captain_code` varchar(20) NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `captain_code` (`captain_code`),
  CONSTRAINT `captain_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captain`
--

LOCK TABLES `captain` WRITE;
/*!40000 ALTER TABLE `captain` DISABLE KEYS */;
INSERT INTO `captain` VALUES ('NYC60061','CAPT-001'),('NYC85411','CAPT-002');
/*!40000 ALTER TABLE `captain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detective`
--

DROP TABLE IF EXISTS `detective`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detective` (
  `employee_id` varchar(50) NOT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `detective_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detective`
--

LOCK TABLES `detective` WRITE;
/*!40000 ALTER TABLE `detective` DISABLE KEYS */;
INSERT INTO `detective` VALUES ('NYC41915','Homicide'),('NYC68858','Cybercrime');
/*!40000 ALTER TABLE `detective` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `badge_num` varchar(20) NOT NULL,
  `rank` varchar(50) DEFAULT NULL,
  `joining_date` date NOT NULL,
  `supervisor_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `badge_num` (`badge_num`),
  KEY `supervisor_id` (`supervisor_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`supervisor_id`) REFERENCES `employee` (`employee_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('NYC10482','Eva','Davis','B005','Deputy','2022-07-12',NULL),('NYC13967','Ivy','Taylor','B009','Inspector','2016-10-17','NYC45927'),('NYC21994','Alice','Johnson','B001','Manager','2017-06-15','NYC45577'),('NYC22231','Nathan','White','B014','Deputy','2019-05-23',NULL),('NYC27591','Bob','Smith','B002','Sergeant','2015-03-22','NYC85411'),('NYC30783','David','Brown','B004','Constable','2021-01-18','NYC22231'),('NYC41915','Mia','Jackson','B013','Detective','2014-12-01','NYC46799'),('NYC45577','Quinn','Lewis','B017','Manager','2015-08-11',NULL),('NYC45664','Karen','Thomas','B011','Lieutenant','2011-06-19','NYC85411'),('NYC45927','Tina','Allen','B020','Chief','2008-04-14',NULL),('NYC46799','Rachel','Young','B018','Inspector','2016-03-29','NYC45927'),('NYC47812','Carol','Williams','B003','Lieutenant','2010-11-09',NULL),('NYC60061','Frank','Miller','B006','Captain','2012-09-30',NULL),('NYC60362','Paul','Clark','B016','Sergeant','2020-01-27','NYC60061'),('NYC64108','Henry','Moore','B008','Officer','2020-08-01','NYC60362'),('NYC68858','Grace','Wilson','B007','Detective','2018-04-05','NYC13967'),('NYC77513','Jack','Anderson','B010','Chief','2009-02-25',NULL),('NYC85411','Olivia','Harris','B015','Captain','2013-10-06','NYC77513'),('NYC95781','Leo','Martin','B012','Officer','2023-03-14','NYC60362'),('NYC97265','Steve','Hall','B019','Constable','2022-11-05','NYC22231');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_insert_employee` BEFORE INSERT ON `employee` FOR EACH ROW BEGIN
  IF NEW.employee_id IS NULL OR NEW.employee_id = '' THEN
    SET NEW.employee_id = CONCAT(
      'NYC',
      LPAD(FLOOR(RAND() * 10000000), 5, '0')
    );
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `evidence`
--

DROP TABLE IF EXISTS `evidence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evidence` (
  `evidence_id` int NOT NULL AUTO_INCREMENT,
  `evidence_type` varchar(20) NOT NULL,
  `description` text NOT NULL,
  `storage_location` varchar(50) NOT NULL,
  `incident_id` varchar(10) NOT NULL,
  PRIMARY KEY (`evidence_id`),
  KEY `incident_id` (`incident_id`),
  CONSTRAINT `evidence_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evidence`
--

LOCK TABLES `evidence` WRITE;
/*!40000 ALTER TABLE `evidence` DISABLE KEYS */;
INSERT INTO `evidence` VALUES (1,'Photo','Image of the robbery suspect','Locker A','INC0FSC4C'),(2,'Video','CCTV footage capturing burglary','Archive B','INC0NWAG4'),(3,'Document','Handwritten statement from neighbor witness.','Cabinet C2','INC32VT8G'),(4,'Photo','Graffiti image taken at library wall.','Locker D1','INC6AMZQF'),(5,'Video','Phone video of street racing activity.','Archive F3','INC94K719'),(6,'Physical Item','Spray paint can left at the scene.','Locker G2','INC9KRTK5'),(7,'Document','Noise complaint form from resident.','Filing Cabinet H1','INCA95ON0'),(8,'Audio','911 call reporting the assault.','Digital Recorder I4','INCBYKNBA'),(9,'Video','Security footage of break-in attempt.','Archive J2','INCDW6TCZ'),(10,'Photo','Image of trespasser near campus gates.','Locker K5','INCFWXN7U');
/*!40000 ALTER TABLE `evidence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `handling_incident`
--

DROP TABLE IF EXISTS `handling_incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `handling_incident` (
  `employee_id` varchar(50) NOT NULL,
  `incident_id` varchar(10) NOT NULL,
  PRIMARY KEY (`employee_id`,`incident_id`),
  KEY `incident_id` (`incident_id`),
  CONSTRAINT `handling_incident_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `handling_incident_ibfk_2` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `handling_incident`
--

LOCK TABLES `handling_incident` WRITE;
/*!40000 ALTER TABLE `handling_incident` DISABLE KEYS */;
INSERT INTO `handling_incident` VALUES ('NYC10482','INC0FSC4C'),('NYC21994','INC0FSC4C'),('NYC60362','INC32VT8G'),('NYC46799','INC6AMZQF'),('NYC95781','INC94K719'),('NYC27591','INC9KRTK5'),('NYC68858','INC9KRTK5'),('NYC85411','INCA95ON0'),('NYC30783','INCBYKNBA'),('NYC60061','INCFWXN7U'),('NYC13967','INCJHJ05G'),('NYC45927','INCLWHD7M'),('NYC45664','INCOQAYLX'),('NYC64108','INCRKAFZB'),('NYC22231','INCVE42OZ');
/*!40000 ALTER TABLE `handling_incident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident`
--

DROP TABLE IF EXISTS `incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incident` (
  `incident_id` varchar(10) NOT NULL,
  `incident_date` date NOT NULL,
  `incident_time` time NOT NULL,
  `is_active` enum('unresolved','in progress','resolved') NOT NULL DEFAULT 'unresolved',
  `description` text,
  `location_id` int NOT NULL,
  `precinct_num` int DEFAULT NULL,
  PRIMARY KEY (`incident_id`),
  KEY `location_id` (`location_id`),
  KEY `fk_incident_precinct` (`precinct_num`),
  CONSTRAINT `fk_incident_precinct` FOREIGN KEY (`precinct_num`) REFERENCES `precinct` (`precinct_num`),
  CONSTRAINT `incident_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `incident_location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incident`
--

LOCK TABLES `incident` WRITE;
/*!40000 ALTER TABLE `incident` DISABLE KEYS */;
INSERT INTO `incident` VALUES ('INC0FSC4C','2023-09-03','08:45:00','resolved','Burglary at a residential area.',3,3),('INC0NWAG4','2023-09-02','14:00:00','in progress','Assault reported outside the mall.',2,2),('INC32VT8G','2023-10-19','03:00:00','unresolved','Break-in attempt at electronics store.',5,3),('INC6AMZQF','2023-09-01','10:30:00','unresolved','Robbery reported at the downtown bank.',1,1),('INC94K719','2023-10-27','16:30:00','in progress','Drug possession arrest at corner.',13,2),('INC9KRTK5','2023-10-24','09:50:00','in progress','Trespassing near college campus.',10,4),('INCA95ON0','2023-10-21','13:30:00','in progress','Disorderly conduct at music event.',7,1),('INCBYKNBA','2023-10-20','11:45:00','resolved','Public intoxication at park.',6,2),('INCDW6TCZ','2023-09-03','08:45:00','resolved','Burglary at a residential area.',3,3),('INCFWXN7U','2023-10-23','07:15:00','resolved','Package theft caught on camera.',9,5),('INCJHJ05G','2023-10-29','08:10:00','unresolved','Vehicle break-in at alley.',15,4),('INCLWHD7M','2023-10-26','15:40:00','resolved','Loud music disturbance.',12,5),('INCMWDVZ2','2023-09-01','10:30:00','unresolved','Robbery reported at the downtown bank.',1,1),('INCOQAYLX','2023-10-25','10:25:00','unresolved','Illegal street racing incident.',11,4),('INCOV3HXV','2023-09-02','14:00:00','in progress','Assault reported outside the mall.',2,4),('INCRKAFZB','2023-10-22','22:10:00','unresolved','Car vandalism in residential area.',8,2),('INCVE42OZ','2023-10-28','19:00:00','resolved','Suspicious loitering reported.',14,5);
/*!40000 ALTER TABLE `incident` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_incident_before_insert` BEFORE INSERT ON `incident` FOR EACH ROW BEGIN
    IF NEW.incident_id IS NULL OR NEW.incident_id = '' THEN
       SET NEW.incident_id = CONCAT('INC', random_alphanum_str(6));
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `incident_involved_person`
--

DROP TABLE IF EXISTS `incident_involved_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incident_involved_person` (
  `incident_id` varchar(10) NOT NULL,
  `involved_person_id` int NOT NULL,
  PRIMARY KEY (`incident_id`,`involved_person_id`),
  KEY `involved_person_id` (`involved_person_id`),
  CONSTRAINT `incident_involved_person_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`),
  CONSTRAINT `incident_involved_person_ibfk_2` FOREIGN KEY (`involved_person_id`) REFERENCES `involved_person` (`involved_person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incident_involved_person`
--

LOCK TABLES `incident_involved_person` WRITE;
/*!40000 ALTER TABLE `incident_involved_person` DISABLE KEYS */;
INSERT INTO `incident_involved_person` VALUES ('INC0FSC4C',1),('INC32VT8G',2),('INC6AMZQF',3),('INC94K719',4),('INC0FSC4C',5),('INCBYKNBA',6),('INCJHJ05G',7),('INCFWXN7U',8),('INC0FSC4C',9),('INC32VT8G',10),('INC6AMZQF',11),('INCJHJ05G',12),('INCLWHD7M',13),('INCOQAYLX',14),('INCOQAYLX',15),('INCVE42OZ',16);
/*!40000 ALTER TABLE `incident_involved_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident_location`
--

DROP TABLE IF EXISTS `incident_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incident_location` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `building_number` varchar(20) DEFAULT NULL,
  `street` varchar(100) NOT NULL,
  `zipcode` varchar(10) NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incident_location`
--

LOCK TABLES `incident_location` WRITE;
/*!40000 ALTER TABLE `incident_location` DISABLE KEYS */;
INSERT INTO `incident_location` VALUES (1,'123','Main Street','10001'),(2,NULL,'Broadway','10002'),(3,'456','Elm Street','11234'),(4,'789','Oak Avenue','11355'),(5,'101','Pine Road','10453'),(6,NULL,'River Road','10301'),(7,'200','Lexington Ave','10016'),(8,'300','5th Avenue','10001'),(9,NULL,'Wall Street','10005'),(10,'1223','Mai1n Street','13001'),(11,NULL,'Broad2way','10012'),(12,'4526','Elm Street','11334'),(13,'78w9','Oak1 Avenue','12355'),(14,'10w1','Pine Road','10453'),(15,NULL,'Ri2ver Road','10321');
/*!40000 ALTER TABLE `incident_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident_offense_code`
--

DROP TABLE IF EXISTS `incident_offense_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incident_offense_code` (
  `incident_id` varchar(10) NOT NULL,
  `offense_code` varchar(20) NOT NULL,
  PRIMARY KEY (`incident_id`,`offense_code`),
  KEY `offense_code` (`offense_code`),
  CONSTRAINT `incident_offense_code_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`),
  CONSTRAINT `incident_offense_code_ibfk_2` FOREIGN KEY (`offense_code`) REFERENCES `offense_code` (`offense_code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incident_offense_code`
--

LOCK TABLES `incident_offense_code` WRITE;
/*!40000 ALTER TABLE `incident_offense_code` DISABLE KEYS */;
INSERT INTO `incident_offense_code` VALUES ('INC0FSC4C','OC001'),('INCDW6TCZ','OC001'),('INC6AMZQF','OC002'),('INCMWDVZ2','OC002'),('INC0NWAG4','OC003'),('INCOV3HXV','OC003'),('INCRKAFZB','OC004'),('INCJHJ05G','OC005'),('INCA95ON0','OC010'),('INCBYKNBA','OC011'),('INC9KRTK5','OC012'),('INCVE42OZ','OC012'),('INC94K719','OC016');
/*!40000 ALTER TABLE `incident_offense_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `involved_person`
--

DROP TABLE IF EXISTS `involved_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `involved_person` (
  `involved_person_id` int NOT NULL AUTO_INCREMENT,
  `id_type` varchar(50) NOT NULL,
  `id_number` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`involved_person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `involved_person`
--

LOCK TABLES `involved_person` WRITE;
/*!40000 ALTER TABLE `involved_person` DISABLE KEYS */;
INSERT INTO `involved_person` VALUES (1,'Driver\'s License','D1234567','John','Doe','1990-05-15','Male','123 Maple Street, Manhattan, NY',NULL,NULL),(2,'Passport','P987654321','Maria','Lopez','1985-08-22','Female','456 Elm Street, Brooklyn, NY','917-555-1001',NULL),(3,'State ID','S20230987','David','Chen','1992-03-30','Male','789 Oak Avenue, Queens, NY','917-555-1002','david.chen@example.com'),(4,'Driver\'s License','D5678901','Fatima','Khan','1997-11-02','Female','321 Pine Road, Bronx, NY',NULL,'fatima.khan@example.com'),(5,'Passport','P556789012','Liam','Nguyen','1988-01-12','Male','112 River Road, Staten Island, NY','917-555-1004','liam.nguyen@example.com'),(6,'State ID (Minor)','M8820191','Alex','Reed','2007-07-19','Non-Binary','77 Sunset Blvd, Manhattan, NY','917-555-1005','alex.reed@example.com'),(7,'State ID','S9081726','Sophia','Martinez','1995-09-25','Female','33 Victory Blvd, Brooklyn, NY','917-555-1006','sophia.martinez@example.com'),(8,'Driver\'s License','D1122334','Daniel','Kim','1991-12-09','Male','55 Grand Concourse, Bronx, NY','917-555-1007','daniel.kim@example.com'),(9,'Passport','P12039876','Emma','Patel','1983-02-03','Female','22 Fordham Rd, Bronx, NY',NULL,'emma.patel@example.com'),(10,'Driver\'s License','D4455667','Noah','Anderson','1989-04-27','Male','10 Wall Street, Manhattan, NY','917-555-1009','noah.anderson@example.com'),(11,'State ID','S77889900','Brian','Lewis','1986-06-22','Male','44 Liberty St, Manhattan, NY','917-555-1010','brian.lewis@example.com'),(12,'Driver\'s License','D9988776','Chloe','Ng','1993-01-18','Female','88 Bedford Ave, Brooklyn, NY',NULL,NULL),(13,'Passport','P88221100','Zara','Singh','1991-04-05','Female','201 Jamaica Ave, Queens, NY',NULL,NULL),(14,'State ID','S33445566','Jamal','Green','1990-09-30','Male','13 Fordham Rd, Bronx, NY','917-555-1013',NULL),(15,'Driver\'s License','D2233445','Lena','Kaur','1987-07-11','Female','6 Victory Blvd, Staten Island, NY',NULL,'lena.kaur@example.com'),(16,'Passport','P11002233','Tariq','Ali','1984-12-03','Male','98 Grand Concourse, Bronx, NY','917-555-1015',NULL);
/*!40000 ALTER TABLE `involved_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offense_code`
--

DROP TABLE IF EXISTS `offense_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offense_code` (
  `offense_code_id` varchar(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`offense_code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offense_code`
--

LOCK TABLES `offense_code` WRITE;
/*!40000 ALTER TABLE `offense_code` DISABLE KEYS */;
INSERT INTO `offense_code` VALUES ('OC001','Burglary','Property Crime'),('OC002','Robbery','Violent Crime'),('OC003','Assault','Violent Crime'),('OC004','Vandalism','Property Crime'),('OC005','Vehicle Theft','Property Crime'),('OC006','Arson','Property Crime'),('OC007','Homicide','Violent Crime'),('OC008','Kidnapping','Violent Crime'),('OC009','Domestic Violence','Violent Crime'),('OC010','Disorderly Conduct','Public Order Crime'),('OC011','Public Intoxication','Public Order Crime'),('OC012','Loitering','Public Order Crime'),('OC013','Identity Theft','Cyber Crime'),('OC014','Hacking','Cyber Crime'),('OC015','Online Harassment','Cyber Crime'),('OC016','Possession of Controlled Substance','Drug Offense'),('OC017','Drug Trafficking','Drug Offense');
/*!40000 ALTER TABLE `offense_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `officer`
--

DROP TABLE IF EXISTS `officer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `officer` (
  `employee_id` varchar(50) NOT NULL,
  `assigned_unit` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `officer_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `officer`
--

LOCK TABLES `officer` WRITE;
/*!40000 ALTER TABLE `officer` DISABLE KEYS */;
INSERT INTO `officer` VALUES ('NYC64108','Unit A'),('NYC95781','Unit B');
/*!40000 ALTER TABLE `officer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_of_interest`
--

DROP TABLE IF EXISTS `person_of_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_of_interest` (
  `involved_person_id` int NOT NULL,
  `incident_id` varchar(10) NOT NULL,
  `reason_for_interest` varchar(255) DEFAULT NULL,
  `investigation_status` varchar(50) DEFAULT NULL,
  `date_identified` date DEFAULT NULL,
  PRIMARY KEY (`involved_person_id`,`incident_id`),
  KEY `incident_id` (`incident_id`),
  CONSTRAINT `person_of_interest_ibfk_1` FOREIGN KEY (`involved_person_id`) REFERENCES `involved_person` (`involved_person_id`),
  CONSTRAINT `person_of_interest_ibfk_2` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_of_interest`
--

LOCK TABLES `person_of_interest` WRITE;
/*!40000 ALTER TABLE `person_of_interest` DISABLE KEYS */;
INSERT INTO `person_of_interest` VALUES (5,'INC0FSC4C','Suspect has prior burglary charges.','Under Investigation','2023-09-04'),(8,'INCFWXN7U','Seen near porch with package before it was stolen.','Questioned','2023-10-23'),(10,'INC32VT8G','Was nearby during the break-in and fled the scene.','Cleared','2023-10-19'),(11,'INC6AMZQF','Linked to similar past robbery case.','Under Surveillance','2023-09-01'),(14,'INCOQAYLX','Known for previous traffic violations.','Pending Review','2023-10-25'),(15,'INCOQAYLX','Vehicle matched description from street racing incident.','Flagged','2023-10-25');
/*!40000 ALTER TABLE `person_of_interest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `precinct`
--

DROP TABLE IF EXISTS `precinct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `precinct` (
  `precinct_num` int NOT NULL AUTO_INCREMENT,
  `address` varchar(100) NOT NULL,
  `borough_name` varchar(50) NOT NULL,
  PRIMARY KEY (`precinct_num`),
  KEY `borough_name` (`borough_name`),
  CONSTRAINT `precinct_ibfk_1` FOREIGN KEY (`borough_name`) REFERENCES `borough` (`borough_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `precinct`
--

LOCK TABLES `precinct` WRITE;
/*!40000 ALTER TABLE `precinct` DISABLE KEYS */;
INSERT INTO `precinct` VALUES (1,'16 Ericsson Place','Manhattan'),(2,'123 Main Street','Brooklyn'),(3,'45 Queens Blvd','Queens'),(4,'67 Bronx Road','Bronx'),(5,'89 Staten Island Avenue','Staten Island');
/*!40000 ALTER TABLE `precinct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `victim`
--

DROP TABLE IF EXISTS `victim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `victim` (
  `involved_person_id` int NOT NULL,
  `incident_id` varchar(10) NOT NULL,
  `injury_description` varchar(255) DEFAULT NULL,
  `victim_statement` text,
  PRIMARY KEY (`involved_person_id`,`incident_id`),
  KEY `incident_id` (`incident_id`),
  CONSTRAINT `victim_ibfk_1` FOREIGN KEY (`involved_person_id`) REFERENCES `involved_person` (`involved_person_id`),
  CONSTRAINT `victim_ibfk_2` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `victim`
--

LOCK TABLES `victim` WRITE;
/*!40000 ALTER TABLE `victim` DISABLE KEYS */;
INSERT INTO `victim` VALUES (1,'INC0FSC4C','Minor bruises on left arm','The intruder pushed me before fleeing.'),(3,'INC6AMZQF','None','The robber threatened but didn’t cause physical harm.'),(6,'INCBYKNBA','Scratches on face','Got hurt during a public altercation.'),(9,'INC0FSC4C','Sprained ankle','I tripped while trying to escape.'),(13,'INCLWHD7M','Hearing discomfort','Loud music disturbed my rest.'),(16,'INCVE42OZ','No visible injuries','Felt threatened by the loiterer.');
/*!40000 ALTER TABLE `victim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `witness`
--

DROP TABLE IF EXISTS `witness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `witness` (
  `involved_person_id` int NOT NULL,
  `incident_id` varchar(10) NOT NULL,
  `witness_statement` text,
  `statement_time` datetime DEFAULT NULL,
  `contact_preference` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`involved_person_id`,`incident_id`),
  KEY `incident_id` (`incident_id`),
  CONSTRAINT `witness_ibfk_1` FOREIGN KEY (`involved_person_id`) REFERENCES `involved_person` (`involved_person_id`),
  CONSTRAINT `witness_ibfk_2` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `witness`
--

LOCK TABLES `witness` WRITE;
/*!40000 ALTER TABLE `witness` DISABLE KEYS */;
INSERT INTO `witness` VALUES (2,'INC32VT8G','Saw someone break in through the side window.','2023-10-19 03:15:00','Phone'),(4,'INC94K719','Observed the suspect hiding something behind a trash bin.','2023-10-27 16:45:00','Email'),(7,'INCJHJ05G','Heard a loud crash in the alley.','2023-10-29 08:20:00','No Preference'),(12,'INCJHJ05G','Saw a shadowy figure running from the car.','2023-10-29 08:25:00','Phone');
/*!40000 ALTER TABLE `witness` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'nypd_database1'
--

--
-- Dumping routines for database 'nypd_database1'
--
/*!50003 DROP FUNCTION IF EXISTS `random_alphanum_str` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `random_alphanum_str`(n INT) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE chars VARCHAR(36) DEFAULT 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    DECLARE result VARCHAR(100) DEFAULT '';
    DECLARE i INT DEFAULT 1;
    WHILE i <= n DO
        SET result = CONCAT(result, SUBSTRING(chars, FLOOR(1 + RAND() * 36), 1));
        SET i = i + 1;
    END WHILE;
    RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-17 21:12:56
