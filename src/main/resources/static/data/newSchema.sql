CREATE DATABASE  IF NOT EXISTS `qairlinez` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `qairlinez`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: qairlinez
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `aircrafts`
--

DROP TABLE IF EXISTS `aircrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircrafts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `manufacturer` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `number_of_seats` int DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircrafts`
--

LOCK TABLES `aircrafts` WRITE;
/*!40000 ALTER TABLE `aircrafts` DISABLE KEYS */;
INSERT INTO `aircrafts` VALUES (1,'Boeing','737',240,_binary '\0'),(2,'Airbus','A320',180,_binary '\0'),(3,'Boeing','737-800',160,_binary ''),(4,'Boeing','787-9 Dreamliner',296,_binary ''),(5,'Boeing','777-200LR',317,_binary ''),(6,'Boeing','747-8',410,_binary ''),(7,'Airbus','A320',180,_binary ''),(8,'Airbus','A350-900',315,_binary ''),(9,'Airbus','A380',500,_binary ''),(10,'Airbus','A321',220,_binary ''),(11,'Embraer','E175',88,_binary ''),(12,'Embraer','E195',120,_binary '\0'),(13,'Bombardier','CRJ200',50,_binary ''),(14,'Bombardier','Q400',78,_binary ''),(15,'ATR','ATR 72',70,_binary ''),(16,'ATR','ATR 42',50,_binary '');
/*!40000 ALTER TABLE `aircrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `airport_code` varchar(255) NOT NULL,
  `airport_name` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `country_id` bigint NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `airport_code_UNIQUE` (`airport_code`),
  KEY `FKimj7pril60webr05larg3wge7` (`country_id`),
  CONSTRAINT `FKimj7pril60webr05larg3wge7` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES (1,'HAN','Noi Bai International Airport','Hanoi',1,'',''),(2,'BKK','Suvarnabhumi Airport','Bangkok',2,'',''),(3,'NRT','Narita International Airport','Tokyo',3,'',''),(4,'SGN','Tan Son Nhat International Airport','Ho Chi Minh City',1,NULL,NULL),(6,'CXR','Cam Ranh International Airport','Nha Trang',1,NULL,NULL),(7,'DAD','Da Nang International Airport','Da Nang',1,NULL,NULL),(8,'UIH','Phu Cat Airport','Qui Nhon',1,NULL,NULL),(9,'VCA','Can Tho International Airport','Can Tho',1,NULL,NULL),(10,'VII','Phu Quoc International Airport','Phu Quoc',1,NULL,NULL),(11,'TBB','Thoi Hoa Airport','Bac Lieu',1,NULL,NULL),(12,'JFK','John F. Kennedy International Airport','New York',4,NULL,NULL),(13,'LHR','Heathrow Airport','London',5,NULL,NULL),(14,'CDG','Charles de Gaulle Airport','Paris',6,NULL,NULL),(15,'FCO','Leonardo da Vinci International Airport','Rome',7,NULL,NULL),(16,'GRU','São Paulo/Guarulhos–Governador André Franco Montoro International Airport','São Paulo',8,NULL,NULL),(17,'DEL','Indira Gandhi International Airport','New Delhi',9,NULL,NULL),(18,'YYZ','Toronto Pearson International Airport','Toronto',10,NULL,NULL),(19,'SYD','Sydney Kingsford Smith Airport','Sydney',11,NULL,NULL),(20,'MEX','Mexico City International Airport','Mexico City',12,NULL,NULL),(21,'ICN','Incheon International Airport','Seoul',13,NULL,NULL);
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `country_name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Vietnam','Vietnam description'),(2,'Thailand','Thailand description'),(3,'Japan','Japan description'),(4,'Vietnam','Vietnam description'),(5,'Thailand','Thailand description'),(6,'Japan','Japan description'),(7,'United States','The United States is a country primarily located in North America, known for its diverse culture and landscape.'),(8,'Germany','Germany is a country in Central Europe known for its history, engineering, and technological innovations.'),(9,'France','France is a European country famous for its rich history, art, and cuisine. Paris is its capital.'),(10,'Italy','Italy is a country in Southern Europe known for its art, architecture, history, and world-famous cuisine.'),(11,'Brazil','Brazil is the largest country in South America, known for its Amazon rainforest and Carnival festival.'),(12,'India','India is a country in South Asia, known for its ancient history, diverse cultures, and the Taj Mahal.'),(13,'Canada','Canada is a country in North America, famous for its natural beauty, including the Rocky Mountains and Niagara Falls.'),(14,'Australia','Australia is a country and continent surrounded by the Indian and Pacific oceans, known for its wildlife and natural wonders.'),(15,'Mexico','Mexico is a country in North America, known for its rich culture, historical landmarks, and beautiful beaches.'),(16,'South Korea','South Korea is a country in East Asia known for its technological innovations, pop culture, and rich history.');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `actual_arrival_time` datetime(6) DEFAULT NULL,
  `actual_departure_time` datetime(6) DEFAULT NULL,
  `expected_arrival_time` datetime(6) DEFAULT NULL,
  `expected_departure_time` datetime(6) DEFAULT NULL,
  `flight_number` varchar(255) DEFAULT NULL,
  `aircraft_id` bigint DEFAULT NULL,
  `departure_airport_id` int DEFAULT NULL,
  `destination_airport_id` int DEFAULT NULL,
  `cancel_due_time` datetime(6) DEFAULT NULL,
  `economy_seats` int NOT NULL,
  `business_seats` int NOT NULL,
  `first_seats` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlref405f4r8lfgiu9gbwbdtgv` (`aircraft_id`),
  KEY `FK1oo8ervoj8230wtvebwrqu2tf` (`departure_airport_id`),
  KEY `FKny1g2v5rad7ben4t7vq8yjlyr` (`destination_airport_id`),
  CONSTRAINT `FK1oo8ervoj8230wtvebwrqu2tf` FOREIGN KEY (`departure_airport_id`) REFERENCES `airports` (`id`),
  CONSTRAINT `FKlref405f4r8lfgiu9gbwbdtgv` FOREIGN KEY (`aircraft_id`) REFERENCES `aircrafts` (`id`),
  CONSTRAINT `FKny1g2v5rad7ben4t7vq8yjlyr` FOREIGN KEY (`destination_airport_id`) REFERENCES `airports` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'2023-12-01 08:30:00.000000','2023-12-01 06:00:00.000000','2023-12-01 08:00:00.000000','2023-12-01 06:00:00.000000','VN123',1,1,2,'2023-06-01 08:30:00.000000',168,48,24),(2,'2023-12-02 18:30:00.000000','2023-12-02 16:00:00.000000','2023-12-02 18:00:00.000000','2023-12-02 16:00:00.000000','TG456',2,2,3,'2023-06-02 18:30:00.000000',126,36,18),(4,'2024-12-05 15:30:00.000000','2024-12-05 13:00:00.000000','2024-12-05 15:45:00.000000','2024-12-05 13:15:00.000000','VN100',1,1,2,'2024-12-05 14:00:00.000000',150,20,5),(5,'2024-12-05 17:45:00.000000','2024-12-05 15:10:00.000000','2024-12-05 17:50:00.000000','2024-12-05 15:30:00.000000','VN101',2,2,1,'2024-12-05 16:00:00.000000',150,20,5),(6,'2024-12-05 22:30:00.000000','2024-12-05 20:00:00.000000','2024-12-06 05:30:00.000000','2024-12-05 20:10:00.000000','VN200',3,1,3,'2024-12-05 19:00:00.000000',200,30,10),(7,'2024-12-06 07:00:00.000000','2024-12-06 06:30:00.000000','2024-12-06 06:30:00.000000','2024-12-06 06:45:00.000000','VN201',4,3,1,'2024-12-06 05:00:00.000000',200,30,10),(8,'2024-12-06 10:30:00.000000','2024-12-06 08:00:00.000000','2024-12-06 12:15:00.000000','2024-12-06 08:30:00.000000','VN300',5,1,4,'2024-12-06 07:00:00.000000',180,25,8),(9,'2024-12-06 14:00:00.000000','2024-12-06 12:15:00.000000','2024-12-06 14:10:00.000000','2024-12-06 12:30:00.000000','VN301',6,4,1,'2024-12-06 11:00:00.000000',180,25,8),(10,'2024-12-06 23:00:00.000000','2024-12-06 21:00:00.000000','2024-12-07 08:15:00.000000','2024-12-06 21:15:00.000000','VN400',7,1,1,'2024-12-06 20:00:00.000000',250,40,15),(11,'2024-12-07 12:00:00.000000','2024-12-07 10:00:00.000000','2024-12-07 12:15:00.000000','2024-12-07 10:15:00.000000','VN401',8,1,1,'2024-12-07 09:00:00.000000',250,40,15),(12,'2024-12-07 17:00:00.000000','2024-12-07 14:30:00.000000','2024-12-07 21:00:00.000000','2024-12-07 14:45:00.000000','VN500',9,1,6,'2024-12-07 13:00:00.000000',300,50,20),(13,'2024-12-07 23:00:00.000000','2024-12-07 21:30:00.000000','2024-12-08 06:00:00.000000','2024-12-07 22:00:00.000000','VN501',10,6,1,'2024-12-07 20:00:00.000000',300,50,20),(14,'2024-12-06 15:30:00.000000','2024-12-06 13:00:00.000000','2024-12-06 15:45:00.000000','2024-12-06 13:15:00.000000','VN102',1,1,2,'2024-12-06 14:00:00.000000',160,20,5),(15,'2024-12-06 17:45:00.000000','2024-12-06 15:10:00.000000','2024-12-06 17:50:00.000000','2024-12-06 15:30:00.000000','VN103',2,2,1,'2024-12-06 16:00:00.000000',160,20,5),(16,'2024-12-07 22:30:00.000000','2024-12-07 20:00:00.000000','2024-12-08 05:30:00.000000','2024-12-07 20:10:00.000000','VN202',3,1,3,'2024-12-07 19:00:00.000000',200,30,10),(17,'2024-12-08 07:00:00.000000','2024-12-08 06:30:00.000000','2024-12-08 06:30:00.000000','2024-12-08 06:45:00.000000','VN203',4,3,1,'2024-12-08 05:00:00.000000',200,30,10),(18,'2024-12-08 10:30:00.000000','2024-12-08 08:00:00.000000','2024-12-08 12:15:00.000000','2024-12-08 08:30:00.000000','VN302',5,1,4,'2024-12-08 07:00:00.000000',180,25,8),(19,'2024-12-08 14:00:00.000000','2024-12-08 12:15:00.000000','2024-12-08 14:10:00.000000','2024-12-08 12:30:00.000000','VN303',6,4,1,'2024-12-08 11:00:00.000000',180,25,8),(20,'2024-12-09 23:00:00.000000','2024-12-09 21:00:00.000000','2024-12-10 08:15:00.000000','2024-12-09 21:15:00.000000','VN402',7,1,1,'2024-12-09 20:00:00.000000',250,40,15),(21,'2024-12-10 12:00:00.000000','2024-12-10 10:00:00.000000','2024-12-10 12:15:00.000000','2024-12-10 10:15:00.000000','VN403',8,1,1,'2024-12-10 09:00:00.000000',250,40,15),(22,'2024-12-10 17:00:00.000000','2024-12-10 14:30:00.000000','2024-12-10 21:00:00.000000','2024-12-10 14:45:00.000000','VN502',9,1,6,'2024-12-10 13:00:00.000000',300,50,20),(23,'2024-12-10 23:00:00.000000','2024-12-10 21:30:00.000000','2024-12-11 06:00:00.000000','2024-12-10 22:00:00.000000','VN503',10,6,1,'2024-12-10 20:00:00.000000',300,50,20),(24,'2024-12-15 15:30:00.000000','2024-12-15 13:00:00.000000','2024-12-15 15:45:00.000000','2024-12-15 13:15:00.000000','VN104',1,1,2,'2024-12-15 14:00:00.000000',160,20,5),(25,'2024-12-15 17:45:00.000000','2024-12-15 15:10:00.000000','2024-12-15 17:50:00.000000','2024-12-15 15:30:00.000000','VN105',2,2,1,'2024-12-15 16:00:00.000000',160,20,5),(26,'2024-12-20 22:30:00.000000','2024-12-20 20:00:00.000000','2024-12-21 05:30:00.000000','2024-12-20 20:10:00.000000','VN204',3,1,3,'2024-12-20 19:00:00.000000',200,30,10),(27,'2024-12-21 07:00:00.000000','2024-12-21 06:30:00.000000','2024-12-21 06:30:00.000000','2024-12-21 06:45:00.000000','VN205',4,3,1,'2024-12-21 05:00:00.000000',200,30,10),(28,'2024-12-22 10:30:00.000000','2024-12-22 08:00:00.000000','2024-12-22 12:15:00.000000','2024-12-22 08:30:00.000000','VN304',5,1,4,'2024-12-22 07:00:00.000000',180,25,8),(29,'2024-12-22 14:00:00.000000','2024-12-22 12:15:00.000000','2024-12-22 14:10:00.000000','2024-12-22 12:30:00.000000','VN305',6,4,1,'2024-12-22 11:00:00.000000',180,25,8),(30,'2024-12-23 23:00:00.000000','2024-12-23 21:00:00.000000','2024-12-24 08:15:00.000000','2024-12-23 21:15:00.000000','VN404',7,1,1,'2024-12-23 20:00:00.000000',250,40,15),(31,'2024-12-24 12:00:00.000000','2024-12-24 10:00:00.000000','2024-12-24 12:15:00.000000','2024-12-24 10:15:00.000000','VN405',8,1,1,'2024-12-24 09:00:00.000000',250,40,15),(32,'2024-12-25 17:00:00.000000','2024-12-25 14:30:00.000000','2024-12-25 21:00:00.000000','2024-12-25 14:45:00.000000','VN504',9,1,6,'2024-12-25 13:00:00.000000',300,50,20),(33,'2024-12-25 23:00:00.000000','2024-12-25 21:30:00.000000','2024-12-26 06:00:00.000000','2024-12-25 22:00:00.000000','VN505',10,6,1,'2024-12-25 20:00:00.000000',300,50,20);
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passengers`
--

DROP TABLE IF EXISTS `passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passengers` (
  `passenger_id` bigint NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(255) DEFAULT NULL,
  `seat_row` int NOT NULL,
  `seat_position` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ticket_class_id` bigint NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `passport_number` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `is_adult` tinyint(1) DEFAULT NULL,
  `flight_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `identification` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`passenger_id`),
  KEY `FK5rwljsnya2tdu14sy99r39k1b` (`flight_id`),
  KEY `FK_user` (`user_id`),
  KEY `FK_ticket_class` (`ticket_class_id`),
  CONSTRAINT `FK5rwljsnya2tdu14sy99r39k1b` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`id`),
  CONSTRAINT `FK_ticket_class` FOREIGN KEY (`ticket_class_id`) REFERENCES `ticket_classes` (`id`),
  CONSTRAINT `FK_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passengers`
--

LOCK TABLES `passengers` WRITE;
/*!40000 ALTER TABLE `passengers` DISABLE KEYS */;
INSERT INTO `passengers` VALUES (1,'Bank A',1,'A','test1@gmail.com',3,'John','Smith','P1234567','0345675123',1,1,1,NULL);
/*!40000 ALTER TABLE `passengers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKofx66keruapi6vyqpv6f2or37` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (2,'ROLE_ADMIN'),(1,'ROLE_USER');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_classes`
--

DROP TABLE IF EXISTS `ticket_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_classes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price_multiplier` float NOT NULL,
  `hand_baggage_weight` float DEFAULT NULL,
  `hand_baggage_count` int DEFAULT NULL,
  `checked_baggage_weight` float DEFAULT NULL,
  `checked_baggage_count` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_classes`
--

LOCK TABLES `ticket_classes` WRITE;
/*!40000 ALTER TABLE `ticket_classes` DISABLE KEYS */;
INSERT INTO `ticket_classes` VALUES (1,'Economy','Basic ticket class with limited amenities',1,7,1,20,1),(2,'Business','Enhanced comfort with additional services',1.5,6,2,40,1),(3,'First','Premium class with luxury amenities',2,15,2,40,3);
/*!40000 ALTER TABLE `ticket_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FKh8ciramu9cc9q3qcqiv4ue8a6` (`role_id`),
  CONSTRAINT `FKh8ciramu9cc9q3qcqiv4ue8a6` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `FKhfh9dx7w3ubf1co1vdev94g3f` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `birthdate` datetime(6) NOT NULL,
  `email` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'1999-12-24 07:00:00.000000','test1@gmail.com','John','Smith','$2a$10$F5xpEalHUfjZcLh0Sf5Mu.5MKT0eZWXloxGOscbs3M5kyBcErAQlO','0345675123'),(2,'2009-10-28 07:00:00.000000','trannhanhot@gmail.com','Trần Nhả','Nhớt','$2a$10$ksjN/QcVi7yWQn1UcMMj7OYNoiIleO/4esqxP4C3tqavangTQm2MK','01234546396');
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

-- Dump completed