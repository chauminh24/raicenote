-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 08, 2025 at 10:20 AM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `website_raicenote`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_tokens`
--

DROP TABLE IF EXISTS `auth_tokens`;
CREATE TABLE IF NOT EXISTS `auth_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token` varchar(64) NOT NULL,
  `expiry` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `event_id` int NOT NULL,
  `number_of_participants` int DEFAULT '1',
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `booking_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `special_requests` text,
  PRIMARY KEY (`booking_id`),
  KEY `user_id` (`user_id`),
  KEY `event_id` (`event_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `event_id`, `number_of_participants`, `total_amount`, `status`, `booking_date`, `special_requests`) VALUES
(1, 2, 1, 2, 299.98, 'Confirmed', '2024-11-13 14:16:52', 'Vegetarian meal options needed'),
(2, 3, 1, 1, 149.99, 'Confirmed', '2024-11-13 14:16:52', NULL),
(3, 4, 2, 3, 179.97, 'Confirmed', '2024-11-13 14:16:52', 'Prefer non-spicy food pairings'),
(4, 5, 2, 2, 119.98, 'Pending', '2024-11-13 14:16:52', NULL),
(5, 6, 3, 4, 319.96, 'Confirmed', '2024-11-13 14:16:52', 'Group seating requested'),
(6, 7, 4, 1, 89.99, 'Confirmed', '2024-11-13 14:16:52', 'Gluten-free options needed'),
(7, 8, 5, 2, 399.98, 'Confirmed', '2024-11-13 14:16:52', 'Anniversary celebration - window seating preferred'),
(8, 9, 3, 3, 239.97, 'Cancelled', '2024-11-13 14:16:52', NULL),
(9, 10, 4, 2, 179.98, 'Confirmed', '2024-11-13 14:16:52', 'First-time brewers');

-- --------------------------------------------------------

--
-- Table structure for table `bundle_items`
--

DROP TABLE IF EXISTS `bundle_items`;
CREATE TABLE IF NOT EXISTS `bundle_items` (
  `bundle_item_id` int NOT NULL AUTO_INCREMENT,
  `bundle_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  `individual_price` decimal(10,2) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`bundle_item_id`),
  KEY `bundle_id` (`bundle_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bundle_items`
--

INSERT INTO `bundle_items` (`bundle_item_id`, `bundle_id`, `product_id`, `quantity`, `individual_price`, `notes`) VALUES
(1, 8, 1, 2, 12.99, 'Traditional Korean rice wine'),
(2, 8, 2, 2, 8.99, 'Classic Korean soju'),
(3, 9, 3, 1, 15.99, 'Traditional sake'),
(4, 9, 4, 1, 18.50, 'Unfiltered sake variant'),
(5, 10, 5, 1, 10.50, 'Traditional Shaoxing wine'),
(6, 10, 6, 1, 9.75, 'Classic Mijiu'),
(11, 28, 22, 1, 19.99, 'Cranberry-infused seasonal Japanese Sake'),
(10, 28, 21, 1, 14.99, 'Festive peppermint-infused Korean Makgeolli'),
(12, 28, 23, 1, 11.99, 'Cinnamon and spice-filled Chinese Muiji'),
(13, 20, 11, 1, 14.99, 'Peach-infused Korean rice wine.'),
(14, 20, 13, 1, 11.99, 'Plum-flavored Korean soju.'),
(15, 20, 18, 1, 17.50, 'Mango-infused rice wine.');

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

DROP TABLE IF EXISTS `contact_messages`;
CREATE TABLE IF NOT EXISTS `contact_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `event_type` varchar(100) DEFAULT NULL,
  `requirements` text,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`event_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `name`, `description`, `start_time`, `end_time`, `capacity`, `price`, `location`, `event_type`, `requirements`, `is_active`) VALUES
(1, 'Sake Brewing Workshop', 'Learn the traditional art of sake brewing', '2024-11-15 10:00:00', '2024-11-15 16:00:00', 15, 149.99, 'Main Brewery - 123 Brew St', 'Workshop', 'Must be 21+. No experience necessary. All materials provided.', 1),
(2, 'Wine Tasting Evening', 'Explore our premium rice wine collection', '2024-11-20 18:00:00', '2024-11-20 21:00:00', 30, 59.99, 'Tasting Room - 123 Brew St', 'Tasting', 'Must be 21+. Light appetizers included.', 1),
(3, 'Korean Rice Wine Festival', 'Celebration of Korean rice wine culture', '2024-12-01 11:00:00', '2024-12-01 20:00:00', 100, 79.99, 'Central Park Event Space', 'Festival', 'Must be 21+. Food vendors available.', 1),
(4, 'Beginner\'s Brewing Class', 'Introduction to rice wine brewing', '2024-11-25 14:00:00', '2024-11-25 17:00:00', 20, 89.99, 'Training Room - 123 Brew St', 'Workshop', 'Must be 21+. All materials provided.', 1),
(5, 'Premium Sake Dinner', 'Five-course dinner with sake pairings', '2024-12-10 19:00:00', '2024-12-10 22:00:00', 40, 199.99, 'Grand Hall - Luxury Hotel', 'Dining', 'Must be 21+. Formal attire required.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE IF NOT EXISTS `inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `batch_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `storage_location` varchar(255) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `batch_number` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `production_date` date DEFAULT NULL,
  `quality_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  KEY `product_id` (`product_id`),
  KEY `batch_id` (`batch_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_id`, `product_id`, `batch_id`, `quantity`, `storage_location`, `expiry_date`, `batch_number`, `status`, `production_date`, `quality_status`) VALUES
(1, 1, 1, 480, 'Warehouse A-1', '2025-10-01', 'MK241001', 'Available', '2024-10-11', 'Passed'),
(2, 2, 2, 980, 'Warehouse B-2', '2026-10-05', 'SJ241005', 'Available', '2024-10-05', 'Passed'),
(3, 12, 5, 385, 'Warehouse A-3', '2025-10-01', 'PM241001', 'Available', '2024-10-11', 'Passed');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `shipping_address` text,
  `payment_status` varchar(50) DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `full_name`, `order_date`, `total_amount`, `status`, `shipping_address`, `payment_status`, `tracking_number`) VALUES
(17, 1, 'Minh Chau Nguyen', '2025-04-29 09:12:51', 16.25, 'Pending', '31 Ros Caoin, Galway, H91 RW9W, Ireland', 'Unpaid', 'TRK-R3UP343CL'),
(16, 1, 'Minh Chau Nguyen', '2025-04-29 09:12:25', 16.25, 'Pending', '31 Ros Caoin, Galway, H91 RW9W, Ireland', 'Unpaid', 'TRK-BMFQ2YOO9'),
(15, 1, 'Robert Taylor', '2024-12-11 12:00:41', 73.94, 'Pending', '123 Main Street, Galway, H91 XY27, Ireland', 'Unpaid', 'TRK-358NTP365'),
(14, 1, 'Robert Taylor', '2024-12-06 01:24:43', 80.50, 'Pending', '123 Main Street, Galway, H91 XY27, Ireland', 'Unpaid', 'TRK-YIDTJKK3Z'),
(18, 1, 'Minh Chau Nguyen', '2025-04-29 09:16:19', 16.25, 'Pending', '31 Ros Caoin, Galway, H91 RW9W, Ireland', 'Unpaid', 'TRK-Z0LP52RQW'),
(19, 1, 'Minh Chau Nguyen', '2025-04-29 09:21:44', 16.25, 'Pending', '31 Ros Caoin, Galway, H91 RW9W, Ireland', 'Unpaid', 'TRK-VSUTK3H0A'),
(20, 1, 'Minh Chau Nguyen', '2025-04-29 09:24:27', 15.50, 'Pending', '31 Ros Caoin, Galway, H91 RY9W, United Kingdom', 'Unpaid', 'TRK-HS51E5V2K'),
(21, 1, 'Minh Chau Nguyen', '2025-04-29 09:25:20', 15.50, 'Pending', '31 Ros Caoin, Galway, H91 RY9W, United Kingdom', 'Unpaid', 'TRK-2V9S97R54'),
(22, 1, 'Minh Chau Nguyen', '2025-04-29 09:31:16', 15.50, 'Pending', '31 Ros Caoin, Galway, H91 RY9W, United Kingdom', 'Unpaid', 'TRK-1RY78YDKS');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE IF NOT EXISTS `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  `unit_price` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES
(12, 15, 31, 1, 13.99, 13.99),
(11, 15, 13, 1, 11.99, 11.99),
(10, 15, 2, 1, 8.99, 8.99),
(9, 15, 1, 3, 12.99, 38.97),
(8, 14, 35, 1, 15.50, 15.50),
(7, 14, 36, 4, 16.25, 65.00),
(13, 16, 36, NULL, 16.25, 0.00),
(14, 17, 36, NULL, 16.25, 0.00),
(15, 18, 36, NULL, 16.25, 0.00),
(16, 19, 36, NULL, 16.25, 0.00),
(17, 20, 35, NULL, 15.50, 0.00),
(18, 21, 35, NULL, 15.50, 0.00),
(19, 22, 35, NULL, 15.50, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `production_batches`
--

DROP TABLE IF EXISTS `production_batches`;
CREATE TABLE IF NOT EXISTS `production_batches` (
  `batch_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `start_date` date DEFAULT NULL,
  `expected_completion` date DEFAULT NULL,
  `quantity_produced` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `batch_number` varchar(100) DEFAULT NULL,
  `notes` text,
  `target_alcohol_percentage` float DEFAULT NULL,
  `recipe_variation` text,
  `expected_yield` int DEFAULT NULL,
  `quality_grade` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`batch_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `production_batches`
--

INSERT INTO `production_batches` (`batch_id`, `product_id`, `start_date`, `expected_completion`, `quantity_produced`, `status`, `batch_number`, `notes`, `target_alcohol_percentage`, `recipe_variation`, `expected_yield`, `quality_grade`) VALUES
(1, 1, '2024-10-01', '2024-10-11', 500, 'Completed', 'MK241001', 'Standard Makgeolli batch', 6.5, 'Traditional', 480, 'A'),
(2, 2, '2024-10-05', '2024-10-05', 1000, 'Completed', 'SJ241005', 'Standard Soju production', 16, 'Classic', 980, 'A+'),
(3, 3, '2024-10-10', '2024-11-09', NULL, 'In Progress', 'SK241010', 'Premium sake batch', 15, 'Premium', 400, NULL),
(4, 4, '2024-10-15', '2024-11-04', NULL, 'In Progress', 'NS241015', 'Nigori sake production', 14.5, 'Unfiltered', 300, NULL),
(5, 12, '2024-10-01', '2024-10-11', 400, 'Completed', 'PM241001', 'Peach Makgeolli special', 6.5, 'Fruit Infused', 385, 'A'),
(6, 13, '2024-10-08', '2024-11-02', NULL, 'In Progress', 'YS241008', 'Yuzu sake batch', 14.5, 'Citrus Infused', 250, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `production_logs`
--

DROP TABLE IF EXISTS `production_logs`;
CREATE TABLE IF NOT EXISTS `production_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `batch_id` int NOT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `action` varchar(100) DEFAULT NULL,
  `description` text,
  `recorded_by` varchar(100) DEFAULT NULL,
  `temperature` float DEFAULT NULL,
  `humidity` float DEFAULT NULL,
  `quality_checks` text,
  `phase` varchar(50) DEFAULT NULL,
  `adjustments_made` text,
  PRIMARY KEY (`log_id`),
  KEY `batch_id` (`batch_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `production_logs`
--

INSERT INTO `production_logs` (`log_id`, `batch_id`, `timestamp`, `action`, `description`, `recorded_by`, `temperature`, `humidity`, `quality_checks`, `phase`, `adjustments_made`) VALUES
(1, 1, '2024-11-13 14:22:06', 'Start', 'Initial rice washing and soaking', 'Kim Jin', 20.5, 65, 'Rice quality verified', 'Preparation', 'None'),
(2, 1, '2024-11-13 14:22:06', 'Fermentation', 'Added nuruk and water', 'Kim Jin', 18, 70, 'pH level: 6.5', 'Primary Fermentation', 'Temperature adjusted -2°C'),
(3, 1, '2024-11-13 14:22:06', 'Check', 'Day 5 fermentation check', 'Park Min', 18.5, 68, 'Alcohol content: 4%', 'Primary Fermentation', 'None'),
(4, 1, '2024-11-13 14:22:06', 'Completion', 'Batch completed', 'Kim Jin', 19, 65, 'Final alcohol content: 6.5%', 'Completion', 'None'),
(5, 2, '2024-11-13 14:22:06', 'Start', 'Preparation for distillation', 'Lee Soo', 22, 60, 'Base mixture verified', 'Preparation', 'None'),
(6, 2, '2024-11-13 14:22:06', 'Distillation', 'First run distillation', 'Lee Soo', 78.5, 55, 'Alcohol vapor temperature optimal', 'Distillation', 'Pressure adjusted +0.2 bar'),
(7, 3, '2024-11-13 14:22:06', 'Start', 'Rice washing and koji preparation', 'Tanaka Yuki', 21, 65, 'Koji quality verified', 'Preparation', 'None'),
(8, 3, '2024-11-13 14:22:06', 'Fermentation', 'Added koji and water', 'Tanaka Yuki', 12, 70, 'pH level: 6.8', 'Primary Fermentation', 'None');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int DEFAULT '0',
  `category` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `ingredients` text,
  `alcohol_percentage` float DEFAULT NULL,
  `aging_period` int DEFAULT NULL,
  `production_guidelines` text,
  `is_bundle` tinyint(1) DEFAULT '0',
  `product_type` varchar(100) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `stock_quantity`, `category`, `is_active`, `ingredients`, `alcohol_percentage`, `aging_period`, `production_guidelines`, `is_bundle`, `product_type`, `image_url`, `created_at`) VALUES
(1, 'Makgeolli', 'A traditional Korean rice wine with a slightly sweet flavor and milky appearance.', 12.99, 147, 'Korean Rice Wine', 1, 'Rice, Nuruk, Water', 6.5, 10, 'Fermented for 10 days in low temperature', 0, 'Single Product', '../uploads/images/rice-wines/makgeolli.jpg', '2024-01-15 10:00:00'),
(2, 'Soju', 'A clear, distilled Korean rice wine with a smooth and neutral taste.', 8.99, 199, 'Korean Rice Wine', 1, 'Rice, Water', 16, 0, 'Distilled to achieve a pure and smooth taste', 0, 'Single Product', '../uploads/images/rice-wines/soju.jpg', '2024-01-15 10:30:00'),
(3, 'Sake', 'A popular Japanese rice wine with a light, smooth flavor profile.', 15.99, 120, 'Japanese Rice Wine', 1, 'Rice, Koji, Water', 15, 30, 'Aged and brewed in low temperatures', 0, 'Single Product', '../uploads/images/rice-wines/sake.jpg', '2024-01-15 11:00:00'),
(4, 'Nigori Sake', 'A coarse-filtered Japanese sake with a cloudy appearance and bold taste.', 18.50, 100, 'Japanese Rice Wine', 1, 'Rice, Koji, Water', 14.5, 20, 'Unfiltered for a rich flavor', 0, 'Single Product', '../uploads/images/rice-wines/nigori-sake.jpg', '2024-01-15 11:30:00'),
(5, 'Shaoxing', 'A Chinese yellow wine with a distinct aroma and flavor, perfect for both drinking and cooking.', 10.50, 80, 'Chinese Rice Wine', 1, 'Glutinous rice, Wheat, Water', 13, 90, 'Brewed traditionally in clay jars', 0, 'Single Product', '../uploads/images/rice-wines/shaoxing.jpg', '2024-01-15 12:00:00'),
(6, 'Mijiu', 'A mildly sweet and smooth Chinese rice wine, often enjoyed warm.', 9.75, 100, 'Chinese Rice Wine', 1, 'Rice, Water', 10, 60, 'Fermented with yeast and aged for a smooth taste', 0, 'Single Product', '../uploads/images/rice-wines/mijiu.jpg', '2024-01-15 12:30:00'),
(7, 'Jinro Soju', 'A popular Korean soju known for its light and crisp flavor.', 7.99, 200, 'Korean Rice Wine', 1, 'Rice, Barley, Tapioca', 17.5, 0, 'Distilled with a mild finish', 0, 'Single Product', '../uploads/images/rice-wines/jinro-soju.jpg', '2024-01-15 13:00:00'),
(8, 'Korean Rice Wine Tasting Bundle', 'A selection of popular Korean rice wines, including Makgeolli and Soju.', 20.99, 50, 'Korean Bundle', 1, 'Makgeolli, Soju', NULL, NULL, 'Includes various popular Korean rice wines.', 1, 'Bundle', '../uploads/images/bundles/korean-tasting.jpg', '2024-01-16 10:00:00'),
(9, 'Japanese Sake Experience', 'Enjoy different types of Japanese sake, including traditional and Nigori sake.', 25.99, 40, 'Japanese Bundle', 1, 'Sake, Nigori Sake', NULL, NULL, 'Includes both filtered and unfiltered sake varieties.', 1, 'Bundle', '../uploads/images/bundles/japanese-experience.jpg', '2024-01-16 10:30:00'),
(10, 'Chinese Rice Wine Collection', 'A collection of classic Chinese rice wines: Shaoxing and Mijiu.', 18.50, 30, 'Chinese Bundle', 1, 'Shaoxing, Mijiu', NULL, NULL, 'Perfect for pairing with Chinese dishes or enjoying alone.', 1, 'Bundle', '../uploads/images/bundles/chinese-collection.jpg', '2024-01-16 11:00:00'),
(11, 'Peach Makgeolli', 'A sweet and refreshing Korean rice wine infused with juicy peach flavor.', 14.99, 120, 'Korean Rice Wine', 1, 'Rice, Nuruk, Water, Peach Extract', 6.5, 10, 'Fermented with peach extract for a fruity twist', 0, 'Flavored Wine', '../uploads/images/flavored/peach-makgeolli.jpg', '2024-01-17 10:00:00'),
(12, 'Yuzu Sake', 'A Japanese sake with a hint of citrus, created using the zest and juice of yuzu.', 19.50, 90, 'Japanese Rice Wine', 1, 'Rice, Koji, Water, Yuzu', 14.5, 25, 'Infused with fresh yuzu for a citrus aroma', 0, 'Flavored Wine', '../uploads/images/flavored/yuzu-sake.jpg', '2024-01-17 10:30:00'),
(13, 'Plum Soju', 'A unique Korean soju flavored with the richness of ripe plums.', 11.99, 149, 'Korean Rice Wine', 1, 'Rice, Plum Extract, Water', 13.5, 0, 'Mixed with plum essence for a tart, fruity taste', 0, 'Flavored Wine', '../uploads/images/flavored/plum-soju.jpg', '2024-01-17 11:00:00'),
(14, 'Lavender Sake', 'A floral Japanese sake infused with a delicate lavender aroma and smooth flavor.', 16.99, 80, 'Japanese Rice Wine', 1, 'Rice, Koji, Water, Lavender', 12.5, 15, 'Aged with lavender for a unique floral fragrance', 0, 'Flavored Wine', '../uploads/images/flavored/lavender-sake.jpg', '2024-01-17 11:30:00'),
(15, 'Ginger Makgeolli', 'Korean rice wine with a kick, thanks to the addition of spicy ginger.', 13.50, 100, 'Korean Rice Wine', 1, 'Rice, Nuruk, Water, Ginger', 6.5, 10, 'Fermented with fresh ginger for a spicy twist', 0, 'Flavored Wine', '../uploads/images/flavored/ginger-makgeolli.jpg', '2024-01-17 12:00:00'),
(16, 'Honey Chrysanthemum Mijiu', 'A smooth Chinese rice wine with a touch of honey and chrysanthemum flower.', 15.75, 90, 'Chinese Rice Wine', 1, 'Rice, Chrysanthemum, Honey, Water', 10, 40, 'Infused with chrysanthemum and honey for floral and sweet notes', 0, 'Flavored Wine', '../uploads/images/flavored/honey-chrysanthemum-mijiu.jpg', '2024-01-17 12:30:00'),
(17, 'Matcha Nigori Sake', 'A Japanese cloudy sake infused with rich matcha flavor for a unique twist.', 20.99, 85, 'Japanese Rice Wine', 1, 'Rice, Koji, Water, Matcha', 14, 20, 'Unfiltered sake with matcha infusion', 0, 'Flavored Wine', '../uploads/images/flavored/matcha-nigori-sake.jpg', '2024-01-17 13:00:00'),
(18, 'Mango Rice Wine', 'A tropical take on rice wine with ripe mango for a sweet and fruity experience.', 17.50, 75, 'Creative Rice Wine', 1, 'Rice, Nuruk, Water, Mango Extract', 8.5, 12, 'Fermented with mango for a tropical flavor', 0, 'Flavored Wine', '../uploads/images/flavored/mango-rice-wine.jpg', '2024-01-17 13:30:00'),
(19, 'Soju Cocktail Mix', 'A ready-to-drink mix of Soju flavors, including peach, lychee, and original.', 21.99, 70, 'Mixed Korean Rice Wine', 1, 'Rice, Water, Peach, Lychee, Original Soju', 13, 0, 'Packaged set of soju cocktail flavors', 1, 'Bundle', '../uploads/images/mixed/soju-cocktail-mix.jpg', '2024-01-18 10:00:00'),
(20, 'Fruit Infusion Bundle', 'A selection of popular fruit-infused rice wines, including Peach Makgeolli, Plum Soju, and Mango Rice Wine.', 29.99, 60, 'Creative Bundle', 1, 'Peach Makgeolli, Plum Soju, Mango Rice Wine', NULL, NULL, 'Includes a range of fruity rice wines', 1, 'Bundle', '../uploads/images/mixed/fruit-infusion-bundle.jpg', '2024-01-18 10:30:00'),
(21, 'Peppermint Makgeolli', 'A festive twist on traditional makgeolli with subtle peppermint notes and vanilla undertones, perfect for winter celebrations.', 14.99, 100, 'Korean Rice Wine', 1, 'Rice, Nuruk, Water, Natural Peppermint, Vanilla', 6.5, 12, 'Fermented for 12 days with peppermint infusion', 0, 'Seasonal Product', '../uploads/images/seasonal/peppermint_makgeolli.jpg', '2024-11-07 00:00:00'),
(22, 'Cranberry Sake', 'A seasonal sake infused with cranberries and winter spices, creating a beautiful ruby color and festive aroma.', 19.99, 80, 'Japanese Rice Wine', 1, 'Rice, Koji, Water, Cranberries, Winter Spices', 14, 35, 'Traditional brewing with cranberry infusion', 0, 'Seasonal Product', '../uploads/images/seasonal/cranberry_sake.jpg', '2024-11-07 00:00:00'),
(23, 'Spiced Mijiu', 'A warming Chinese rice wine enhanced with cinnamon, star anise, and orange peel for the holiday season.', 11.99, 75, 'Chinese Rice Wine', 1, 'Rice, Water, Cinnamon, Star Anise, Orange Peel', 10.5, 65, 'Fermented with traditional spices', 0, 'Seasonal Product', '../uploads/images/seasonal/spiced_mijiu.jpg', '2024-11-07 00:00:00'),
(24, 'Gingerbread Makgeolli', 'A sweet and spicy makgeolli that captures the essence of holiday cookies with notes of ginger and molasses.', 15.99, 90, 'Korean Rice Wine', 1, 'Rice, Nuruk, Water, Ginger, Molasses, Spices', 6, 14, 'Special fermentation with holiday spices', 0, 'Seasonal Product', '../uploads/images/seasonal/gingerbread_makgeolli.jpg', '2024-11-07 00:00:00'),
(25, 'Winter Forest Sake', 'Premium sake with subtle pine and juniper notes, reminiscent of a snow-covered forest.', 24.99, 60, 'Japanese Rice Wine', 1, 'Rice, Koji, Water, Pine Extract, Juniper Berries', 15, 40, 'Aged with natural forest botanicals', 0, 'Seasonal Product', '../uploads/images/seasonal/winter_forest_sake.jpg', '2024-11-07 00:00:00'),
(26, 'Honey Cinnamon Soju', 'A festive take on traditional soju with warm honey and cinnamon notes.', 11.99, 120, 'Korean Rice Wine', 1, 'Rice, Water, Honey, Cinnamon', 16, 0, 'Infused with holiday spices post-distillation', 0, 'Seasonal Product', '../uploads/images/seasonal/honey_cinnamon_soju.jpg', '2024-11-07 00:00:00'),
(27, 'Golden Spice Shaoxing', 'A warming holiday version of Shaoxing wine with notes of vanilla, nutmeg, and dried fruits.', 13.99, 70, 'Chinese Rice Wine', 1, 'Glutinous Rice, Wheat, Water, Winter Spices, Dried Fruits', 13.5, 95, 'Traditional aging with holiday spice blend', 0, 'Seasonal Product', '../uploads/images/seasonal/golden_spice_shaoxing.jpg', '2024-11-07 00:00:00'),
(28, 'Festive Rice Wine Tasting Bundle', 'A selection of three seasonal rice wines, perfect for holiday celebrations.', 42.99, 50, 'Rice Wine Bundle', 1, 'Rice, Water, Seasonal Spices, Fruit Infusions', 0, 0, 'Includes a mix of peppermint, cranberry, and spiced flavors.', 1, 'Seasonal Bundle', '../uploads/images/seasonal/festive_rice_wine_tasting_bundle.jpg', '2024-11-08 00:00:00'),
(29, 'Millet Wine', 'Fenzhou millet wine is golden in color and has an alcohol content of 10-13% by volume. It is very fragrant, and its sweetness is balanced by a hint of astringency.', 14.00, 123, 'Taiwanese Rice Wine', 1, 'Millet, Yeast, Water', 13, 12, 'Allow the mixture to ferment in a cool, shaded environment for approximately one month', 0, 'Single Product', '../uploads/images/rice-wines/millet.jpg', '2024-01-15 10:30:00'),
(31, 'Vietnamese Lotus Rice Wine', 'A fragrant and delicate rice wine infused with the essence of lotus flowers.', 13.99, 99, 'Vietnamese Rice Wine', 1, 'Rice, Lotus Extract, Water', 12, 20, 'Infused with lotus essence for floral notes', 0, 'Single Product', '../uploads/images/rice-wines/vietnamese-lotus-rice-wine.jpg', '2024-11-18 17:23:25'),
(34, 'Vietnamese Traditional Rice Wine', 'A classic Vietnamese rice wine with a rich and smooth flavor.', 10.99, 120, 'Vietnamese Rice Wine', 1, 'Rice, Water, Yeast', 14, 30, 'Aged to perfection for a smooth finish', 0, 'Single Product', '../uploads/images/rice-wines/vietnamese-traditional-rice-wine.jpg', '2024-11-18 17:23:25'),
(35, 'Coconut Rice Wine', 'A tropical rice wine with the sweet and creamy flavor of coconut.', 15.50, NULL, 'Creative Rice Wine', 1, 'Rice, Coconut Extract, Water', 10.5, 15, 'Fermented with coconut for a tropical twist', 0, 'Flavored Wine', '../uploads/images/flavoured/coconut-rice-wine.jpg', '2024-11-18 17:23:25'),
(36, 'Pineapple Makgeolli', 'A refreshing Korean rice wine with the tangy sweetness of pineapple.', 16.25, 86, 'Korean Rice Wine', 1, 'Rice, Pineapple Extract, Water', 7, 10, 'Fermented with pineapple for a fruity flavor', 0, 'Flavored Wine', '../uploads/images/flavoured/pineapple-makgeolli.jpg', '2024-11-18 17:23:25');

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
CREATE TABLE IF NOT EXISTS `recipes` (
  `recipe_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `instructions` text,
  `ingredients` text,
  `difficulty_level` int DEFAULT NULL,
  `duration_days` int DEFAULT NULL,
  `notes` text,
  `is_public` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`recipe_id`)
) ;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`recipe_id`, `name`, `instructions`, `ingredients`, `difficulty_level`, `duration_days`, `notes`, `is_public`) VALUES
(1, 'Traditional Makgeolli', 'Step 1: Wash and soak rice\nStep 2: Steam rice\nStep 3: Cool rice\nStep 4: Mix with nuruk\nStep 5: Ferment', 'Rice: 5kg\nNuruk: 1kg\nWater: 6.5L', 3, 7, 'Keep temperature between 18-22°C during fermentation', 1),
(2, 'Premium Sake', 'Step 1: Polish rice\nStep 2: Prepare koji\nStep 3: Create moto\nStep 4: Main fermentation', 'Premium rice: 10kg\nKoji rice: 3kg\nWater: 13L\nYeast starter: 1kg', 4, 30, 'Requires precise temperature control', 0),
(3, 'Fruit-Infused Makgeolli', 'Step 1: Create basic makgeolli\nStep 2: Secondary fermentation with fruit', 'Basic makgeolli base\nFresh fruit: 2kg\nSugar: 0.5kg', 2, 10, 'Use very ripe fruits for best results', 1),
(4, 'Quick Homebrew Rice Wine', 'Step 1: Prepare rice\nStep 2: Add water and yeast\nStep 3: Let ferment for 3 days', 'Rice: 2kg\nYeast: 0.5g\nWater: 3L\nSugar: 100g', 1, 3, 'Ideal for beginners, simple and quick', 1),
(5, 'Classic Soju', 'Step 1: Prepare and ferment ingredients\nStep 2: Distill\nStep 3: Filter and age', 'Rice or barley: 5kg\nWater: 10L\nYeast: 1kg', 4, 45, 'Requires distillation equipment and careful handling', 0),
(6, 'Yuzu-Infused Sake', 'Step 1: Make sake base\nStep 2: Add yuzu zest during final fermentation', 'Sake base\nYuzu zest: 200g', 3, 35, 'Adds citrus flavor to traditional sake', 1),
(7, 'Peach Makgeolli', 'Step 1: Create traditional makgeolli\nStep 2: Add peach puree in secondary fermentation', 'Basic makgeolli base\nPeach puree: 1.5kg\nSugar: 0.2kg', 2, 10, 'Peach flavor blends well with makgeolli', 1),
(8, 'High-Alcohol Soju', 'Step 1: Ferment rice and water\nStep 2: Distill to higher proof\nStep 3: Dilute if necessary', 'Rice: 6kg\nWater: 8L\nYeast: 1kg', 5, 60, 'Produce with caution due to high alcohol content', 0);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `reference_id` int DEFAULT NULL,
  `review_type` varchar(50) DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `comment` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_verified` tinyint(1) DEFAULT '0',
  `pros` text,
  `cons` text,
  `experience_level` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `user_id` (`user_id`)
) ;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `user_id`, `reference_id`, `review_type`, `rating`, `comment`, `created_at`, `is_verified`, `pros`, `cons`, `experience_level`) VALUES
(1, 2, 1, 'Product', 5, 'Excellent traditional Makgeolli!', '2024-11-13 14:25:04', 1, 'Authentic taste, Good value', 'None', 'Intermediate'),
(2, 3, 2, 'Product', 4, 'Good quality Soju', '2024-11-13 14:25:04', 1, 'Smooth taste, Good price', 'Could be stronger', 'Expert'),
(3, 4, 1, 'Event', 5, 'Amazing workshop experience', '2024-11-13 14:25:04', 1, 'Informative, Hands-on', 'Location bit far', 'Beginner'),
(4, 5, 3, 'Product', 3, 'Decent sake but expected more', '2024-11-13 14:25:04', 1, 'Good aroma', 'Price bit high', 'Expert'),
(5, 6, 2, 'Event', 5, 'Wonderful tasting event', '2024-11-13 14:25:04', 1, 'Great selection, Knowledgeable staff', 'None', 'Intermediate');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_admin` tinyint(1) DEFAULT '0',
  `address` text,
  `date_of_birth` date DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `password_hash`, `first_name`, `last_name`, `phone`, `created_at`, `is_admin`, `address`, `date_of_birth`) VALUES
(1, 'admin@raicenote.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Admin', 'User', '+1234567890', '2024-11-13 14:16:52', 1, '123 Admin Street, Business District, 12345', '1980-01-01'),
(2, 'john.smith@email.com', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 'John', 'Smith', '+1234567891', '2024-11-13 14:16:52', 0, '456 Oak Ave, Springfield, 12346', '1985-03-15'),
(3, 'mary.johnson@email.com', '1d4598d1949b47f7f211134b639ec32238ce73086a83c2f745713b3f12f817e5', 'Mary', 'Johnson', '+1234567892', '2024-11-13 14:16:52', 0, '789 Pine St, Riverside, 12347', '1990-06-22'),
(4, 'david.lee@email.com', '9dbd5c893b5b573a1aa909c8cade58df194310e411c590d9fb0d63431841fd67', 'David', 'Lee', '+1234567893', '2024-11-13 14:16:52', 0, '321 Maple Dr, Hillside, 12348', '1988-09-10'),
(5, 'sarah.wilson@email.com', 'e5b2ec1eb34a6f7a78eda6bcdd18b3c3dcfdc90a1d5c66fc2301c1ceaef8fbf4', 'Sarah', 'Wilson', '+1234567894', '2024-11-13 14:16:52', 0, '654 Cedar Ln, Lakeside, 12349', '1992-12-05'),
(6, 'michael.brown@email.com', '47e8a8d9a3841640f185b767fe82245cb2e6aa102ca8e43d6f29126a0e03a862', 'Michael', 'Brown', '+1234567895', '2024-11-13 14:16:52', 0, '987 Birch Rd, Mountain View, 12350', '1987-04-18'),
(7, 'emily.davis@email.com', 'd5f2f0f4ad1a8766bb07e27dc121d514ea770886feb1406e1ed1f76f9867d6bf', 'Emily', 'Davis', '+1234567896', '2024-11-13 14:16:52', 0, '147 Elm St, Seaside, 12351', '1995-07-30'),
(8, 'james.wilson@email.com', '6272a94b52b95b50a5304af63d146fe8c7151e094927437e0cf2919f212888ff', 'James', 'Wilson', '+1234567897', '2024-11-13 14:16:52', 0, '258 Walnut Ave, Downtown, 12352', '1983-11-25'),
(9, 'lisa.anderson@email.com', '7913d6c6ca2d3c8913d830ca150460974d1aace643ae24bcfdf1e661862d2b9b', 'Lisa', 'Anderson', '+1234567898', '2024-11-13 14:16:52', 0, '369 Cherry Ln, Uptown, 12353', '1993-02-14'),
(10, 'robert.taylor@email.com', '$2y$10$iqPrydEAmrz6V8RNeJnMYeMm2vwIsSmy2eIP24c04DwuzNZ20xtdu', 'Robert', 'Taylor', '+1234567899', '2024-11-13 14:16:52', 0, '741 Pineapple St, Beachside, 12354', '1986-08-08'),
(12, 'mindy@flo.wer', '$2y$10$BM0Bp73wPZI/hhir1h3mOe5Klx36Y83383jlVxo68r8ePVs5C0Y1e', '', '', NULL, '2024-11-19 20:13:31', 0, NULL, NULL),
(18, 'mindy@flower.com', '$2y$10$rX7dOK3KaMCMfPc3unFXeO3P0rvdESOBAB2bCXFT8b04kTfk2FSSe', '', '', NULL, '2024-11-19 20:30:24', 0, NULL, NULL),
(19, 'mindy@email.com', '$2y$10$iVYSUZEErJECs5He3gcqROC1tLI.w2xqOQT2xfHbfti/H8wFG6k2.', '', '', NULL, '2024-11-19 20:32:23', 0, NULL, NULL),
(20, 'minh@cha.u', '$2y$10$ay9G4PzHNFHb0R2qZy1v5O6tqixRbzen10iRbT1t80syC6tWLs21.', '', '', NULL, '2024-11-19 20:42:41', 0, NULL, NULL),
(21, 'minh@chau.ng', '$2y$10$ToahOYYpZWHiAjO5nk2Y1.4x7quCnugCxv7QpDjePBdBfyBEJXzr6', '', '', NULL, '2024-11-19 20:45:51', 0, NULL, NULL),
(22, 'kevin@thui.com', '$2y$10$OnZ9N5Uw9CevWqUqqVJR5OFiYMJAmVDnycY2fYWUC8YPD6Oqk8FC2', '', '', NULL, '2024-11-20 12:35:47', 0, NULL, NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
