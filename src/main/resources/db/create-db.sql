-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: restaurant
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `dishes`
--

DROP TABLE IF EXISTS `dishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dishes` (
                          `dish_id` int NOT NULL AUTO_INCREMENT,
                          `dish_title` varchar(90) NOT NULL,
                          `dish_description` tinytext,
                          `dish_price` decimal(8,2) NOT NULL,
                          `dish_calorie_content` float DEFAULT NULL,
                          `dish_is_available` tinyint NOT NULL,
                          `dish_picture_path` varchar(100) NOT NULL,
                          PRIMARY KEY (`dish_id`),
                          UNIQUE KEY `dishId_UNIQUE` (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dishes`
--

LOCK TABLES `dishes` WRITE;
/*!40000 ALTER TABLE `dishes` DISABLE KEYS */;
INSERT INTO `dishes` VALUES (1,'Цезарь','С куриным филе, листьями салата романо и айсберг, соусом цезарь, сыром пармезан, чесночными сухариками, томатами черри и зеленью, яйцами',6.00,44,0,'/static/img/our-menu-04.jpg'),(2,'Салат с бужениной','С салатом айсберг, свежими овощами, маринованным болгарским перцем, яйцом, сухариками под соусом сливочный хрен',5.00,50,1,'/static/img/lunch-02.jpg'),(3,'Салат с рулетами из блинчика','Салат с рулетами из блинов с грибами',8.55,54,1,'/static/img/lunch-02.jpg'),(4,'Картофель по-деревенски дольками','Слегка отваренный и затем обжаренный дольками, со специями',5.00,50,1,'/static/img/lunch-04.jpg'),(5,'Дегустационный сет горячих закусок','2 вида жареных колбас, а также «Колдуны» мясные (пельмени)  cо свининой - жареные и запеченные, картофель по деревенски дольками и др.',50.00,120,0,'/static/img/dinner-01.jpg');
/*!40000 ALTER TABLE `dishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drinks`
--

DROP TABLE IF EXISTS `drinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drinks` (
                          `drink_id` int NOT NULL AUTO_INCREMENT,
                          `drink_title` varchar(90) NOT NULL,
                          `drink_description` tinytext,
                          `drink_price` decimal(8,2) NOT NULL,
                          `drink_is_avaible` tinyint NOT NULL,
                          `drink_picture_path` varchar(100) NOT NULL,
                          PRIMARY KEY (`drink_id`),
                          UNIQUE KEY `drinks_id_UNIQUE` (`drink_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drinks`
--

LOCK TABLES `drinks` WRITE;
/*!40000 ALTER TABLE `drinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `drinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
                        `menu_id` int NOT NULL AUTO_INCREMENT,
                        `menu_name` varchar(45) NOT NULL,
                        `menu_dishes_id` int NOT NULL,
                        `menu_creation_date` date NOT NULL,
                        `menu_picture_path` varchar(100) NOT NULL,
                        PRIMARY KEY (`menu_id`),
                        UNIQUE KEY `menuId_UNIQUE` (`menu_id`),
                        KEY `fk_menu_menuInclude1_idx` (`menu_dishes_id`),
                        CONSTRAINT `fk_menu_menuInclude1` FOREIGN KEY (`menu_dishes_id`) REFERENCES `menudishes` (`menu_dishes_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menudishes`
--

DROP TABLE IF EXISTS `menudishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `menudishes` (

                              `menu_dishes_id` int NOT NULL AUTO_INCREMENT,
                              `dish_id` int NOT NULL,
                              `drink_id` int NOT NULL,
                              PRIMARY KEY (`menu_dishes_id`),
                              UNIQUE KEY `menu_include_id_UNIQUE` (`menu_dishes_id`),
                              KEY `fk_menuInclude_dishes1_idx` (`dish_id`),
                              KEY `fk_menuInclude_drinks1_idx` (`drink_id`),
                              CONSTRAINT `fk_menuInclude_dishes1` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
                              CONSTRAINT `fk_menuInclude_drinks1` FOREIGN KEY (`drink_id`) REFERENCES `drinks` (`drink_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menudishes`
--

LOCK TABLES `menudishes` WRITE;
/*!40000 ALTER TABLE `menudishes` DISABLE KEYS */;
/*!40000 ALTER TABLE `menudishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `odereddishes`
--

DROP TABLE IF EXISTS `odereddishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `odereddishes` (
                                `odered_dishes_id` int NOT NULL AUTO_INCREMENT,
                                `dish_id` int NOT NULL,
                                `order_id` int NOT NULL,
                                PRIMARY KEY (`odered_dishes_id`),
                                UNIQUE KEY `oderedDishesId_UNIQUE` (`odered_dishes_id`),
                                KEY `fk_oderedDishes_dish1_idx` (`dish_id`),
                                KEY `fk_oderedDishes_orders1_idx` (`order_id`),
                                CONSTRAINT `fk_oderedDishes_dish1` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `odereddishes`
--

LOCK TABLES `odereddishes` WRITE;
/*!40000 ALTER TABLE `odereddishes` DISABLE KEYS */;
INSERT INTO `odereddishes` VALUES (3,2,1),(4,4,1),(5,2,1),(6,4,2),(7,4,3),(8,4,4),(9,2,5),(10,2,6),(11,5,6),(12,5,6),(13,4,6),(14,2,6),(15,2,6),(16,4,6),(17,2,7),(18,5,7),(19,2,7),(20,4,8),(21,2,8),(22,4,8),(23,2,9),(24,4,9),(25,2,10),(26,2,10),(27,1,11),(28,4,12),(29,2,12),(30,4,12),(31,1,13),(32,4,14),(33,4,15),(34,4,15),(35,1,15),(36,2,15),(37,1,15),(38,1,15),(39,2,15),(40,1,16),(41,1,17),(42,1,18),(43,1,18),(44,1,19),(45,1,20),(46,1,20),(47,2,21),(48,1,22),(49,1,22),(50,2,22),(51,2,22),(52,1,23),(53,1,24),(54,2,25),(55,1,25),(56,1,26),(57,2,26),(58,2,26),(59,1,27),(64,4,28),(65,2,28),(66,1,29),(67,2,29),(69,4,30),(70,3,31);
/*!40000 ALTER TABLE `odereddishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_payment_methods`
--
DROP TABLE IF EXISTS `order_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_payment_methods` (
                                         `order_payment_method_id` int NOT NULL AUTO_INCREMENT,
                                         `order_payment_method_name` varchar(45) NOT NULL,
                                         PRIMARY KEY (`order_payment_method_id`),
                                         UNIQUE KEY `order_payment_method_id_UNIQUE` (`order_payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_payment_methods`
--

LOCK TABLES `order_payment_methods` WRITE;
/*!40000 ALTER TABLE `order_payment_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordereddrinks`
--

DROP TABLE IF EXISTS `ordereddrinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordereddrinks` (
                                 `odered_drinks_id` int NOT NULL AUTO_INCREMENT,
                                 `drink_id` int NOT NULL,
                                 `order_id` int NOT NULL,
                                 PRIMARY KEY (`odered_drinks_id`),
                                 UNIQUE KEY `odered_drinks_id_UNIQUE` (`odered_drinks_id`),
                                 KEY `fk_orderedDrinks_drinks1_idx` (`drink_id`),
                                 KEY `fk_orderedDrinks_orders1_idx` (`order_id`),
                                 CONSTRAINT `fk_orderedDrinks_drinks1` FOREIGN KEY (`drink_id`) REFERENCES `drinks` (`drink_id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                 CONSTRAINT `fk_orderedDrinks_orders1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordereddrinks`
--

LOCK TABLES `ordereddrinks` WRITE;
/*!40000 ALTER TABLE `ordereddrinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordereddrinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
                          `order_id` int NOT NULL AUTO_INCREMENT,
                          `order_status` enum('READY','VIOLATED','PREPARING','CANCELED','EXPECTED','PAID') NOT NULL,

                          `order_time` datetime DEFAULT NULL,
                          `order_total_price` decimal(16,2) DEFAULT NULL,
                          `order_review` tinytext,
                          `user_id` int NOT NULL,
                          `order_payment_method_id` int DEFAULT NULL,
                          `table_reservation_id` int DEFAULT NULL,
                          PRIMARY KEY (`order_id`),
                          UNIQUE KEY `orderId_UNIQUE` (`order_id`),
                          KEY `fk_order_user1_idx` (`user_id`),
                          KEY `fk_orders_tableReservation1_idx` (`table_reservation_id`),
                          KEY `fk_orders_order_payment_methods1_idx1` (`order_payment_method_id`),
                          CONSTRAINT `fk_order_user1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
                          CONSTRAINT `fk_orders_order_payment_methods1` FOREIGN KEY (`order_payment_method_id`) REFERENCES `order_payment_methods` (`order_payment_method_id`),
                          CONSTRAINT `fk_orders_tableReservation1` FOREIGN KEY (`table_reservation_id`) REFERENCES `tablereservation` (`table_reservation_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(2,'VIOLATED',NULL,NULL,NULL,4,NULL,NULL),(3,'VIOLATED',NULL,NULL,NULL,5,NULL,NULL),(4,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(5,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(6,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(7,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(8,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(9,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(10,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(11,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(12,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(13,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(14,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(16,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(17,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(22,'PAID','2022-04-26 00:00:00',22.00,NULL,3,NULL,NULL),(23,'PAID','2022-04-26 19:24:00',6.00,NULL,3,NULL,NULL),(24,'PAID','2022-04-29 19:49:00',6.00,NULL,3,NULL,NULL),(25,'PAID','2022-04-30 15:00:00',11.00,NULL,3,NULL,NULL),(26,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(27,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(28,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(29,'VIOLATED',NULL,NULL,NULL,3,NULL,NULL),(30,'PAID','2022-05-08 16:25:00',5.00,NULL,3,NULL,NULL),(31,'PAID','2022-05-15 09:59:00',8.55,NULL,3,NULL,NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
                         `role_id` int NOT NULL AUTO_INCREMENT,
                         `role_name` enum('ADMIN','USER') NOT NULL,
                         PRIMARY KEY (`role_id`),

                         UNIQUE KEY `roleId_UNIQUE` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN'),(2,'USER');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tablereservation`
--

DROP TABLE IF EXISTS `tablereservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tablereservation` (
                                    `table_reservation_id` int NOT NULL AUTO_INCREMENT,
                                    `table_date_of_reservation` datetime NOT NULL,
                                    `table_finish_date_of_reservation` datetime NOT NULL,
                                    `table_id` int NOT NULL,
                                    PRIMARY KEY (`table_reservation_id`),
                                    UNIQUE KEY `table_reservation_id_UNIQUE` (`table_reservation_id`),
                                    KEY `fk_tableReservation_tables1_idx` (`table_id`),
                                    CONSTRAINT `fk_tableReservation_tables1` FOREIGN KEY (`table_id`) REFERENCES `tables` (`table_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tablereservation`
--

LOCK TABLES `tablereservation` WRITE;
/*!40000 ALTER TABLE `tablereservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `tablereservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tables` (
                          `table_id` int NOT NULL AUTO_INCREMENT,
                          `table_number` int NOT NULL,
                          `table_number_of_seats` int NOT NULL,
                          PRIMARY KEY (`table_id`),
                          UNIQUE KEY `table_id_UNIQUE` (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--

-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
                         `user_id` int NOT NULL AUTO_INCREMENT,
                         `user_name` varchar(45) DEFAULT NULL,
                         `user_surname` varchar(45) DEFAULT NULL,
                         `user_phone` varchar(45) DEFAULT NULL,
                         `user_email` varchar(45) NOT NULL,
                         `user_password` varchar(45) NOT NULL,
                         `role_id` int NOT NULL,
                         `user_picture_path` varchar(100) DEFAULT NULL,
                         PRIMARY KEY (`user_id`),
                         UNIQUE KEY `userId_UNIQUE` (`user_id`),
                         UNIQUE KEY `user_email_UNIQUE` (`user_email`),
                         KEY `fk_user_role_idx` (`role_id`),
                         CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'Владислав','Жидик','+375298065248','okolotovich2000@mail.ru','gw225om2000',1,NULL),(3,'Максим','Меша','+375336570985','karpeychyk@mail.ru','qwertyui',2,NULL),(4,'Борис','Астапенко','+375297703791','shepelevich@mail.ru','asdfghjk',2,NULL),(5,'Александр','Кезик','+375335475825','ostapko@mail.ru','qazwsxed',2,NULL),(10,'Михаил Василевский','Василевский','+375336570985','tima@mail.ru','aaaaaaaa',2,NULL);
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

-- Dump completed on 2022-05-4  1:56:11

