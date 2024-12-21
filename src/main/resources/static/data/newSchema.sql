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

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
                           `id` bigint NOT NULL AUTO_INCREMENT,
                           `expected_departure_time` datetime(6) DEFAULT NULL,
                           `expected_arrival_time` datetime(6) DEFAULT NULL,
                           `actual_departure_time` datetime(6) DEFAULT NULL,
                           `actual_arrival_time` datetime(6) DEFAULT NULL,
                           `flight_number` varchar(255) DEFAULT NULL,
                           `aircraft_id` bigint DEFAULT NULL,
                           `departure_airport_id` int DEFAULT NULL,
                           `destination_airport_id` int DEFAULT NULL,
                           `cancel_due_time` datetime(6) DEFAULT NULL,
                           `economy_available_seats` int NOT NULL,
                           `business_available_seats` int NOT NULL,
                           `first_available_seats` int NOT NULL,
                           `status` VARCHAR(50) DEFAULT 'Scheduled',
                           `meal_discount` DECIMAL(19,2) DEFAULT 0.00,
                           `ticket_discount` DECIMAL(19,2) DEFAULT 0.00,
                           `base_price` DECIMAL(19,2) DEFAULT 1000000.00,
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
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status, base_price)
VALUES (1, '2024-12-25 00:45:27', '2024-12-25 03:45:27', '2024-12-25 00:35:27', '2024-12-25 03:35:27', 'VN714', 14, 1, 13, NULL, 102, 35, 28, 'Scheduled', 1200000.00);
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (2, '2024-12-28 16:04:36', '2024-12-28 20:04:36', '2024-12-28 16:00:36', '2024-12-28 20:00:36', 'VN133', 15, 10, 20, NULL, 128, 37, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (3, '2024-12-24 14:10:51', '2024-12-24 21:10:51', '2024-12-24 14:10:51', '2024-12-24 21:10:51', 'VN247', 4, 4, 7, NULL, 133, 46, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (4, '2024-12-22 16:50:29', '2024-12-22 17:50:29', '2024-12-22 16:54:29', '2024-12-22 17:54:29', 'VN738', 2, 4, 3, NULL, 168, 43, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (5, '2024-12-26 04:10:48', '2024-12-26 10:10:48', '2024-12-26 04:07:48', '2024-12-26 10:07:48', 'VN369', 2, 10, 15, NULL, 149, 47, 19, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (6, '2024-12-26 11:04:11', '2024-12-26 16:04:11', '2024-12-26 11:10:11', '2024-12-26 16:10:11', 'VN705', 10, 19, 13, NULL, 193, 35, 22, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (7, '2024-12-24 05:45:38', '2024-12-24 12:45:38', '2024-12-24 05:41:38', '2024-12-24 12:41:38', 'VN334', 5, 4, 20, NULL, 198, 58, 26, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (8, '2024-12-23 17:55:24', '2024-12-24 03:55:24', '2024-12-23 17:55:24', '2024-12-24 03:55:24', 'VN403', 14, 15, 11, NULL, 142, 55, 18, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (9, '2024-12-27 09:50:10', '2024-12-27 18:50:10', '2024-12-27 09:48:10', '2024-12-27 18:48:10', 'VN806', 16, 15, 3, NULL, 122, 56, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (10, '2024-12-28 21:09:25', '2024-12-29 04:09:25', '2024-12-28 21:14:25', '2024-12-29 04:14:25', 'VN240', 16, 20, 3, NULL, 111, 33, 22, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (11, '2024-12-29 21:16:57', '2024-12-30 04:16:57', '2024-12-29 21:08:57', '2024-12-30 04:08:57', 'VN507', 17, 20, 3, NULL, 134, 31, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (12, '2024-12-28 06:09:13', '2024-12-28 14:09:13', '2024-12-28 06:19:13', '2024-12-28 14:19:13', 'VN658', 9, 2, 6, NULL, 109, 60, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (13, '2024-12-25 03:01:42', '2024-12-25 10:01:42', '2024-12-25 03:09:42', '2024-12-25 10:09:42', 'VN560', 20, 11, 14, NULL, 149, 45, 26, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (14, '2024-12-27 12:13:59', '2024-12-27 20:13:59', '2024-12-27 12:07:59', '2024-12-27 20:07:59', 'VN110', 4, 15, 20, NULL, 179, 60, 12, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (15, '2024-12-25 17:08:50', '2024-12-25 18:08:50', '2024-12-25 17:11:50', '2024-12-25 18:11:50', 'VN684', 17, 6, 18, NULL, 149, 59, 10, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (16, '2024-12-26 05:13:38', '2024-12-26 08:13:38', '2024-12-26 05:17:38', '2024-12-26 08:17:38', 'VN360', 15, 13, 1, NULL, 109, 35, 12, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (17, '2024-12-26 02:46:36', '2024-12-26 11:46:36', '2024-12-26 02:36:36', '2024-12-26 11:36:36', 'VN420', 10, 11, 9, NULL, 150, 30, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (18, '2024-12-29 13:51:27', '2024-12-29 16:51:27', '2024-12-29 13:46:27', '2024-12-29 16:46:27', 'VN956', 16, 17, 4, NULL, 152, 36, 12, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (19, '2024-12-24 22:54:06', '2024-12-24 23:54:06', '2024-12-24 22:44:06', '2024-12-24 23:44:06', 'VN217', 4, 13, 7, NULL, 128, 60, 11, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (20, '2024-12-22 19:27:05', '2024-12-23 05:27:05', '2024-12-22 19:33:05', '2024-12-23 05:33:05', 'VN243', 7, 20, 10, NULL, 159, 57, 16, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (21, '2024-12-28 23:26:24', '2024-12-29 08:26:24', '2024-12-28 23:32:24', '2024-12-29 08:32:24', 'VN237', 7, 2, 9, NULL, 192, 39, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (22, '2024-12-29 11:02:47', '2024-12-29 16:02:47', '2024-12-29 11:11:47', '2024-12-29 16:11:47', 'VN318', 2, 12, 16, NULL, 193, 49, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (23, '2024-12-24 03:14:23', '2024-12-24 11:14:23', '2024-12-24 03:23:23', '2024-12-24 11:23:23', 'VN148', 16, 20, 3, NULL, 125, 42, 12, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (24, '2024-12-28 10:50:55', '2024-12-28 12:50:55', '2024-12-28 10:56:55', '2024-12-28 12:56:55', 'VN533', 4, 2, 20, NULL, 177, 34, 29, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (25, '2024-12-22 15:16:22', '2024-12-22 21:16:22', '2024-12-22 15:06:22', '2024-12-22 21:06:22', 'VN613', 7, 21, 4, NULL, 105, 60, 30, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (26, '2024-12-24 07:52:15', '2024-12-24 14:52:15', '2024-12-24 07:45:15', '2024-12-24 14:45:15', 'VN598', 18, 20, 1, NULL, 156, 41, 30, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (27, '2024-12-28 08:55:36', '2024-12-28 09:55:36', '2024-12-28 09:04:36', '2024-12-28 10:04:36', 'VN667', 4, 10, 8, NULL, 143, 39, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (28, '2024-12-24 13:49:48', '2024-12-24 14:49:48', '2024-12-24 13:49:48', '2024-12-24 14:49:48', 'VN598', 19, 14, 18, NULL, 196, 40, 26, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (29, '2024-12-25 17:39:32', '2024-12-25 18:39:32', '2024-12-25 17:48:32', '2024-12-25 18:48:32', 'VN633', 12, 2, 9, NULL, 168, 35, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (30, '2024-12-22 12:41:32', '2024-12-22 21:41:32', '2024-12-22 12:43:32', '2024-12-22 21:43:32', 'VN394', 3, 3, 14, NULL, 123, 33, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (31, '2024-12-24 14:44:15', '2024-12-24 19:44:15', '2024-12-24 14:39:15', '2024-12-24 19:39:15', 'VN327', 6, 15, 21, NULL, 143, 47, 23, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (32, '2024-12-23 18:27:06', '2024-12-23 22:27:06', '2024-12-23 18:37:06', '2024-12-23 22:37:06', 'VN597', 6, 2, 1, NULL, 161, 42, 15, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (33, '2024-12-25 10:31:42', '2024-12-25 11:31:42', '2024-12-25 10:31:42', '2024-12-25 11:31:42', 'VN397', 5, 6, 16, NULL, 102, 51, 23, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (34, '2024-12-27 13:48:05', '2024-12-27 16:48:05', '2024-12-27 13:45:05', '2024-12-27 16:45:05', 'VN148', 6, 10, 14, NULL, 124, 46, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (35, '2024-12-22 15:44:58', '2024-12-22 18:44:58', '2024-12-22 15:39:58', '2024-12-22 18:39:58', 'VN280', 11, 15, 6, NULL, 112, 39, 22, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (36, '2024-12-24 13:39:35', '2024-12-24 21:39:35', '2024-12-24 13:34:35', '2024-12-24 21:34:35', 'VN747', 18, 11, 15, NULL, 102, 40, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (37, '2024-12-26 01:28:58', '2024-12-26 02:28:58', '2024-12-26 01:26:58', '2024-12-26 02:26:58', 'VN347', 19, 18, 4, NULL, 136, 47, 22, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (38, '2024-12-22 22:31:18', '2024-12-23 06:31:18', '2024-12-22 22:25:18', '2024-12-23 06:25:18', 'VN368', 5, 6, 20, NULL, 119, 50, 11, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (39, '2024-12-27 03:46:35', '2024-12-27 06:46:35', '2024-12-27 03:45:35', '2024-12-27 06:45:35', 'VN433', 13, 16, 7, NULL, 192, 58, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (40, '2024-12-22 12:45:23', '2024-12-22 21:45:23', '2024-12-22 12:50:23', '2024-12-22 21:50:23', 'VN250', 11, 7, 4, NULL, 196, 38, 18, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (41, '2024-12-22 09:11:16', '2024-12-22 11:11:16', '2024-12-22 09:03:16', '2024-12-22 11:03:16', 'VN333', 17, 3, 2, NULL, 174, 41, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (42, '2024-12-27 23:54:05', '2024-12-28 02:54:05', '2024-12-27 23:54:05', '2024-12-28 02:54:05', 'VN772', 11, 21, 3, NULL, 127, 60, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (43, '2024-12-27 13:10:29', '2024-12-27 20:10:29', '2024-12-27 13:20:29', '2024-12-27 20:20:29', 'VN528', 8, 17, 19, NULL, 185, 57, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (44, '2024-12-28 20:51:35', '2024-12-28 23:51:35', '2024-12-28 21:01:35', '2024-12-29 00:01:35', 'VN748', 5, 21, 15, NULL, 110, 31, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (45, '2024-12-29 11:19:11', '2024-12-29 16:19:11', '2024-12-29 11:22:11', '2024-12-29 16:22:11', 'VN252', 6, 1, 19, NULL, 151, 55, 19, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (46, '2024-12-22 07:53:58', '2024-12-22 11:53:58', '2024-12-22 07:53:58', '2024-12-22 11:53:58', 'VN779', 13, 14, 18, NULL, 123, 35, 19, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (47, '2024-12-26 21:31:50', '2024-12-27 07:31:50', '2024-12-26 21:35:50', '2024-12-27 07:35:50', 'VN354', 4, 21, 8, NULL, 149, 50, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (48, '2024-12-28 23:40:47', '2024-12-29 07:40:47', '2024-12-28 23:48:47', '2024-12-29 07:48:47', 'VN437', 1, 21, 11, NULL, 170, 47, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (49, '2024-12-24 18:21:32', '2024-12-25 00:21:32', '2024-12-24 18:22:32', '2024-12-25 00:22:32', 'VN124', 18, 8, 13, NULL, 194, 38, 19, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (50, '2024-12-23 16:44:15', '2024-12-23 20:44:15', '2024-12-23 16:51:15', '2024-12-23 20:51:15', 'VN862', 9, 3, 10, NULL, 161, 58, 11, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (51, '2024-12-22 19:03:27', '2024-12-22 23:03:27', '2024-12-22 19:10:27', '2024-12-22 23:10:27', 'VN301', 10, 16, 1, NULL, 133, 45, 29, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (52, '2024-12-23 19:46:46', '2024-12-24 00:46:46', '2024-12-23 19:37:46', '2024-12-24 00:37:46', 'VN156', 2, 15, 8, NULL, 111, 56, 16, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (53, '2024-12-22 09:14:44', '2024-12-22 17:14:44', '2024-12-22 09:15:44', '2024-12-22 17:15:44', 'VN671', 3, 4, 15, NULL, 152, 59, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (54, '2024-12-22 08:51:45', '2024-12-22 15:51:45', '2024-12-22 08:47:45', '2024-12-22 15:47:45', 'VN267', 15, 15, 18, NULL, 116, 44, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (55, '2024-12-26 20:44:27', '2024-12-27 00:44:27', '2024-12-26 20:48:27', '2024-12-27 00:48:27', 'VN378', 19, 8, 17, NULL, 156, 50, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (56, '2024-12-25 20:42:15', '2024-12-26 00:42:15', '2024-12-25 20:39:15', '2024-12-26 00:39:15', 'VN774', 9, 1, 3, NULL, 167, 30, 16, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (57, '2024-12-28 06:15:23', '2024-12-28 15:15:23', '2024-12-28 06:07:23', '2024-12-28 15:07:23', 'VN766', 12, 9, 6, NULL, 154, 47, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (58, '2024-12-26 06:22:11', '2024-12-26 08:22:11', '2024-12-26 06:19:11', '2024-12-26 08:19:11', 'VN166', 18, 3, 19, NULL, 125, 58, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (59, '2024-12-29 06:11:55', '2024-12-29 14:11:55', '2024-12-29 06:16:55', '2024-12-29 14:16:55', 'VN622', 12, 13, 4, NULL, 178, 47, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (60, '2024-12-26 07:32:12', '2024-12-26 12:32:12', '2024-12-26 07:32:12', '2024-12-26 12:32:12', 'VN123', 5, 6, 11, NULL, 168, 37, 15, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (61, '2024-12-28 12:10:01', '2024-12-28 21:10:01', '2024-12-28 12:11:01', '2024-12-28 21:11:01', 'VN738', 16, 6, 9, NULL, 111, 45, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (62, '2024-12-24 17:43:22', '2024-12-24 22:43:22', '2024-12-24 17:37:22', '2024-12-24 22:37:22', 'VN558', 14, 17, 12, NULL, 163, 32, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (63, '2024-12-23 10:46:45', '2024-12-23 19:46:45', '2024-12-23 10:38:45', '2024-12-23 19:38:45', 'VN668', 17, 6, 13, NULL, 112, 53, 15, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (64, '2024-12-23 09:58:28', '2024-12-23 17:58:28', '2024-12-23 09:51:28', '2024-12-23 17:51:28', 'VN205', 6, 19, 6, NULL, 190, 36, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (65, '2024-12-28 00:11:21', '2024-12-28 10:11:21', '2024-12-28 00:13:21', '2024-12-28 10:13:21', 'VN426', 4, 21, 18, NULL, 159, 52, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (66, '2024-12-29 22:18:53', '2024-12-30 02:18:53', '2024-12-29 22:16:53', '2024-12-30 02:16:53', 'VN609', 4, 4, 21, NULL, 175, 50, 12, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (67, '2024-12-28 18:58:18', '2024-12-28 22:58:18', '2024-12-28 18:57:18', '2024-12-28 22:57:18', 'VN697', 16, 17, 8, NULL, 186, 31, 16, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (68, '2024-12-25 17:17:35', '2024-12-26 03:17:35', '2024-12-25 17:07:35', '2024-12-26 03:07:35', 'VN269', 19, 21, 13, NULL, 130, 33, 15, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (69, '2024-12-27 22:27:34', '2024-12-28 03:27:34', '2024-12-27 22:29:34', '2024-12-28 03:29:34', 'VN828', 18, 8, 15, NULL, 190, 43, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (70, '2024-12-24 00:18:36', '2024-12-24 03:18:36', '2024-12-24 00:23:36', '2024-12-24 03:23:36', 'VN507', 10, 12, 17, NULL, 162, 35, 28, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (71, '2024-12-27 13:28:28', '2024-12-27 22:28:28', '2024-12-27 13:30:28', '2024-12-27 22:30:28', 'VN659', 2, 3, 2, NULL, 167, 44, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (72, '2024-12-27 03:27:35', '2024-12-27 13:27:35', '2024-12-27 03:20:35', '2024-12-27 13:20:35', 'VN133', 16, 8, 1, NULL, 169, 30, 20, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (73, '2024-12-27 07:57:36', '2024-12-27 10:57:36', '2024-12-27 08:02:36', '2024-12-27 11:02:36', 'VN244', 3, 17, 1, NULL, 166, 51, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (74, '2024-12-26 10:19:13', '2024-12-26 12:19:13', '2024-12-26 10:11:13', '2024-12-26 12:11:13', 'VN474', 3, 19, 6, NULL, 123, 33, 12, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (75, '2024-12-29 13:09:55', '2024-12-29 14:09:55', '2024-12-29 13:06:55', '2024-12-29 14:06:55', 'VN545', 16, 21, 8, NULL, 107, 42, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (76, '2024-12-29 11:22:11', '2024-12-29 13:22:11', '2024-12-29 11:17:11', '2024-12-29 13:17:11', 'VN883', 12, 17, 12, NULL, 109, 37, 28, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (77, '2024-12-25 15:15:06', '2024-12-25 17:15:06', '2024-12-25 15:11:06', '2024-12-25 17:11:06', 'VN124', 10, 21, 6, NULL, 144, 54, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (78, '2024-12-24 22:37:04', '2024-12-25 01:37:04', '2024-12-24 22:32:04', '2024-12-25 01:32:04', 'VN756', 10, 1, 11, NULL, 105, 56, 10, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (79, '2024-12-24 11:34:15', '2024-12-24 21:34:15', '2024-12-24 11:40:15', '2024-12-24 21:40:15', 'VN724', 10, 20, 12, NULL, 112, 60, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (80, '2024-12-29 15:36:47', '2024-12-30 00:36:47', '2024-12-29 15:28:47', '2024-12-30 00:28:47', 'VN349', 6, 3, 20, NULL, 149, 37, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (81, '2024-12-23 20:09:07', '2024-12-24 06:09:07', '2024-12-23 20:03:07', '2024-12-24 06:03:07', 'VN988', 18, 8, 3, NULL, 171, 36, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (82, '2024-12-23 15:32:00', '2024-12-24 01:32:00', '2024-12-23 15:30:00', '2024-12-24 01:30:00', 'VN812', 19, 13, 11, NULL, 157, 41, 23, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (83, '2024-12-23 19:58:25', '2024-12-23 22:58:25', '2024-12-23 19:59:25', '2024-12-23 22:59:25', 'VN432', 5, 1, 4, NULL, 107, 39, 22, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (84, '2024-12-27 18:14:06', '2024-12-28 00:14:06', '2024-12-27 18:23:06', '2024-12-28 00:23:06', 'VN173', 14, 16, 3, NULL, 181, 46, 10, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (85, '2024-12-23 17:09:56', '2024-12-23 23:09:56', '2024-12-23 17:13:56', '2024-12-23 23:13:56', 'VN678', 7, 7, 15, NULL, 156, 38, 10, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (86, '2024-12-22 13:41:54', '2024-12-22 19:41:54', '2024-12-22 13:45:54', '2024-12-22 19:45:54', 'VN932', 19, 4, 7, NULL, 117, 54, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (87, '2024-12-24 04:48:54', '2024-12-24 10:48:54', '2024-12-24 04:38:54', '2024-12-24 10:38:54', 'VN222', 14, 2, 13, NULL, 177, 40, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (88, '2024-12-22 20:55:31', '2024-12-23 05:55:31', '2024-12-22 20:48:31', '2024-12-23 05:48:31', 'VN834', 2, 21, 11, NULL, 120, 41, 23, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (89, '2024-12-25 14:40:27', '2024-12-25 18:40:27', '2024-12-25 14:33:27', '2024-12-25 18:33:27', 'VN728', 9, 8, 18, NULL, 104, 35, 12, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (90, '2024-12-24 22:34:18', '2024-12-25 08:34:18', '2024-12-24 22:33:18', '2024-12-25 08:33:18', 'VN401', 2, 11, 17, NULL, 197, 57, 20, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (91, '2024-12-25 23:54:01', '2024-12-26 04:54:01', '2024-12-25 23:57:01', '2024-12-26 04:57:01', 'VN810', 11, 10, 16, NULL, 136, 55, 30, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (92, '2024-12-25 18:41:49', '2024-12-25 22:41:49', '2024-12-25 18:36:49', '2024-12-25 22:36:49', 'VN210', 16, 18, 3, NULL, 178, 45, 20, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (93, '2024-12-26 05:35:18', '2024-12-26 06:35:18', '2024-12-26 05:32:18', '2024-12-26 06:32:18', 'VN262', 5, 4, 15, NULL, 170, 44, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (94, '2024-12-22 04:31:27', '2024-12-22 05:31:27', '2024-12-22 04:37:27', '2024-12-22 05:37:27', 'VN803', 13, 1, 16, NULL, 116, 46, 19, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (95, '2024-12-26 16:07:30', '2024-12-27 02:07:30', '2024-12-26 16:16:30', '2024-12-27 02:16:30', 'VN585', 9, 10, 3, NULL, 184, 49, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (96, '2024-12-29 13:12:42', '2024-12-29 18:12:42', '2024-12-29 13:08:42', '2024-12-29 18:08:42', 'VN176', 11, 8, 10, NULL, 168, 36, 23, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (97, '2024-12-24 01:53:55', '2024-12-24 05:53:55', '2024-12-24 01:55:55', '2024-12-24 05:55:55', 'VN454', 16, 16, 17, NULL, 131, 59, 11, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (98, '2024-12-26 12:37:46', '2024-12-26 19:37:46', '2024-12-26 12:46:46', '2024-12-26 19:46:46', 'VN838', 11, 16, 9, NULL, 110, 48, 18, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (99, '2024-12-27 22:59:29', '2024-12-28 07:59:29', '2024-12-27 22:49:29', '2024-12-28 07:49:29', 'VN778', 13, 6, 9, NULL, 161, 52, 18, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (100, '2024-12-26 03:16:21', '2024-12-26 10:16:21', '2024-12-26 03:26:21', '2024-12-26 10:26:21', 'VN927', 13, 17, 4, NULL, 198, 58, 17, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (101, '2024-12-26 15:39:12', '2024-12-27 00:39:12', '2024-12-26 15:44:12', '2024-12-27 00:44:12', 'VN152', 4, 16, 18, NULL, 168, 48, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (102, '2024-12-27 16:56:50', '2024-12-27 17:56:50', '2024-12-27 17:01:50', '2024-12-27 18:01:50', 'VN339', 15, 12, 4, NULL, 134, 33, 15, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (103, '2024-12-22 05:21:17', '2024-12-22 13:21:17', '2024-12-22 05:12:17', '2024-12-22 13:12:17', 'VN955', 6, 15, 21, NULL, 140, 55, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (104, '2024-12-22 21:48:00', '2024-12-23 02:48:00', '2024-12-22 21:55:00', '2024-12-23 02:55:00', 'VN721', 14, 14, 18, NULL, 105, 53, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (105, '2024-12-25 11:30:39', '2024-12-25 12:30:39', '2024-12-25 11:24:39', '2024-12-25 12:24:39', 'VN746', 3, 8, 15, NULL, 102, 50, 28, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (106, '2024-12-24 08:43:21', '2024-12-24 11:43:21', '2024-12-24 08:38:21', '2024-12-24 11:38:21', 'VN426', 20, 12, 2, NULL, 135, 56, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (107, '2024-12-24 09:06:14', '2024-12-24 17:06:14', '2024-12-24 09:05:14', '2024-12-24 17:05:14', 'VN909', 3, 2, 7, NULL, 176, 52, 28, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (108, '2024-12-27 17:00:49', '2024-12-27 22:00:49', '2024-12-27 17:07:49', '2024-12-27 22:07:49', 'VN984', 16, 2, 21, NULL, 166, 51, 26, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (109, '2024-12-22 05:33:01', '2024-12-22 12:33:01', '2024-12-22 05:32:01', '2024-12-22 12:32:01', 'VN362', 17, 21, 8, NULL, 113, 37, 30, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (110, '2024-12-28 03:56:16', '2024-12-28 11:56:16', '2024-12-28 03:55:16', '2024-12-28 11:55:16', 'VN274', 3, 1, 20, NULL, 132, 33, 29, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (111, '2024-12-25 12:03:45', '2024-12-25 20:03:45', '2024-12-25 12:12:45', '2024-12-25 20:12:45', 'VN876', 17, 7, 4, NULL, 109, 39, 15, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (112, '2024-12-29 04:19:57', '2024-12-29 09:19:57', '2024-12-29 04:29:57', '2024-12-29 09:29:57', 'VN643', 17, 15, 6, NULL, 108, 48, 28, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (113, '2024-12-28 15:31:12', '2024-12-29 01:31:12', '2024-12-28 15:32:12', '2024-12-29 01:32:12', 'VN553', 6, 11, 10, NULL, 133, 30, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (114, '2024-12-26 10:26:24', '2024-12-26 19:26:24', '2024-12-26 10:19:24', '2024-12-26 19:19:24', 'VN179', 19, 15, 11, NULL, 177, 37, 11, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (115, '2024-12-28 10:03:33', '2024-12-28 19:03:33', '2024-12-28 10:02:33', '2024-12-28 19:02:33', 'VN225', 3, 19, 8, NULL, 141, 52, 15, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (116, '2024-12-25 22:25:02', '2024-12-26 01:25:02', '2024-12-25 22:35:02', '2024-12-26 01:35:02', 'VN300', 7, 7, 13, NULL, 176, 56, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (117, '2024-12-28 20:04:43', '2024-12-29 00:04:43', '2024-12-28 20:14:43', '2024-12-29 00:14:43', 'VN804', 6, 11, 2, NULL, 191, 60, 30, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (118, '2024-12-29 01:30:00', '2024-12-29 02:30:00', '2024-12-29 01:23:00', '2024-12-29 02:23:00', 'VN488', 3, 2, 3, NULL, 121, 59, 30, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (119, '2024-12-28 18:17:19', '2024-12-28 22:17:19', '2024-12-28 18:15:19', '2024-12-28 22:15:19', 'VN866', 7, 4, 13, NULL, 130, 40, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (120, '2024-12-22 17:49:10', '2024-12-23 01:49:10', '2024-12-22 17:39:10', '2024-12-23 01:39:10', 'VN833', 2, 2, 6, NULL, 157, 56, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (121, '2024-12-22 08:46:32', '2024-12-22 15:46:32', '2024-12-22 08:43:32', '2024-12-22 15:43:32', 'VN329', 10, 18, 13, NULL, 192, 32, 19, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (122, '2024-12-28 11:19:30', '2024-12-28 13:19:30', '2024-12-28 11:10:30', '2024-12-28 13:10:30', 'VN813', 12, 11, 18, NULL, 141, 52, 16, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (123, '2024-12-28 06:26:24', '2024-12-28 14:26:24', '2024-12-28 06:17:24', '2024-12-28 14:17:24', 'VN955', 1, 1, 13, NULL, 112, 31, 19, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (124, '2024-12-29 20:29:04', '2024-12-30 06:29:04', '2024-12-29 20:26:04', '2024-12-30 06:26:04', 'VN906', 17, 15, 1, NULL, 178, 31, 28, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (125, '2024-12-27 06:14:00', '2024-12-27 13:14:00', '2024-12-27 06:09:00', '2024-12-27 13:09:00', 'VN682', 9, 4, 17, NULL, 127, 44, 19, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (126, '2024-12-23 08:44:15', '2024-12-23 12:44:15', '2024-12-23 08:37:15', '2024-12-23 12:37:15', 'VN851', 1, 13, 6, NULL, 141, 33, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (127, '2024-12-26 09:52:28', '2024-12-26 14:52:28', '2024-12-26 09:49:28', '2024-12-26 14:49:28', 'VN848', 4, 14, 18, NULL, 197, 55, 12, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (128, '2024-12-24 01:15:27', '2024-12-24 09:15:27', '2024-12-24 01:14:27', '2024-12-24 09:14:27', 'VN881', 17, 19, 13, NULL, 104, 32, 17, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (129, '2024-12-25 18:18:11', '2024-12-26 04:18:11', '2024-12-25 18:22:11', '2024-12-26 04:22:11', 'VN265', 19, 10, 16, NULL, 149, 42, 19, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (130, '2024-12-22 17:23:53', '2024-12-23 02:23:53', '2024-12-22 17:27:53', '2024-12-23 02:27:53', 'VN954', 17, 6, 12, NULL, 110, 40, 18, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (131, '2024-12-28 02:59:32', '2024-12-28 10:59:32', '2024-12-28 02:59:32', '2024-12-28 10:59:32', 'VN240', 13, 17, 19, NULL, 105, 57, 22, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (132, '2024-12-24 14:08:14', '2024-12-24 22:08:14', '2024-12-24 14:10:14', '2024-12-24 22:10:14', 'VN416', 7, 17, 14, NULL, 173, 51, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (133, '2024-12-22 04:36:11', '2024-12-22 08:36:11', '2024-12-22 04:35:11', '2024-12-22 08:35:11', 'VN153', 14, 14, 8, NULL, 168, 32, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (134, '2024-12-27 19:27:33', '2024-12-28 02:27:33', '2024-12-27 19:25:33', '2024-12-28 02:25:33', 'VN677', 15, 14, 2, NULL, 112, 34, 30, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (135, '2024-12-26 09:17:56', '2024-12-26 19:17:56', '2024-12-26 09:17:56', '2024-12-26 19:17:56', 'VN265', 4, 7, 16, NULL, 194, 48, 11, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (136, '2024-12-22 10:47:12', '2024-12-22 16:47:12', '2024-12-22 10:57:12', '2024-12-22 16:57:12', 'VN473', 18, 10, 2, NULL, 148, 40, 26, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (137, '2024-12-24 02:29:08', '2024-12-24 04:29:08', '2024-12-24 02:25:08', '2024-12-24 04:25:08', 'VN982', 7, 11, 2, NULL, 126, 38, 23, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (138, '2024-12-23 20:02:39', '2024-12-24 05:02:39', '2024-12-23 19:52:39', '2024-12-24 04:52:39', 'VN745', 6, 14, 10, NULL, 192, 57, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (139, '2024-12-29 20:07:26', '2024-12-29 23:07:26', '2024-12-29 20:17:26', '2024-12-29 23:17:26', 'VN560', 15, 10, 2, NULL, 186, 56, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (140, '2024-12-27 12:05:40', '2024-12-27 14:05:40', '2024-12-27 12:13:40', '2024-12-27 14:13:40', 'VN730', 6, 20, 7, NULL, 141, 60, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (141, '2024-12-23 04:36:56', '2024-12-23 09:36:56', '2024-12-23 04:26:56', '2024-12-23 09:26:56', 'VN511', 10, 12, 8, NULL, 153, 52, 23, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (142, '2024-12-22 00:48:47', '2024-12-22 03:48:47', '2024-12-22 00:47:47', '2024-12-22 03:47:47', 'VN118', 11, 18, 19, NULL, 191, 56, 30, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (143, '2024-12-24 06:50:02', '2024-12-24 13:50:02', '2024-12-24 06:44:02', '2024-12-24 13:44:02', 'VN144', 14, 16, 14, NULL, 135, 55, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (144, '2024-12-23 03:26:48', '2024-12-23 04:26:48', '2024-12-23 03:21:48', '2024-12-23 04:21:48', 'VN425', 14, 8, 9, NULL, 132, 54, 10, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (145, '2024-12-22 11:34:35', '2024-12-22 19:34:35', '2024-12-22 11:26:35', '2024-12-22 19:26:35', 'VN507', 10, 2, 9, NULL, 124, 59, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (146, '2024-12-23 19:20:18', '2024-12-24 02:20:18', '2024-12-23 19:24:18', '2024-12-24 02:24:18', 'VN471', 18, 18, 1, NULL, 153, 53, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (147, '2024-12-26 00:38:28', '2024-12-26 03:38:28', '2024-12-26 00:42:28', '2024-12-26 03:42:28', 'VN289', 5, 13, 6, NULL, 111, 48, 30, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (148, '2024-12-26 21:40:20', '2024-12-27 07:40:20', '2024-12-26 21:33:20', '2024-12-27 07:33:20', 'VN356', 2, 17, 11, NULL, 108, 31, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (149, '2024-12-23 05:11:02', '2024-12-23 07:11:02', '2024-12-23 05:14:02', '2024-12-23 07:14:02', 'VN699', 5, 17, 19, NULL, 188, 59, 16, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (150, '2024-12-28 20:28:15', '2024-12-28 23:28:15', '2024-12-28 20:34:15', '2024-12-28 23:34:15', 'VN461', 19, 9, 11, NULL, 144, 31, 17, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (151, '2024-12-29 04:21:43', '2024-12-29 05:21:43', '2024-12-29 04:17:43', '2024-12-29 05:17:43', 'VN800', 13, 9, 13, NULL, 130, 54, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (152, '2024-12-23 02:27:36', '2024-12-23 04:27:36', '2024-12-23 02:24:36', '2024-12-23 04:24:36', 'VN930', 3, 8, 10, NULL, 176, 57, 15, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (153, '2024-12-29 05:59:15', '2024-12-29 12:59:15', '2024-12-29 06:05:15', '2024-12-29 13:05:15', 'VN936', 20, 13, 2, NULL, 167, 35, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (154, '2024-12-25 03:44:34', '2024-12-25 04:44:34', '2024-12-25 03:36:34', '2024-12-25 04:36:34', 'VN590', 14, 12, 8, NULL, 168, 56, 18, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (155, '2024-12-22 04:12:16', '2024-12-22 06:12:16', '2024-12-22 04:17:16', '2024-12-22 06:17:16', 'VN458', 13, 6, 20, NULL, 166, 46, 26, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (156, '2024-12-28 21:22:56', '2024-12-28 23:22:56', '2024-12-28 21:15:56', '2024-12-28 23:15:56', 'VN550', 18, 14, 21, NULL, 131, 48, 16, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (157, '2024-12-29 05:15:16', '2024-12-29 08:15:16', '2024-12-29 05:22:16', '2024-12-29 08:22:16', 'VN300', 17, 10, 18, NULL, 113, 47, 30, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (158, '2024-12-29 19:13:59', '2024-12-29 21:13:59', '2024-12-29 19:03:59', '2024-12-29 21:03:59', 'VN410', 17, 15, 12, NULL, 136, 51, 16, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (159, '2024-12-26 04:49:11', '2024-12-26 13:49:11', '2024-12-26 04:59:11', '2024-12-26 13:59:11', 'VN602', 9, 16, 17, NULL, 107, 43, 20, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (160, '2024-12-24 16:44:43', '2024-12-24 19:44:43', '2024-12-24 16:54:43', '2024-12-24 19:54:43', 'VN681', 19, 4, 8, NULL, 167, 53, 17, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (161, '2024-12-25 06:08:39', '2024-12-25 11:08:39', '2024-12-25 06:11:39', '2024-12-25 11:11:39', 'VN815', 6, 19, 12, NULL, 140, 47, 11, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (162, '2024-12-25 02:48:44', '2024-12-25 09:48:44', '2024-12-25 02:57:44', '2024-12-25 09:57:44', 'VN565', 20, 15, 13, NULL, 186, 49, 15, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (163, '2024-12-29 08:24:01', '2024-12-29 18:24:01', '2024-12-29 08:20:01', '2024-12-29 18:20:01', 'VN615', 7, 14, 19, NULL, 192, 41, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (164, '2024-12-28 23:54:38', '2024-12-29 04:54:38', '2024-12-29 00:00:38', '2024-12-29 05:00:38', 'VN906', 18, 1, 3, NULL, 149, 56, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (165, '2024-12-29 23:17:44', '2024-12-30 09:17:44', '2024-12-29 23:25:44', '2024-12-30 09:25:44', 'VN760', 8, 18, 10, NULL, 199, 34, 22, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (166, '2024-12-25 17:15:11', '2024-12-25 20:15:11', '2024-12-25 17:10:11', '2024-12-25 20:10:11', 'VN828', 7, 16, 3, NULL, 142, 41, 28, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (167, '2024-12-24 03:38:45', '2024-12-24 06:38:45', '2024-12-24 03:34:45', '2024-12-24 06:34:45', 'VN362', 2, 7, 4, NULL, 144, 43, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (168, '2024-12-25 14:38:04', '2024-12-25 17:38:04', '2024-12-25 14:33:04', '2024-12-25 17:33:04', 'VN405', 1, 12, 8, NULL, 126, 41, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (169, '2024-12-22 03:30:37', '2024-12-22 10:30:37', '2024-12-22 03:20:37', '2024-12-22 10:20:37', 'VN228', 6, 11, 12, NULL, 129, 59, 26, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (170, '2024-12-27 10:17:18', '2024-12-27 13:17:18', '2024-12-27 10:22:18', '2024-12-27 13:22:18', 'VN616', 19, 6, 21, NULL, 182, 59, 29, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (171, '2024-12-22 10:18:17', '2024-12-22 16:18:17', '2024-12-22 10:25:17', '2024-12-22 16:25:17', 'VN544', 1, 13, 10, NULL, 200, 37, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (172, '2024-12-22 06:21:36', '2024-12-22 09:21:36', '2024-12-22 06:14:36', '2024-12-22 09:14:36', 'VN705', 11, 20, 19, NULL, 109, 45, 20, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (173, '2024-12-23 22:52:31', '2024-12-24 01:52:31', '2024-12-23 22:52:31', '2024-12-24 01:52:31', 'VN611', 17, 2, 9, NULL, 103, 50, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (174, '2024-12-22 06:29:07', '2024-12-22 11:29:07', '2024-12-22 06:38:07', '2024-12-22 11:38:07', 'VN565', 3, 13, 20, NULL, 149, 39, 16, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (175, '2024-12-22 10:46:44', '2024-12-22 20:46:44', '2024-12-22 10:54:44', '2024-12-22 20:54:44', 'VN673', 6, 15, 13, NULL, 194, 58, 16, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (176, '2024-12-25 21:19:20', '2024-12-25 22:19:20', '2024-12-25 21:10:20', '2024-12-25 22:10:20', 'VN851', 14, 19, 7, NULL, 105, 44, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (177, '2024-12-25 11:17:15', '2024-12-25 19:17:15', '2024-12-25 11:24:15', '2024-12-25 19:24:15', 'VN859', 4, 9, 6, NULL, 188, 39, 11, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (178, '2024-12-26 00:47:32', '2024-12-26 07:47:32', '2024-12-26 00:49:32', '2024-12-26 07:49:32', 'VN406', 9, 17, 15, NULL, 174, 46, 19, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (179, '2024-12-28 05:54:00', '2024-12-28 11:54:00', '2024-12-28 05:47:00', '2024-12-28 11:47:00', 'VN446', 13, 6, 11, NULL, 173, 37, 29, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (180, '2024-12-22 10:30:05', '2024-12-22 11:30:05', '2024-12-22 10:37:05', '2024-12-22 11:37:05', 'VN765', 11, 1, 6, NULL, 170, 43, 26, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (181, '2024-12-26 23:29:33', '2024-12-27 01:29:33', '2024-12-26 23:35:33', '2024-12-27 01:35:33', 'VN302', 10, 18, 1, NULL, 119, 42, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (182, '2024-12-23 08:20:21', '2024-12-23 15:20:21', '2024-12-23 08:26:21', '2024-12-23 15:26:21', 'VN787', 19, 16, 3, NULL, 169, 42, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (183, '2024-12-23 18:35:16', '2024-12-24 00:35:16', '2024-12-23 18:26:16', '2024-12-24 00:26:16', 'VN528', 17, 2, 4, NULL, 146, 57, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (184, '2024-12-29 17:34:07', '2024-12-30 02:34:07', '2024-12-29 17:38:07', '2024-12-30 02:38:07', 'VN656', 15, 4, 20, NULL, 190, 33, 29, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (185, '2024-12-27 18:28:36', '2024-12-27 23:28:36', '2024-12-27 18:37:36', '2024-12-27 23:37:36', 'VN435', 20, 9, 16, NULL, 121, 42, 28, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (186, '2024-12-26 04:56:41', '2024-12-26 05:56:41', '2024-12-26 04:50:41', '2024-12-26 05:50:41', 'VN818', 14, 12, 15, NULL, 113, 60, 22, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (187, '2024-12-29 02:17:58', '2024-12-29 08:17:58', '2024-12-29 02:14:58', '2024-12-29 08:14:58', 'VN733', 4, 17, 9, NULL, 129, 59, 12, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (188, '2024-12-28 17:41:40', '2024-12-29 01:41:40', '2024-12-28 17:40:40', '2024-12-29 01:40:40', 'VN942', 1, 1, 3, NULL, 170, 43, 21, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (189, '2024-12-27 20:43:59', '2024-12-28 05:43:59', '2024-12-27 20:53:59', '2024-12-28 05:53:59', 'VN666', 5, 1, 2, NULL, 174, 51, 24, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (190, '2024-12-24 23:20:07', '2024-12-25 09:20:07', '2024-12-24 23:23:07', '2024-12-25 09:23:07', 'VN874', 6, 13, 4, NULL, 116, 39, 25, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (191, '2024-12-25 19:58:52', '2024-12-25 22:58:52', '2024-12-25 19:53:52', '2024-12-25 22:53:52', 'VN400', 8, 15, 14, NULL, 150, 37, 27, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (192, '2024-12-23 03:49:04', '2024-12-23 08:49:04', '2024-12-23 03:50:04', '2024-12-23 08:50:04', 'VN255', 10, 12, 1, NULL, 155, 56, 19, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (193, '2024-12-26 16:44:42', '2024-12-26 22:44:42', '2024-12-26 16:36:42', '2024-12-26 22:36:42', 'VN935', 11, 16, 14, NULL, 126, 37, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (194, '2024-12-24 23:43:00', '2024-12-25 02:43:00', '2024-12-24 23:39:00', '2024-12-25 02:39:00', 'VN917', 5, 16, 7, NULL, 179, 39, 15, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (195, '2024-12-24 11:26:26', '2024-12-24 20:26:26', '2024-12-24 11:36:26', '2024-12-24 20:36:26', 'VN373', 14, 18, 21, NULL, 198, 50, 13, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (196, '2024-12-22 11:34:02', '2024-12-22 12:34:02', '2024-12-22 11:27:02', '2024-12-22 12:27:02', 'VN559', 10, 6, 3, NULL, 191, 49, 14, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (197, '2024-12-28 06:50:12', '2024-12-28 12:50:12', '2024-12-28 06:54:12', '2024-12-28 12:54:12', 'VN668', 5, 12, 4, NULL, 120, 34, 11, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (198, '2024-12-24 15:50:20', '2024-12-24 21:50:20', '2024-12-24 15:51:20', '2024-12-24 21:51:20', 'VN406', 20, 3, 20, NULL, 117, 52, 15, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (199, '2024-12-29 11:12:48', '2024-12-29 16:12:48', '2024-12-29 11:22:48', '2024-12-29 16:22:48', 'VN117', 4, 2, 13, NULL, 148, 53, 18, 'Scheduled');
INSERT INTO `flights` (id, expected_departure_time, expected_arrival_time, actual_departure_time, actual_arrival_time, flight_number, aircraft_id, departure_airport_id, destination_airport_id, cancel_due_time, economy_available_seats, business_available_seats, first_available_seats, status)
VALUES (200, '2024-12-28 09:28:36', '2024-12-28 18:28:36', '2024-12-28 09:26:36', '2024-12-28 18:26:36', 'VN619', 8, 8, 21, NULL, 191, 51, 24, 'Scheduled');


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