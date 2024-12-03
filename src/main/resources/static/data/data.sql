drop database if exists qairlinez;
create database qairlinez;
use qairlinez;
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
-- Table structure for table roles
--

DROP TABLE IF EXISTS roles;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE roles (
                       id bigint NOT NULL AUTO_INCREMENT,
                       name varchar(255) NOT NULL,
                       PRIMARY KEY (id),
                       UNIQUE KEY UKofx66keruapi6vyqpv6f2or37 (name)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table roles
--

LOCK TABLES roles WRITE;
/*!40000 ALTER TABLE roles DISABLE KEYS */;
INSERT INTO roles VALUES (2,'ROLE_ADMIN'),(1,'ROLE_USER');
/*!40000 ALTER TABLE roles ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;



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
-- Table structure for table users
--

DROP TABLE IF EXISTS users;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE users (
                       id bigint NOT NULL AUTO_INCREMENT,
                       birthdate datetime(6) NOT NULL,
                       email varchar(255) NOT NULL,
                       firstname varchar(255) NOT NULL,
                       lastname varchar(255) NOT NULL,
                       password varchar(255) NOT NULL,
                       phone_number varchar(255) DEFAULT NULL,
                       PRIMARY KEY (id),
                       UNIQUE KEY UK6dotkott2kjsp8vw4d0m25fb7 (email)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table users
--

LOCK TABLES users WRITE;
/*!40000 ALTER TABLE users DISABLE KEYS */;
INSERT INTO users VALUES (1,'1999-12-24 07:00:00.000000','test1@gmail.com','John','Smith','$2a$10$F5xpEalHUfjZcLh0Sf5Mu.5MKT0eZWXloxGOscbs3M5kyBcErAQlO','0345675123');
INSERT INTO users VALUES (2,'2009-10-28 07:00:00.000000','trannhanhot@gmail.com','Trần Nhả','Nhớt','$2a$10$ksjN/QcVi7yWQn1UcMMj7OYNoiIleO/4esqxP4C3tqavangTQm2MK','01234546396');
/*!40000 ALTER TABLE users ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

--
-- Table structure for table user_roles
--

DROP TABLE IF EXISTS user_roles;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE user_roles (
                            user_id bigint NOT NULL,
                            role_id bigint NOT NULL,
                            PRIMARY KEY (user_id,role_id),
                            KEY FKh8ciramu9cc9q3qcqiv4ue8a6 (role_id),
                            CONSTRAINT FKh8ciramu9cc9q3qcqiv4ue8a6 FOREIGN KEY (role_id) REFERENCES roles (id),
                            CONSTRAINT FKhfh9dx7w3ubf1co1vdev94g3f FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table user_roles
--

LOCK TABLES user_roles WRITE;
/*!40000 ALTER TABLE user_roles DISABLE KEYS */;
INSERT INTO user_roles VALUES (1,1);
INSERT INTO user_roles VALUES (2,2);
/*!40000 ALTER TABLE user_roles ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table countries
--

DROP TABLE IF EXISTS countries;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE countries (
                           id bigint NOT NULL AUTO_INCREMENT,
                           country_name varchar(255) NOT NULL,
                           description varchar(255) NOT NULL,
                           PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table countries
--

LOCK TABLES countries WRITE;
/*!40000 ALTER TABLE countries DISABLE KEYS */;
/*!40000 ALTER TABLE countries ENABLE KEYS */;

/*!40000 ALTER TABLE countries DISABLE KEYS */;
INSERT INTO countries VALUES
                          (1, 'Vietnam', 'Vietnam description'),
                          (2, 'Thailand', 'Thailand description'),
                          (3, 'Japan', 'Japan description');

/*!40000 ALTER TABLE countries ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


--
-- Table structure for table airports
--

DROP TABLE IF EXISTS airports;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE airports (
                          id int NOT NULL AUTO_INCREMENT,
                          airport_code varchar(255) NOT NULL,
                          airport_name varchar(255) NOT NULL,
                          city varchar(255) NOT NULL,
                          country_id bigint NOT NULL,
                          PRIMARY KEY (id),
                          image_link varchar(255) not null,
                          description varchar(255) not null,
                          KEY FKimj7pril60webr05larg3wge7 (country_id),
                          CONSTRAINT FKimj7pril60webr05larg3wge7 FOREIGN KEY (country_id) REFERENCES countries (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table airports
--
INSERT INTO airports (id, airport_code, airport_name, city, country_id, image_link, description) VALUES
                                                                                                     (1, 'DAN', 'Đà Nẵng International Airport', 'Đà Nẵng', 1, "https://drive.google.com/file/d/1DjQHk5gkHmLdhRcoppW1cuBFzbVnPXgG/view?usp=drive_link", "Đến với Đà Nẵng để mê mẩn trước những bãi cát trắng, đắm mình giữa làn nước xanh dưới cái nắng vàng ươm."),
                                                                                                     (2, 'HAN', 'Noi Bai International Airport', 'Hà Nội', 1, "https://drive.google.com/file/d/1spNCS12dOiSu4Cdin7EXuXNE3g7E6I56/view?usp=drive_link", "Khám phá thủ đô với vẻ đẹp cổ kính và những di tích lịch sử độc đáo."),
                                                                                                     (3, 'BKK', 'Suvarnabhumi Airport', 'Bangkok', 2, "https://drive.google.com/file/d/1I78JlI3TNHkJn3s8vBtgVaPU8SYtZp8T/view?usp=drive_link", "Khám phá thành phố sôi động với các ngôi chùa và món ăn đường phố tuyệt vời.");

LOCK TABLES airports WRITE;
/*!40000 ALTER TABLE airports DISABLE KEYS */;
/*!40000 ALTER TABLE airports ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table aircrafts
--

DROP TABLE IF EXISTS aircrafts;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE aircrafts (
                           id bigint NOT NULL AUTO_INCREMENT,
                           manufacturer varchar(255) DEFAULT NULL,
                           model varchar(255) DEFAULT NULL,
                           number_of_seats int DEFAULT NULL,
                           is_active boolean default false,
                           PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table aircrafts
--

LOCK TABLES aircrafts WRITE;
/*!40000 ALTER TABLE aircrafts DISABLE KEYS */;
/*!40000 ALTER TABLE aircrafts ENABLE KEYS */;
INSERT INTO aircrafts VALUES
                          (1, 'Boeing', '737', 240, true),
                          (2, 'Airbus', 'A320', 180, true);
UNLOCK TABLES;




--
-- Table structure for table flights
--

DROP TABLE IF EXISTS flights;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE flights (
                         id bigint NOT NULL AUTO_INCREMENT,
                         actual_arrival_time datetime(6) DEFAULT NULL,
                         actual_departure_time datetime(6) DEFAULT NULL,
                         expected_arrival_time datetime(6) DEFAULT NULL,
                         expected_departure_time datetime(6) DEFAULT NULL,
                         flight_number varchar(255) DEFAULT NULL,
                         aircraft_id bigint DEFAULT NULL,
                         departure_airport_id int DEFAULT NULL,
                         destination_airport_id int DEFAULT NULL,
                         cancel_due_time  datetime(6) DEFAULT NULL,
                         economy_seats INT NOT NULL,
                         business_seats INT NOT NULL,
                         first_seats INT NOT NULL,
                         PRIMARY KEY (id),
                         KEY FKlref405f4r8lfgiu9gbwbdtgv (aircraft_id),
                         KEY FK1oo8ervoj8230wtvebwrqu2tf (departure_airport_id),
                         KEY FKny1g2v5rad7ben4t7vq8yjlyr (destination_airport_id),
                         CONSTRAINT FK1oo8ervoj8230wtvebwrqu2tf FOREIGN KEY (departure_airport_id) REFERENCES airports (id),
                         CONSTRAINT FKlref405f4r8lfgiu9gbwbdtgv FOREIGN KEY (aircraft_id) REFERENCES aircrafts (id),
                         CONSTRAINT FKny1g2v5rad7ben4t7vq8yjlyr FOREIGN KEY (destination_airport_id) REFERENCES airports (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table flights
--

LOCK TABLES flights WRITE;
/*!40000 ALTER TABLE flights DISABLE KEYS */;
/*!40000 ALTER TABLE flights ENABLE KEYS */;
INSERT INTO flights VALUES
                        (1, '2023-12-01 08:30', '2023-12-01 06:00', '2023-12-01 08:00', '2023-12-01 06:00', 'VN123', 1, 1, 2, '2023-06-01 08:30', 168, 48, 24),
                        (2, '2023-12-02 18:30', '2023-12-02 16:00', '2023-12-02 18:00', '2023-12-02 16:00', 'TG456', 2, 2, 3, '2023-06-02 18:30', 126, 36, 18);
UNLOCK TABLES;


--
-- Table structure for table ticket_classes
--
CREATE TABLE ticket_classes (
                                id bigint NOT NULL AUTO_INCREMENT,
                                class_name varchar(255) NOT NULL,
                                description varchar(255) DEFAULT NULL,
                                price_multiplier decimal(5,2) NOT NULL DEFAULT 1.00,
                                hand_baggage_weight decimal(5,2) DEFAULT NULL,
                                hand_baggage_count int DEFAULT NULL,
                                checked_baggage_weight decimal(5,2) DEFAULT NULL,
                                checked_baggage_count int DEFAULT NULL,
                                PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table ticket_classes
--

INSERT INTO ticket_classes (id, class_name, description, price_multiplier, hand_baggage_weight, hand_baggage_count, checked_baggage_weight, checked_baggage_count)
VALUES
    (1, 'Economy', 'Basic ticket class with limited amenities', 1.00, 7.00, 1, 20.00, 1),
    (2, 'Business', 'Enhanced comfort with additional services', 1.50, 6.00, 2, 40.00, 1),
    (3, 'First', 'Premium class with luxury amenities', 2.00, 15.00, 2, 40.00, 3);



--
-- Table structure for table passengers
--

DROP TABLE IF EXISTS passengers;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE passengers (
                            passenger_id bigint NOT NULL AUTO_INCREMENT,
                            bank_name varchar(255),
                            seat_row int NOT NULL,
                            seat_position varchar(1) NOT NULL,
                            email varchar(255),
                            ticket_class_id bigint NOT NULL,
                            first_name varchar(255) NOT NULL,
                            last_name varchar(255) NOT NULL,
                            passport_number varchar(255),
                            phone_number varchar(255),
                            is_adult boolean,
                            identification varchar(255),
                            flight_id bigint NOT NULL,
                            user_id bigint NOT NULL,
                            PRIMARY KEY (passenger_id),
                            KEY FK5rwljsnya2tdu14sy99r39k1b (flight_id),
                            CONSTRAINT FK_user foreign key (user_id) references users(id),
                            CONSTRAINT FK5rwljsnya2tdu14sy99r39k1b FOREIGN KEY (flight_id) REFERENCES flights (id),
                            CONSTRAINT FK_ticket_class FOREIGN KEY (ticket_class_id) REFERENCES ticket_classes (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table passengers
--

LOCK TABLES passengers WRITE;
/*!40000 ALTER TABLE passengers DISABLE KEYS */;
/*!40000 ALTER TABLE passengers ENABLE KEYS */;
INSERT INTO passengers (passenger_id, bank_name, seat_row, seat_position, email, ticket_class_id, first_name, last_name, passport_number, phone_number, is_adult, flight_id, user_id, identification)
VALUES
    (1, 'Bank A', 1, 'A', 'test1@gmail.com', 3, 'John', 'Smith', 'P1234567', '0345675123', true, 1, 1, "0304000233");

UNLOCK TABLES;