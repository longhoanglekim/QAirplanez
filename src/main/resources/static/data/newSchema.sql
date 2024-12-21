Drop DATABASE IF EXISTS `qairlinez`;
CREATE DATABASE  IF NOT EXISTS `qairlinez`;
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


/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (2,'ROLE_ADMIN'),(1,'ROLE_USER'),
                           (3, 'ROLE_ADMIN_FLIGHT'), (4, 'ROLE_ADMIN_AIRCRAFT'),
                           (5, 'ROLE_ADMIN_AIRPORT'), (6, 'ROLE_ADMIN_NEWS'),
                           (7, 'ROLE_ADMIN_PASSENGER');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;


--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `birthdate` datetime(6) NOT NULL,
                         `email` varchar(255) unique NOT NULL,
                         `firstname` varchar(255) NOT NULL,
                         `lastname` varchar(255) NOT NULL,
                         `password` varchar(255) NOT NULL,
                         `phone_number` varchar(255) unique DEFAULT NULL,
                         `identification` varchar(255) unique ,
                         `nationality` varchar(255) ,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--


/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2004-10-20 07:00:00.000000','quyenluong@gmail.com','John','Smith','$2a$10$tkTCCEd6MYfqxq1IQDZPduT8HgU1H3/CbquVCg2Vcsi.p3bsZPLxS','0345675123', '020203000123','Vietnam'),
                           (2,'2009-10-28 07:00:00.000000','trannhanhot@gmail.com','Trần Nhả','Nhớt','$2a$10$ksjN/QcVi7yWQn1UcMMj7OYNoiIleO/4esqxP4C3tqavangTQm2MK','01234546396', '020403000123','Vietnam'),
                           (3,'2003-12-17 07:00:00.000000','adminflight@gmail.com','Hoàng','Long','$2a$10$BE0z27bNdJV1R72GCw9FxupWSFGFGDrb0sfx/s1beULqK5tl2FDYK','0123567486', '020403000121','Vietnam');  /* password : adminflight */
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


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


/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1),(2,2), (3,3);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;


--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
                          `id` bigint NOT NULL AUTO_INCREMENT,
                          `name` varchar(255) NOT NULL,
                          `type` varchar(255) NOT NULL,
                          `image_data` longblob,
                          `user_id` bigint DEFAULT NULL,
                          `upload_date` date DEFAULT NULL,
                          PRIMARY KEY (`id`),
                          CONSTRAINT `images_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
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
                             `status` varchar(255) NOT NULL DEFAULT 'Scheduled',
                             `serial_number` varchar(255) unique not null,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircrafts`
--


/*!40000 ALTER TABLE `aircrafts` DISABLE KEYS */;
INSERT INTO `aircrafts` (`id`, `manufacturer`, `model`, `number_of_seats`, `status`, `serial_number`) VALUES
                                                                                                          (1, 'Boeing', '737', 240, 'Active', 'B00001'),
                                                                                                          (2, 'Airbus', 'A320', 180, 'Maintenance', 'A00001'),
                                                                                                          (3, 'Boeing', '737-800', 160, 'Inactive', 'B00002'),
                                                                                                          (4, 'Boeing', '787-9 Dreamliner', 296, 'Active', 'B00003'),
                                                                                                          (5, 'Boeing', '777-200LR', 317, 'Active', 'B00004'),
                                                                                                          (6, 'Boeing', '747-8', 410, 'Active', 'B00005'),
                                                                                                          (7, 'Airbus', 'A320', 180, 'Inactive', 'A00002'),
                                                                                                          (8, 'Airbus', 'A350-900', 315, 'Maintenance', 'A00003'),
                                                                                                          (9, 'Airbus', 'A380', 500, 'Active', 'A00004'),
                                                                                                          (10, 'Airbus', 'A321', 220, 'Active', 'A00005'),
                                                                                                          (11, 'Embraer', 'E175', 88, 'Active', 'E00001'),
                                                                                                          (12, 'Embraer', 'E195', 120, 'Active', 'E00002'),
                                                                                                          (13, 'Bombardier', 'CRJ200', 50, 'Active', 'B00006'),
                                                                                                          (14, 'Bombardier', 'Q400', 78, 'Maintenance', 'B00007'),
                                                                                                          (15, 'ATR', 'BE', 160, 'Maintenance', 'A00006'),
                                                                                                          (16, 'ATR', 'AE', 50, 'Inactive', 'A00007');


--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        `news_index` BIGINT,
                        title VARCHAR(255) NOT NULL,
                        posting_date DATETIME,
                        author_id BIGINT NOT NULL,
                        content TEXT,
                        `type` varchar(255) DEFAULT NULL,
                        edit_date DATETIME,
                        image_id bigint,
                        CONSTRAINT `key_user` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`), -- Giả sử bảng `users` tồn tại
                        CONSTRAINT `key_image` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`) -- Giả sử bảng `users` tồn tại
);

INSERT INTO news (`news_index`, title, posting_date, content, author_id)
VALUES
    (1, 'Breaking News: Market Hits New High', '2024-12-17 10:00:00', 'The stock market reached an all-time high today, fueled by optimism about the economy. Investors are seeing strong earnings reports from major corporations.', 2),
    (2, 'Weather Alert: Winter Storm Approaching', '2024-12-17 12:00:00', 'A winter storm is expected to hit the region by tomorrow morning. Residents are advised to prepare for heavy snow and icy roads.', 2),
    (3, 'New Technology Startup Gains Attention', '2024-12-17 14:00:00', 'A new tech startup focused on AI solutions is making waves in Silicon Valley. The company has already secured a significant amount of investment and is poised for growth.', 2);

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


/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES (1,'HAN','Noi Bai International Airport','Hanoi',1,'',''),(2,'BKK','Suvarnabhumi Airport','Bangkok',2,'',''),(3,'NRT','Narita International Airport','Tokyo',3,'',''),(4,'SGN','Tan Son Nhat International Airport','Ho Chi Minh City',1,NULL,NULL),(6,'CXR','Cam Ranh International Airport','Nha Trang',1,NULL,NULL),(7,'DAD','Da Nang International Airport','Da Nang',1,NULL,NULL),(8,'UIH','Phu Cat Airport','Qui Nhon',1,NULL,NULL),(9,'VCA','Can Tho International Airport','Can Tho',1,NULL,NULL),(10,'VII','Phu Quoc International Airport','Phu Quoc',1,NULL,NULL),(11,'TBB','Thoi Hoa Airport','Bac Lieu',1,NULL,NULL),(12,'JFK','John F. Kennedy International Airport','New York',4,NULL,NULL),(13,'LHR','Heathrow Airport','London',5,NULL,NULL),(14,'CDG','Charles de Gaulle Airport','Paris',6,NULL,NULL),(15,'FCO','Leonardo da Vinci International Airport','Rome',7,NULL,NULL),(16,'GRU','São Paulo/Guarulhos–Governador André Franco Montoro International Airport','São Paulo',8,NULL,NULL),(17,'DEL','Indira Gandhi International Airport','New Delhi',9,NULL,NULL),(18,'YYZ','Toronto Pearson International Airport','Toronto',10,NULL,NULL),(19,'SYD','Sydney Kingsford Smith Airport','Sydney',11,NULL,NULL),(20,'MEX','Mexico City International Airport','Mexico City',12,NULL,NULL),(21,'ICN','Incheon International Airport','Seoul',13,NULL,NULL);
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;


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


/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Vietnam','Vietnam description'),(2,'Thailand','Thailand description'),(3,'Japan','Japan description'),(4,'Vietnam','Vietnam description'),(5,'Thailand','Thailand description'),(6,'Japan','Japan description'),(7,'United States','The United States is a country primarily located in North America, known for its diverse culture and landscape.'),(8,'Germany','Germany is a country in Central Europe known for its history, engineering, and technological innovations.'),(9,'France','France is a European country famous for its rich history, art, and cuisine. Paris is its capital.'),(10,'Italy','Italy is a country in Southern Europe known for its art, architecture, history, and world-famous cuisine.'),(11,'Brazil','Brazil is the largest country in South America, known for its Amazon rainforest and Carnival festival.'),(12,'India','India is a country in South Asia, known for its ancient history, diverse cultures, and the Taj Mahal.'),(13,'Canada','Canada is a country in North America, famous for its natural beauty, including the Rocky Mountains and Niagara Falls.'),(14,'Australia','Australia is a country and continent surrounded by the Indian and Pacific oceans, known for its wildlife and natural wonders.'),(15,'Mexico','Mexico is a country in North America, known for its rich culture, historical landmarks, and beautiful beaches.'),(16,'South Korea','South Korea is a country in East Asia known for its technological innovations, pop culture, and rich history.');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;


--
-- Table structure for table `flights`
--

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
                           `economy_available_seats` int NOT NULL,
                           `business_available_seats` int NOT NULL,
                           `first_available_seats` int NOT NULL,
                           `status` VARCHAR(50) DEFAULT 'Scheduled',
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


/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'2024-12-30 08:30:00.000000','2024-12-30 06:00:00.000000','2024-12-30 08:00:00.000000','2024-12-30 06:00:00.000000','VN123',1,1,2,'2024-12-22 08:30:00.000000',168,48,23,'Scheduled'),
                             (2,'2025-01-07 08:30:00.000000','2025-01-07 08:30:00.000000','2025-01-07 10:30:00.000000','2025-01-07 10:30:00.000000','VN124',1,2,1,'2025-01-02 10:30:00.000000',168,48,23,'Scheduled'),
                             (3,'2024-12-05 15:30:00.000000','2024-12-05 13:00:00.000000','2024-12-05 15:45:00.000000','2024-12-05 13:15:00.000000','VN100',1,1,2,'2024-12-05 14:00:00.000000',150,20,5, 'Scheduled'),
                             (4,'2024-12-05 17:45:00.000000','2024-12-05 15:10:00.000000','2024-12-05 17:50:00.000000','2024-12-05 15:30:00.000000','VN101',2,2,1,'2024-12-05 16:00:00.000000',150,20,5, 'Scheduled'),
                             (5,'2024-12-05 22:30:00.000000','2024-12-05 20:00:00.000000','2024-12-06 05:30:00.000000','2024-12-05 20:10:00.000000','VN200',3,1,3,'2024-12-05 19:00:00.000000',200,30,10, 'Scheduled'),
                             (6,'2024-12-06 07:00:00.000000','2024-12-06 06:30:00.000000','2024-12-06 06:30:00.000000','2024-12-06 06:45:00.000000','VN201',4,3,1,'2024-12-06 05:00:00.000000',200,30,10, 'Scheduled'),
                             (7,'2024-12-06 10:30:00.000000','2024-12-06 08:00:00.000000','2024-12-06 12:15:00.000000','2024-12-06 08:30:00.000000','VN300',5,1,4,'2024-12-06 07:00:00.000000',180,25,8, 'Scheduled'),
                             (8,'2024-12-06 14:00:00.000000','2024-12-06 12:15:00.000000','2024-12-06 14:10:00.000000','2024-12-06 12:30:00.000000','VN301',6,4,1,'2024-12-06 11:00:00.000000',180,25,8, 'Scheduled'),
                             (9,'2024-12-06 23:00:00.000000','2024-12-06 21:00:00.000000','2024-12-07 08:15:00.000000','2024-12-06 21:15:00.000000','VN400',7,1,1,'2024-12-06 20:00:00.000000',250,40,15, 'Scheduled'),
                             (10,'2024-12-07 12:00:00.000000','2024-12-07 10:00:00.000000','2024-12-07 12:15:00.000000','2024-12-07 10:15:00.000000','VN401',8,1,1,'2024-12-07 09:00:00.000000',250,40,15, 'Scheduled'),
                             (11,'2024-12-07 17:00:00.000000','2024-12-07 14:30:00.000000','2024-12-07 21:00:00.000000','2024-12-07 14:45:00.000000','VN500',9,1,6,'2024-12-07 13:00:00.000000',300,50,20, 'Scheduled'),
                             (12,'2024-12-07 23:00:00.000000','2024-12-07 21:30:00.000000','2024-12-08 06:00:00.000000','2024-12-07 22:00:00.000000','VN501',10,6,1,'2024-12-07 20:00:00.000000',300,50,20, 'Scheduled'),
                             (13,'2024-12-06 15:30:00.000000','2024-12-06 13:00:00.000000','2024-12-06 15:45:00.000000','2024-12-06 13:15:00.000000','VN102',1,1,2,'2024-12-06 14:00:00.000000',160,20,5, 'Scheduled'),
                             (14,'2024-12-06 17:45:00.000000','2024-12-06 15:10:00.000000','2024-12-06 17:50:00.000000','2024-12-06 15:30:00.000000','VN103',2,2,1,'2024-12-06 16:00:00.000000',160,20,5, 'Scheduled'),
                             (15,'2024-12-07 22:30:00.000000','2024-12-07 20:00:00.000000','2024-12-08 05:30:00.000000','2024-12-07 20:10:00.000000','VN202',3,1,3,'2024-12-07 19:00:00.000000',200,30,10, 'Scheduled'),
                             (16,'2024-12-08 07:00:00.000000','2024-12-08 06:30:00.000000','2024-12-08 06:30:00.000000','2024-12-08 06:45:00.000000','VN203',4,3,1,'2024-12-08 05:00:00.000000',200,30,10, 'Scheduled'),
                             (17,'2024-12-08 10:30:00.000000','2024-12-08 08:00:00.000000','2024-12-08 12:15:00.000000','2024-12-08 08:30:00.000000','VN302',5,1,4,'2024-12-08 07:00:00.000000',180,25,8, 'Scheduled'),
                             (18,'2024-12-08 14:00:00.000000','2024-12-08 12:15:00.000000','2024-12-08 14:10:00.000000','2024-12-08 12:30:00.000000','VN303',6,4,1,'2024-12-08 11:00:00.000000',180,25,8, 'Scheduled'),
                             (19,'2024-12-09 23:00:00.000000','2024-12-09 21:00:00.000000','2024-12-10 08:15:00.000000','2024-12-09 21:15:00.000000','VN402',7,1,1,'2024-12-09 20:00:00.000000',250,40,15, 'Scheduled'),
                             (20,'2024-12-10 12:00:00.000000','2024-12-10 10:00:00.000000','2024-12-10 12:15:00.000000','2024-12-10 10:15:00.000000','VN403',8,1,1,'2024-12-10 09:00:00.000000',250,40,15, 'Scheduled'),
                             (21,'2024-12-10 17:00:00.000000','2024-12-10 14:30:00.000000','2024-12-10 21:00:00.000000','2024-12-10 14:45:00.000000','VN502',9,1,6,'2024-12-10 13:00:00.000000',300,50,20, 'Scheduled'),
                             (22,'2024-12-10 23:00:00.000000','2024-12-10 21:30:00.000000','2024-12-11 06:00:00.000000','2024-12-10 22:00:00.000000','VN503',10,6,1,'2024-12-10 20:00:00.000000',300,50,20, 'Scheduled'),
                             (23,'2024-12-15 15:30:00.000000','2024-12-15 13:00:00.000000','2024-12-15 15:45:00.000000','2024-12-15 13:15:00.000000','VN104',1,1,2,'2024-12-15 14:00:00.000000',160,20,5, 'Scheduled'),
                             (24,'2024-12-15 17:45:00.000000','2024-12-15 15:10:00.000000','2024-12-15 17:50:00.000000','2024-12-15 15:30:00.000000','VN105',2,2,1,'2024-12-15 16:00:00.000000',160,20,5, 'Scheduled'),
                             (25,'2024-12-20 22:30:00.000000','2024-12-20 20:00:00.000000','2024-12-21 05:30:00.000000','2024-12-20 20:10:00.000000','VN204',3,1,3,'2024-12-20 19:00:00.000000',200,30,10, 'Scheduled'),
                             (26,'2024-12-21 07:00:00.000000','2024-12-21 06:30:00.000000','2024-12-21 06:30:00.000000','2024-12-21 06:45:00.000000','VN205',4,3,1,'2024-12-21 05:00:00.000000',200,30,10, 'Scheduled'),
                             (27,'2024-12-22 10:30:00.000000','2024-12-22 08:00:00.000000','2024-12-22 12:15:00.000000','2024-12-22 08:30:00.000000','VN304',5,1,4,'2024-12-22 07:00:00.000000',180,25,8, 'Scheduled'),
                             (28,'2024-12-22 14:00:00.000000','2024-12-22 12:15:00.000000','2024-12-22 14:10:00.000000','2024-12-22 12:30:00.000000','VN305',6,4,1,'2024-12-22 11:00:00.000000',180,25,8, 'Scheduled'),
                             (29,'2024-12-23 23:00:00.000000','2024-12-23 21:00:00.000000','2024-12-24 08:15:00.000000','2024-12-23 21:15:00.000000','VN404',7,1,1,'2024-12-23 20:00:00.000000',250,40,15, 'Scheduled'),
                             (30,'2024-12-24 12:00:00.000000','2024-12-24 10:00:00.000000','2024-12-24 12:15:00.000000','2024-12-24 10:15:00.000000','VN405',8,1,1,'2024-12-24 09:00:00.000000',250,40,15, 'Scheduled'),
                             (31,'2024-12-25 17:00:00.000000','2024-12-25 14:30:00.000000','2024-12-25 21:00:00.000000','2024-12-25 14:45:00.000000','VN504',9,1,6,'2024-12-25 13:00:00.000000',300,50,20, 'Scheduled'),
                             (32,'2024-12-25 23:00:00.000000','2024-12-25 21:30:00.000000','2024-12-26 06:00:00.000000','2024-12-25 22:00:00.000000','VN505',10,6,1,'2024-12-25 20:00:00.000000',300,50,20, 'Scheduled');
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;

--
-- Dumping data for table `flights`
--


/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'2024-12-30 08:30:00.000000','2024-12-30 06:00:00.000000','2024-12-30 08:00:00.000000','2024-12-30 06:00:00.000000','VN123',1,1,2,'2024-12-22 08:30:00.000000',168,48,23,'Scheduled'),
                             (2,'2025-01-07 08:30:00.000000','2025-01-07 08:30:00.000000','2025-01-07 10:30:00.000000','2025-01-07 10:30:00.000000','VN124',1,2,1,'2025-01-02 10:30:00.000000',168,48,23,'Scheduled'),
                             (3,'2024-12-05 15:30:00.000000','2024-12-05 13:00:00.000000','2024-12-05 15:45:00.000000','2024-12-05 13:15:00.000000','VN100',1,1,2,'2024-12-05 14:00:00.000000',150,20,5, 'Scheduled'),
                             (4,'2024-12-05 17:45:00.000000','2024-12-05 15:10:00.000000','2024-12-05 17:50:00.000000','2024-12-05 15:30:00.000000','VN101',2,2,1,'2024-12-05 16:00:00.000000',150,20,5, 'Scheduled'),
                             (5,'2024-12-05 22:30:00.000000','2024-12-05 20:00:00.000000','2024-12-06 05:30:00.000000','2024-12-05 20:10:00.000000','VN200',3,1,3,'2024-12-05 19:00:00.000000',200,30,10, 'Scheduled'),
                             (6,'2024-12-06 07:00:00.000000','2024-12-06 06:30:00.000000','2024-12-06 06:30:00.000000','2024-12-06 06:45:00.000000','VN201',4,3,1,'2024-12-06 05:00:00.000000',200,30,10, 'Scheduled'),
                             (7,'2024-12-06 10:30:00.000000','2024-12-06 08:00:00.000000','2024-12-06 12:15:00.000000','2024-12-06 08:30:00.000000','VN300',5,1,4,'2024-12-06 07:00:00.000000',180,25,8, 'Scheduled'),
                             (8,'2024-12-06 14:00:00.000000','2024-12-06 12:15:00.000000','2024-12-06 14:10:00.000000','2024-12-06 12:30:00.000000','VN301',6,4,1,'2024-12-06 11:00:00.000000',180,25,8, 'Scheduled'),
                             (9,'2024-12-06 23:00:00.000000','2024-12-06 21:00:00.000000','2024-12-07 08:15:00.000000','2024-12-06 21:15:00.000000','VN400',7,1,1,'2024-12-06 20:00:00.000000',250,40,15, 'Scheduled'),
                             (10,'2024-12-07 12:00:00.000000','2024-12-07 10:00:00.000000','2024-12-07 12:15:00.000000','2024-12-07 10:15:00.000000','VN401',8,1,1,'2024-12-07 09:00:00.000000',250,40,15, 'Scheduled'),
                             (11,'2024-12-07 17:00:00.000000','2024-12-07 14:30:00.000000','2024-12-07 21:00:00.000000','2024-12-07 14:45:00.000000','VN500',9,1,6,'2024-12-07 13:00:00.000000',300,50,20, 'Scheduled'),
                             (12,'2024-12-07 23:00:00.000000','2024-12-07 21:30:00.000000','2024-12-08 06:00:00.000000','2024-12-07 22:00:00.000000','VN501',10,6,1,'2024-12-07 20:00:00.000000',300,50,20, 'Scheduled'),
                             (13,'2024-12-06 15:30:00.000000','2024-12-06 13:00:00.000000','2024-12-06 15:45:00.000000','2024-12-06 13:15:00.000000','VN102',1,1,2,'2024-12-06 14:00:00.000000',160,20,5, 'Scheduled'),
                             (14,'2024-12-06 17:45:00.000000','2024-12-06 15:10:00.000000','2024-12-06 17:50:00.000000','2024-12-06 15:30:00.000000','VN103',2,2,1,'2024-12-06 16:00:00.000000',160,20,5, 'Scheduled'),
                             (15,'2024-12-07 22:30:00.000000','2024-12-07 20:00:00.000000','2024-12-08 05:30:00.000000','2024-12-07 20:10:00.000000','VN202',3,1,3,'2024-12-07 19:00:00.000000',200,30,10, 'Scheduled'),
                             (16,'2024-12-08 07:00:00.000000','2024-12-08 06:30:00.000000','2024-12-08 06:30:00.000000','2024-12-08 06:45:00.000000','VN203',4,3,1,'2024-12-08 05:00:00.000000',200,30,10, 'Scheduled'),
                             (17,'2024-12-08 10:30:00.000000','2024-12-08 08:00:00.000000','2024-12-08 12:15:00.000000','2024-12-08 08:30:00.000000','VN302',5,1,4,'2024-12-08 07:00:00.000000',180,25,8, 'Scheduled'),
                             (18,'2024-12-08 14:00:00.000000','2024-12-08 12:15:00.000000','2024-12-08 14:10:00.000000','2024-12-08 12:30:00.000000','VN303',6,4,1,'2024-12-08 11:00:00.000000',180,25,8, 'Scheduled'),
                             (19,'2024-12-09 23:00:00.000000','2024-12-09 21:00:00.000000','2024-12-10 08:15:00.000000','2024-12-09 21:15:00.000000','VN402',7,1,1,'2024-12-09 20:00:00.000000',250,40,15, 'Scheduled'),
                             (20,'2024-12-10 12:00:00.000000','2024-12-10 10:00:00.000000','2024-12-10 12:15:00.000000','2024-12-10 10:15:00.000000','VN403',8,1,1,'2024-12-10 09:00:00.000000',250,40,15, 'Scheduled'),
                             (21,'2024-12-10 17:00:00.000000','2024-12-10 14:30:00.000000','2024-12-10 21:00:00.000000','2024-12-10 14:45:00.000000','VN502',9,1,6,'2024-12-10 13:00:00.000000',300,50,20, 'Scheduled'),
                             (22,'2024-12-10 23:00:00.000000','2024-12-10 21:30:00.000000','2024-12-11 06:00:00.000000','2024-12-10 22:00:00.000000','VN503',10,6,1,'2024-12-10 20:00:00.000000',300,50,20, 'Scheduled'),
                             (23,'2024-12-15 15:30:00.000000','2024-12-15 13:00:00.000000','2024-12-15 15:45:00.000000','2024-12-15 13:15:00.000000','VN104',1,1,2,'2024-12-15 14:00:00.000000',160,20,5, 'Scheduled'),
                             (24,'2024-12-15 17:45:00.000000','2024-12-15 15:10:00.000000','2024-12-15 17:50:00.000000','2024-12-15 15:30:00.000000','VN105',2,2,1,'2024-12-15 16:00:00.000000',160,20,5, 'Scheduled'),
                             (25,'2024-12-20 22:30:00.000000','2024-12-20 20:00:00.000000','2024-12-21 05:30:00.000000','2024-12-20 20:10:00.000000','VN204',3,1,3,'2024-12-20 19:00:00.000000',200,30,10, 'Scheduled'),
                             (26,'2024-12-21 07:00:00.000000','2024-12-21 06:30:00.000000','2024-12-21 06:30:00.000000','2024-12-21 06:45:00.000000','VN205',4,3,1,'2024-12-21 05:00:00.000000',200,30,10, 'Scheduled'),
                             (27,'2024-12-22 10:30:00.000000','2024-12-22 08:00:00.000000','2024-12-22 12:15:00.000000','2024-12-22 08:30:00.000000','VN304',5,1,4,'2024-12-22 07:00:00.000000',180,25,8, 'Scheduled'),
                             (28,'2024-12-22 14:00:00.000000','2024-12-22 12:15:00.000000','2024-12-22 14:10:00.000000','2024-12-22 12:30:00.000000','VN305',6,4,1,'2024-12-22 11:00:00.000000',180,25,8, 'Scheduled'),
                             (29,'2024-12-23 23:00:00.000000','2024-12-23 21:00:00.000000','2024-12-24 08:15:00.000000','2024-12-23 21:15:00.000000','VN404',7,1,1,'2024-12-23 20:00:00.000000',250,40,15, 'Scheduled'),
                             (30,'2024-12-24 12:00:00.000000','2024-12-24 10:00:00.000000','2024-12-24 12:15:00.000000','2024-12-24 10:15:00.000000','VN405',8,1,1,'2024-12-24 09:00:00.000000',250,40,15, 'Scheduled'),
                             (31,'2024-12-25 17:00:00.000000','2024-12-25 14:30:00.000000','2024-12-25 21:00:00.000000','2024-12-25 14:45:00.000000','VN504',9,1,6,'2024-12-25 13:00:00.000000',300,50,20, 'Scheduled'),
                             (32,'2024-12-25 23:00:00.000000','2024-12-25 21:30:00.000000','2024-12-26 06:00:00.000000','2024-12-25 22:00:00.000000','VN505',10,6,1,'2024-12-25 20:00:00.000000',300,50,20, 'Scheduled');
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;

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


/*!40000 ALTER TABLE `ticket_classes` DISABLE KEYS */;
INSERT INTO `ticket_classes` VALUES (1,'Economy','Basic ticket class with limited amenities',1,7,1,20,1),
                                    (2,'Business','Enhanced comfort with additional services',1.5,6,2,40,1),
                                    (3,'First','Premium class with luxury amenities',2,15,2,40,3);
/*!40000 ALTER TABLE `ticket_classes` ENABLE KEYS */;

--
-- Table structure for table `booking_ticket`
--
DROP table if exists `booking_tickets`;
CREATE TABLE booking_tickets (
                                 id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                 booking_code VARCHAR(255),
                                 service VARCHAR(255),
                                 total_price decimal,
                                 booking_date datetime
);
INSERT INTO booking_tickets (id, booking_code, service, total_price, booking_date)
VALUES
    (2, 'XLF46', "service_1", 145000.00, '2024-12-31'),
    (3, 'XLF47', "service_2", 98000.00, '2025-01-01'),
    (4, 'XLF48', "service_3", 154000.00, '2025-01-02'),
    (5, 'XLF49', "service_4", 132000.00, '2025-01-03'),
    (6, 'XLF50', "service_5", 121000.00, '2025-01-04'),
    (7, 'XLF51', "service_6", 114000.00, '2025-01-05'),
    (8, 'XLF52', "service_7", 160000.00, '2025-01-06'),
    (9, 'XLF53', "service_8", 102000.00, '2025-01-07'),
    (10, 'XLF54', "service_9", 139000.00, '2025-01-08'),
    (11, 'XLF55', "service_10", 118000.00, '2025-01-09'),
    (12, 'XLF56', "service_11", 97000.00, '2025-01-10'),
    (13, 'XLF57', "service_12", 143000.00, '2025-01-11'),
    (14, 'XLF58', "service_13", 120000.00, '2025-01-12'),
    (15, 'XLF59', "service_14", 150000.00, '2025-01-13'),
    (16, 'XLF60', "service_15", 135000.00, '2025-01-14'),
    (17, 'XLF61', "service_16", 108000.00, '2025-01-15'),
    (18, 'XLF62', "service_17", 132000.00, '2025-01-16'),
    (19, 'XLF63', "service_18", 155000.00, '2025-01-17'),
    (20, 'XLF64', "service_19", 122000.00, '2025-01-18'),
    (21, 'XLF65', "service_20", 111000.00, '2025-01-19'),
    (22, 'XLF66', "service_21", 141000.00, '2025-01-20'),
    (23, 'XLF67', "service_22", 128000.00, '2025-01-21'),
    (24, 'XLF68', "service_23", 137000.00, '2025-01-22'),
    (25, 'XLF69', "service_24", 100000.00, '2025-01-23'),
    (26, 'XLF70', "service_25", 119000.00, '2025-01-24'),
    (27, 'XLF71', "service_26", 126000.00, '2025-01-25'),
    (28, 'XLF72', "service_27", 138000.00, '2025-01-26'),
    (29, 'XLF73', "service_28", 140000.00, '2025-01-27'),
    (30, 'XLF74', "service_29", 113000.00, '2025-01-28'),
    (31, 'XLF75', "service_30", 134000.00, '2025-01-29'),
    (32, 'XLF76', "service_31", 144000.00, '2025-01-30'),
    (33, 'XLF77', "service_32", 149000.00, '2025-01-31'),
    (34, 'XLF78', "service_33", 130000.00, '2025-02-01'),
    (35, 'XLF79', "service_34", 101000.00, '2025-02-02'),
    (36, 'XLF80', "service_35", 153000.00, '2025-02-03'),
    (37, 'XLF81', "service_36", 112000.00, '2025-02-04'),
    (38, 'XLF82', "service_37", 129000.00, '2025-02-05'),
    (39, 'XLF83', "service_38", 136000.00, '2025-02-06'),
    (40, 'XLF84', "service_39", 121000.00, '2025-02-07'),
    (41, 'XLF85', "service_40", 145000.00, '2025-02-08'),
    (42, 'XLF86', "service_41", 123000.00, '2025-02-09'),
    (43, 'XLF87', "service_42", 157000.00, '2025-02-10'),
    (44, 'XLF88', "service_43", 139000.00, '2025-02-11'),
    (45, 'XLF89', "service_44", 142000.00, '2025-02-12'),
    (46, 'XLF90', "service_45", 119000.00, '2025-02-13'),
    (47, 'XLF91', "service_46", 148000.00, '2025-02-14'),
    (48, 'XLF92', "service_47", 133000.00, '2025-02-15'),
    (49, 'XLF93', "service_48", 147000.00, '2025-02-16'),
    (50, 'XLF94', "service_49", 152000.00, '2025-02-17');
--
-- Table structure for table `passengers`
--

DROP TABLE IF EXISTS `passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE passengers (
                            passenger_id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            first_name VARCHAR(255) NOT NULL,
                            last_name VARCHAR(255) NOT NULL,
                            phone_number VARCHAR(10),
                            passport_number VARCHAR(255),
                            email VARCHAR(100),
                            bank_name VARCHAR(255),
                            birthdate DATE,
                            seat_row INT NOT NULL,
                            seat_position VARCHAR(255) NOT NULL,
                            identification VARCHAR(255),
                            booking_ticket_id BIGINT NOT NULL,
                            flight_id BIGINT NOT NULL,
                            user_id BIGINT,
                            ticket_class_id BIGINT
                            CONSTRAINT fk_booking_ticket FOREIGN KEY (booking_ticket_id) REFERENCES booking_tickets (id) ON DELETE CASCADE,
                            CONSTRAINT fk_flight FOREIGN KEY (flight_id) REFERENCES flights (id),
                            CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users (id),
                            CONSTRAINT fk_ticket_class FOREIGN KEY (ticket_class_id) REFERENCES ticket_classes (id)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `passengers`
--


/*!40000 ALTER TABLE `passengers` DISABLE KEYS */;
/*!40000 ALTER TABLE `passengers` DISABLE KEYS */;
INSERT INTO `passengers` VALUES (1,'John','Smith','0123456789','X123456789','john.doe@example.com','Bank of America','1990-05-15',1,'A','ABC123XYZ',1,1,1,3),(2,'Nguyễn','Văn Anh','0913702415','P910959192','nguyen.van.anh@example.com',NULL,'1974-09-27',28,'A','ID911647',24,10,NULL,1),(3,'Trần','Thị Bích','0982127112','P106704935','tran.thi.bich@example.com',NULL,'1994-01-12',13,'B','ID311455',5,10,NULL,3),(4,'Phạm','Quốc Cường','0931056291','P749724931','pham.quoc.cuong@example.com',NULL,'1982-11-01',6,'A','ID886987',19,6,NULL,2),(5,'Lê','Thanh Hà','0927228436','P830335356','le.thanh.ha@example.com',NULL,'1974-07-10',5,'A','ID366522',36,1,NULL,1),(6,'Võ','Hoài Linh','0917527490','P412145643','vo.hoai.linh@example.com',NULL,'1987-11-06',18,'F','ID145597',30,6,NULL,3),(7,'Hoàng','Phương Nam','0961026168','P774979537','hoang.phuong.nam@example.com',NULL,'1983-08-06',19,'B','ID603250',18,2,NULL,2),(8,'Đặng','Mai Hương','0946835956','P794086560','dang.mai.huong@example.com',NULL,'1979-08-28',26,'D','ID496560',5,5,NULL,3),(9,'Bùi','Thu Minh','0940648704','P572511876','bui.thu.minh@example.com',NULL,'1994-08-26',14,'E','ID656728',9,1,NULL,3),(10,'Nguyễn','Kim Tuấn','0916471149','P532794728','nguyen.kim.tuan@example.com',NULL,'1980-07-27',24,'A','ID335215',26,6,NULL,2),(11,'Trương','Hồng An','0989206865','P273049255','truong.hong.an@example.com',NULL,'1973-02-13',32,'C','ID477248',44,4,NULL,1),(12,'Nguyễn','Tuấn Kiệt','0941414959','P894612141','nguyen.tuan.kiet@example.com',NULL,'1974-07-04',1,'D','ID732210',13,3,NULL,2),(13,'Đào','Thị Hoa','0930231698','P337763415','dao.thi.hoa@example.com',NULL,'1988-11-22',18,'D','ID325460',49,7,NULL,1),(14,'Nguyễn','Vũ Huy','0950767536','P943550822','nguyen.vu.huy@example.com',NULL,'1973-01-20',30,'F','ID993567',50,10,NULL,2),(15,'Phạm','Trần Lan','0962996906','P620249814','pham.tran.lan@example.com',NULL,'1971-06-11',14,'E','ID975047',23,4,NULL,3),(16,'Võ','Hồng Anh','0925948911','P200280876','vo.hong.anh@example.com',NULL,'1971-10-04',27,'A','ID425559',11,5,NULL,1),(17,'Trần','Khánh Ly','0953881873','P907157437','tran.khanh.ly@example.com',NULL,'1987-05-02',32,'C','ID847221',48,1,NULL,1),(18,'Lê','Hồng Phúc','0933862233','P688597442','le.hong.phuc@example.com',NULL,'1970-04-11',11,'B','ID495630',8,5,NULL,1),(19,'Hoàng','Thùy Tiên','0966334523','P799393760','hoang.thuy.tien@example.com',NULL,'1985-08-09',26,'A','ID466000',34,9,NULL,1),(20,'Đào','Trung Dũng','0930433020','P877228578','dao.trung.dung@example.com',NULL,'1978-07-19',7,'D','ID361939',9,7,NULL,2),(21,'Phạm','Văn Bảo','0985733539','P120735153','pham.van.bao@example.com',NULL,'1975-09-22',14,'B','ID479761',13,9,NULL,2),(22,'Nguyễn','Văn A','0925948911','P200280876','nguyenvana45@example.com',NULL,'1971-10-04',27,'A','ID425559',11,5,NULL,3),(23,'Trần','Thị B','0953881873','P907157437','tranthib12@example.com',NULL,'1987-05-02',32,'C','ID847221',48,1,NULL,3),(24,'Phạm','Quốc D','0933862233','P688597442','phamquocd45@example.com',NULL,'1970-04-11',11,'B','ID495630',8,5,NULL,2),(25,'Lê','Duy Hoàng','0966334523','P799393760','leduyhoang76@example.com',NULL,'1985-08-09',26,'A','ID466000',34,9,NULL,1),(26,'Võ','Thị Minh','0930433020','P877228578','vothiminh23@example.com',NULL,'1978-07-19',7,'D','ID361939',9,7,NULL,1),(27,'Đặng','Kim Anh','0985733539','P120735153','dangkimanh89@example.com',NULL,'1975-09-22',14,'B','ID479761',13,9,NULL,1),(28,'Huỳnh','Tuấn Anh','0995998918','P987389018','huynhtuananh12@example.com',NULL,'1977-01-20',1,'F','ID901752',33,8,NULL,2),(29,'Trương','Hoàng An','0981525552','P282093753','truonghoangan34@example.com',NULL,'1990-09-07',7,'A','ID634431',34,2,NULL,3),(30,'Nguyễn','Lê Bảo','0920459085','P271747659','nguyenlebao57@example.com',NULL,'1991-11-02',2,'E','ID995803',34,7,NULL,3),(31,'Đặng','Minh Phú','0982070189','P895289605','dangminhphu90@example.com',NULL,'1996-07-25',16,'A','ID563733',25,10,NULL,2),(32,'Phan','Hồng Quân','0940934118','P404424101','phanhongquan67@example.com',NULL,'2005-05-25',2,'E','ID111754',29,3,NULL,2),(33,'Huỳnh','Thị Trang','0957697551','P518677043','huynhthitrang45@example.com',NULL,'1994-11-13',30,'A','ID874330',13,9,NULL,2),(34,'Nguyễn','Bảo Trân','0940534388','P205802424','nguyenbaotran87@example.com',NULL,'2002-01-08',24,'C','ID854810',18,8,NULL,2),(35,'Trần','Duy Khang','0910854451','P829908102','tranduykhang45@example.com',NULL,'1992-05-11',3,'A','ID249673',30,8,NULL,1),(36,'Nguyễn','Thị Xuân','0928329309','P630437272','nguyenthixuan23@example.com',NULL,'1986-12-19',27,'C','ID556626',11,8,NULL,1),(37,'Đặng','Giang Nam','0987853800','P228984723','danggiangnam12@example.com',NULL,'1975-05-20',30,'F','ID923875',28,9,NULL,1),(38,'Vũ','Quang Minh','0988602622','P303509212','vuquangminh78@example.com',NULL,'2000-05-13',14,'B','ID438231',37,1,NULL,1),(39,'Đặng','Hữu Thắng','0946142831','P578968508','danghuuthang34@example.com',NULL,'1991-08-09',13,'D','ID193797',45,3,NULL,1),(40,'Trần','Thị Mỹ Hoa','0930843272','P469508644','tranthimyhoa45@example.com',NULL,'1993-01-17',18,'C','ID356488',35,4,NULL,1),(41,'Phạm','Minh Khánh','0920464577','P472438423','phamminhkhanh87@example.com',NULL,'1998-10-06',4,'C','ID767941',44,4,NULL,1),(42,'Nguyễn','Văn A','0959252443','P254837224','nguyenvana78@example.com',NULL,'1980-09-24',2,'C','ID634327',49,8,NULL,1),(43,'Trần','Thị B','0923147767','P389658468','tranthib56@example.com',NULL,'1981-06-23',11,'E','ID383651',40,5,NULL,1),(44,'Phạm','Văn D','0975173113','P122418395','phamvand90@example.com',NULL,'1979-04-20',27,'D','ID287313',24,5,NULL,1),(45,'Lê','Duy Hoàng','0996059747','P620295227','leduyhoang32@example.com',NULL,'2003-10-07',26,'F','ID230072',38,6,NULL,1),(46,'Võ','Thị Anh','0993091381','P656739301','vothianh88@example.com',NULL,'1976-06-01',1,'B','ID902329',22,6,NULL,1),(47,'Đinh','Thị Minh','0959989877','P547792422','dinhthiminh23@example.com',NULL,'1978-07-18',8,'D','ID872495',2,8,NULL,1),(48,'Hoàng','Kim Phụ','0929067468','P708759417','hoangkimphu76@example.com',NULL,'1988-10-14',10,'A','ID517714',20,4,NULL,1),(49,'Vũ','Minh Khang','0918247183','P154270509','vuminhkhang65@example.com',NULL,'1999-04-24',31,'F','ID190876',34,6,NULL,1),(50,'Lê','Thị Bảo','0987966501','P361034656','lethibao23@example.com',NULL,'1997-07-28',23,'C','ID741420',31,6,NULL,1),(51,'Nguyễn','Quang Minh','0926875958','P705237836','nguyenquangminh34@example.com',NULL,'1998-04-03',15,'C','ID294605',37,7,NULL,1),(52,'Trần','Hữu Thắng','0949980194','P831210161','tranhuuthang56@example.com',NULL,'1972-11-12',27,'F','ID514909',9,2,NULL,1),(53,'Phạm','Kim Anh','0950366454','P834054716','phamkimanh78@example.com',NULL,'1995-01-05',17,'C','ID231421',16,3,NULL,1),(54,'Võ','Tuấn Anh','0942968741','P805593590','votuananh89@example.com',NULL,'1984-01-20',5,'D','ID974871',6,7,NULL,2),(55,'Đặng','Kim Hoa','0969001535','P103264758','dangkimhoa67@example.com',NULL,'1990-11-10',21,'D','ID472814',42,2,NULL,3),(56,'Huỳnh','Tuấn Bảo','0980464899','P304634223','huynhtuanbao45@example.com',NULL,'2001-12-24',10,'F','ID378063',28,6,NULL,3),(57,'Nguyễn','Thị Minh','0992420805','P528699661','nguyenthiminh76@example.com',NULL,'1975-06-03',3,'C','ID886395',45,3,NULL,3),(58,'Trần','Lê Hoàng','0913274343','P920792834','tranlehoang23@example.com',NULL,'1974-03-13',1,'B','ID565380',35,3,NULL,3),(59,'Phan','Quốc Bảo','0953120958','P874009373','phanquocbao34@example.com',NULL,'2003-07-02',16,'F','ID405783',16,5,NULL,3),(60,'Nguyễn','Thị Mỹ Hoa','0957629268','P201672002','nguyenthimyhoa65@example.com',NULL,'1970-02-07',32,'D','ID129538',28,7,NULL,2),(61,'Trần','Duy Minh','0936810422','P622297545','tranduyminh56@example.com',NULL,'1971-08-27',1,'E','ID997641',3,4,NULL,1),(62,'Lê','Duy Phúc','0982377362','P222664347','leduyphuc89@example.com',NULL,'1990-06-07',19,'C','ID530301',36,3,NULL,2),(63,'Phạm','Thùy Dương','0962898268','P884717565','phamthuyduong67@example.com',NULL,'1988-12-19',9,'D','ID153928',10,4,NULL,2),(64,'Nguyễn','Văn A','0920354331','P318990533','nguyenvana74@example.com',NULL,'1987-02-15',22,'A','ID388256',47,8,NULL,2),(65,'Trần','Thị B','0993691709','P767288200','tranthib97@example.com',NULL,'1983-09-16',22,'C','ID163497',30,2,NULL,3),(66,'Phạm','Văn H','0974262113','P772131865','phamvanh53@example.com',NULL,'2003-02-10',6,'B','ID341258',37,5,NULL,2),(67,'Lê','Duy Thành','0916913838','P796384695','leduythanh65@example.com',NULL,'1981-11-13',10,'E','ID678700',41,1,NULL,2),(68,'Hoàng','Kim Long','0981828594','P786544030','hoangkimlong78@example.com',NULL,'1998-11-08',24,'E','ID197596',28,1,NULL,3),(69,'Vũ','Minh Khoa','0979008033','P494126290','vuminhkhoa92@example.com',NULL,'1972-03-26',14,'D','ID264723',14,4,NULL,2),(70,'Nguyễn','Minh Khôi','0979839953','P922816778','nguyenminhkhoi81@example.com',NULL,'1990-07-01',31,'F','ID443394',20,1,NULL,3),(71,'Phạm','Thị Quỳnh','0932053977','P725580687','phamthiquynh62@example.com',NULL,'1988-01-01',32,'C','ID702273',8,8,NULL,2),(72,'Lê','Thị Minh Hà','0984839058','P948377166','lethiminhha74@example.com',NULL,'1984-05-14',11,'A','ID130591',24,3,NULL,3),(73,'Trần','Hoàng Duy','0980217530','P218779145','tranhoangduy53@example.com',NULL,'1980-11-27',24,'A','ID321759',2,4,NULL,2),(74,'Võ','Thị Mai Hà','0941214661','P940728883','vothimaiha47@example.com',NULL,'1980-04-09',23,'D','ID402400',34,6,NULL,3),(75,'Hoàng','Thị Bích','0939422873','P293240961','hoangthibich78@example.com',NULL,'2003-09-14',1,'D','ID183562',9,9,NULL,2),(76,'Đinh','Thị Bích Ngọc','0955352616','P114786449','dinhthibichngoc95@example.com',NULL,'2004-09-27',1,'C','ID465902',31,2,NULL,3),(77,'Đặng','Minh Phúc','0989987282','P526472308','dangminhphuc89@example.com',NULL,'2005-03-03',27,'E','ID412642',37,1,NULL,2),(78,'Nguyễn','Thị Bích Ngân','0982261795','P568625904','nguyenthibichngan46@example.com',NULL,'2004-09-09',30,'E','ID245377',23,2,NULL,3),(79,'Phạm','Thị Yến','0975159146','P376035072','phamthiyen91@example.com',NULL,'1996-09-24',10,'D','ID452694',7,3,NULL,2),(80,'Trần','Quang Hiếu','0944387726','P554111621','tranquanghieu62@example.com',NULL,'1981-05-18',25,'C','ID287546',20,1,NULL,3),(81,'Lê','Đình Ngọc Anh','0973333049','P471693389','ledinhngocanh49@example.com',NULL,'1970-08-09',20,'A','ID174429',30,8,NULL,2),(82,'Nguyễn','Thị Văn A','0942952080','P310284069','nguyenthivanad45@example.com',NULL,'1978-05-13',21,'F','ID253794',47,1,NULL,3),(83,'Trần','Minh Quang','0949746368','P741708944','tranminhquang75@example.com',NULL,'1993-02-21',29,'D','ID172301',19,6,NULL,2),(84,'Phạm','Thị Yến','0958920510','P951388752','phamthiyen62@example.com',NULL,'1977-02-27',9,'C','ID192035',7,6,NULL,2),(85,'Lê','Văn Bình','0944135519','P146737528','levanbinh12@example.com',NULL,'1971-06-13',8,'F','ID638565',19,6,NULL,2),(86,'Vũ','Hoàng Anh','0968541689','P348431583','vuhoanganh67@example.com',NULL,'1992-06-18',12,'D','ID869665',12,8,NULL,2),(87,'Nguyễn','Thị Minh Hoa','0913090785','P467656578','nguyenthiminhhoa33@example.com',NULL,'1994-06-10',16,'F','ID150840',5,5,NULL,2),(88,'Phạm','Thị Thu Hằng','0990746543','P946756342','phamthithuhang81@example.com',NULL,'1989-12-05',14,'A','ID711430',18,8,NULL,2),(89,'Lê','Duy Phong','0986595072','P344162520','leduyphong47@example.com',NULL,'1985-11-26',25,'E','ID411731',42,2,NULL,2),(90,'Trần','Đức Thành','0990631372','P218099843','tranducthanh54@example.com',NULL,'2005-10-19',5,'A','ID694832',36,7,NULL,2),(91,'Đặng','Minh Đức','0932610800','P980021479','dangminhduc92@example.com',NULL,'1973-08-22',15,'B','ID492082',22,1,NULL,2),(92,'Hoàng','Kim Hùng','0979073189','P626803261','hoangkimhung82@example.com',NULL,'1971-02-22',21,'C','ID929131',32,7,NULL,2),(93,'Vũ','Minh Thuận','0947666131','P912082207','vuminhthuan66@example.com',NULL,'1993-08-20',7,'D','ID804028',31,3,NULL,2),(94,'Nguyễn','Thị Minh Anh','0979666026','P345651420','nguyenthiminhanh52@example.com',NULL,'1996-10-17',19,'D','ID119783',26,8,NULL,2),(95,'Phạm','Văn Hiệp','0914892949','P802132388','phamvanhiep95@example.com',NULL,'1975-04-11',4,'F','ID957029',15,7,NULL,2),(96,'Lê','Đình Hiếu','0998700593','P466148759','ledinhhieu85@example.com',NULL,'2002-10-17',21,'D','ID719781',37,3,NULL,2),(97,'Trần','Đức Hải','0912247425','P243407721','tranduchai78@example.com',NULL,'1983-06-02',28,'E','ID173321',45,1,NULL,2),(98,'Võ','Hoàng Nam','0933272957','P857268030','vohoangnam91@example.com',NULL,'2003-08-13',10,'B','ID244326',9,9,NULL,1),(99,'Trần','Quang Hiếu','0966569132','P239619196','tranquanghieu68@example.com',NULL,'1972-05-18',4,'D','ID394989',50,8,NULL,2),(100,'Phạm','Quang Vinh','0954650529','P265802464','phamquangvinh92@example.com',NULL,'1979-04-27',24,'F','ID112051',14,5,NULL,2),(101,'Nguyễn','Thị Hương','0947313274','P396993561','nguyenthihuong86@example.com',NULL,'1983-10-23',13,'E','ID991698',27,7,NULL,3),(102,'Lê','Đình Như','0963467852','P411989138','ledinhnhu72@example.com',NULL,'2000-10-18',15,'F','ID476725',15,7,NULL,3),(103,'Phạm','Thị Hương Mai','0954228313','P221180072','phamthihuongmai82@example.com',NULL,'1979-03-23',16,'B','ID246332',28,1,NULL,3),(104,'Nguyễn','Hoàng Duy','0942735291','P272243749','nguyenhoangduy63@example.com',NULL,'2000-08-24',9,'A','ID888160',7,5,NULL,3),(105,'Trần','Minh Ngọc','0929108725','P878420855','tranminhngoc82@example.com',NULL,'1986-01-27',4,'A','ID174775',41,7,NULL,3),(106,'Phạm','Quang Huy','0939952119','P276212736','phamquanghuy58@example.com',NULL,'1980-04-18',23,'F','ID883250',12,9,NULL,1);
-- Table structure for table `meals`
--


DROP TABLE IF EXISTS `meals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meals` (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `description` varchar(255) DEFAULT NULL,
                         `dietary_info` varchar(255) DEFAULT NULL,
                         `image` varchar(255) DEFAULT NULL,
                         `name` varchar(255) DEFAULT NULL,
                         `price` double NOT NULL,
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meals`
--

LOCK TABLES `meals` WRITE;
/*!40000 ALTER TABLE `meals` DISABLE KEYS */;
INSERT INTO `meals` VALUES (1,'Cơm rang cực ngon','Món mặn',NULL,'Cơm rang bò Wagu',150000),(2,'Kem Merino với các vị chanh, cam, socola, dâu tây','Đồ ngọt',NULL,'Kem Merino',25000),(3,'Đậu hũ được chế biến với phong cách cay nồng của Tứ Xuyên, với hành tỏi ớt tiêu,...','Món chay, cay',NULL,'Đậu phụ Tứ Xuyên',120000);
/*!40000 ALTER TABLE `meals` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                 `title` varchar(255) DEFAULT NULL,
                                 `content` varchar(255) DEFAULT NULL,
                                 `created_date` datetime(6) DEFAULT NULL,
                                 `type` varchar(255) DEFAULT NULL,
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotion` (
                             `id` bigint NOT NULL AUTO_INCREMENT,
                             `code` varchar(255) DEFAULT NULL,
                             `discount` int NOT NULL,
                             `end_date` datetime(6) DEFAULT NULL,
                             `start_date` datetime(6) DEFAULT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
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