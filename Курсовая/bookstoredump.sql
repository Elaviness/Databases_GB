-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: bookstore
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `all_orders`
--

DROP TABLE IF EXISTS `all_orders`;
/*!50001 DROP VIEW IF EXISTS `all_orders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `all_orders` AS SELECT 
 1 AS `id`,
 1 AS `full_name`,
 1 AS `total_sum`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `ISBN` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `author` varchar(45) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `publish_year` year DEFAULT NULL,
  `price` decimal(7,2) unsigned DEFAULT NULL,
  `count` int unsigned DEFAULT NULL,
  PRIMARY KEY (`ISBN`),
  UNIQUE KEY `ISBN_UNIQUE` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES ('9785170738472','Полная история Средиземья','Джон Р.Р.Толкин','Фентези',2013,986.00,49),('9785170786961','Властелин колец','Джон Р.Р.Толкин','Фентези',2013,748.50,84),('9785170905430','Чуб земли','Макс Фрай','Фентези',2018,402.00,160),('9785170923212','Властелин Морморы','Макс Фрай','Фентези',2018,405.00,150),('9785170924554','Неуловимый Хабба Хэн','Макс Фрай','Фентези',2018,450.00,200),('9785170924561','Ворона на мосту','Макс Фрай','Фентези',2018,390.00,145),('9785498075808','Психология лжи','Пол Экман','Психология',2010,500.00,319),('9785769548789','Психология общения','В.А.Горянина','Психология',2004,358.50,77),('9785928707088','Сонник','Г.Х.Миллер','Эзотерика',2004,160.00,25),('9785941422306','Личный ребрендинг','Т.Мужицкая','Саморазвитие',2013,250.00,102),('9785942787468','Молот ведьм','Яков Шпренгер','Эзотерика',2005,268.00,50),('9785988571230','Рунические практики','Светлана Некрасова','Эзотерика',2008,215.00,60);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_has_orders`
--

DROP TABLE IF EXISTS `books_has_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_has_orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `books_ISBN` varchar(13) NOT NULL,
  `orders_id` int unsigned NOT NULL,
  `book_count` int unsigned DEFAULT NULL,
  `position_cost` decimal(7,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_books_has_orders_orders1_idx` (`orders_id`),
  KEY `fk_books_has_orders_books1_idx` (`books_ISBN`),
  CONSTRAINT `fk_books_has_orders_books1` FOREIGN KEY (`books_ISBN`) REFERENCES `books` (`ISBN`),
  CONSTRAINT `fk_books_has_orders_orders1` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_has_orders`
--

LOCK TABLES `books_has_orders` WRITE;
/*!40000 ALTER TABLE `books_has_orders` DISABLE KEYS */;
INSERT INTO `books_has_orders` VALUES (1,'9785170905430',1,1,402.00),(2,'9785170924554',1,1,450.00),(3,'9785170923212',1,1,405.00),(4,'9785170924561',1,1,390.00),(5,'9785769548789',2,1,358.50),(6,'9785498075808',2,1,500.00),(7,'9785170738472',3,2,1972.00),(8,'9785942787468',4,1,268.00),(9,'9785170905430',5,5,2010.00),(10,'9785928707088',6,2,320.00),(11,'9785941422306',6,1,250.00),(12,'9785170738472',7,1,986.00),(13,'9785170786961',7,1,748.00),(14,'9785498075808',7,3,1500.00);
/*!40000 ALTER TABLE `books_has_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cheque`
--

DROP TABLE IF EXISTS `cheque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cheque` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `purshase_time` datetime DEFAULT NULL,
  `orders_id` int unsigned NOT NULL,
  `tax` tinyint DEFAULT '10',
  PRIMARY KEY (`id`),
  KEY `fk_cheque_orders_idx` (`orders_id`),
  CONSTRAINT `fk_cheque_orders` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cheque`
--

LOCK TABLES `cheque` WRITE;
/*!40000 ALTER TABLE `cheque` DISABLE KEYS */;
INSERT INTO `cheque` VALUES (1,'2019-12-07 13:28:27',1,10),(2,'2019-09-10 12:55:47',2,10),(3,'2019-09-07 17:50:35',3,10),(4,'2020-05-30 22:04:09',6,10),(5,'2020-06-02 13:33:10',7,10),(6,'2020-06-02 17:17:49',7,10);
/*!40000 ALTER TABLE `cheque` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `decrease_count` BEFORE INSERT ON `cheque` FOR EACH ROW begin
    declare finished int default 0;
    declare curr_count int;
    declare curr_ISBN varchar(13);
    declare curr_space int;
    declare curr_order int;
    declare row_cursor cursor for
        select orders_id,books_ISBN, spaces_id, book_count
                    from short_order_info where short_order_info.orders_id = new.orders_id;
    DECLARE continue HANDLER FOR NOT FOUND SET finished = 1;
    OPEN row_cursor;
    while finished = 0 do
        FETCH row_cursor into curr_order,curr_ISBN,curr_space,curr_count;
        update spaces_has_books set count_in_space = count_in_space - curr_count
        where spaces_has_books.spaces_id = curr_space and
              books_ISBN = curr_ISBN and
              curr_order = new.orders_id;
        end while;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `discount_status` AFTER INSERT ON `cheque` FOR EACH ROW begin
    declare client_sum decimal(10,2);
    declare curr_id int;
    select all_orders.total_sum, all_orders.id into client_sum, curr_id from all_orders where id = (select clients_id from orders where orders.id = new.orders_id);
        if client_sum < 5000
            then update clients set discount_status = 0 where clients.id = curr_id;
        elseif client_sum = 5000 or client_sum > 5000 and client_sum <10000
            then update clients set discount_status = 5 where clients.id = curr_id;
        elseif client_sum = 5000 or client_sum > 10000 and client_sum < 20000
            then update clients set discount_status = 10 where clients.id = curr_id;
        elseif client_sum = 10000 or client_sum > 20000 and client_sum < 50000
            then update clients set discount_status = 15 where clients.id = curr_id;
        else update clients set discount_status = 25 where clients.id = curr_id;
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `login` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `loyalty_card` varchar(45) DEFAULT NULL,
  `discount_status` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Марселина Хоуп','2005-03-19','marcelina.hoppe@example.net','dubuque.mossie','e5a043773a67fb8c0fcdc5e295d687509e0c7d1c','4934539883228389',0),(2,'Иосиф Блумач','1985-03-30','friesen.toni@example.com','cole.shaun','56f9f99f963fc0f0dc67180188dcb50509c6e9f2','4024007111132',15),(3,'Элеонора Федотова','1972-09-10','elenora49@example.org','grayson56','f40e6b02bf051d5a026dae5422e6f2a324cae7cb','4916041015092394',5),(4,'Егор Шастун','1994-10-01','rocky65@example.com','rebeka03','762b2918ab17b939d32f6290d09326c31f3d36a0','5416317396757656',5),(5,'Николай Джаллибов','1987-03-08','nikolaus.jordon@example.com','ivah18','8f155bb9178d199ed655b253e783d89ce52c49ba','5405493198341772',25),(6,'Анна-Мария Грант','1970-04-12','amalia.grant@example.net','annamarie.ankunding','dabafe900dc0b5226bc3c1263b9eb77bd959eaf5','377007879790721',10),(7,'Ольга Байцова','1974-05-09','obie88@example.com','maurine.wehner','0de6e01842387411233f8785ea6dae0b1d8d80d0','340815543579308',0),(8,'Eлисей Ховенцов','1988-07-11','ehowe@example.com','lgreen','60eeac1807c35a33c2d1e47477af507c17359469','5166295782019827',10),(9,'Инесса Ким','2006-10-13','bins.kurt@example.org','doug.senger','bceb0d1f4eca24c4f2c61d046478a62e1f31b44f','4716478251497228',15),(10,'Григорий Вутц','2002-12-06','lueilwitz.jack@example.com','sonya.stanton','f4f04f216d6d7548e9943171372639aa76085255','5275783236827135',0),(11,'Матвей Брейтенберг','2003-01-25','ruben27@example.org','vbreitenberg','43e6b63325711621136c2f653c276c2199240e74','4556679341670886',5),(12,'Мария Шерман','1994-01-30','hilll.lucienne@example.com','sherman46','e359de3ce69323e1d0f958c67fe56245e6bb6bc3','4916606818295805',5),(13,'Герман Фоменко','2000-07-31','herminia.kreiger@example.com','fkirlin','a1586c7d02475b62e0a375ba11b73360f08d6e27','5484951236587168',0),(14,'Анна Земляк','1995-01-09','vhickle@example.org','shanna.zemlak','beaa629a8938d58136412083060d83b87c410076','5534776066385728',10),(15,'Михаил Подобедов','2004-10-03','michele.mosciski@example.net','gbeer','adf8c93f8d73ad9b7234a6847b304f871265de57','342564896224129',0);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `birth_date` date NOT NULL,
  `position` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone_number` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `spaces_id` int unsigned NOT NULL,
  `salary` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employees_spaces1_idx` (`spaces_id`),
  CONSTRAINT `fk_employees_spaces1` FOREIGN KEY (`spaces_id`) REFERENCES `spaces` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Екатерина Волкова','1988-11-05','бухгалтер','89549665964',2,27000.00),(2,'Даниил Коваленко','2001-06-27','сотрудник склада','89656062935',1,22500.00),(3,'Mаксим Шульц','1983-05-23','директор','89853452022',3,60000.00),(4,'Эвелина Скворцова','1993-12-30','администратор','89691120466',2,35700.00),(5,'Никита Алексеев','1991-11-01','продавец','89776487598',3,32500.00),(6,'Галина Зорина','1970-04-21','бухгалтер','89766636193',5,40000.00),(7,'Виктор Попов','2000-12-05','продавец','89672794202',4,22000.07),(8,'Константин Южаков','1997-11-16','менеджер склада','89720764558',1,31800.00),(9,'Марина Михайлова','1988-08-21','администратор','89544270713',4,42000.40),(10,'Наталья Бычкова','1982-10-06','бухгалтер','89493873883',1,44500.00),(11,'Кристина Ермилова','1988-06-30','администратор','89735451-42',3,35000.00),(12,'Николай Чудин','2000-10-17','продавец','89778741593',3,23500.00),(13,'Нелли Акопян','1972-10-29','продавец','89241849699',2,20450.00),(14,'Михаил Виноградов','2004-07-04','администратор','89258467952',5,38600.00),(15,'Светлана Новицкая','1972-12-07','продавец','89771136485',5,17850.00);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees_has_requests`
--

DROP TABLE IF EXISTS `employees_has_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees_has_requests` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `employees_id` int unsigned NOT NULL,
  `requests_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employees_has_requests_requests1_idx` (`requests_id`),
  KEY `fk_employees_has_requests_employees1_idx` (`employees_id`),
  CONSTRAINT `fk_employees_has_requests_employees1` FOREIGN KEY (`employees_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `fk_employees_has_requests_requests1` FOREIGN KEY (`requests_id`) REFERENCES `requests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_has_requests`
--

LOCK TABLES `employees_has_requests` WRITE;
/*!40000 ALTER TABLE `employees_has_requests` DISABLE KEYS */;
INSERT INTO `employees_has_requests` VALUES (1,4,1),(2,11,2),(3,9,3),(4,14,4),(5,4,5),(6,11,6),(7,9,7),(8,4,8),(9,11,9),(10,14,10);
/*!40000 ALTER TABLE `employees_has_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `not_enough_books`
--

DROP TABLE IF EXISTS `not_enough_books`;
/*!50001 DROP VIEW IF EXISTS `not_enough_books`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `not_enough_books` AS SELECT 
 1 AS `spaces_id`,
 1 AS `ISBN`,
 1 AS `title`,
 1 AS `count_in_space`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `not_paid_orders`
--

DROP TABLE IF EXISTS `not_paid_orders`;
/*!50001 DROP VIEW IF EXISTS `not_paid_orders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `not_paid_orders` AS SELECT 
 1 AS `id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `clients_id` int unsigned NOT NULL,
  `employees_id` int unsigned NOT NULL,
  `order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `delivery_date` date NOT NULL,
  `delivery_cost` decimal(6,2) NOT NULL,
  `order_cost` decimal(7,2) NOT NULL,
  `delivery_status` enum('accepted','paid','in_delivery','delivered') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `total_count` int NOT NULL,
  `total_price` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orders_clients1_idx` (`clients_id`),
  KEY `fk_orders_employees1_idx` (`employees_id`),
  CONSTRAINT `fk_orders_clients1` FOREIGN KEY (`clients_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `fk_orders_employees1` FOREIGN KEY (`employees_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,7,'2019-12-07 13:28:27','Горького, дом 28','2019-12-06',0.00,99999.99,'delivered',4,1647.00),(2,2,8,'2019-09-07 21:50:35','Молостовых, 5','2019-09-10',300.00,2040.00,'delivered',2,858.50),(3,5,13,'2019-09-07 17:50:35','Студенческая Ул., дом 23/А','2019-09-07',0.00,1972.00,'delivered',2,1972.00),(4,3,8,'2020-05-27 10:17:21','26-Бакинских Комиссаров,15','2020-06-04',300.00,268.00,'in_delivery',1,268.00),(5,4,8,'2020-06-01 17:35:23','Новикова, 34','2020-06-09',0.00,2010.00,'accepted',5,2010.00),(6,5,8,'2020-05-30 22:04:09','Станиславского, 9','2020-06-10',300.00,570.00,'paid',3,570.00),(7,4,8,'2020-06-01 21:09:59','Горького, дом 58','2020-06-04',0.00,3234.00,'paid',4,3234.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `report_month`
--

DROP TABLE IF EXISTS `report_month`;
/*!50001 DROP VIEW IF EXISTS `report_month`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `report_month` AS SELECT 
 1 AS `books_ISBN`,
 1 AS `count`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `spaces_id` int unsigned NOT NULL,
  `request_date` date NOT NULL,
  `complete_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_requests_spaces1_idx` (`spaces_id`),
  CONSTRAINT `fk_requests_spaces1` FOREIGN KEY (`spaces_id`) REFERENCES `spaces` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
INSERT INTO `requests` VALUES (1,2,'2019-07-09','2019-07-13'),(2,3,'2019-08-27','2019-08-31'),(3,4,'2019-10-01','2019-10-06'),(4,5,'2019-10-04','2019-10-09'),(5,3,'2020-01-10','2020-01-14'),(6,5,'2020-02-10','2020-02-15'),(7,4,'2020-03-14','2020-03-23'),(8,2,'2020-03-30','2020-04-05'),(9,3,'2020-05-29','2003-06-01'),(10,5,'2020-05-30','2020-06-04');
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `short_order_info`
--

DROP TABLE IF EXISTS `short_order_info`;
/*!50001 DROP VIEW IF EXISTS `short_order_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `short_order_info` AS SELECT 
 1 AS `orders_id`,
 1 AS `books_ISBN`,
 1 AS `book_count`,
 1 AS `spaces_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `spaces`
--

DROP TABLE IF EXISTS `spaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spaces` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` enum('store','warehouse') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spaces`
--

LOCK TABLES `spaces` WRITE;
/*!40000 ALTER TABLE `spaces` DISABLE KEYS */;
INSERT INTO `spaces` VALUES (1,'Хорошевское Шоссе, дом 62','warehouse'),(2,'Студенческая Ул., дом 23/А','store'),(3,'Вадковский Пер., дом 20','store'),(4,'Горького, дом 58','store'),(5,'Пограничная, дом 26','store');
/*!40000 ALTER TABLE `spaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spaces_has_books`
--

DROP TABLE IF EXISTS `spaces_has_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spaces_has_books` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `spaces_id` int unsigned NOT NULL,
  `books_ISBN` varchar(13) NOT NULL,
  `count_in_space` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_spaces_has_books_books1_idx` (`books_ISBN`),
  KEY `fk_spaces_has_books_spaces1_idx` (`spaces_id`),
  CONSTRAINT `fk_spaces_has_books_books1` FOREIGN KEY (`books_ISBN`) REFERENCES `books` (`ISBN`),
  CONSTRAINT `fk_spaces_has_books_spaces1` FOREIGN KEY (`spaces_id`) REFERENCES `spaces` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spaces_has_books`
--

LOCK TABLES `spaces_has_books` WRITE;
/*!40000 ALTER TABLE `spaces_has_books` DISABLE KEYS */;
INSERT INTO `spaces_has_books` VALUES (1,1,'9785170905430',155),(2,2,'9785170905430',5),(3,3,'9785170905430',0),(4,4,'9785170905430',0),(5,5,'9785170905430',0),(6,1,'9785170924554',200),(7,2,'9785170924554',0),(8,3,'9785170924554',0),(9,4,'9785170924554',0),(10,5,'9785170924554',0),(11,1,'9785170923212',150),(12,2,'9785170923212',0),(13,3,'9785170923212',0),(14,4,'9785170923212',0),(15,5,'9785170923212',0),(16,1,'9785170924561',145),(17,2,'9785170924561',0),(18,3,'9785170924561',0),(19,4,'9785170924561',0),(20,5,'9785170924561',0),(21,1,'9785170786961',84),(22,2,'9785170786961',0),(23,3,'9785170786961',0),(24,4,'9785170786961',0),(25,5,'9785170786961',0),(26,1,'9785170738472',49),(27,2,'9785170738472',0),(28,3,'9785170738472',0),(29,4,'9785170738472',0),(30,5,'9785170738472',0),(32,1,'9785941422306',102),(33,2,'9785941422306',0),(34,3,'9785941422306',0),(35,4,'9785941422306',0),(36,5,'9785941422306',0),(37,1,'9785769548789',77),(38,2,'9785769548789',0),(39,3,'9785769548789',0),(40,4,'9785769548789',0),(41,5,'9785769548789',0),(42,1,'9785498075808',319),(43,2,'9785498075808',0),(44,3,'9785498075808',0),(45,4,'9785498075808',0),(46,5,'9785498075808',0),(47,1,'9785988571230',60),(48,2,'9785988571230',0),(49,3,'9785988571230',0),(50,4,'9785988571230',0),(51,5,'9785988571230',0),(52,1,'9785170905430',155);
/*!40000 ALTER TABLE `spaces_has_books` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_total_count` BEFORE UPDATE ON `spaces_has_books` FOR EACH ROW if new.count_in_space is not null then
        update books set count = count - OLD.count_in_space + new.count_in_space
        where new.books_ISBN = ISBN;
    end if */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `supplies`
--

DROP TABLE IF EXISTS `supplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplies` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `supplier` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `spaces_id` int unsigned NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_supplies_spaces1_idx` (`spaces_id`),
  CONSTRAINT `fk_supplies_spaces1` FOREIGN KEY (`spaces_id`) REFERENCES `spaces` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplies`
--

LOCK TABLES `supplies` WRITE;
/*!40000 ALTER TABLE `supplies` DISABLE KEYS */;
INSERT INTO `supplies` VALUES (1,'Амфора',1,50000.00,'2019-06-28'),(2,'Книги для всех',2,35000.00,'2019-08-02'),(3,'АСТ',3,155325.00,'2019-09-16'),(4,'Лабиринт пресс',4,49765.00,'2019-12-23'),(5,'Амфора',5,65700.00,'2020-01-12'),(6,'Фантастика',1,251025.75,'2020-02-02'),(7,'АСТ',2,264003.00,'2020-04-30'),(8,'Росмэн',3,148500.00,'2020-05-16'),(9,'АСТ',4,205678.30,'2020-05-23');
/*!40000 ALTER TABLE `supplies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `all_orders`
--

/*!50001 DROP VIEW IF EXISTS `all_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_orders` AS select `clients`.`id` AS `id`,`clients`.`full_name` AS `full_name`,sum(`orders`.`total_price`) AS `total_sum` from (`clients` join `orders`) where (`clients`.`id` = `orders`.`clients_id`) group by `clients`.`full_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `not_enough_books`
--

/*!50001 DROP VIEW IF EXISTS `not_enough_books`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `not_enough_books` AS select `spaces_has_books`.`spaces_id` AS `spaces_id`,`books`.`ISBN` AS `ISBN`,`books`.`title` AS `title`,`spaces_has_books`.`count_in_space` AS `count_in_space` from (`spaces_has_books` join `books`) where ((`spaces_has_books`.`count_in_space` < 10) and (`spaces_has_books`.`books_ISBN` = `books`.`ISBN`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `not_paid_orders`
--

/*!50001 DROP VIEW IF EXISTS `not_paid_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `not_paid_orders` AS select `orders`.`id` AS `id` from (`orders` left join `cheque` on((`orders`.`id` = `cheque`.`orders_id`))) where (`cheque`.`orders_id` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `report_month`
--

/*!50001 DROP VIEW IF EXISTS `report_month`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report_month` AS select `books_has_orders`.`books_ISBN` AS `books_ISBN`,sum(`books_has_orders`.`book_count`) AS `count` from `books_has_orders` where `books_has_orders`.`orders_id` in (select `orders`.`id` from (`orders` join `cheque`) where ((`orders`.`id` = `cheque`.`orders_id`) and (`cheque`.`orders_id` is not null) and (month(`cheque`.`purshase_time`) = month(now())))) group by `books_has_orders`.`books_ISBN` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `short_order_info`
--

/*!50001 DROP VIEW IF EXISTS `short_order_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `short_order_info` AS select `books_has_orders`.`orders_id` AS `orders_id`,`books_has_orders`.`books_ISBN` AS `books_ISBN`,`books_has_orders`.`book_count` AS `book_count`,`employees`.`spaces_id` AS `spaces_id` from ((`orders` left join `books_has_orders` on((`orders`.`id` = `books_has_orders`.`orders_id`))) join `employees` on((`orders`.`employees_id` = `employees`.`id`))) */;
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

-- Dump completed on 2020-06-11 20:13:45
