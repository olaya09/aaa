CREATE DATABASE  IF NOT EXISTS `db_reservas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_reservas`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: db_reservas
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `equipocomputo`
--

DROP TABLE IF EXISTS `equipocomputo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipocomputo` (
  `noInventario` int NOT NULL,
  `marca` varchar(45) DEFAULT NULL,
  `anhoCompra` int DEFAULT NULL,
  PRIMARY KEY (`noInventario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipocomputo`
--

LOCK TABLES `equipocomputo` WRITE;
/*!40000 ALTER TABLE `equipocomputo` DISABLE KEYS */;
INSERT INTO `equipocomputo` VALUES (147,'hpta',2024),(456,'hpta',2010),(789,'Dell',2025);
/*!40000 ALTER TABLE `equipocomputo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiante`
--

DROP TABLE IF EXISTS `estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiante` (
  `codigo` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiante`
--

LOCK TABLES `estudiante` WRITE;
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
INSERT INTO `estudiante` VALUES (202460311,'miguel','olaya'),(202460369,'carlos','castro'),(202460660,'gerson','gomez'),(202460680,'harry','haramillo');
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesor`
--

DROP TABLE IF EXISTS `profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesor` (
  `cedula` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `curso` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesor`
--

LOCK TABLES `profesor` WRITE;
/*!40000 ALTER TABLE `profesor` DISABLE KEYS */;
INSERT INTO `profesor` VALUES (123,'akiles','brinco','fundamentos de programación orientada a '),(456,'Juan','Matachin','fpoo'),(11113,'andres','qdeek','dqwasd'),(111133,'fgd','dfgdff','dfgdf'),(11113334,'fgd','dfgdff','dfgdf'),(111133344,'fgd','dfgdff','dfgdf');
/*!40000 ALTER TABLE `profesor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `cedulaProfesor` int DEFAULT NULL,
  `noInventarioPC` int NOT NULL,
  `fechaRecogida` datetime DEFAULT NULL,
  `fechaEntrega` datetime DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `cedulaProfesor_idx` (`cedulaProfesor`),
  KEY `noInventarioPC_idx` (`noInventarioPC`),
  CONSTRAINT `cedulaProfesor` FOREIGN KEY (`cedulaProfesor`) REFERENCES `profesor` (`cedula`),
  CONSTRAINT `noInventarioPC` FOREIGN KEY (`noInventarioPC`) REFERENCES `equipocomputo` (`noInventario`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` VALUES (1,123,147,'2025-06-09 21:00:36','2025-06-09 21:00:36'),(2,456,456,'2025-06-09 21:01:00','2025-06-09 21:01:00'),(3,456,789,'2025-06-09 21:01:16','2025-06-09 21:01:16'),(4,456,789,'2025-06-09 21:04:16','2025-06-09 21:04:16'),(5,123,789,'2025-06-25 02:07:02','2025-06-25 02:07:02'),(7,11113,456,'2025-06-25 02:39:13','2025-06-25 02:39:13'),(8,11113334,789,'2025-06-25 02:39:20','2025-06-25 02:39:20'),(11,11113334,456,'2025-06-25 02:41:46','2025-06-25 02:41:46'),(12,11113334,456,'2025-06-25 02:41:49','2025-06-25 02:41:49'),(17,11113,789,'2025-06-25 03:13:25','2025-06-25 03:13:25'),(21,111133,147,'2025-06-25 03:18:02','2025-06-25 03:18:02'),(26,123,147,'2025-06-25 03:32:49','2025-06-25 03:32:49'),(29,123,789,'2025-06-25 03:48:31','2025-06-25 03:48:31'),(30,111133,147,'2025-06-25 03:49:43','2025-06-25 03:49:43'),(31,111133,456,'2025-06-25 03:49:52','2025-06-25 03:49:52'),(35,11113,147,'2025-06-25 17:26:47','2025-06-25 17:26:47'),(36,123,147,'2025-06-25 17:32:01','2025-06-25 17:32:01');
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'db_reservas'
--

--
-- Dumping routines for database 'db_reservas'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-25 17:44:05
