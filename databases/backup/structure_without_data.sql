-- MariaDB dump 10.18  Distrib 10.5.8-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: university
-- ------------------------------------------------------
-- Server version	10.5.8-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `advisor`
--

DROP TABLE IF EXISTS `advisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advisor` (
  `s_ID` varchar(5) NOT NULL DEFAULT '',
  `i_ID` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`s_ID`),
  KEY `i_ID` (`i_ID`),
  CONSTRAINT `advisor_ibfk_1` FOREIGN KEY (`i_ID`) REFERENCES `instructor` (`ID`),
  CONSTRAINT `advisor_ibfk_2` FOREIGN KEY (`s_ID`) REFERENCES `student` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom` (
  `building` varchar(15) NOT NULL DEFAULT '',
  `room_number` varchar(7) NOT NULL DEFAULT '',
  `capacity` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`building`,`room_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `course_id` varchar(8) NOT NULL DEFAULT '',
  `title` varchar(50) DEFAULT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `credits` decimal(2,0) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `dept_name` varchar(20) NOT NULL DEFAULT '',
  `building` varchar(15) DEFAULT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor` (
  `ID` varchar(5) NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `instructor_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prereq`
--

DROP TABLE IF EXISTS `prereq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prereq` (
  `course_id` varchar(8) NOT NULL DEFAULT '',
  `prereq_id` varchar(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`course_id`,`prereq_id`),
  KEY `prereq_id` (`prereq_id`),
  CONSTRAINT `prereq_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `prereq_ibfk_2` FOREIGN KEY (`prereq_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section` (
  `course_id` varchar(8) NOT NULL DEFAULT '',
  `sec_id` varchar(8) NOT NULL DEFAULT '',
  `semester` varchar(6) NOT NULL DEFAULT '',
  `year` decimal(4,0) NOT NULL DEFAULT 0,
  `building` varchar(15) DEFAULT NULL,
  `room_number` varchar(7) DEFAULT NULL,
  `time_slot_id` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`course_id`,`sec_id`,`semester`,`year`),
  KEY `building` (`building`,`room_number`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `section_ibfk_2` FOREIGN KEY (`building`, `room_number`) REFERENCES `classroom` (`building`, `room_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `ID` varchar(5) NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `tot_cred` decimal(3,0) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `takes`
--

DROP TABLE IF EXISTS `takes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `takes` (
  `ID` varchar(5) NOT NULL DEFAULT '',
  `course_id` varchar(8) NOT NULL DEFAULT '',
  `sec_id` varchar(8) NOT NULL DEFAULT '',
  `semester` varchar(6) NOT NULL DEFAULT '',
  `year` decimal(4,0) NOT NULL DEFAULT 0,
  `grade` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID`,`course_id`,`sec_id`,`semester`,`year`),
  KEY `course_id` (`course_id`,`sec_id`,`semester`,`year`),
  CONSTRAINT `takes_ibfk_1` FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `section` (`course_id`, `sec_id`, `semester`, `year`) ON DELETE CASCADE,
  CONSTRAINT `takes_ibfk_2` FOREIGN KEY (`ID`) REFERENCES `student` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teaches`
--

DROP TABLE IF EXISTS `teaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teaches` (
  `ID` varchar(5) NOT NULL DEFAULT '',
  `course_id` varchar(8) NOT NULL DEFAULT '',
  `sec_id` varchar(8) NOT NULL DEFAULT '',
  `semester` varchar(6) NOT NULL DEFAULT '',
  `year` decimal(4,0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`,`course_id`,`sec_id`,`semester`,`year`),
  KEY `course_id` (`course_id`,`sec_id`,`semester`,`year`),
  CONSTRAINT `teaches_ibfk_1` FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `section` (`course_id`, `sec_id`, `semester`, `year`) ON DELETE CASCADE,
  CONSTRAINT `teaches_ibfk_2` FOREIGN KEY (`ID`) REFERENCES `instructor` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_slot`
--

DROP TABLE IF EXISTS `time_slot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_slot` (
  `time_slot_id` varchar(4) NOT NULL DEFAULT '',
  `day` varchar(1) NOT NULL DEFAULT '',
  `start_hr` decimal(2,0) NOT NULL DEFAULT 0,
  `start_min` decimal(2,0) NOT NULL DEFAULT 0,
  `end_hr` decimal(2,0) DEFAULT NULL,
  `end_min` decimal(2,0) DEFAULT NULL,
  PRIMARY KEY (`time_slot_id`,`day`,`start_hr`,`start_min`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-17 16:45:33
