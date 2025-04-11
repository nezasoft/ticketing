-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for rt_oris
DROP DATABASE IF EXISTS `rt_oris`;
CREATE DATABASE IF NOT EXISTS `rt_oris` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `rt_oris`;

-- Dumping structure for table rt_oris.api_settings
DROP TABLE IF EXISTS `api_settings`;
CREATE TABLE IF NOT EXISTS `api_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.api_settings: ~0 rows (approximately)
DELETE FROM `api_settings`;
/*!40000 ALTER TABLE `api_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_settings` ENABLE KEYS */;

-- Dumping structure for table rt_oris.attachments
DROP TABLE IF EXISTS `attachments`;
CREATE TABLE IF NOT EXISTS `attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `file_name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_path` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.attachments: ~0 rows (approximately)
DELETE FROM `attachments`;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;

-- Dumping structure for table rt_oris.auth_users
DROP TABLE IF EXISTS `auth_users`;
CREATE TABLE IF NOT EXISTS `auth_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` blob DEFAULT NULL,
  `phone` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dept_id` int(10) unsigned NOT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.auth_users: ~0 rows (approximately)
DELETE FROM `auth_users`;
/*!40000 ALTER TABLE `auth_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_users` ENABLE KEYS */;

-- Dumping structure for table rt_oris.business_docs
DROP TABLE IF EXISTS `business_docs`;
CREATE TABLE IF NOT EXISTS `business_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `document_name` varchar(45) DEFAULT NULL,
  `document_no` varchar(20) DEFAULT NULL,
  `document_value` int(11) DEFAULT NULL,
  `doc_code` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table rt_oris.business_docs: ~1 rows (approximately)
DELETE FROM `business_docs`;
/*!40000 ALTER TABLE `business_docs` DISABLE KEYS */;
INSERT INTO `business_docs` (`id`, `company_id`, `document_name`, `document_no`, `document_value`, `doc_code`) VALUES
	(34, 1, 'Ticket', '100000', 1, 'TK');
/*!40000 ALTER TABLE `business_docs` ENABLE KEYS */;

-- Dumping structure for table rt_oris.cache
DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.cache: ~0 rows (approximately)
DELETE FROM `cache`;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;

-- Dumping structure for table rt_oris.cache_locks
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.cache_locks: ~0 rows (approximately)
DELETE FROM `cache_locks`;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;

-- Dumping structure for table rt_oris.channels
DROP TABLE IF EXISTS `channels`;
CREATE TABLE IF NOT EXISTS `channels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.channels: ~0 rows (approximately)
DELETE FROM `channels`;
/*!40000 ALTER TABLE `channels` DISABLE KEYS */;
/*!40000 ALTER TABLE `channels` ENABLE KEYS */;

-- Dumping structure for table rt_oris.channel_contacts
DROP TABLE IF EXISTS `channel_contacts`;
CREATE TABLE IF NOT EXISTS `channel_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int(10) unsigned NOT NULL,
  `email` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.channel_contacts: ~0 rows (approximately)
DELETE FROM `channel_contacts`;
/*!40000 ALTER TABLE `channel_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `channel_contacts` ENABLE KEYS */;

-- Dumping structure for table rt_oris.companies
DROP TABLE IF EXISTS `companies`;
CREATE TABLE IF NOT EXISTS `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `website` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phy_add` varchar(200) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `client_no` varchar(45) DEFAULT NULL,
  `company_logo` varchar(100) DEFAULT NULL,
  `active` int(1) DEFAULT 0,
  `days` int(3) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.companies: ~0 rows (approximately)
DELETE FROM `companies`;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;

-- Dumping structure for table rt_oris.country_code
DROP TABLE IF EXISTS `country_code`;
CREATE TABLE IF NOT EXISTS `country_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iso` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `nicename` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `iso3` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `numcode` smallint(6) NOT NULL,
  `phonecode` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.country_code: ~239 rows (approximately)
DELETE FROM `country_code`;
/*!40000 ALTER TABLE `country_code` DISABLE KEYS */;
INSERT INTO `country_code` (`id`, `iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `created_at`, `updated_at`) VALUES
	(1, 'AF', 'AFGHANISTAN', 'Afghanistan', 'AFG', 4, 93, '2016-12-13 06:19:33', '2016-12-13 06:19:33'),
	(2, 'AL', 'ALBANIA', 'Albania', 'ALB', 8, 355, '2016-12-13 06:19:33', '2016-12-13 06:19:33'),
	(3, 'DZ', 'ALGERIA', 'Algeria', 'DZA', 12, 213, '2016-12-13 06:19:33', '2016-12-13 06:19:33'),
	(4, 'AS', 'AMERICAN SAMOA', 'American Samoa', 'ASM', 16, 1684, '2016-12-13 06:19:33', '2016-12-13 06:19:33'),
	(5, 'AD', 'ANDORRA', 'Andorra', 'AND', 20, 376, '2016-12-13 06:19:33', '2016-12-13 06:19:33'),
	(6, 'AO', 'ANGOLA', 'Angola', 'AGO', 24, 244, '2016-12-13 06:19:33', '2016-12-13 06:19:33'),
	(7, 'AI', 'ANGUILLA', 'Anguilla', 'AIA', 660, 1264, '2016-12-13 06:19:33', '2016-12-13 06:19:33'),
	(8, 'AQ', 'ANTARCTICA', 'Antarctica', 'NUL', 0, 0, '2016-12-13 06:19:33', '2016-12-13 06:19:33'),
	(9, 'AG', 'ANTIGUA AND BARBUDA', 'Antigua and Barbuda', 'ATG', 28, 1268, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(10, 'AR', 'ARGENTINA', 'Argentina', 'ARG', 32, 54, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(11, 'AM', 'ARMENIA', 'Armenia', 'ARM', 51, 374, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(12, 'AW', 'ARUBA', 'Aruba', 'ABW', 533, 297, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(13, 'AU', 'AUSTRALIA', 'Australia', 'AUS', 36, 61, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(14, 'AT', 'AUSTRIA', 'Austria', 'AUT', 40, 43, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(15, 'AZ', 'AZERBAIJAN', 'Azerbaijan', 'AZE', 31, 994, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(16, 'BS', 'BAHAMAS', 'Bahamas', 'BHS', 44, 1242, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(17, 'BH', 'BAHRAIN', 'Bahrain', 'BHR', 48, 973, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(18, 'BD', 'BANGLADESH', 'Bangladesh', 'BGD', 50, 880, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(19, 'BB', 'BARBADOS', 'Barbados', 'BRB', 52, 1246, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(20, 'BY', 'BELARUS', 'Belarus', 'BLR', 112, 375, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(21, 'BE', 'BELGIUM', 'Belgium', 'BEL', 56, 32, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(22, 'BZ', 'BELIZE', 'Belize', 'BLZ', 84, 501, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(23, 'BJ', 'BENIN', 'Benin', 'BEN', 204, 229, '2016-12-13 06:19:34', '2016-12-13 06:19:34'),
	(24, 'BM', 'BERMUDA', 'Bermuda', 'BMU', 60, 1441, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(25, 'BT', 'BHUTAN', 'Bhutan', 'BTN', 64, 975, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(26, 'BO', 'BOLIVIA', 'Bolivia', 'BOL', 68, 591, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(27, 'BA', 'BOSNIA AND HERZEGOVINA', 'Bosnia and Herzegovina', 'BIH', 70, 387, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(28, 'BW', 'BOTSWANA', 'Botswana', 'BWA', 72, 267, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(29, 'BV', 'BOUVET ISLAND', 'Bouvet Island', 'NUL', 0, 0, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(30, 'BR', 'BRAZIL', 'Brazil', 'BRA', 76, 55, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(31, 'IO', 'BRITISH INDIAN OCEAN TERRITORY', 'British Indian Ocean Territory', 'NUL', 0, 246, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(32, 'BN', 'BRUNEI DARUSSALAM', 'Brunei Darussalam', 'BRN', 96, 673, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(33, 'BG', 'BULGARIA', 'Bulgaria', 'BGR', 100, 359, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(34, 'BF', 'BURKINA FASO', 'Burkina Faso', 'BFA', 854, 226, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(35, 'BI', 'BURUNDI', 'Burundi', 'BDI', 108, 257, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(36, 'KH', 'CAMBODIA', 'Cambodia', 'KHM', 116, 855, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(37, 'CM', 'CAMEROON', 'Cameroon', 'CMR', 120, 237, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(38, 'CA', 'CANADA', 'Canada', 'CAN', 124, 1, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(39, 'CV', 'CAPE VERDE', 'Cape Verde', 'CPV', 132, 238, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(40, 'KY', 'CAYMAN ISLANDS', 'Cayman Islands', 'CYM', 136, 1345, '2016-12-13 06:19:35', '2016-12-13 06:19:35'),
	(41, 'CF', 'CENTRAL AFRICAN REPUBLIC', 'Central African Republic', 'CAF', 140, 236, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(42, 'TD', 'CHAD', 'Chad', 'TCD', 148, 235, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(43, 'CL', 'CHILE', 'Chile', 'CHL', 152, 56, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(44, 'CN', 'CHINA', 'China', 'CHN', 156, 86, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(45, 'CX', 'CHRISTMAS ISLAND', 'Christmas Island', 'NUL', 0, 61, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(46, 'CC', 'COCOS (KEELING) ISLANDS', 'Cocos (Keeling) Islands', 'NUL', 0, 672, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(47, 'CO', 'COLOMBIA', 'Colombia', 'COL', 170, 57, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(48, 'KM', 'COMOROS', 'Comoros', 'COM', 174, 269, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(49, 'CG', 'CONGO', 'Congo', 'COG', 178, 242, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(50, 'CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 'Congo, the Democratic Republic of the', 'COD', 180, 242, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(51, 'CK', 'COOK ISLANDS', 'Cook Islands', 'COK', 184, 682, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(52, 'CR', 'COSTA RICA', 'Costa Rica', 'CRI', 188, 506, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(53, 'CI', 'COTE DIVOIRE', 'Cote DIvoire', 'CIV', 384, 225, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(54, 'HR', 'CROATIA', 'Croatia', 'HRV', 191, 385, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(55, 'CU', 'CUBA', 'Cuba', 'CUB', 192, 53, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(56, 'CY', 'CYPRUS', 'Cyprus', 'CYP', 196, 357, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(57, 'CZ', 'CZECH REPUBLIC', 'Czech Republic', 'CZE', 203, 420, '2016-12-13 06:19:36', '2016-12-13 06:19:36'),
	(58, 'DK', 'DENMARK', 'Denmark', 'DNK', 208, 45, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(59, 'DJ', 'DJIBOUTI', 'Djibouti', 'DJI', 262, 253, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(60, 'DM', 'DOMINICA', 'Dominica', 'DMA', 212, 1767, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(61, 'DO', 'DOMINICAN REPUBLIC', 'Dominican Republic', 'DOM', 214, 1809, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(62, 'EC', 'ECUADOR', 'Ecuador', 'ECU', 218, 593, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(63, 'EG', 'EGYPT', 'Egypt', 'EGY', 818, 20, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(64, 'SV', 'EL SALVADOR', 'El Salvador', 'SLV', 222, 503, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(65, 'GQ', 'EQUATORIAL GUINEA', 'Equatorial Guinea', 'GNQ', 226, 240, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(66, 'ER', 'ERITREA', 'Eritrea', 'ERI', 232, 291, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(67, 'EE', 'ESTONIA', 'Estonia', 'EST', 233, 372, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(68, 'ET', 'ETHIOPIA', 'Ethiopia', 'ETH', 231, 251, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(69, 'FK', 'FALKLAND ISLANDS (MALVINAS)', 'Falkland Islands (Malvinas)', 'FLK', 238, 500, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(70, 'FO', 'FAROE ISLANDS', 'Faroe Islands', 'FRO', 234, 298, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(71, 'FJ', 'FIJI', 'Fiji', 'FJI', 242, 679, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(72, 'FI', 'FINLAND', 'Finland', 'FIN', 246, 358, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(73, 'FR', 'FRANCE', 'France', 'FRA', 250, 33, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(74, 'GF', 'FRENCH GUIANA', 'French Guiana', 'GUF', 254, 594, '2016-12-13 06:19:37', '2016-12-13 06:19:37'),
	(75, 'PF', 'FRENCH POLYNESIA', 'French Polynesia', 'PYF', 258, 689, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(76, 'TF', 'FRENCH SOUTHERN TERRITORIES', 'French Southern Territories', 'NUL', 0, 0, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(77, 'GA', 'GABON', 'Gabon', 'GAB', 266, 241, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(78, 'GM', 'GAMBIA', 'Gambia', 'GMB', 270, 220, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(79, 'GE', 'GEORGIA', 'Georgia', 'GEO', 268, 995, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(80, 'DE', 'GERMANY', 'Germany', 'DEU', 276, 49, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(81, 'GH', 'GHANA', 'Ghana', 'GHA', 288, 233, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(82, 'GI', 'GIBRALTAR', 'Gibraltar', 'GIB', 292, 350, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(83, 'GR', 'GREECE', 'Greece', 'GRC', 300, 30, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(84, 'GL', 'GREENLAND', 'Greenland', 'GRL', 304, 299, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(85, 'GD', 'GRENADA', 'Grenada', 'GRD', 308, 1473, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(86, 'GP', 'GUADELOUPE', 'Guadeloupe', 'GLP', 312, 590, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(87, 'GU', 'GUAM', 'Guam', 'GUM', 316, 1671, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(88, 'GT', 'GUATEMALA', 'Guatemala', 'GTM', 320, 502, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(89, 'GN', 'GUINEA', 'Guinea', 'GIN', 324, 224, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(90, 'GW', 'GUINEA-BISSAU', 'Guinea-Bissau', 'GNB', 624, 245, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(91, 'GY', 'GUYANA', 'Guyana', 'GUY', 328, 592, '2016-12-13 06:19:38', '2016-12-13 06:19:38'),
	(92, 'HT', 'HAITI', 'Haiti', 'HTI', 332, 509, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(93, 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS', 'Heard Island and Mcdonald Islands', 'NUL', 0, 0, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(94, 'VA', 'HOLY SEE (VATICAN CITY STATE)', 'Holy See (Vatican City State)', 'VAT', 336, 39, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(95, 'HN', 'HONDURAS', 'Honduras', 'HND', 340, 504, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(96, 'HK', 'HONG KONG', 'Hong Kong', 'HKG', 344, 852, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(97, 'HU', 'HUNGARY', 'Hungary', 'HUN', 348, 36, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(98, 'IS', 'ICELAND', 'Iceland', 'ISL', 352, 354, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(99, 'IN', 'INDIA', 'India', 'IND', 356, 91, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(100, 'ID', 'INDONESIA', 'Indonesia', 'IDN', 360, 62, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(101, 'IR', 'IRAN, ISLAMIC REPUBLIC OF', 'Iran, Islamic Republic of', 'IRN', 364, 98, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(102, 'IQ', 'IRAQ', 'Iraq', 'IRQ', 368, 964, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(103, 'IE', 'IRELAND', 'Ireland', 'IRL', 372, 353, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(104, 'IL', 'ISRAEL', 'Israel', 'ISR', 376, 972, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(105, 'IT', 'ITALY', 'Italy', 'ITA', 380, 39, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(106, 'JM', 'JAMAICA', 'Jamaica', 'JAM', 388, 1876, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(107, 'JP', 'JAPAN', 'Japan', 'JPN', 392, 81, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(108, 'JO', 'JORDAN', 'Jordan', 'JOR', 400, 962, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(109, 'KZ', 'KAZAKHSTAN', 'Kazakhstan', 'KAZ', 398, 7, '2016-12-13 06:19:39', '2016-12-13 06:19:39'),
	(110, 'KE', 'KENYA', 'Kenya', 'KEN', 404, 254, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(111, 'KI', 'KIRIBATI', 'Kiribati', 'KIR', 296, 686, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(112, 'KP', 'KOREA, DEMOCRATIC PEOPLES REPUBLIC OF', 'Korea, Democratic Peoples Republic of', 'PRK', 408, 850, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(113, 'KR', 'KOREA, REPUBLIC OF', 'Korea, Republic of', 'KOR', 410, 82, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(114, 'KW', 'KUWAIT', 'Kuwait', 'KWT', 414, 965, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(115, 'KG', 'KYRGYZSTAN', 'Kyrgyzstan', 'KGZ', 417, 996, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(116, 'LA', 'LAO PEOPLES DEMOCRATIC REPUBLIC', 'Lao Peoples Democratic Republic', 'LAO', 418, 856, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(117, 'LV', 'LATVIA', 'Latvia', 'LVA', 428, 371, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(118, 'LB', 'LEBANON', 'Lebanon', 'LBN', 422, 961, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(119, 'LS', 'LESOTHO', 'Lesotho', 'LSO', 426, 266, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(120, 'LR', 'LIBERIA', 'Liberia', 'LBR', 430, 231, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(121, 'LY', 'LIBYAN ARAB JAMAHIRIYA', 'Libyan Arab Jamahiriya', 'LBY', 434, 218, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(122, 'LI', 'LIECHTENSTEIN', 'Liechtenstein', 'LIE', 438, 423, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(123, 'LT', 'LITHUANIA', 'Lithuania', 'LTU', 440, 370, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(124, 'LU', 'LUXEMBOURG', 'Luxembourg', 'LUX', 442, 352, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(125, 'MO', 'MACAO', 'Macao', 'MAC', 446, 853, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(126, 'MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 'Macedonia, the Former Yugoslav Republic of', 'MKD', 807, 389, '2016-12-13 06:19:40', '2016-12-13 06:19:40'),
	(127, 'MG', 'MADAGASCAR', 'Madagascar', 'MDG', 450, 261, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(128, 'MW', 'MALAWI', 'Malawi', 'MWI', 454, 265, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(129, 'MY', 'MALAYSIA', 'Malaysia', 'MYS', 458, 60, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(130, 'MV', 'MALDIVES', 'Maldives', 'MDV', 462, 960, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(131, 'ML', 'MALI', 'Mali', 'MLI', 466, 223, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(132, 'MT', 'MALTA', 'Malta', 'MLT', 470, 356, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(133, 'MH', 'MARSHALL ISLANDS', 'Marshall Islands', 'MHL', 584, 692, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(134, 'MQ', 'MARTINIQUE', 'Martinique', 'MTQ', 474, 596, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(135, 'MR', 'MAURITANIA', 'Mauritania', 'MRT', 478, 222, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(136, 'MU', 'MAURITIUS', 'Mauritius', 'MUS', 480, 230, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(137, 'YT', 'MAYOTTE', 'Mayotte', 'NUL', 0, 269, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(138, 'MX', 'MEXICO', 'Mexico', 'MEX', 484, 52, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(139, 'FM', 'MICRONESIA, FEDERATED STATES OF', 'Micronesia, Federated States of', 'FSM', 583, 691, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(140, 'MD', 'MOLDOVA, REPUBLIC OF', 'Moldova, Republic of', 'MDA', 498, 373, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(141, 'MC', 'MONACO', 'Monaco', 'MCO', 492, 377, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(142, 'MN', 'MONGOLIA', 'Mongolia', 'MNG', 496, 976, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(143, 'MS', 'MONTSERRAT', 'Montserrat', 'MSR', 500, 1664, '2016-12-13 06:19:41', '2016-12-13 06:19:41'),
	(144, 'MA', 'MOROCCO', 'Morocco', 'MAR', 504, 212, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(145, 'MZ', 'MOZAMBIQUE', 'Mozambique', 'MOZ', 508, 258, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(146, 'MM', 'MYANMAR', 'Myanmar', 'MMR', 104, 95, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(147, 'NA', 'NAMIBIA', 'Namibia', 'NAM', 516, 264, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(148, 'NR', 'NAURU', 'Nauru', 'NRU', 520, 674, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(149, 'NP', 'NEPAL', 'Nepal', 'NPL', 524, 977, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(150, 'NL', 'NETHERLANDS', 'Netherlands', 'NLD', 528, 31, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(151, 'AN', 'NETHERLANDS ANTILLES', 'Netherlands Antilles', 'ANT', 530, 599, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(152, 'NC', 'NEW CALEDONIA', 'New Caledonia', 'NCL', 540, 687, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(153, 'NZ', 'NEW ZEALAND', 'New Zealand', 'NZL', 554, 64, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(154, 'NI', 'NICARAGUA', 'Nicaragua', 'NIC', 558, 505, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(155, 'NE', 'NIGER', 'Niger', 'NER', 562, 227, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(156, 'NG', 'NIGERIA', 'Nigeria', 'NGA', 566, 234, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(157, 'NU', 'NIUE', 'Niue', 'NIU', 570, 683, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(158, 'NF', 'NORFOLK ISLAND', 'Norfolk Island', 'NFK', 574, 672, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(159, 'MP', 'NORTHERN MARIANA ISLANDS', 'Northern Mariana Islands', 'MNP', 580, 1670, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(160, 'NO', 'NORWAY', 'Norway', 'NOR', 578, 47, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(161, 'OM', 'OMAN', 'Oman', 'OMN', 512, 968, '2016-12-13 06:19:42', '2016-12-13 06:19:42'),
	(162, 'PK', 'PAKISTAN', 'Pakistan', 'PAK', 586, 92, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(163, 'PW', 'PALAU', 'Palau', 'PLW', 585, 680, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(164, 'PS', 'PALESTINIAN TERRITORY, OCCUPIED', 'Palestinian Territory, Occupied', 'NUL', 0, 970, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(165, 'PA', 'PANAMA', 'Panama', 'PAN', 591, 507, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(166, 'PG', 'PAPUA NEW GUINEA', 'Papua New Guinea', 'PNG', 598, 675, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(167, 'PY', 'PARAGUAY', 'Paraguay', 'PRY', 600, 595, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(168, 'PE', 'PERU', 'Peru', 'PER', 604, 51, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(169, 'PH', 'PHILIPPINES', 'Philippines', 'PHL', 608, 63, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(170, 'PN', 'PITCAIRN', 'Pitcairn', 'PCN', 612, 0, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(171, 'PL', 'POLAND', 'Poland', 'POL', 616, 48, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(172, 'PT', 'PORTUGAL', 'Portugal', 'PRT', 620, 351, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(173, 'PR', 'PUERTO RICO', 'Puerto Rico', 'PRI', 630, 1787, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(174, 'QA', 'QATAR', 'Qatar', 'QAT', 634, 974, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(175, 'RE', 'REUNION', 'Reunion', 'REU', 638, 262, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(176, 'RO', 'ROMANIA', 'Romania', 'ROM', 642, 40, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(177, 'RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS', 643, 70, '2016-12-13 06:19:43', '2016-12-13 06:19:43'),
	(178, 'RW', 'RWANDA', 'Rwanda', 'RWA', 646, 250, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(179, 'SH', 'SAINT HELENA', 'Saint Helena', 'SHN', 654, 290, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(180, 'KN', 'SAINT KITTS AND NEVIS', 'Saint Kitts and Nevis', 'KNA', 659, 1869, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(181, 'LC', 'SAINT LUCIA', 'Saint Lucia', 'LCA', 662, 1758, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(182, 'PM', 'SAINT PIERRE AND MIQUELON', 'Saint Pierre and Miquelon', 'SPM', 666, 508, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(183, 'VC', 'SAINT VINCENT AND THE GRENADINES', 'Saint Vincent and the Grenadines', 'VCT', 670, 1784, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(184, 'WS', 'SAMOA', 'Samoa', 'WSM', 882, 684, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(185, 'SM', 'SAN MARINO', 'San Marino', 'SMR', 674, 378, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(186, 'ST', 'SAO TOME AND PRINCIPE', 'Sao Tome and Principe', 'STP', 678, 239, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(187, 'SA', 'SAUDI ARABIA', 'Saudi Arabia', 'SAU', 682, 966, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(188, 'SN', 'SENEGAL', 'Senegal', 'SEN', 686, 221, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(189, 'CS', 'SERBIA AND MONTENEGRO', 'Serbia and Montenegro', 'NUL', 0, 381, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(190, 'SC', 'SEYCHELLES', 'Seychelles', 'SYC', 690, 248, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(191, 'SL', 'SIERRA LEONE', 'Sierra Leone', 'SLE', 694, 232, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(192, 'SG', 'SINGAPORE', 'Singapore', 'SGP', 702, 65, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(193, 'SK', 'SLOVAKIA', 'Slovakia', 'SVK', 703, 421, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(194, 'SI', 'SLOVENIA', 'Slovenia', 'SVN', 705, 386, '2016-12-13 06:19:44', '2016-12-13 06:19:44'),
	(195, 'SB', 'SOLOMON ISLANDS', 'Solomon Islands', 'SLB', 90, 677, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(196, 'SO', 'SOMALIA', 'Somalia', 'SOM', 706, 252, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(197, 'ZA', 'SOUTH AFRICA', 'South Africa', 'ZAF', 710, 27, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(198, 'GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'South Georgia and the South Sandwich Islands', 'NUL', 0, 0, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(199, 'ES', 'SPAIN', 'Spain', 'ESP', 724, 34, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(200, 'LK', 'SRI LANKA', 'Sri Lanka', 'LKA', 144, 94, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(201, 'SD', 'SUDAN', 'Sudan', 'SDN', 736, 249, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(202, 'SR', 'SURINAME', 'Suriname', 'SUR', 740, 597, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(203, 'SJ', 'SVALBARD AND JAN MAYEN', 'Svalbard and Jan Mayen', 'SJM', 744, 47, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(204, 'SZ', 'SWAZILAND', 'Swaziland', 'SWZ', 748, 268, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(205, 'SE', 'SWEDEN', 'Sweden', 'SWE', 752, 46, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(206, 'CH', 'SWITZERLAND', 'Switzerland', 'CHE', 756, 41, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(207, 'SY', 'SYRIAN ARAB REPUBLIC', 'Syrian Arab Republic', 'SYR', 760, 963, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(208, 'TW', 'TAIWAN, PROVINCE OF CHINA', 'Taiwan, Province of China', 'TWN', 158, 886, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(209, 'TJ', 'TAJIKISTAN', 'Tajikistan', 'TJK', 762, 992, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(210, 'TZ', 'TANZANIA, UNITED REPUBLIC OF', 'Tanzania, United Republic of', 'TZA', 834, 255, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(211, 'TH', 'THAILAND', 'Thailand', 'THA', 764, 66, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(212, 'TL', 'TIMOR-LESTE', 'Timor-Leste', 'NUL', 0, 670, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(213, 'TG', 'TOGO', 'Togo', 'TGO', 768, 228, '2016-12-13 06:19:45', '2016-12-13 06:19:45'),
	(214, 'TK', 'TOKELAU', 'Tokelau', 'TKL', 772, 690, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(215, 'TO', 'TONGA', 'Tonga', 'TON', 776, 676, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(216, 'TT', 'TRINIDAD AND TOBAGO', 'Trinidad and Tobago', 'TTO', 780, 1868, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(217, 'TN', 'TUNISIA', 'Tunisia', 'TUN', 788, 216, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(218, 'TR', 'TURKEY', 'Turkey', 'TUR', 792, 90, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(219, 'TM', 'TURKMENISTAN', 'Turkmenistan', 'TKM', 795, 7370, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(220, 'TC', 'TURKS AND CAICOS ISLANDS', 'Turks and Caicos Islands', 'TCA', 796, 1649, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(221, 'TV', 'TUVALU', 'Tuvalu', 'TUV', 798, 688, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(222, 'UG', 'UGANDA', 'Uganda', 'UGA', 800, 256, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(223, 'UA', 'UKRAINE', 'Ukraine', 'UKR', 804, 380, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(224, 'AE', 'UNITED ARAB EMIRATES', 'United Arab Emirates', 'ARE', 784, 971, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(225, 'GB', 'UNITED KINGDOM', 'United Kingdom', 'GBR', 826, 44, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(226, 'US', 'UNITED STATES', 'United States', 'USA', 840, 1, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(227, 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS', 'United States Minor Outlying Islands', 'NUL', 0, 1, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(228, 'UY', 'URUGUAY', 'Uruguay', 'URY', 858, 598, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(229, 'UZ', 'UZBEKISTAN', 'Uzbekistan', 'UZB', 860, 998, '2016-12-13 06:19:46', '2016-12-13 06:19:46'),
	(230, 'VU', 'VANUATU', 'Vanuatu', 'VUT', 548, 678, '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(231, 'VE', 'VENEZUELA', 'Venezuela', 'VEN', 862, 58, '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(232, 'VN', 'VIET NAM', 'Viet Nam', 'VNM', 704, 84, '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(233, 'VG', 'VIRGIN ISLANDS, BRITISH', 'Virgin Islands, British', 'VGB', 92, 1284, '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(234, 'VI', 'VIRGIN ISLANDS, U.S.', 'Virgin Islands, U.s.', 'VIR', 850, 1340, '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(235, 'WF', 'WALLIS AND FUTUNA', 'Wallis and Futuna', 'WLF', 876, 681, '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(236, 'EH', 'WESTERN SAHARA', 'Western Sahara', 'ESH', 732, 212, '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(237, 'YE', 'YEMEN', 'Yemen', 'YEM', 887, 967, '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(238, 'ZM', 'ZAMBIA', 'Zambia', 'ZMB', 894, 260, '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(239, 'ZW', 'ZIMBABWE', 'Zimbabwe', 'ZWE', 716, 263, '2016-12-13 06:19:47', '2016-12-13 06:19:47');
/*!40000 ALTER TABLE `country_code` ENABLE KEYS */;

-- Dumping structure for table rt_oris.customers
DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `client_no` varchar(45) DEFAULT NULL,
  `account_no` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table rt_oris.customers: ~0 rows (approximately)
DELETE FROM `customers`;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;

-- Dumping structure for table rt_oris.customer_types
DROP TABLE IF EXISTS `customer_types`;
CREATE TABLE IF NOT EXISTS `customer_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.customer_types: ~0 rows (approximately)
DELETE FROM `customer_types`;
/*!40000 ALTER TABLE `customer_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_types` ENABLE KEYS */;

-- Dumping structure for table rt_oris.departments
DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.departments: ~0 rows (approximately)
DELETE FROM `departments`;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Management', '2025-04-11 06:20:13', '2025-04-11 06:20:19'),
	(2, 'Customer Care', '2025-04-11 06:20:14', '2025-04-11 06:20:14'),
	(3, 'Technical Support', '2025-04-11 06:20:37', '2025-04-11 06:20:38');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;

-- Dumping structure for table rt_oris.emails
DROP TABLE IF EXISTS `emails`;
CREATE TABLE IF NOT EXISTS `emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `department` int(10) unsigned DEFAULT NULL,
  `priority` int(10) unsigned DEFAULT NULL,
  `help_topic` int(10) unsigned DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fetching_host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fetching_port` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fetching_protocol` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fetching_encryption` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mailbox_protocol` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `imap_config` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `folder` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sending_host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sending_port` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sending_protocol` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sending_encryption` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `smtp_validate` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `smtp_authentication` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `internal_notes` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auto_response` tinyint(1) NOT NULL,
  `fetching_status` tinyint(1) NOT NULL,
  `move_to_folder` tinyint(1) NOT NULL,
  `delete_email` tinyint(1) NOT NULL,
  `do_nothing` tinyint(1) NOT NULL,
  `sending_status` tinyint(1) NOT NULL,
  `authentication` tinyint(1) NOT NULL,
  `header_spoofing` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `department` (`department`,`priority`,`help_topic`),
  KEY `department_2` (`department`,`priority`,`help_topic`),
  KEY `priority` (`priority`),
  KEY `help_topic` (`help_topic`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.emails: ~0 rows (approximately)
DELETE FROM `emails`;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
INSERT INTO `emails` (`id`, `email_address`, `email_name`, `department`, `priority`, `help_topic`, `user_name`, `password`, `fetching_host`, `fetching_port`, `fetching_protocol`, `fetching_encryption`, `mailbox_protocol`, `imap_config`, `folder`, `sending_host`, `sending_port`, `sending_protocol`, `sending_encryption`, `smtp_validate`, `smtp_authentication`, `internal_notes`, `auto_response`, `fetching_status`, `move_to_folder`, `delete_email`, `do_nothing`, `sending_status`, `authentication`, `header_spoofing`, `created_at`, `updated_at`) VALUES
	(1, 'info@nezasoft.net', 'Nezasoft Email', 1, 3, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL),
	(2, 'support@nezasoft.net', 'Technical Support', 3, 1, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL),
	(3, 'customer_care@nezasoft.net', 'Customer Care', 2, 2, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL);
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;

-- Dumping structure for table rt_oris.event_types
DROP TABLE IF EXISTS `event_types`;
CREATE TABLE IF NOT EXISTS `event_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.event_types: ~0 rows (approximately)
DELETE FROM `event_types`;
/*!40000 ALTER TABLE `event_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_types` ENABLE KEYS */;

-- Dumping structure for table rt_oris.failed_jobs
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.failed_jobs: ~0 rows (approximately)
DELETE FROM `failed_jobs`;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Dumping structure for table rt_oris.jobs
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.jobs: ~0 rows (approximately)
DELETE FROM `jobs`;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table rt_oris.job_batches
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.job_batches: ~0 rows (approximately)
DELETE FROM `job_batches`;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;

-- Dumping structure for table rt_oris.mailbox_protocol
DROP TABLE IF EXISTS `mailbox_protocol`;
CREATE TABLE IF NOT EXISTS `mailbox_protocol` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.mailbox_protocol: ~4 rows (approximately)
DELETE FROM `mailbox_protocol`;
/*!40000 ALTER TABLE `mailbox_protocol` DISABLE KEYS */;
INSERT INTO `mailbox_protocol` (`id`, `name`, `value`) VALUES
	(1, 'IMAP', '/imap'),
	(2, 'IMAP+SSL', '/imap/ssl'),
	(3, 'IMAP+TLS', '/imap/tls'),
	(4, 'IMAP+SSL/No-validate', '/imap/ssl/novalidate-cert');
/*!40000 ALTER TABLE `mailbox_protocol` ENABLE KEYS */;

-- Dumping structure for table rt_oris.mail_services
DROP TABLE IF EXISTS `mail_services`;
CREATE TABLE IF NOT EXISTS `mail_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.mail_services: ~6 rows (approximately)
DELETE FROM `mail_services`;
/*!40000 ALTER TABLE `mail_services` DISABLE KEYS */;
INSERT INTO `mail_services` (`id`, `name`, `short_name`, `created_at`, `updated_at`) VALUES
	(1, 'SMTP', 'smtp', '2016-12-13 06:19:08', '2016-12-13 06:19:08'),
	(2, 'Php Mail', 'mail', '2016-12-13 06:19:08', '2016-12-13 06:19:08'),
	(3, 'Send Mail', 'sendmail', '2016-12-13 06:19:08', '2016-12-13 06:19:08'),
	(4, 'Mailgun', 'mailgun', '2016-12-13 06:19:08', '2016-12-13 06:19:08'),
	(5, 'Mandrill', 'mandrill', '2016-12-13 06:19:09', '2016-12-13 06:19:09'),
	(6, 'Log file', 'log', '2016-12-13 06:19:09', '2016-12-13 06:19:09');
/*!40000 ALTER TABLE `mail_services` ENABLE KEYS */;

-- Dumping structure for table rt_oris.migrations
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.migrations: ~20 rows (approximately)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2025_04_09_172749_create_attachments_table', 1),
	(5, '2025_04_09_172930_create_auth_users_table', 1),
	(6, '2025_04_09_173023_create_channels_table', 1),
	(7, '2025_04_09_173101_create_channel_contacts_table', 1),
	(8, '2025_04_09_173211_create_customer_types_table', 1),
	(9, '2025_04_09_173301_create_departments_table', 1),
	(10, '2025_04_09_173400_create_event_types_table', 1),
	(11, '2025_04_09_173447_create_priorities_table', 1),
	(12, '2025_04_09_173539_create_roles_table', 1),
	(13, '2025_04_09_173611_create_sla_events_table', 1),
	(14, '2025_04_09_173659_create_sla_policies_table', 1),
	(15, '2025_04_09_173752_create_sla_rules_table', 1),
	(16, '2025_04_09_174012_create_statuses_table', 1),
	(17, '2025_04_09_174048_create_tickets_table', 1),
	(18, '2025_04_09_174150_create_ticket_assignments_table', 1),
	(19, '2025_04_09_174226_create_ticket_replies_table', 1),
	(20, '2025_04_09_174255_create_ticket_types_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table rt_oris.notifications
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.notifications: ~0 rows (approximately)
DELETE FROM `notifications`;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Dumping structure for table rt_oris.notification_types
DROP TABLE IF EXISTS `notification_types`;
CREATE TABLE IF NOT EXISTS `notification_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `icon_class` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.notification_types: ~3 rows (approximately)
DELETE FROM `notification_types`;
/*!40000 ALTER TABLE `notification_types` DISABLE KEYS */;
INSERT INTO `notification_types` (`id`, `message`, `type`, `icon_class`, `created_at`, `updated_at`) VALUES
	(1, 'A new user is registered', 'registration', 'fa fa-user', '2016-12-13 06:19:14', '2016-12-13 06:19:14'),
	(2, 'You have a new reply on this ticket', 'reply', 'fa fa-envelope', '2016-12-13 06:19:14', '2016-12-13 06:19:14'),
	(3, 'A new ticket has been created', 'new_ticket', 'fa fa-envelope', '2016-12-13 06:19:14', '2016-12-13 06:19:14');
/*!40000 ALTER TABLE `notification_types` ENABLE KEYS */;

-- Dumping structure for table rt_oris.password_reset_tokens
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.password_reset_tokens: ~0 rows (approximately)
DELETE FROM `password_reset_tokens`;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;

-- Dumping structure for table rt_oris.priorities
DROP TABLE IF EXISTS `priorities`;
CREATE TABLE IF NOT EXISTS `priorities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.priorities: ~3 rows (approximately)
DELETE FROM `priorities`;
/*!40000 ALTER TABLE `priorities` DISABLE KEYS */;
INSERT INTO `priorities` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'High', '2025-04-10 22:19:26', '2025-04-10 22:19:27'),
	(2, 'Low', '2025-04-10 22:19:37', '2025-04-10 22:19:38'),
	(3, 'Medium', '2025-04-10 22:20:08', '2025-04-10 22:20:06');
/*!40000 ALTER TABLE `priorities` ENABLE KEYS */;

-- Dumping structure for table rt_oris.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.roles: ~0 rows (approximately)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table rt_oris.sessions
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.sessions: ~0 rows (approximately)
DELETE FROM `sessions`;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;

-- Dumping structure for table rt_oris.sla_events
DROP TABLE IF EXISTS `sla_events`;
CREATE TABLE IF NOT EXISTS `sla_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `event_type_id` int(10) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `due_date` datetime DEFAULT NULL,
  `met_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.sla_events: ~0 rows (approximately)
DELETE FROM `sla_events`;
/*!40000 ALTER TABLE `sla_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `sla_events` ENABLE KEYS */;

-- Dumping structure for table rt_oris.sla_policies
DROP TABLE IF EXISTS `sla_policies`;
CREATE TABLE IF NOT EXISTS `sla_policies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `response_time_min` int(11) DEFAULT NULL,
  `resolve_time_min` int(11) DEFAULT NULL,
  `is_default` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.sla_policies: ~0 rows (approximately)
DELETE FROM `sla_policies`;
/*!40000 ALTER TABLE `sla_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `sla_policies` ENABLE KEYS */;

-- Dumping structure for table rt_oris.sla_rules
DROP TABLE IF EXISTS `sla_rules`;
CREATE TABLE IF NOT EXISTS `sla_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sla_policy_id` int(10) unsigned NOT NULL,
  `customer_type_id` int(10) unsigned NOT NULL,
  `priority_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.sla_rules: ~0 rows (approximately)
DELETE FROM `sla_rules`;
/*!40000 ALTER TABLE `sla_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `sla_rules` ENABLE KEYS */;

-- Dumping structure for table rt_oris.statuses
DROP TABLE IF EXISTS `statuses`;
CREATE TABLE IF NOT EXISTS `statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.statuses: ~4 rows (approximately)
DELETE FROM `statuses`;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;
INSERT INTO `statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'New', '2025-04-10 22:20:16', '2025-04-10 22:20:18'),
	(2, 'Resolved', '2025-04-10 22:20:49', '2025-04-10 22:20:54'),
	(3, 'Pending', '2025-04-10 22:20:50', '2025-04-10 22:20:53'),
	(4, 'Archived', '2025-04-10 22:20:51', '2025-04-10 22:20:52');
/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;

-- Dumping structure for table rt_oris.templates
DROP TABLE IF EXISTS `templates`;
CREATE TABLE IF NOT EXISTS `templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `variable` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `set_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.templates: ~14 rows (approximately)
DELETE FROM `templates`;
/*!40000 ALTER TABLE `templates` DISABLE KEYS */;
INSERT INTO `templates` (`id`, `name`, `variable`, `type`, `subject`, `message`, `description`, `set_id`, `created_at`, `updated_at`) VALUES
	(1, 'This template is for sending notice to agent when ticket is assigned to them', '0', 1, '', '<div>Hello {!!$ticket_agent_name!!},<br /><br /><b>Ticket No:</b> {!!$ticket_number!!}<br />Has been assigned to you by {!!$ticket_assigner!!} <br /> Please check and resppond on the ticket.<br /> Link: {!!$ticket_link!!}<br /><br />Thank You<br />Kind Regards,<br /> {!!$system_from!!}</div>', '', 1, '2016-12-13 06:19:50', '2016-12-13 06:19:50'),
	(2, 'This template is for sending notice to client with ticket link to check ticket without logging in to system', '1', 2, 'Check your Ticket', '<div>Hello {!!$user!!},<br /><br />Click the link below to view your requested ticket<br /> {!!$ticket_link_with_number!!}<br /><br />Kind Regards,<br /> {!!$system_from!!}</div>', '', 1, '2016-12-13 06:19:50', '2016-12-13 06:19:50'),
	(3, 'This template is for sending notice to client when ticket status is changed to close', '0', 3, '', '<div>Hello,<br /><br />This message is regarding your ticket ID {!!$ticket_number!!}. We are changing the status of this ticket to "Closed" as the issue appears to be resolved.<br /><br />Thank you<br />Kind regards,<br /> {!!$system_from!!}</div>', '', 1, '2016-12-13 06:19:50', '2016-12-13 06:19:50'),
	(4, 'This template is for sending notice to client on successful ticket creation', '0', 4, '', '<div><span>Hello {!!$user!!}<br /><br /></span><span>Thank you for contacting us. This is an automated response confirming the receipt of your ticket. Our team will get back to you as soon as possible. When replying, please make sure that the ticket ID is kept in the subject so that we can track your replies.<br /><br /></span><span><b>Ticket ID:</b> {!!$ticket_number!!} <br /><br /></span><span> {!!$department_sign!!}<br /></span>You can check the status of or update this ticket online at: {!!$system_link!!}</div>', '', 1, '2016-12-13 06:19:51', '2016-12-13 06:19:51'),
	(5, 'This template is for sending notice to agent on new ticket creation', '0', 5, '', '<div>Hello {!!$ticket_agent_name!!},<br /><br />New ticket {!!$ticket_number!!}created <br /><br /><b>From</b><br /><b>Name:</b> {!!$ticket_client_name!!}   <br /><b>E-mail:</b> {!!$ticket_client_email!!}<br /><br /> {!!$content!!}<br /><br />Kind Regards,<br /> {!!$system_from!!}</div>', '', 1, '2016-12-13 06:19:51', '2016-12-13 06:19:51'),
	(6, 'This template is for sending notice to client on new ticket created by agent in name of client', '0', 6, '', '<div> {!!$content!!}<br /><br /> {!!$agent_sign!!}<br /><br />You can check the status of or update this ticket online at: {!!$system_link!!}</div>', '', 1, '2016-12-13 06:19:51', '2016-12-13 06:19:51'),
	(7, 'This template is for sending notice to client on new registration during new ticket creation for un registered clients', '1', 7, 'Registration Confirmation', '<p>Hello {!!$user!!}, </p><p>This email is confirmation that you are now registered at our helpdesk.</p><p><b>Registered Email:</b> {!!$email_address!!}</p><p><b>Password:</b> {!!$user_password!!}</p><p>You can visit the helpdesk to browse articles and contact us at any time: {!!$system_link!!}</p><p>Thank You.</p><p>Kind Regards,</p><p> {!!$system_from!!} </p>', '', 1, '2016-12-13 06:19:51', '2016-12-13 06:19:51'),
	(8, 'This template is for sending notice to any user about reset password option', '1', 8, 'Reset your Password', 'Hello {!!$user!!},<br /><br />You asked to reset your password. To do so, please click this link:<br /><br /> {!!$password_reset_link!!}<br /><br />This will let you change your password to something new. If you didn\'t ask for this, don\'t worry, we\'ll keep your password safe.<br /><br />Thank You.<br /><br />Kind Regards,<br /> {!!$system_from!!}', '', 1, '2016-12-13 06:19:51', '2016-12-13 06:19:51'),
	(9, 'This template is for sending notice to client when a reply made to his/her ticket', '0', 9, '', '<span></span><div><span></span><p> {!!$content!!}<br /></p><p> {!!$agent_sign!!} </p><p><b>Ticket Details</b></p><p><b>Ticket ID:</b> {!!$ticket_number!!}</p></div>', '', 1, '2016-12-13 06:19:51', '2016-12-13 06:19:51'),
	(10, 'This template is for sending notice to agent when ticket reply is made by client on a ticket', '0', 10, '', '<div>Hello {!!$ticket_agent_name!!},<br /><b><br /></b>A reply been made to ticket {!!$ticket_number!!}<br /><b><br /></b><b>From<br /></b><b>Name: </b>{!!$ticket_client_name!!}<br /><b>E-mail: </b>{!!$ticket_client_email!!}<br /><b><br /></b> {!!$content!!}<br /><b><br /></b>Kind Regards,<br /> {!!$system_from!!}</div>', '', 1, '2016-12-13 06:19:51', '2016-12-13 06:19:51'),
	(11, 'This template is for sending notice to client about registration confirmation link', '1', 11, 'Verify your email address', '<p>Hello {!!$user!!}, </p><p>This email is confirmation that you are now registered at our helpdesk.</p><p><b>Registered Email:</b> {!!$email_address!!}</p><p>Please click on the below link to activate your account and Login to the system {!!$password_reset_link!!}</p><p>Thank You.</p><p>Kind Regards,</p><p> {!!$system_from!!} </p>', '', 1, '2016-12-13 06:19:52', '2016-12-13 06:19:52'),
	(12, 'This template is for sending notice to team when ticket is assigned to team', '1', 12, '', '<div>Hello {!!$ticket_agent_name!!},<br /><br /><b>Ticket No:</b> {!!$ticket_number!!}<br />Has been assigned to your team : {!!$team!!} by {!!$ticket_assigner!!} <br /><br />Thank You<br />Kind Regards,<br />{!!$system_from!!}</div>', '', 1, '2016-12-13 06:19:52', '2016-12-13 06:19:52'),
	(13, 'This template is for sending notice to client when password is changed', '1', 13, 'Verify your email address', 'Hello {!!$user!!},<br /><br />Your password is successfully changed.Your new password is : {!!$user_password!!}<br /><br />Thank You.<br /><br />Kind Regards,<br /> {!!$system_from!!}', '', 1, '2016-12-13 06:19:52', '2016-12-13 06:19:52'),
	(14, 'This template is to notify users when their tickets are merged.', '1', 14, 'Your tickets have been merged.', '<p>Hello {!!$user!!},<br />&nbsp;</p><p>Your ticket(s) with ticket number {!!$merged_ticket_numbers!!} have been closed and&nbsp;merged with <a href="{!!$ticket_link!!}">{!!$ticket_number!!}</a>.&nbsp;</p><p>Possible reasons for merging tickets</p><ul><li>Tickets are duplicate</li<li>Tickets state&nbsp;the same issue</li><li>Another member from your organization has created a ticket for the same issue</li></ul><p><a href="{!!$system_link!!}">Click here</a> to login to your account and check your tickets.</p><p>Regards,</p><p>{!!$system_from!!}</p>', '', 1, '2017-01-02 03:20:12', '2017-01-02 03:31:50');
/*!40000 ALTER TABLE `templates` ENABLE KEYS */;

-- Dumping structure for table rt_oris.template_types
DROP TABLE IF EXISTS `template_types`;
CREATE TABLE IF NOT EXISTS `template_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.template_types: ~14 rows (approximately)
DELETE FROM `template_types`;
/*!40000 ALTER TABLE `template_types` DISABLE KEYS */;
INSERT INTO `template_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'assign-ticket', '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(2, 'check-ticket', '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(3, 'close-ticket', '2016-12-13 06:19:47', '2016-12-13 06:19:47'),
	(4, 'create-ticket', '2016-12-13 06:19:48', '2016-12-13 06:19:48'),
	(5, 'create-ticket-agent', '2016-12-13 06:19:48', '2016-12-13 06:19:48'),
	(6, 'create-ticket-by-agent', '2016-12-13 06:19:48', '2016-12-13 06:19:48'),
	(7, 'registration-notification', '2016-12-13 06:19:48', '2016-12-13 06:19:48'),
	(8, 'reset-password', '2016-12-13 06:19:48', '2016-12-13 06:19:48'),
	(9, 'ticket-reply', '2016-12-13 06:19:48', '2016-12-13 06:19:48'),
	(10, 'ticket-reply-agent', '2016-12-13 06:19:48', '2016-12-13 06:19:48'),
	(11, 'registration', '2016-12-13 06:19:48', '2016-12-13 06:19:48'),
	(12, 'team_assign_ticket', '2016-12-13 06:19:48', '2016-12-13 06:19:48'),
	(13, 'reset_new_password', '2016-12-13 06:19:48', '2016-12-13 06:19:48'),
	(14, 'merge-ticket-notification', '2017-01-02 03:20:11', '2017-01-02 03:20:11');
/*!40000 ALTER TABLE `template_types` ENABLE KEYS */;

-- Dumping structure for table rt_oris.tickets
DROP TABLE IF EXISTS `tickets`;
CREATE TABLE IF NOT EXISTS `tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_no` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `priority_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `subject` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_response_at` datetime DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.tickets: ~0 rows (approximately)
DELETE FROM `tickets`;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;

-- Dumping structure for table rt_oris.ticket_assignments
DROP TABLE IF EXISTS `ticket_assignments`;
CREATE TABLE IF NOT EXISTS `ticket_assignments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.ticket_assignments: ~0 rows (approximately)
DELETE FROM `ticket_assignments`;
/*!40000 ALTER TABLE `ticket_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_assignments` ENABLE KEYS */;

-- Dumping structure for table rt_oris.ticket_replies
DROP TABLE IF EXISTS `ticket_replies`;
CREATE TABLE IF NOT EXISTS `ticket_replies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `reply_message` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.ticket_replies: ~0 rows (approximately)
DELETE FROM `ticket_replies`;
/*!40000 ALTER TABLE `ticket_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_replies` ENABLE KEYS */;

-- Dumping structure for table rt_oris.ticket_types
DROP TABLE IF EXISTS `ticket_types`;
CREATE TABLE IF NOT EXISTS `ticket_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.ticket_types: ~2 rows (approximately)
DELETE FROM `ticket_types`;
/*!40000 ALTER TABLE `ticket_types` DISABLE KEYS */;
INSERT INTO `ticket_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Customer', '2025-04-10 22:23:12', '2025-04-10 22:23:11'),
	(2, 'Guest', '2025-04-10 22:23:23', '2025-04-10 22:23:24');
/*!40000 ALTER TABLE `ticket_types` ENABLE KEYS */;

-- Dumping structure for table rt_oris.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.users: ~0 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
