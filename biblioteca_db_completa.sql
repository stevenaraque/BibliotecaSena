CREATE DATABASE  IF NOT EXISTS `biblioteca_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `biblioteca_db`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: biblioteca_db
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `auditoria_prestamo`
--

DROP TABLE IF EXISTS `auditoria_prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_prestamo` (
  `id_auditoria` int NOT NULL AUTO_INCREMENT,
  `id_prestamo` int DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  `id_libro` int DEFAULT NULL,
  `fecha_accion` datetime DEFAULT NULL,
  `accion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_auditoria`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_prestamo`
--

LOCK TABLES `auditoria_prestamo` WRITE;
/*!40000 ALTER TABLE `auditoria_prestamo` DISABLE KEYS */;
INSERT INTO `auditoria_prestamo` VALUES (1,1,1,1,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(2,2,2,2,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(3,3,3,3,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(4,4,4,4,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(5,5,5,5,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(6,6,6,6,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(7,7,7,7,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(8,8,8,8,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(9,9,9,9,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(10,10,10,10,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(11,11,11,11,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(12,12,12,12,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(13,13,13,13,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(14,14,14,14,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(15,15,15,15,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(16,16,16,16,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(17,17,17,17,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(18,18,18,18,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(19,19,19,19,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(20,20,20,20,'2026-04-04 22:53:13','PRESTAMO REGISTRADO'),(21,21,1,15,'2026-04-05 09:17:29','PRESTAMO REGISTRADO');
/*!40000 ALTER TABLE `auditoria_prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `id_autor` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(80) NOT NULL,
  `apellidos` varchar(80) NOT NULL,
  `nacionalidad` varchar(50) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'Gabriel','García Márquez','Colombiana','1927-03-06'),(2,'Jorge Luis','Borges','Argentina','1899-08-24'),(3,'Isabel','Allende','Chilena','1942-08-02'),(4,'Mario','Vargas Llosa','Peruana','1936-03-28'),(5,'Tomás','González','Colombiana','1950-06-15'),(6,'Stephen','Hawking','Británica','1942-01-08'),(7,'Carl','Sagan','Estadounidense','1934-11-09'),(8,'Yuval','Harari','Israelí','1976-02-24'),(9,'Robert','Martin','Estadounidense','1952-12-05'),(10,'Andrew','Tanenbaum','Estadounidense','1944-03-16'),(11,'Edgar','Codd','Británica','1923-08-19'),(12,'Donald','Knuth','Estadounidense','1938-01-10'),(13,'Platón','','Griega','0428-01-01'),(14,'Friedrich','Nietzsche','Alemana','1844-10-15'),(15,'Immanuel','Kant','Alemana','1724-04-22');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Novela','Ficción narrativa larga'),(2,'Ciencia','Libros de ciencias naturales y exactas'),(3,'Historia','Libros de eventos históricos'),(4,'Tecnología','Libros de informática y sistemas'),(5,'Filosofía','Libros de pensamiento y filosofía'),(6,'Derecho','Libros jurídicos y legales'),(7,'Economía','Libros de economía y finanzas'),(8,'Arte','Libros de arte y cultura'),(9,'Matemáticas','Libros de matemáticas y estadística'),(10,'Ingeniería','Libros técnicos de ingeniería');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editorial`
--

DROP TABLE IF EXISTS `editorial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editorial` (
  `id_editorial` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `pais` varchar(50) DEFAULT NULL,
  `sitio_web` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_editorial`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editorial`
--

LOCK TABLES `editorial` WRITE;
/*!40000 ALTER TABLE `editorial` DISABLE KEYS */;
INSERT INTO `editorial` VALUES (1,'Alfaguara','España','www.alfaguara.com'),(2,'Planeta','España','www.planeta.es'),(3,'Norma','Colombia','www.norma.com'),(4,'Panamericana','Colombia','www.panamericana.com.co'),(5,'McGraw-Hill','USA','www.mcgrawhill.com'),(6,'Pearson','USA','www.pearson.com'),(7,'Santillana','España','www.santillana.com'),(8,'Anagrama','España','www.anagrama-ed.es'),(9,'Fondo de Cultura','México','www.fondodeculturaeconomica.com'),(10,'Siglo XXI','México','www.sigloxxieditores.com');
/*!40000 ALTER TABLE `editorial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_multa`
--

DROP TABLE IF EXISTS `estado_multa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_multa` (
  `id_estado_multa` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_estado_multa`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_multa`
--

LOCK TABLES `estado_multa` WRITE;
/*!40000 ALTER TABLE `estado_multa` DISABLE KEYS */;
INSERT INTO `estado_multa` VALUES (1,'pendiente','Multa sin pagar'),(2,'pagada','Multa cancelada');
/*!40000 ALTER TABLE `estado_multa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_prestamo`
--

DROP TABLE IF EXISTS `estado_prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_prestamo` (
  `id_estado_prestamo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_estado_prestamo`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_prestamo`
--

LOCK TABLES `estado_prestamo` WRITE;
/*!40000 ALTER TABLE `estado_prestamo` DISABLE KEYS */;
INSERT INTO `estado_prestamo` VALUES (1,'activo','Préstamo en curso'),(2,'devuelto','Libro devuelto a tiempo'),(3,'vencido','Préstamo no devuelto a tiempo');
/*!40000 ALTER TABLE `estado_prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_usuario`
--

DROP TABLE IF EXISTS `estado_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_usuario` (
  `id_estado_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_estado_usuario`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_usuario`
--

LOCK TABLES `estado_usuario` WRITE;
/*!40000 ALTER TABLE `estado_usuario` DISABLE KEYS */;
INSERT INTO `estado_usuario` VALUES (1,'activo','Usuario habilitado para préstamos'),(2,'inactivo','Usuario sin acceso al sistema');
/*!40000 ALTER TABLE `estado_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libro`
--

DROP TABLE IF EXISTS `libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libro` (
  `id_libro` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `anio_publicacion` smallint DEFAULT NULL,
  `num_paginas` int DEFAULT NULL,
  `id_editorial` int DEFAULT NULL,
  `id_categoria` int DEFAULT NULL,
  `disponible` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_libro`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `id_editorial` (`id_editorial`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `libro_ibfk_1` FOREIGN KEY (`id_editorial`) REFERENCES `editorial` (`id_editorial`),
  CONSTRAINT `libro_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  CONSTRAINT `libro_chk_1` CHECK ((`num_paginas` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libro`
--

LOCK TABLES `libro` WRITE;
/*!40000 ALTER TABLE `libro` DISABLE KEYS */;
INSERT INTO `libro` VALUES (1,'Cien años de soledad','978-0307474728',1967,471,1,1,1),(2,'El amor en los tiempos del cólera','978-0307389732',1985,348,1,1,0),(3,'Ficciones','978-8420633138',1944,224,8,1,1),(4,'El aleph','978-8420674414',1949,208,8,1,1),(5,'La casa de los espíritus','978-8401352836',1982,433,2,1,0),(6,'La ciudad y los perros','978-8420634050',1963,384,1,1,1),(7,'Breve historia del tiempo','978-0553380163',1988,212,5,2,1),(8,'Cosmos','978-0345539434',1980,365,5,2,1),(9,'Sapiens','978-0062316097',2011,443,6,3,1),(10,'Código limpio','978-0132350884',2008,431,5,4,1),(11,'Redes de computadoras','978-0132126953',2010,960,6,4,1),(12,'El modelo relacional','978-0201141924',1990,538,6,4,0),(13,'El arte de la programación','978-0201485417',1968,650,5,4,1),(14,'La república','978-8420678726',380,368,7,5,1),(15,'Así habló Zaratustra','978-8420674780',1883,352,7,5,1),(16,'Crítica de la razón pura','978-8420674803',1781,694,7,5,0),(17,'Matemáticas discretas','978-9701062937',2005,615,6,9,1),(18,'Cálculo diferencial','978-9701062944',2007,900,6,9,1),(19,'Fundamentos de economía','978-9701062951',2010,480,3,7,1),(20,'Derecho constitucional','978-9701062968',2015,520,4,6,1);
/*!40000 ALTER TABLE `libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libro_autor`
--

DROP TABLE IF EXISTS `libro_autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libro_autor` (
  `id_libro` int NOT NULL,
  `id_autor` int NOT NULL,
  PRIMARY KEY (`id_libro`,`id_autor`),
  KEY `id_autor` (`id_autor`),
  CONSTRAINT `libro_autor_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libro` (`id_libro`),
  CONSTRAINT `libro_autor_ibfk_2` FOREIGN KEY (`id_autor`) REFERENCES `autor` (`id_autor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libro_autor`
--

LOCK TABLES `libro_autor` WRITE;
/*!40000 ALTER TABLE `libro_autor` DISABLE KEYS */;
INSERT INTO `libro_autor` VALUES (1,1),(2,1),(3,2),(4,2),(5,3),(6,4),(20,4),(7,6),(8,7),(9,8),(19,8),(10,9),(11,10),(12,11),(13,12),(17,12),(18,12),(14,13),(15,14),(16,15);
/*!40000 ALTER TABLE `libro_autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multa`
--

DROP TABLE IF EXISTS `multa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multa` (
  `id_multa` int NOT NULL AUTO_INCREMENT,
  `id_prestamo` int NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_generacion` date NOT NULL DEFAULT (curdate()),
  `fecha_pago` date DEFAULT NULL,
  `id_estado_multa` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_multa`),
  UNIQUE KEY `id_prestamo` (`id_prestamo`),
  KEY `id_estado_multa` (`id_estado_multa`),
  CONSTRAINT `multa_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamo` (`id_prestamo`),
  CONSTRAINT `multa_ibfk_2` FOREIGN KEY (`id_estado_multa`) REFERENCES `estado_multa` (`id_estado_multa`),
  CONSTRAINT `multa_chk_1` CHECK ((`monto` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multa`
--

LOCK TABLES `multa` WRITE;
/*!40000 ALTER TABLE `multa` DISABLE KEYS */;
INSERT INTO `multa` VALUES (1,2,15000.00,'2025-01-26',NULL,1),(2,6,25000.00,'2025-03-02',NULL,2),(3,9,10000.00,'2025-03-22',NULL,1),(4,13,30000.00,'2025-04-11',NULL,1),(5,17,20000.00,'2025-05-01',NULL,2);
/*!40000 ALTER TABLE `multa` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_pago_multa` BEFORE UPDATE ON `multa` FOR EACH ROW BEGIN
    IF NEW.id_estado_multa = 2 AND OLD.id_estado_multa = 1 THEN
        SET NEW.fecha_pago = CURDATE();
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `prestamo`
--

DROP TABLE IF EXISTS `prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamo` (
  `id_prestamo` int NOT NULL AUTO_INCREMENT,
  `id_libro` int NOT NULL,
  `id_usuario` int NOT NULL,
  `fecha_prestamo` date NOT NULL DEFAULT (curdate()),
  `fecha_devolucion_esperada` date NOT NULL,
  `fecha_devolucion_real` date DEFAULT NULL,
  `id_estado_prestamo` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_prestamo`),
  KEY `id_libro` (`id_libro`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_estado_prestamo` (`id_estado_prestamo`),
  CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libro` (`id_libro`),
  CONSTRAINT `prestamo_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `prestamo_ibfk_3` FOREIGN KEY (`id_estado_prestamo`) REFERENCES `estado_prestamo` (`id_estado_prestamo`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamo`
--

LOCK TABLES `prestamo` WRITE;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
INSERT INTO `prestamo` VALUES (1,1,1,'2025-01-05','2025-01-19','2025-01-18',2),(2,2,2,'2025-01-10','2025-01-24','2025-01-25',3),(3,3,3,'2025-01-15','2025-01-29','2025-01-29',2),(4,4,4,'2025-02-01','2025-02-15',NULL,1),(5,5,5,'2025-02-05','2025-02-19','2025-02-18',2),(6,6,6,'2025-02-10','2025-02-24','2025-03-01',3),(7,7,7,'2025-02-15','2025-03-01','2025-03-01',2),(8,8,8,'2025-02-20','2025-03-06',NULL,1),(9,9,9,'2025-03-01','2025-03-15','2025-03-20',3),(10,10,10,'2025-03-05','2025-03-19','2025-03-19',2),(11,11,11,'2025-03-10','2025-03-24',NULL,1),(12,12,12,'2025-03-15','2025-03-29','2025-03-28',2),(13,13,13,'2025-03-20','2025-04-03','2025-04-10',3),(14,14,14,'2025-03-25','2025-04-08',NULL,1),(15,15,15,'2025-04-01','2025-04-15','2025-04-15',2),(16,16,16,'2025-04-05','2025-04-19',NULL,1),(17,17,17,'2025-04-10','2025-04-24','2025-04-30',3),(18,18,18,'2025-04-15','2025-04-29',NULL,1),(19,19,19,'2026-01-10','2026-01-24',NULL,1),(20,20,20,'2026-02-01','2026-02-15',NULL,1),(21,15,1,'2026-04-05','2026-04-22',NULL,1);
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_auditoria_prestamo` AFTER INSERT ON `prestamo` FOR EACH ROW BEGIN
    INSERT INTO auditoria_prestamo(id_prestamo, id_usuario, id_libro, fecha_accion, accion)
    VALUES(NEW.id_prestamo, NEW.id_usuario, NEW.id_libro, NOW(), 'PRESTAMO REGISTRADO');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tipo_usuario`
--

DROP TABLE IF EXISTS `tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_usuario` (
  `id_tipo_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_usuario`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_usuario`
--

LOCK TABLES `tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
INSERT INTO `tipo_usuario` VALUES (1,'estudiante','Estudiante universitario'),(2,'docente','Profesor de la universidad'),(3,'administrativo','Personal administrativo');
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `documento` varchar(20) NOT NULL,
  `nombres` varchar(80) NOT NULL,
  `apellidos` varchar(80) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT '1234',
  `telefono` varchar(20) DEFAULT NULL,
  `id_tipo_usuario` int NOT NULL,
  `id_estado_usuario` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `documento` (`documento`),
  UNIQUE KEY `email` (`email`),
  KEY `id_tipo_usuario` (`id_tipo_usuario`),
  KEY `id_estado_usuario` (`id_estado_usuario`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_tipo_usuario`) REFERENCES `tipo_usuario` (`id_tipo_usuario`),
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_estado_usuario`) REFERENCES `estado_usuario` (`id_estado_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'1000001','Carlos','Rodríguez','carlos.rodriguez@urb.edu.co','1234','3101234567',1,1),(2,'1000002','María','González','maria.gonzalez@urb.edu.co','1234','3112345678',1,1),(3,'1000003','Andrés','Martínez','andres.martinez@urb.edu.co','1234','3123456789',1,1),(4,'1000004','Laura','Pérez','laura.perez@urb.edu.co','1234','3134567890',1,1),(5,'1000005','Juliana','López','juliana.lopez@urb.edu.co','1234','3145678901',1,1),(6,'1000006','Santiago','Ramírez','santiago.ramirez@urb.edu.co','1234','3156789012',1,1),(7,'1000007','Valentina','Torres','valentina.torres@urb.edu.co','1234','3167890123',1,1),(8,'1000008','David','Vargas','david.vargas@urb.edu.co','1234','3178901234',1,1),(9,'1000009','Daniela','Castro','daniela.castro@urb.edu.co','1234','3189012345',1,1),(10,'1000010','Felipe','Moreno','felipe.moreno@urb.edu.co','1234','3190123456',1,1),(11,'2000001','Jorge','Hernández','jorge.hernandez@urb.edu.co','1234','3201234567',2,1),(12,'2000002','Patricia','Díaz','patricia.diaz@urb.edu.co','1234','3212345678',2,1),(13,'2000003','Ricardo','Muñoz','ricardo.munoz@urb.edu.co','1234','3223456789',2,1),(14,'2000004','Claudia','Jiménez','claudia.jimenez@urb.edu.co','1234','3234567890',2,1),(15,'2000005','Gustavo','Ruiz','gustavo.ruiz@urb.edu.co','1234','3245678901',2,1),(16,'3000001','Mónica','Suárez','monica.suarez@urb.edu.co','admin123','3256789012',3,1),(17,'3000002','Hernando','Medina','hernando.medina@urb.edu.co','admin123','3267890123',3,1),(18,'3000003','Adriana','Rojas','adriana.rojas@urb.edu.co','admin123','3278901234',3,1),(19,'3000004','Camilo','Ortiz','camilo.ortiz@urb.edu.co','admin123','3289012345',3,1),(20,'3000005','Silvia','Reyes','silvia.reyes@urb.edu.co','admin123','3290123456',3,1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_libros_detallados`
--

DROP TABLE IF EXISTS `vw_libros_detallados`;
/*!50001 DROP VIEW IF EXISTS `vw_libros_detallados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_libros_detallados` AS SELECT 
 1 AS `id_libro`,
 1 AS `titulo`,
 1 AS `categoria`,
 1 AS `editorial`,
 1 AS `disponible`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_prestamos_activos`
--

DROP TABLE IF EXISTS `vw_prestamos_activos`;
/*!50001 DROP VIEW IF EXISTS `vw_prestamos_activos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_prestamos_activos` AS SELECT 
 1 AS `id_prestamo`,
 1 AS `nombre_usuario`,
 1 AS `apellido_usuario`,
 1 AS `titulo_libro`,
 1 AS `fecha_prestamo`,
 1 AS `fecha_devolucion_esperada`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_resumen_multas`
--

DROP TABLE IF EXISTS `vw_resumen_multas`;
/*!50001 DROP VIEW IF EXISTS `vw_resumen_multas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_resumen_multas` AS SELECT 
 1 AS `nombres`,
 1 AS `apellidos`,
 1 AS `email`,
 1 AS `total_deuda`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'biblioteca_db'
--

--
-- Dumping routines for database 'biblioteca_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_calcular_multa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_calcular_multa`(
    IN p_id_prestamo INT
)
BEGIN
    DECLARE v_fecha_esperada DATE;
    DECLARE v_dias_retraso INT;
    DECLARE v_monto DECIMAL(10,2);

    SELECT fecha_devolucion_esperada INTO v_fecha_esperada
    FROM prestamo
    WHERE id_prestamo = p_id_prestamo;

    SET v_dias_retraso = DATEDIFF(CURDATE(), v_fecha_esperada);

    IF v_dias_retraso > 0 THEN
        SET v_monto = v_dias_retraso * 1000;

        INSERT INTO multa(id_prestamo, monto, fecha_generacion, id_estado_multa)
        VALUES(p_id_prestamo, v_monto, CURDATE(), 1);

        UPDATE prestamo SET id_estado_prestamo = 3
        WHERE id_prestamo = p_id_prestamo;

        SELECT v_dias_retraso AS dias_retraso, v_monto AS monto_multa;
    ELSE
        SELECT 'El prestamo no tiene retraso' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_historial_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_historial_usuario`(
    IN p_id_usuario INT
)
BEGIN
    SELECT libro.titulo,
           prestamo.fecha_prestamo,
           prestamo.fecha_devolucion_esperada,
           prestamo.fecha_devolucion_real,
           estado_prestamo.nombre AS estado
    FROM prestamo
    INNER JOIN libro ON prestamo.id_libro = libro.id_libro
    INNER JOIN estado_prestamo ON prestamo.id_estado_prestamo = estado_prestamo.id_estado_prestamo
    WHERE prestamo.id_usuario = p_id_usuario
    ORDER BY prestamo.fecha_prestamo DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_prestamo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_prestamo`(
    IN p_id_libro INT,
    IN p_id_usuario INT,
    IN p_dias INT
)
BEGIN
    DECLARE v_disponible BOOLEAN;

    SELECT disponible INTO v_disponible
    FROM libro
    WHERE id_libro = p_id_libro;

    IF v_disponible = 1 THEN
        INSERT INTO prestamo(id_libro, id_usuario, fecha_prestamo, fecha_devolucion_esperada, id_estado_prestamo)
        VALUES(p_id_libro, p_id_usuario, CURDATE(), DATE_ADD(CURDATE(), INTERVAL p_dias DAY), 1);

        UPDATE libro SET disponible = 0
        WHERE id_libro = p_id_libro;

        SELECT 'Prestamo registrado exitosamente' AS mensaje;
    ELSE
        SELECT 'El libro no esta disponible' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_libros_detallados`
--

/*!50001 DROP VIEW IF EXISTS `vw_libros_detallados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_libros_detallados` AS select `l`.`id_libro` AS `id_libro`,`l`.`titulo` AS `titulo`,`c`.`nombre` AS `categoria`,`e`.`nombre` AS `editorial`,`l`.`disponible` AS `disponible` from ((`libro` `l` join `categoria` `c` on((`l`.`id_categoria` = `c`.`id_categoria`))) join `editorial` `e` on((`l`.`id_editorial` = `e`.`id_editorial`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_prestamos_activos`
--

/*!50001 DROP VIEW IF EXISTS `vw_prestamos_activos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_prestamos_activos` AS select `p`.`id_prestamo` AS `id_prestamo`,`u`.`nombres` AS `nombre_usuario`,`u`.`apellidos` AS `apellido_usuario`,`l`.`titulo` AS `titulo_libro`,`p`.`fecha_prestamo` AS `fecha_prestamo`,`p`.`fecha_devolucion_esperada` AS `fecha_devolucion_esperada` from ((`prestamo` `p` join `usuario` `u` on((`p`.`id_usuario` = `u`.`id_usuario`))) join `libro` `l` on((`p`.`id_libro` = `l`.`id_libro`))) where (`p`.`id_estado_prestamo` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_resumen_multas`
--

/*!50001 DROP VIEW IF EXISTS `vw_resumen_multas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_resumen_multas` AS select `u`.`nombres` AS `nombres`,`u`.`apellidos` AS `apellidos`,`u`.`email` AS `email`,sum(`m`.`monto`) AS `total_deuda` from ((`multa` `m` join `prestamo` `p` on((`m`.`id_prestamo` = `p`.`id_prestamo`))) join `usuario` `u` on((`p`.`id_usuario` = `u`.`id_usuario`))) where (`m`.`id_estado_multa` = 1) group by `u`.`id_usuario` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-05 22:46:53
