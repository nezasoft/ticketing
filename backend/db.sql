-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.4.5-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for rt_oris
DROP DATABASE IF EXISTS `rt_oris`;
CREATE DATABASE IF NOT EXISTS `rt_oris` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `rt_oris`;

-- Dumping structure for table rt_oris.api_settings
DROP TABLE IF EXISTS `api_settings`;
CREATE TABLE IF NOT EXISTS `api_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.api_settings: ~0 rows (approximately)
DELETE FROM `api_settings`;

-- Dumping structure for table rt_oris.attachments
DROP TABLE IF EXISTS `attachments`;
CREATE TABLE IF NOT EXISTS `attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `file_name` varchar(200) DEFAULT NULL,
  `file_path` varchar(200) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `mime_type` varchar(50) DEFAULT NULL,
  `thread_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.attachments: ~6 rows (approximately)
DELETE FROM `attachments`;
INSERT INTO `attachments` (`id`, `ticket_id`, `user_id`, `file_name`, `file_path`, `created_at`, `updated_at`, `file_size`, `mime_type`, `thread_id`) VALUES
	(1, 6, 1, 'Rain Telecoms Invoice.pdf', 'attachments/kXc6PAAt5GDzsxBXaVRCCobssncUJ1b1krCK0ht2.pdf', '2025-07-03 02:00:12', '2025-07-03 02:00:12', 242689, 'application/pdf', 13),
	(2, 2, 1, 'Kenya-Gazette-Vol-CXXVIINo-15-1-1-36-2-1.pdf', 'attachments/Y8JzUqlYp24sWwZDCXhjKwU2W7igBzuwfc7B7bp0.pdf', '2025-07-03 12:52:56', '2025-07-03 12:52:56', 442863, 'application/pdf', 14),
	(3, 7, 1, 'Eclectics-Carbon-Offset-Platform- Marketplace-BRD-V1.pdf', 'attachments/I1GRV6tL6cOgdigFOgbqRLTO5KovWPdHfbuXO9HF.pdf', '2025-07-05 08:56:04', '2025-07-05 08:56:04', 940664, 'application/pdf', 17),
	(4, 10, 1, 'Recreated_KRA_P9_Styled_Walter_Omedo_2024.pdf', 'attachments/jNq0siZtdJjhmfZuEtGRqdCnuImDSEQ5JhdFKyTQ.pdf', '2025-07-05 09:54:21', '2025-07-05 09:54:21', 2496, 'application/pdf', 0),
	(5, 20, 1, 'Eclectics-Carbon-Offset-Platform- Marketplace-BRD-V1.pdf', 'attachments/tOFxLtIfQefQmhK2roZsTDIKi8OCfjZIfgz7Fntp.pdf', '2025-07-24 08:41:20', '2025-07-24 08:41:20', 940664, 'application/pdf', 75),
	(6, 21, 1, 'disbursements (1).pdf', 'attachments/9FsH9E0GcDLEnXONL45Kb7uDD6iwdpDdBJhbsg63.pdf', '2025-07-24 08:45:53', '2025-07-24 08:45:53', 2604, 'application/pdf', 0),
	(7, 24, 1, 'SonnarQube Scanner Manual.pdf', 'attachments/rqFc3FkZFtb5qhgb4GgDhQO68o7MAY1Bf3NPHBLw.pdf', '2025-07-26 09:37:23', '2025-07-26 09:37:23', 132240, 'application/pdf', 0);

-- Dumping structure for table rt_oris.auth_users
DROP TABLE IF EXISTS `auth_users`;
CREATE TABLE IF NOT EXISTS `auth_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `password_hash` blob DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `dept_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `change_password` tinyint(1) DEFAULT 1,
  `profile_photo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.auth_users: ~3 rows (approximately)
DELETE FROM `auth_users`;
INSERT INTO `auth_users` (`id`, `name`, `email`, `company_id`, `password_hash`, `phone`, `dept_id`, `role_id`, `status`, `created_at`, `updated_at`, `change_password`, `profile_photo`) VALUES
	(1, 'Walter Adamba', 'wadamba@yahoo.com', 2, _binary 0x24327924313224442f4f784a4162425853557a555842456f504a6c6f2e54767a484f5561566c627239752e735258514a4536506c46592f7a5a344857, '0724802834', 3, 1, 1, '2025-04-13 09:23:03', '2025-05-19 13:15:59', 1, NULL),
	(2, 'John Doe', 'nezasoft@gmail.com', 2, NULL, '0727129606', 3, 2, 1, '2025-04-25 16:25:06', '2025-04-25 16:25:07', 1, NULL),
	(3, 'System', 'admin@nezasoft.net', 0, NULL, NULL, 1, 2, 1, '2025-05-23 13:21:54', '2025-05-23 13:22:02', 1, NULL);

-- Dumping structure for table rt_oris.business_docs
DROP TABLE IF EXISTS `business_docs`;
CREATE TABLE IF NOT EXISTS `business_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `document_name` varchar(45) DEFAULT NULL,
  `document_no` varchar(20) DEFAULT NULL,
  `document_value` int(11) DEFAULT NULL,
  `doc_code` char(2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=COMPACT;

-- Dumping data for table rt_oris.business_docs: ~0 rows (approximately)
DELETE FROM `business_docs`;
INSERT INTO `business_docs` (`id`, `company_id`, `document_name`, `document_no`, `document_value`, `doc_code`, `created_at`, `updated_at`) VALUES
	(34, 1, 'Ticket', '1', 29, 'TK', '2025-04-13 12:21:18', '2025-07-31 02:29:19');

-- Dumping structure for table rt_oris.business_documents
DROP TABLE IF EXISTS `business_documents`;
CREATE TABLE IF NOT EXISTS `business_documents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.business_documents: ~0 rows (approximately)
DELETE FROM `business_documents`;

-- Dumping structure for table rt_oris.cache
DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.cache: ~1 rows (approximately)
DELETE FROM `cache`;
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
	('oris_rt_cache_integration_configs', 'a:7:{s:12:"RT_MAIL_HOST";a:1:{s:5:"value";s:21:"saver.vivawebhost.com";}s:12:"RT_MAIL_PORT";a:1:{s:5:"value";s:3:"465";}s:16:"RT_MAIL_USERNAME";a:1:{s:5:"value";s:17:"demo@nezasoft.net";}s:16:"RT_MAIL_PASSWORD";a:1:{s:5:"value";s:9:"Demo@2015";}s:18:"RT_MAIL_ENCRYPTION";a:1:{s:5:"value";s:3:"ssl";}s:20:"RT_MAIL_FROM_ADDRESS";a:1:{s:5:"value";s:17:"demo@nezasoft.net";}s:17:"RT_MAIL_FROM_NAME";a:1:{s:5:"value";s:24:"Oris RT Ticketing System";}}', 1753943014);

-- Dumping structure for table rt_oris.cache_locks
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.cache_locks: ~0 rows (approximately)
DELETE FROM `cache_locks`;

-- Dumping structure for table rt_oris.channels
DROP TABLE IF EXISTS `channels`;
CREATE TABLE IF NOT EXISTS `channels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.channels: ~7 rows (approximately)
DELETE FROM `channels`;
INSERT INTO `channels` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Portal', '2025-04-13 08:52:46', '2025-04-13 08:52:47'),
	(2, 'Email', '2025-04-13 08:52:45', '2025-04-13 08:52:48'),
	(3, 'Whatsapp', '2025-04-13 08:52:43', '2025-04-13 08:52:48'),
	(4, 'Chatbot', '2025-04-13 08:52:44', '2025-04-13 08:52:49'),
	(5, 'Phone', '2025-04-13 08:52:43', '2025-04-13 08:52:50'),
	(6, 'Twitter', '2025-04-13 08:52:42', '2025-04-13 08:52:51'),
	(7, 'Facebook', '2025-04-13 08:52:41', '2025-04-13 08:52:51');

-- Dumping structure for table rt_oris.channel_contacts
DROP TABLE IF EXISTS `channel_contacts`;
CREATE TABLE IF NOT EXISTS `channel_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int(10) unsigned NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.channel_contacts: ~7 rows (approximately)
DELETE FROM `channel_contacts`;
INSERT INTO `channel_contacts` (`id`, `channel_id`, `email`, `full_name`, `phone`, `company_id`, `created_at`, `updated_at`) VALUES
	(1, 2, 'walter.omedo@gmail.com', NULL, '', 1, '2025-04-25 13:55:27', '2025-07-31 05:31:12'),
	(20, 2, '', NULL, '254724802834', 2, '2025-04-26 11:45:11', '2025-07-31 05:31:12'),
	(21, 1, 'nezasoft@gmail.com', 'Nezasoft Limited', '254727129606', 2, '2025-07-26 09:37:23', '2025-07-31 05:31:11'),
	(22, 1, 'omedo.walter@eclectics.io', 'James Madisson', '', 2, '2025-07-30 10:43:53', '2025-07-30 10:43:53'),
	(23, 2, 'walter.omedo@gmail.com', 'Walter Omedo', '', 2, '2025-07-31 05:31:08', '2025-07-31 05:31:10'),
	(24, 1, 'gozepalan@mailinator.com', 'Yetta Benson', '', 2, '2025-07-31 02:23:34', '2025-07-31 02:23:34'),
	(25, 1, 'pidojy@mailinator.com', 'Donna Hanson', '', 2, '2025-07-31 02:29:19', '2025-07-31 02:29:19');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.companies: ~0 rows (approximately)
DELETE FROM `companies`;
INSERT INTO `companies` (`id`, `name`, `website`, `email`, `phy_add`, `phone`, `client_no`, `company_logo`, `active`, `days`) VALUES
	(2, 'Nezasoft Technologies', 'www.nezasoft.net', 'info@nezasoft.net', 'Westlands Nairobi', '0727129606', NULL, NULL, 1, 0);

-- Dumping structure for table rt_oris.country_codes
DROP TABLE IF EXISTS `country_codes`;
CREATE TABLE IF NOT EXISTS `country_codes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iso` char(2) NOT NULL,
  `name` varchar(100) NOT NULL,
  `nicename` varchar(100) NOT NULL,
  `iso3` char(3) NOT NULL,
  `numcode` smallint(6) NOT NULL,
  `phonecode` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.country_codes: ~239 rows (approximately)
DELETE FROM `country_codes`;
INSERT INTO `country_codes` (`id`, `iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `created_at`, `updated_at`) VALUES
	(1, 'AF', 'AFGHANISTAN', 'Afghanistan', 'AFG', 4, 93, '2016-12-13 03:19:33', '2016-12-13 03:19:33'),
	(2, 'AL', 'ALBANIA', 'Albania', 'ALB', 8, 355, '2016-12-13 03:19:33', '2016-12-13 03:19:33'),
	(3, 'DZ', 'ALGERIA', 'Algeria', 'DZA', 12, 213, '2016-12-13 03:19:33', '2016-12-13 03:19:33'),
	(4, 'AS', 'AMERICAN SAMOA', 'American Samoa', 'ASM', 16, 1684, '2016-12-13 03:19:33', '2016-12-13 03:19:33'),
	(5, 'AD', 'ANDORRA', 'Andorra', 'AND', 20, 376, '2016-12-13 03:19:33', '2016-12-13 03:19:33'),
	(6, 'AO', 'ANGOLA', 'Angola', 'AGO', 24, 244, '2016-12-13 03:19:33', '2016-12-13 03:19:33'),
	(7, 'AI', 'ANGUILLA', 'Anguilla', 'AIA', 660, 1264, '2016-12-13 03:19:33', '2016-12-13 03:19:33'),
	(8, 'AQ', 'ANTARCTICA', 'Antarctica', 'NUL', 0, 0, '2016-12-13 03:19:33', '2016-12-13 03:19:33'),
	(9, 'AG', 'ANTIGUA AND BARBUDA', 'Antigua and Barbuda', 'ATG', 28, 1268, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(10, 'AR', 'ARGENTINA', 'Argentina', 'ARG', 32, 54, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(11, 'AM', 'ARMENIA', 'Armenia', 'ARM', 51, 374, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(12, 'AW', 'ARUBA', 'Aruba', 'ABW', 533, 297, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(13, 'AU', 'AUSTRALIA', 'Australia', 'AUS', 36, 61, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(14, 'AT', 'AUSTRIA', 'Austria', 'AUT', 40, 43, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(15, 'AZ', 'AZERBAIJAN', 'Azerbaijan', 'AZE', 31, 994, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(16, 'BS', 'BAHAMAS', 'Bahamas', 'BHS', 44, 1242, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(17, 'BH', 'BAHRAIN', 'Bahrain', 'BHR', 48, 973, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(18, 'BD', 'BANGLADESH', 'Bangladesh', 'BGD', 50, 880, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(19, 'BB', 'BARBADOS', 'Barbados', 'BRB', 52, 1246, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(20, 'BY', 'BELARUS', 'Belarus', 'BLR', 112, 375, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(21, 'BE', 'BELGIUM', 'Belgium', 'BEL', 56, 32, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(22, 'BZ', 'BELIZE', 'Belize', 'BLZ', 84, 501, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(23, 'BJ', 'BENIN', 'Benin', 'BEN', 204, 229, '2016-12-13 03:19:34', '2016-12-13 03:19:34'),
	(24, 'BM', 'BERMUDA', 'Bermuda', 'BMU', 60, 1441, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(25, 'BT', 'BHUTAN', 'Bhutan', 'BTN', 64, 975, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(26, 'BO', 'BOLIVIA', 'Bolivia', 'BOL', 68, 591, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(27, 'BA', 'BOSNIA AND HERZEGOVINA', 'Bosnia and Herzegovina', 'BIH', 70, 387, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(28, 'BW', 'BOTSWANA', 'Botswana', 'BWA', 72, 267, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(29, 'BV', 'BOUVET ISLAND', 'Bouvet Island', 'NUL', 0, 0, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(30, 'BR', 'BRAZIL', 'Brazil', 'BRA', 76, 55, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(31, 'IO', 'BRITISH INDIAN OCEAN TERRITORY', 'British Indian Ocean Territory', 'NUL', 0, 246, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(32, 'BN', 'BRUNEI DARUSSALAM', 'Brunei Darussalam', 'BRN', 96, 673, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(33, 'BG', 'BULGARIA', 'Bulgaria', 'BGR', 100, 359, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(34, 'BF', 'BURKINA FASO', 'Burkina Faso', 'BFA', 854, 226, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(35, 'BI', 'BURUNDI', 'Burundi', 'BDI', 108, 257, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(36, 'KH', 'CAMBODIA', 'Cambodia', 'KHM', 116, 855, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(37, 'CM', 'CAMEROON', 'Cameroon', 'CMR', 120, 237, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(38, 'CA', 'CANADA', 'Canada', 'CAN', 124, 1, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(39, 'CV', 'CAPE VERDE', 'Cape Verde', 'CPV', 132, 238, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(40, 'KY', 'CAYMAN ISLANDS', 'Cayman Islands', 'CYM', 136, 1345, '2016-12-13 03:19:35', '2016-12-13 03:19:35'),
	(41, 'CF', 'CENTRAL AFRICAN REPUBLIC', 'Central African Republic', 'CAF', 140, 236, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(42, 'TD', 'CHAD', 'Chad', 'TCD', 148, 235, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(43, 'CL', 'CHILE', 'Chile', 'CHL', 152, 56, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(44, 'CN', 'CHINA', 'China', 'CHN', 156, 86, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(45, 'CX', 'CHRISTMAS ISLAND', 'Christmas Island', 'NUL', 0, 61, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(46, 'CC', 'COCOS (KEELING) ISLANDS', 'Cocos (Keeling) Islands', 'NUL', 0, 672, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(47, 'CO', 'COLOMBIA', 'Colombia', 'COL', 170, 57, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(48, 'KM', 'COMOROS', 'Comoros', 'COM', 174, 269, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(49, 'CG', 'CONGO', 'Congo', 'COG', 178, 242, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(50, 'CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 'Congo, the Democratic Republic of the', 'COD', 180, 242, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(51, 'CK', 'COOK ISLANDS', 'Cook Islands', 'COK', 184, 682, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(52, 'CR', 'COSTA RICA', 'Costa Rica', 'CRI', 188, 506, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(53, 'CI', 'COTE DIVOIRE', 'Cote DIvoire', 'CIV', 384, 225, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(54, 'HR', 'CROATIA', 'Croatia', 'HRV', 191, 385, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(55, 'CU', 'CUBA', 'Cuba', 'CUB', 192, 53, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(56, 'CY', 'CYPRUS', 'Cyprus', 'CYP', 196, 357, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(57, 'CZ', 'CZECH REPUBLIC', 'Czech Republic', 'CZE', 203, 420, '2016-12-13 03:19:36', '2016-12-13 03:19:36'),
	(58, 'DK', 'DENMARK', 'Denmark', 'DNK', 208, 45, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(59, 'DJ', 'DJIBOUTI', 'Djibouti', 'DJI', 262, 253, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(60, 'DM', 'DOMINICA', 'Dominica', 'DMA', 212, 1767, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(61, 'DO', 'DOMINICAN REPUBLIC', 'Dominican Republic', 'DOM', 214, 1809, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(62, 'EC', 'ECUADOR', 'Ecuador', 'ECU', 218, 593, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(63, 'EG', 'EGYPT', 'Egypt', 'EGY', 818, 20, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(64, 'SV', 'EL SALVADOR', 'El Salvador', 'SLV', 222, 503, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(65, 'GQ', 'EQUATORIAL GUINEA', 'Equatorial Guinea', 'GNQ', 226, 240, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(66, 'ER', 'ERITREA', 'Eritrea', 'ERI', 232, 291, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(67, 'EE', 'ESTONIA', 'Estonia', 'EST', 233, 372, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(68, 'ET', 'ETHIOPIA', 'Ethiopia', 'ETH', 231, 251, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(69, 'FK', 'FALKLAND ISLANDS (MALVINAS)', 'Falkland Islands (Malvinas)', 'FLK', 238, 500, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(70, 'FO', 'FAROE ISLANDS', 'Faroe Islands', 'FRO', 234, 298, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(71, 'FJ', 'FIJI', 'Fiji', 'FJI', 242, 679, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(72, 'FI', 'FINLAND', 'Finland', 'FIN', 246, 358, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(73, 'FR', 'FRANCE', 'France', 'FRA', 250, 33, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(74, 'GF', 'FRENCH GUIANA', 'French Guiana', 'GUF', 254, 594, '2016-12-13 03:19:37', '2016-12-13 03:19:37'),
	(75, 'PF', 'FRENCH POLYNESIA', 'French Polynesia', 'PYF', 258, 689, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(76, 'TF', 'FRENCH SOUTHERN TERRITORIES', 'French Southern Territories', 'NUL', 0, 0, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(77, 'GA', 'GABON', 'Gabon', 'GAB', 266, 241, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(78, 'GM', 'GAMBIA', 'Gambia', 'GMB', 270, 220, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(79, 'GE', 'GEORGIA', 'Georgia', 'GEO', 268, 995, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(80, 'DE', 'GERMANY', 'Germany', 'DEU', 276, 49, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(81, 'GH', 'GHANA', 'Ghana', 'GHA', 288, 233, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(82, 'GI', 'GIBRALTAR', 'Gibraltar', 'GIB', 292, 350, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(83, 'GR', 'GREECE', 'Greece', 'GRC', 300, 30, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(84, 'GL', 'GREENLAND', 'Greenland', 'GRL', 304, 299, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(85, 'GD', 'GRENADA', 'Grenada', 'GRD', 308, 1473, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(86, 'GP', 'GUADELOUPE', 'Guadeloupe', 'GLP', 312, 590, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(87, 'GU', 'GUAM', 'Guam', 'GUM', 316, 1671, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(88, 'GT', 'GUATEMALA', 'Guatemala', 'GTM', 320, 502, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(89, 'GN', 'GUINEA', 'Guinea', 'GIN', 324, 224, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(90, 'GW', 'GUINEA-BISSAU', 'Guinea-Bissau', 'GNB', 624, 245, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(91, 'GY', 'GUYANA', 'Guyana', 'GUY', 328, 592, '2016-12-13 03:19:38', '2016-12-13 03:19:38'),
	(92, 'HT', 'HAITI', 'Haiti', 'HTI', 332, 509, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(93, 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS', 'Heard Island and Mcdonald Islands', 'NUL', 0, 0, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(94, 'VA', 'HOLY SEE (VATICAN CITY STATE)', 'Holy See (Vatican City State)', 'VAT', 336, 39, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(95, 'HN', 'HONDURAS', 'Honduras', 'HND', 340, 504, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(96, 'HK', 'HONG KONG', 'Hong Kong', 'HKG', 344, 852, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(97, 'HU', 'HUNGARY', 'Hungary', 'HUN', 348, 36, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(98, 'IS', 'ICELAND', 'Iceland', 'ISL', 352, 354, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(99, 'IN', 'INDIA', 'India', 'IND', 356, 91, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(100, 'ID', 'INDONESIA', 'Indonesia', 'IDN', 360, 62, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(101, 'IR', 'IRAN, ISLAMIC REPUBLIC OF', 'Iran, Islamic Republic of', 'IRN', 364, 98, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(102, 'IQ', 'IRAQ', 'Iraq', 'IRQ', 368, 964, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(103, 'IE', 'IRELAND', 'Ireland', 'IRL', 372, 353, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(104, 'IL', 'ISRAEL', 'Israel', 'ISR', 376, 972, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(105, 'IT', 'ITALY', 'Italy', 'ITA', 380, 39, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(106, 'JM', 'JAMAICA', 'Jamaica', 'JAM', 388, 1876, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(107, 'JP', 'JAPAN', 'Japan', 'JPN', 392, 81, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(108, 'JO', 'JORDAN', 'Jordan', 'JOR', 400, 962, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(109, 'KZ', 'KAZAKHSTAN', 'Kazakhstan', 'KAZ', 398, 7, '2016-12-13 03:19:39', '2016-12-13 03:19:39'),
	(110, 'KE', 'KENYA', 'Kenya', 'KEN', 404, 254, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(111, 'KI', 'KIRIBATI', 'Kiribati', 'KIR', 296, 686, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(112, 'KP', 'KOREA, DEMOCRATIC PEOPLES REPUBLIC OF', 'Korea, Democratic Peoples Republic of', 'PRK', 408, 850, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(113, 'KR', 'KOREA, REPUBLIC OF', 'Korea, Republic of', 'KOR', 410, 82, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(114, 'KW', 'KUWAIT', 'Kuwait', 'KWT', 414, 965, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(115, 'KG', 'KYRGYZSTAN', 'Kyrgyzstan', 'KGZ', 417, 996, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(116, 'LA', 'LAO PEOPLES DEMOCRATIC REPUBLIC', 'Lao Peoples Democratic Republic', 'LAO', 418, 856, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(117, 'LV', 'LATVIA', 'Latvia', 'LVA', 428, 371, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(118, 'LB', 'LEBANON', 'Lebanon', 'LBN', 422, 961, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(119, 'LS', 'LESOTHO', 'Lesotho', 'LSO', 426, 266, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(120, 'LR', 'LIBERIA', 'Liberia', 'LBR', 430, 231, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(121, 'LY', 'LIBYAN ARAB JAMAHIRIYA', 'Libyan Arab Jamahiriya', 'LBY', 434, 218, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(122, 'LI', 'LIECHTENSTEIN', 'Liechtenstein', 'LIE', 438, 423, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(123, 'LT', 'LITHUANIA', 'Lithuania', 'LTU', 440, 370, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(124, 'LU', 'LUXEMBOURG', 'Luxembourg', 'LUX', 442, 352, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(125, 'MO', 'MACAO', 'Macao', 'MAC', 446, 853, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(126, 'MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 'Macedonia, the Former Yugoslav Republic of', 'MKD', 807, 389, '2016-12-13 03:19:40', '2016-12-13 03:19:40'),
	(127, 'MG', 'MADAGASCAR', 'Madagascar', 'MDG', 450, 261, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(128, 'MW', 'MALAWI', 'Malawi', 'MWI', 454, 265, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(129, 'MY', 'MALAYSIA', 'Malaysia', 'MYS', 458, 60, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(130, 'MV', 'MALDIVES', 'Maldives', 'MDV', 462, 960, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(131, 'ML', 'MALI', 'Mali', 'MLI', 466, 223, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(132, 'MT', 'MALTA', 'Malta', 'MLT', 470, 356, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(133, 'MH', 'MARSHALL ISLANDS', 'Marshall Islands', 'MHL', 584, 692, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(134, 'MQ', 'MARTINIQUE', 'Martinique', 'MTQ', 474, 596, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(135, 'MR', 'MAURITANIA', 'Mauritania', 'MRT', 478, 222, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(136, 'MU', 'MAURITIUS', 'Mauritius', 'MUS', 480, 230, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(137, 'YT', 'MAYOTTE', 'Mayotte', 'NUL', 0, 269, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(138, 'MX', 'MEXICO', 'Mexico', 'MEX', 484, 52, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(139, 'FM', 'MICRONESIA, FEDERATED STATES OF', 'Micronesia, Federated States of', 'FSM', 583, 691, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(140, 'MD', 'MOLDOVA, REPUBLIC OF', 'Moldova, Republic of', 'MDA', 498, 373, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(141, 'MC', 'MONACO', 'Monaco', 'MCO', 492, 377, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(142, 'MN', 'MONGOLIA', 'Mongolia', 'MNG', 496, 976, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(143, 'MS', 'MONTSERRAT', 'Montserrat', 'MSR', 500, 1664, '2016-12-13 03:19:41', '2016-12-13 03:19:41'),
	(144, 'MA', 'MOROCCO', 'Morocco', 'MAR', 504, 212, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(145, 'MZ', 'MOZAMBIQUE', 'Mozambique', 'MOZ', 508, 258, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(146, 'MM', 'MYANMAR', 'Myanmar', 'MMR', 104, 95, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(147, 'NA', 'NAMIBIA', 'Namibia', 'NAM', 516, 264, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(148, 'NR', 'NAURU', 'Nauru', 'NRU', 520, 674, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(149, 'NP', 'NEPAL', 'Nepal', 'NPL', 524, 977, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(150, 'NL', 'NETHERLANDS', 'Netherlands', 'NLD', 528, 31, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(151, 'AN', 'NETHERLANDS ANTILLES', 'Netherlands Antilles', 'ANT', 530, 599, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(152, 'NC', 'NEW CALEDONIA', 'New Caledonia', 'NCL', 540, 687, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(153, 'NZ', 'NEW ZEALAND', 'New Zealand', 'NZL', 554, 64, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(154, 'NI', 'NICARAGUA', 'Nicaragua', 'NIC', 558, 505, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(155, 'NE', 'NIGER', 'Niger', 'NER', 562, 227, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(156, 'NG', 'NIGERIA', 'Nigeria', 'NGA', 566, 234, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(157, 'NU', 'NIUE', 'Niue', 'NIU', 570, 683, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(158, 'NF', 'NORFOLK ISLAND', 'Norfolk Island', 'NFK', 574, 672, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(159, 'MP', 'NORTHERN MARIANA ISLANDS', 'Northern Mariana Islands', 'MNP', 580, 1670, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(160, 'NO', 'NORWAY', 'Norway', 'NOR', 578, 47, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(161, 'OM', 'OMAN', 'Oman', 'OMN', 512, 968, '2016-12-13 03:19:42', '2016-12-13 03:19:42'),
	(162, 'PK', 'PAKISTAN', 'Pakistan', 'PAK', 586, 92, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(163, 'PW', 'PALAU', 'Palau', 'PLW', 585, 680, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(164, 'PS', 'PALESTINIAN TERRITORY, OCCUPIED', 'Palestinian Territory, Occupied', 'NUL', 0, 970, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(165, 'PA', 'PANAMA', 'Panama', 'PAN', 591, 507, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(166, 'PG', 'PAPUA NEW GUINEA', 'Papua New Guinea', 'PNG', 598, 675, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(167, 'PY', 'PARAGUAY', 'Paraguay', 'PRY', 600, 595, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(168, 'PE', 'PERU', 'Peru', 'PER', 604, 51, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(169, 'PH', 'PHILIPPINES', 'Philippines', 'PHL', 608, 63, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(170, 'PN', 'PITCAIRN', 'Pitcairn', 'PCN', 612, 0, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(171, 'PL', 'POLAND', 'Poland', 'POL', 616, 48, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(172, 'PT', 'PORTUGAL', 'Portugal', 'PRT', 620, 351, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(173, 'PR', 'PUERTO RICO', 'Puerto Rico', 'PRI', 630, 1787, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(174, 'QA', 'QATAR', 'Qatar', 'QAT', 634, 974, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(175, 'RE', 'REUNION', 'Reunion', 'REU', 638, 262, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(176, 'RO', 'ROMANIA', 'Romania', 'ROM', 642, 40, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(177, 'RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS', 643, 70, '2016-12-13 03:19:43', '2016-12-13 03:19:43'),
	(178, 'RW', 'RWANDA', 'Rwanda', 'RWA', 646, 250, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(179, 'SH', 'SAINT HELENA', 'Saint Helena', 'SHN', 654, 290, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(180, 'KN', 'SAINT KITTS AND NEVIS', 'Saint Kitts and Nevis', 'KNA', 659, 1869, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(181, 'LC', 'SAINT LUCIA', 'Saint Lucia', 'LCA', 662, 1758, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(182, 'PM', 'SAINT PIERRE AND MIQUELON', 'Saint Pierre and Miquelon', 'SPM', 666, 508, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(183, 'VC', 'SAINT VINCENT AND THE GRENADINES', 'Saint Vincent and the Grenadines', 'VCT', 670, 1784, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(184, 'WS', 'SAMOA', 'Samoa', 'WSM', 882, 684, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(185, 'SM', 'SAN MARINO', 'San Marino', 'SMR', 674, 378, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(186, 'ST', 'SAO TOME AND PRINCIPE', 'Sao Tome and Principe', 'STP', 678, 239, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(187, 'SA', 'SAUDI ARABIA', 'Saudi Arabia', 'SAU', 682, 966, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(188, 'SN', 'SENEGAL', 'Senegal', 'SEN', 686, 221, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(189, 'CS', 'SERBIA AND MONTENEGRO', 'Serbia and Montenegro', 'NUL', 0, 381, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(190, 'SC', 'SEYCHELLES', 'Seychelles', 'SYC', 690, 248, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(191, 'SL', 'SIERRA LEONE', 'Sierra Leone', 'SLE', 694, 232, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(192, 'SG', 'SINGAPORE', 'Singapore', 'SGP', 702, 65, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(193, 'SK', 'SLOVAKIA', 'Slovakia', 'SVK', 703, 421, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(194, 'SI', 'SLOVENIA', 'Slovenia', 'SVN', 705, 386, '2016-12-13 03:19:44', '2016-12-13 03:19:44'),
	(195, 'SB', 'SOLOMON ISLANDS', 'Solomon Islands', 'SLB', 90, 677, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(196, 'SO', 'SOMALIA', 'Somalia', 'SOM', 706, 252, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(197, 'ZA', 'SOUTH AFRICA', 'South Africa', 'ZAF', 710, 27, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(198, 'GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'South Georgia and the South Sandwich Islands', 'NUL', 0, 0, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(199, 'ES', 'SPAIN', 'Spain', 'ESP', 724, 34, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(200, 'LK', 'SRI LANKA', 'Sri Lanka', 'LKA', 144, 94, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(201, 'SD', 'SUDAN', 'Sudan', 'SDN', 736, 249, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(202, 'SR', 'SURINAME', 'Suriname', 'SUR', 740, 597, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(203, 'SJ', 'SVALBARD AND JAN MAYEN', 'Svalbard and Jan Mayen', 'SJM', 744, 47, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(204, 'SZ', 'SWAZILAND', 'Swaziland', 'SWZ', 748, 268, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(205, 'SE', 'SWEDEN', 'Sweden', 'SWE', 752, 46, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(206, 'CH', 'SWITZERLAND', 'Switzerland', 'CHE', 756, 41, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(207, 'SY', 'SYRIAN ARAB REPUBLIC', 'Syrian Arab Republic', 'SYR', 760, 963, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(208, 'TW', 'TAIWAN, PROVINCE OF CHINA', 'Taiwan, Province of China', 'TWN', 158, 886, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(209, 'TJ', 'TAJIKISTAN', 'Tajikistan', 'TJK', 762, 992, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(210, 'TZ', 'TANZANIA, UNITED REPUBLIC OF', 'Tanzania, United Republic of', 'TZA', 834, 255, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(211, 'TH', 'THAILAND', 'Thailand', 'THA', 764, 66, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(212, 'TL', 'TIMOR-LESTE', 'Timor-Leste', 'NUL', 0, 670, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(213, 'TG', 'TOGO', 'Togo', 'TGO', 768, 228, '2016-12-13 03:19:45', '2016-12-13 03:19:45'),
	(214, 'TK', 'TOKELAU', 'Tokelau', 'TKL', 772, 690, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(215, 'TO', 'TONGA', 'Tonga', 'TON', 776, 676, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(216, 'TT', 'TRINIDAD AND TOBAGO', 'Trinidad and Tobago', 'TTO', 780, 1868, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(217, 'TN', 'TUNISIA', 'Tunisia', 'TUN', 788, 216, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(218, 'TR', 'TURKEY', 'Turkey', 'TUR', 792, 90, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(219, 'TM', 'TURKMENISTAN', 'Turkmenistan', 'TKM', 795, 7370, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(220, 'TC', 'TURKS AND CAICOS ISLANDS', 'Turks and Caicos Islands', 'TCA', 796, 1649, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(221, 'TV', 'TUVALU', 'Tuvalu', 'TUV', 798, 688, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(222, 'UG', 'UGANDA', 'Uganda', 'UGA', 800, 256, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(223, 'UA', 'UKRAINE', 'Ukraine', 'UKR', 804, 380, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(224, 'AE', 'UNITED ARAB EMIRATES', 'United Arab Emirates', 'ARE', 784, 971, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(225, 'GB', 'UNITED KINGDOM', 'United Kingdom', 'GBR', 826, 44, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(226, 'US', 'UNITED STATES', 'United States', 'USA', 840, 1, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(227, 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS', 'United States Minor Outlying Islands', 'NUL', 0, 1, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(228, 'UY', 'URUGUAY', 'Uruguay', 'URY', 858, 598, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(229, 'UZ', 'UZBEKISTAN', 'Uzbekistan', 'UZB', 860, 998, '2016-12-13 03:19:46', '2016-12-13 03:19:46'),
	(230, 'VU', 'VANUATU', 'Vanuatu', 'VUT', 548, 678, '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(231, 'VE', 'VENEZUELA', 'Venezuela', 'VEN', 862, 58, '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(232, 'VN', 'VIET NAM', 'Viet Nam', 'VNM', 704, 84, '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(233, 'VG', 'VIRGIN ISLANDS, BRITISH', 'Virgin Islands, British', 'VGB', 92, 1284, '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(234, 'VI', 'VIRGIN ISLANDS, U.S.', 'Virgin Islands, U.s.', 'VIR', 850, 1340, '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(235, 'WF', 'WALLIS AND FUTUNA', 'Wallis and Futuna', 'WLF', 876, 681, '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(236, 'EH', 'WESTERN SAHARA', 'Western Sahara', 'ESH', 732, 212, '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(237, 'YE', 'YEMEN', 'Yemen', 'YEM', 887, 967, '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(238, 'ZM', 'ZAMBIA', 'Zambia', 'ZMB', 894, 260, '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(239, 'ZW', 'ZIMBABWE', 'Zimbabwe', 'ZWE', 716, 263, '2016-12-13 03:19:47', '2016-12-13 03:19:47');

-- Dumping structure for table rt_oris.customers
DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `client_no` varchar(45) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `account_no` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table rt_oris.customers: ~0 rows (approximately)
DELETE FROM `customers`;
INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `client_no`, `company_id`, `account_no`) VALUES
	(1, 'Walter Adamba Omedo', 'walter.omedo@gmail.com', '+254724802834', 'C001', 2, 'C001/2');

-- Dumping structure for table rt_oris.customer_types
DROP TABLE IF EXISTS `customer_types`;
CREATE TABLE IF NOT EXISTS `customer_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.customer_types: ~2 rows (approximately)
DELETE FROM `customer_types`;
INSERT INTO `customer_types` (`id`, `name`, `created_at`, `updated_at`, `company_id`) VALUES
	(1, 'Premium ', '2025-05-19 17:43:40', '2025-05-19 17:43:41', 2),
	(2, 'Regular', '2025-05-22 08:04:52', '2025-05-22 08:04:53', 2);

-- Dumping structure for table rt_oris.departments
DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.departments: ~3 rows (approximately)
DELETE FROM `departments`;
INSERT INTO `departments` (`id`, `name`, `created_at`, `updated_at`, `company_id`) VALUES
	(1, 'Management', '2025-04-11 03:20:13', '2025-04-11 03:20:19', 2),
	(2, 'Customer Care', '2025-04-11 03:20:14', '2025-04-11 03:20:14', 2),
	(3, 'Technical Support', '2025-04-11 03:20:37', '2025-04-11 03:20:38', 2);

-- Dumping structure for table rt_oris.department_heads
DROP TABLE IF EXISTS `department_heads`;
CREATE TABLE IF NOT EXISTS `department_heads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table rt_oris.department_heads: ~0 rows (approximately)
DELETE FROM `department_heads`;
INSERT INTO `department_heads` (`id`, `user_id`, `dept_id`, `created_at`, `updated_at`) VALUES
	(1, 2, 3, '2025-05-22 15:49:10', '2025-05-23 15:49:12');

-- Dumping structure for table rt_oris.emails
DROP TABLE IF EXISTS `emails`;
CREATE TABLE IF NOT EXISTS `emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `dept_id` int(10) unsigned DEFAULT NULL,
  `priority_id` int(10) unsigned DEFAULT NULL,
  `company_id` int(10) unsigned DEFAULT NULL,
  `help_topic` int(10) unsigned DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `fetching_host` varchar(255) NOT NULL,
  `fetching_port` varchar(255) NOT NULL,
  `fetching_protocol` varchar(255) NOT NULL,
  `fetching_encryption` varchar(255) NOT NULL,
  `mailbox_protocol` varchar(255) DEFAULT NULL,
  `imap_config` varchar(255) DEFAULT NULL,
  `folder` varchar(255) DEFAULT NULL,
  `sending_host` varchar(255) DEFAULT NULL,
  `sending_port` varchar(255) DEFAULT NULL,
  `sending_protocol` varchar(255) DEFAULT NULL,
  `sending_encryption` varchar(255) DEFAULT NULL,
  `smtp_validate` varchar(255) DEFAULT NULL,
  `smtp_authentication` varchar(255) DEFAULT NULL,
  `internal_notes` varchar(255) DEFAULT NULL,
  `auto_response` tinyint(1) DEFAULT NULL,
  `fetching_status` tinyint(1) DEFAULT NULL,
  `move_to_folder` tinyint(1) DEFAULT NULL,
  `delete_email` tinyint(1) DEFAULT NULL,
  `do_nothing` tinyint(1) DEFAULT NULL,
  `sending_status` tinyint(1) DEFAULT NULL,
  `authentication` tinyint(1) DEFAULT NULL,
  `header_spoofing` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` int(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `department` (`dept_id`,`priority_id`,`help_topic`),
  KEY `department_2` (`dept_id`,`priority_id`,`help_topic`),
  KEY `priority` (`priority_id`),
  KEY `help_topic` (`help_topic`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.emails: ~4 rows (approximately)
DELETE FROM `emails`;
INSERT INTO `emails` (`id`, `email`, `name`, `dept_id`, `priority_id`, `company_id`, `help_topic`, `username`, `password`, `fetching_host`, `fetching_port`, `fetching_protocol`, `fetching_encryption`, `mailbox_protocol`, `imap_config`, `folder`, `sending_host`, `sending_port`, `sending_protocol`, `sending_encryption`, `smtp_validate`, `smtp_authentication`, `internal_notes`, `auto_response`, `fetching_status`, `move_to_folder`, `delete_email`, `do_nothing`, `sending_status`, `authentication`, `header_spoofing`, `created_at`, `updated_at`, `active`) VALUES
	(1, 'info@nezasoft.net', 'Nezasoft Email', 1, 3, 2, NULL, 'info@nezasoft.net', '#info2016', 'saver.vivawebhost.com', '993', 'imap', 'tls', '', '', '', '', '465', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0),
	(2, 'nezasoft@gmail.com', 'Technical Support', 3, 1, 2, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0),
	(3, 'customer_care@nezasoft.net', 'Customer Care', 2, 2, 2, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0),
	(4, 'demo@nezasoft.net', 'Support Email', 3, 1, 2, NULL, 'demo@nezasoft.net', 'Demo@2015', 'saver.vivawebhost.com', '993', 'imap', 'ssl', NULL, NULL, 'INBOX', NULL, '465', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-19 13:37:03', '2025-07-23 10:43:17', 1);

-- Dumping structure for table rt_oris.email_verification_codes
DROP TABLE IF EXISTS `email_verification_codes`;
CREATE TABLE IF NOT EXISTS `email_verification_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `code` int(10) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table rt_oris.email_verification_codes: ~6 rows (approximately)
DELETE FROM `email_verification_codes`;
INSERT INTO `email_verification_codes` (`id`, `email`, `code`, `created_at`, `updated_at`) VALUES
	(1, 'wadamba@yahoo.com', 539777, '2025-07-23 05:38:40', '2025-07-23 05:38:40'),
	(2, 'wadamba@yahoo.com', 499021, '2025-07-23 06:52:37', '2025-07-23 06:52:37'),
	(3, 'nezasoft@gmail.com', 557355, '2025-07-23 06:54:29', '2025-07-23 06:54:29'),
	(4, 'nezasoft@gmail.com', 541047, '2025-07-23 07:01:49', '2025-07-23 07:01:49'),
	(5, 'nezasoft@gmail.com', 122978, '2025-07-23 07:10:35', '2025-07-23 07:10:35'),
	(6, 'nezasoft@gmail.com', 277493, '2025-07-23 07:15:44', '2025-07-23 07:15:44');

-- Dumping structure for table rt_oris.event_types
DROP TABLE IF EXISTS `event_types`;
CREATE TABLE IF NOT EXISTS `event_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.event_types: ~9 rows (approximately)
DELETE FROM `event_types`;
INSERT INTO `event_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Ticket Created', '2025-05-22 08:24:09', '2025-05-22 08:24:11'),
	(2, 'First Response Sent', '2025-05-22 08:24:22', '2025-05-22 08:24:23'),
	(3, 'Ticket Assigned', '2025-05-22 08:24:34', '2025-05-22 08:24:35'),
	(4, 'Status Changed', '2025-05-22 08:24:44', '2025-05-22 08:24:45'),
	(5, 'Customer Responded', '2025-05-22 08:24:53', '2025-05-22 08:24:54'),
	(6, 'Ticket Resolved', '2025-05-22 08:25:40', '2025-05-22 08:25:53'),
	(7, 'Ticket Closed', '2025-05-22 08:25:51', '2025-05-22 08:25:52'),
	(8, 'SLA Breach Detected', '2025-05-22 08:26:04', '2025-05-22 08:26:05'),
	(9, 'Escalation Triggered', '2025-05-22 08:26:17', '2025-05-22 08:26:18');

-- Dumping structure for table rt_oris.failed_jobs
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.failed_jobs: ~0 rows (approximately)
DELETE FROM `failed_jobs`;

-- Dumping structure for table rt_oris.integration_settings
DROP TABLE IF EXISTS `integration_settings`;
CREATE TABLE IF NOT EXISTS `integration_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `code` varchar(100) NOT NULL,
  `value` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table rt_oris.integration_settings: ~6 rows (approximately)
DELETE FROM `integration_settings`;
INSERT INTO `integration_settings` (`id`, `company_id`, `code`, `value`, `created_at`, `updated_at`) VALUES
	(1, 2, 'RT_MAIL_HOST', 'saver.vivawebhost.com', '2025-07-23 06:29:46', '2025-07-23 06:29:46'),
	(2, 2, 'RT_MAIL_PORT', '465', '2025-07-23 06:30:07', '2025-07-23 06:30:07'),
	(3, 2, 'RT_MAIL_USERNAME', 'demo@nezasoft.net', '2025-07-23 06:30:32', '2025-07-23 06:30:32'),
	(4, 2, 'RT_MAIL_PASSWORD', 'Demo@2015', '2025-07-23 06:30:49', '2025-07-23 06:30:49'),
	(5, 2, 'RT_MAIL_ENCRYPTION', 'ssl', '2025-07-23 06:31:06', '2025-07-23 06:31:06'),
	(6, 2, 'RT_MAIL_FROM_ADDRESS', 'demo@nezasoft.net', '2025-07-23 06:31:27', '2025-07-23 06:31:27'),
	(7, 2, 'RT_MAIL_FROM_NAME', 'Oris RT Ticketing System', '2025-07-23 06:31:50', '2025-07-23 06:31:50');

-- Dumping structure for table rt_oris.jobs
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.jobs: ~0 rows (approximately)
DELETE FROM `jobs`;

-- Dumping structure for table rt_oris.job_batches
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.job_batches: ~0 rows (approximately)
DELETE FROM `job_batches`;

-- Dumping structure for table rt_oris.mailbox_protocol
DROP TABLE IF EXISTS `mailbox_protocol`;
CREATE TABLE IF NOT EXISTS `mailbox_protocol` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.mailbox_protocol: ~4 rows (approximately)
DELETE FROM `mailbox_protocol`;
INSERT INTO `mailbox_protocol` (`id`, `name`, `value`) VALUES
	(1, 'IMAP', '/imap'),
	(2, 'IMAP+SSL', '/imap/ssl'),
	(3, 'IMAP+TLS', '/imap/tls'),
	(4, 'IMAP+SSL/No-validate', '/imap/ssl/novalidate-cert');

-- Dumping structure for table rt_oris.mail_services
DROP TABLE IF EXISTS `mail_services`;
CREATE TABLE IF NOT EXISTS `mail_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `short_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.mail_services: ~6 rows (approximately)
DELETE FROM `mail_services`;
INSERT INTO `mail_services` (`id`, `name`, `short_name`, `created_at`, `updated_at`) VALUES
	(1, 'SMTP', 'smtp', '2016-12-13 03:19:08', '2016-12-13 03:19:08'),
	(2, 'Php Mail', 'mail', '2016-12-13 03:19:08', '2016-12-13 03:19:08'),
	(3, 'Send Mail', 'sendmail', '2016-12-13 03:19:08', '2016-12-13 03:19:08'),
	(4, 'Mailgun', 'mailgun', '2016-12-13 03:19:08', '2016-12-13 03:19:08'),
	(5, 'Mandrill', 'mandrill', '2016-12-13 03:19:09', '2016-12-13 03:19:09'),
	(6, 'Log file', 'log', '2016-12-13 03:19:09', '2016-12-13 03:19:09');

-- Dumping structure for table rt_oris.migrations
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.migrations: ~20 rows (approximately)
DELETE FROM `migrations`;
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
	(20, '2025_04_09_174255_create_ticket_types_table', 1),
	(21, '2025_04_10_032745_create_business_documents_table', 2);

-- Dumping structure for table rt_oris.notifications
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.notifications: ~28 rows (approximately)
DELETE FROM `notifications`;
INSERT INTO `notifications` (`id`, `user_id`, `type_id`, `created_at`, `updated_at`, `company_id`, `status`) VALUES
	(1, 1, 3, '2025-05-24 02:16:10', '2025-05-24 02:16:10', NULL, 0),
	(2, 1, 3, '2025-05-31 04:57:48', '2025-05-31 04:57:48', NULL, 0),
	(3, 2, 5, '2025-06-01 12:45:27', '2025-06-01 12:45:27', NULL, 0),
	(4, 1, 3, '2025-07-01 04:04:32', '2025-07-01 04:04:32', NULL, 0),
	(6, 2, 3, '2025-07-05 08:43:59', '2025-07-05 08:43:59', NULL, 0),
	(7, 2, 3, '2025-07-05 09:19:34', '2025-07-05 09:19:34', NULL, 0),
	(8, 2, 3, '2025-07-05 09:27:07', '2025-07-05 09:27:07', NULL, 0),
	(9, 2, 3, '2025-07-22 03:38:22', '2025-07-22 03:38:22', NULL, 0),
	(10, 2, 5, '2025-07-22 05:47:40', '2025-07-22 05:47:40', NULL, 0),
	(11, 2, 5, '2025-07-23 02:26:07', '2025-07-23 02:26:07', NULL, 0),
	(12, 1, 3, '2025-07-24 08:45:53', '2025-07-24 08:45:53', NULL, 0),
	(13, 2, 3, '2025-07-24 08:45:57', '2025-07-24 08:45:57', NULL, 0),
	(14, 1, 3, '2025-07-25 10:19:20', '2025-07-25 10:19:20', NULL, 0),
	(15, 2, 3, '2025-07-25 10:19:25', '2025-07-25 10:19:25', NULL, 0),
	(16, 1, 6, '2025-07-26 04:49:24', '2025-07-26 04:49:24', NULL, 0),
	(17, 1, 6, '2025-07-26 04:52:10', '2025-07-26 04:52:10', NULL, 0),
	(18, 1, 6, '2025-07-26 05:03:27', '2025-07-26 05:03:27', NULL, 0),
	(19, 1, 3, '2025-07-26 09:37:23', '2025-07-26 09:37:23', NULL, 0),
	(20, 2, 3, '2025-07-26 09:37:30', '2025-07-26 09:37:30', NULL, 0),
	(21, 1, 6, '2025-07-26 09:44:15', '2025-07-26 09:44:15', NULL, 0),
	(22, 1, 3, '2025-07-30 10:36:35', '2025-07-30 10:36:35', NULL, 0),
	(23, 2, 3, '2025-07-30 10:36:40', '2025-07-30 10:36:40', NULL, 0),
	(24, 1, 3, '2025-07-30 10:43:53', '2025-07-30 10:43:53', NULL, 0),
	(25, 2, 3, '2025-07-30 10:43:58', '2025-07-30 10:43:58', NULL, 0),
	(26, 1, 3, '2025-07-31 02:23:34', '2025-07-31 02:23:34', NULL, 0),
	(27, 2, 3, '2025-07-31 02:23:40', '2025-07-31 02:23:40', NULL, 0),
	(28, 1, 3, '2025-07-31 02:29:19', '2025-07-31 02:29:19', NULL, 0),
	(29, 2, 3, '2025-07-31 02:29:22', '2025-07-31 02:29:22', NULL, 0);

-- Dumping structure for table rt_oris.notification_types
DROP TABLE IF EXISTS `notification_types`;
CREATE TABLE IF NOT EXISTS `notification_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `icon_class` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.notification_types: ~5 rows (approximately)
DELETE FROM `notification_types`;
INSERT INTO `notification_types` (`id`, `message`, `type`, `icon_class`, `created_at`, `updated_at`) VALUES
	(1, 'A new user is registered', 'registration', 'fa fa-user', '2016-12-13 03:19:14', '2016-12-13 03:19:14'),
	(2, 'You have a new reply on this ticket', 'reply', 'fa fa-envelope', '2016-12-13 03:19:14', '2016-12-13 03:19:14'),
	(3, 'A new ticket has been created', 'new_ticket', 'fa fa-envelope', '2016-12-13 03:19:14', '2016-12-13 03:19:14'),
	(4, 'Ticket has been closed', 'closed', 'fa fa-envelope', '2025-05-31 09:48:40', '2025-05-31 09:48:40'),
	(5, 'Ticket has been resolved', 'resolved', 'fa fa-envelope', '2025-05-31 09:49:53', '2025-05-31 09:49:53'),
	(6, 'You have been assigned a ticket', 'assignment', 'fa fa-user', '2025-07-26 07:11:53', '2025-07-26 07:11:54');

-- Dumping structure for table rt_oris.password_reset_tokens
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.password_reset_tokens: ~0 rows (approximately)
DELETE FROM `password_reset_tokens`;
INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
	('nezasoft@gmail.com', '$2y$12$xBKxxb10g0fS0/9bfeUA8euTDmhLqotdxfkLOnbfwrGSCxibK1NeW', '2025-07-23 04:01:16');

-- Dumping structure for table rt_oris.priorities
DROP TABLE IF EXISTS `priorities`;
CREATE TABLE IF NOT EXISTS `priorities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.priorities: ~3 rows (approximately)
DELETE FROM `priorities`;
INSERT INTO `priorities` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'High', '2025-04-10 19:19:26', '2025-04-10 19:19:27'),
	(2, 'Low', '2025-04-10 19:19:37', '2025-04-10 19:19:38'),
	(3, 'Medium', '2025-04-10 19:20:08', '2025-04-10 19:20:06');

-- Dumping structure for table rt_oris.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.roles: ~2 rows (approximately)
DELETE FROM `roles`;
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`, `company_id`) VALUES
	(1, 'Admin', '2025-07-04 07:08:11', '2025-07-04 07:08:12', 2),
	(2, 'User', '2025-07-04 07:08:20', '2025-07-04 07:08:21', 2);

-- Dumping structure for table rt_oris.sessions
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.sessions: ~11 rows (approximately)
DELETE FROM `sessions`;
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
	('2ha7V34GKI5phF35a1m9bNMEXRynApkUXy6oM2ri', NULL, '127.0.0.1', 'PostmanRuntime/7.44.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0hkVG96VUl2a09tN1BRSnM1UkFuOFZJTDY3bUNCSXF1ZWFYTVlwUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly9sb2NhbGhvc3QvdGlja2V0aW5nL2JhY2tlbmQvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1751611997),
	('2y9Eiry5vZyAXK5C0eaHD6OhwEHZUJVbROqKswh2', NULL, '127.0.0.1', 'PostmanRuntime/7.44.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaEc5a1paS0JxYzRrUFc1ZjA5R0IwaFZ0WkZUWVZDU2ZoS1FmSzNIUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly9sb2NhbGhvc3QvdGlja2V0aW5nL2JhY2tlbmQvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1751518901),
	('91IS3WlThHyIKlKsETBdQL9rtipb9nz7Iw4VIJyK', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidlc0TjlvZHN2TVhmV1FCNXE3dldnWEg5em9hTkxNNWRjMkJqQ1JFViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3QvdGlja2V0aW5nL2NoYW5uZWxzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1753168006),
	('dJ0HCVuqv53puRCDFYlwKz1EbbhbdnJRhCS1gu5o', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaVl6Umo1bTYxV1oxYlk5bXQ4Y3A4TzhxbGZPd0I5SGk2WVJyWkczeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3QvdGlja2V0aW5nL2NoYW5uZWxzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1744529981),
	('ebe3yL6C8s1t6dzuxCjQ25R43yo3vfy00o6NkpQl', NULL, '127.0.0.1', 'PostmanRuntime/7.44.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMUlaeGtrb014bEZrUUYzMVczNWkwWlhWUkNDMmdOTGdWOWRrN2ZSdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly9sb2NhbGhvc3QvdGlja2V0aW5nL2JhY2tlbmQvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1753451960),
	('IasOxxAmB5rVmN4DFYLjDX4iQ1iv0pXGHHLMTOhs', NULL, '127.0.0.1', 'PostmanRuntime/7.43.4', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibDBWM3NSN2NaU1dxMU5RazVPWXZxZ3lkVE92UVBiMGhzRmwzb1QzUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1747900318),
	('l2p5Os2U0pQf8Ow4B5Tt7j6EQUYX8ufA990dzkfl', NULL, '127.0.0.1', 'PostmanRuntime/7.43.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibmh5VTExTDdIbWtsell4aUVkVFN5Z0dBWmljd3E4OXZTUVdWVXd5SyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1748765535),
	('lF2q5e17hLH15yONz6PN4fmLi8Zh4660HnbiuXxL', NULL, '127.0.0.1', 'PostmanRuntime/7.44.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM1FwZDBwcDJuOVA0THZvaVlFWjVaZUZLaXdYaE9FNTM0eVdlWkxNTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly9sb2NhbGhvc3QvdGlja2V0aW5nL2JhY2tlbmQvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1751396667),
	('LjSAfdZMVETBrHBCJa7XbD80Jricg7PXa5fpMd9r', NULL, '127.0.0.1', 'PostmanRuntime/7.44.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiamJYTmFPenNsMGYwM1Z6MDFtMlpFbzAxejd6M3pNajNmb2hkWHJ0WCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1749572688),
	('ltfMzdoUES7GK6RjrQLERj3UUJ8IsY35u05EVi5G', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTWJGVWFaZlRDdzhYRkNwbnhzRUpuTGpTU3NqT1Ixa0lVdkZxSXhpTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3QvdGlja2V0aW5nLW1hc3Rlci9jaGFubmVscyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1748063325),
	('PcxYwYoXN0uYJoXiEDAGUkgyY8XmuNAANuDN1CNj', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic2NtVFV2bFIwTTFyVnppak5wVVExUFdzWDVOSkhBSlViZHpLcU5WeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3QvdGlja2V0aW5nL2JhY2tlbmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1751520812),
	('snbGthP5U1j89j4x1ETQElsgWuivwWHXbolW85Ze', NULL, '127.0.0.1', 'PostmanRuntime/7.44.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2FLN3M5MnlLRHdlU1E0OHdZcVkwZ0R5UjZsVU9WWGpKa2FSZ1FXYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly9sb2NhbGhvc3QvdGlja2V0aW5nL2JhY2tlbmQvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1753277727),
	('SQA6hyOI7s4LnPssX82fFKXJFIW6DbWSEVQ1BAub', NULL, '127.0.0.1', 'PostmanRuntime/7.43.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMURuSFVkU0RmTHo0NUlQaW1PVUMzcGpGT0ljQzVSVUFMcUc2V3VTaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1748663702),
	('tVppxN7BRTZXOGS39PWY0ZRl5bUsIH5dyA7g9r93', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZEFZWlpBbnBVQUtaYVJPRFNpR2NyS0lZTVBBbjZ0QjNBOFllazdzZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3QvdGlja2V0aW5nL2JhY2tlbmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1749573172),
	('uA2lH0Yc4blqa6foycHCycHr0Tos9oHkNQM29aGp', NULL, '127.0.0.1', 'PostmanRuntime/7.43.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOGRqR1VuMjlRT1dqYUo0WEViSWtoRmVhcFJ3ZEhFRUE0VWhEVHh3TiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1747459850),
	('w6tfB1ZCzdM1zcT4fIGn5VEPMHLkrqbCKEESukkw', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUVQyQmM1OFZLNlphZndXd2UwcVYyUWUxUjNibFR0MmpMZzNvcFFvaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1747671366);

-- Dumping structure for table rt_oris.sla_events
DROP TABLE IF EXISTS `sla_events`;
CREATE TABLE IF NOT EXISTS `sla_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `event_type_id` int(10) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `due_date` datetime DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `met_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `sla_policy_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.sla_events: ~39 rows (approximately)
DELETE FROM `sla_events`;
INSERT INTO `sla_events` (`id`, `ticket_id`, `event_type_id`, `status_id`, `due_date`, `company_id`, `met_at`, `created_at`, `updated_at`, `sla_policy_id`) VALUES
	(1, 1, 1, 1, '2025-05-23 14:15:49', 2, NULL, '2025-05-23 09:15:49', '2025-05-23 09:15:49', 1),
	(2, 1, 2, 2, '2025-05-23 12:18:20', 2, NULL, '2025-05-23 09:18:20', '2025-05-23 09:18:20', 1),
	(3, 2, 1, 1, '2025-05-24 07:16:10', 2, NULL, '2025-05-24 02:16:10', '2025-05-24 02:16:10', 3),
	(4, 2, 2, 2, '2025-05-24 05:18:59', 2, NULL, '2025-05-24 02:18:59', '2025-05-24 02:18:59', 3),
	(5, 3, 1, 1, '2025-05-31 09:57:48', 2, NULL, '2025-05-31 04:57:48', '2025-05-31 04:57:48', 2),
	(6, 1, 6, 2, '2025-06-01 15:45:27', 2, NULL, '2025-06-01 12:45:27', '2025-06-01 12:45:27', 2),
	(7, 4, 1, 1, '2025-07-01 09:04:32', 2, NULL, '2025-07-01 04:04:32', '2025-07-01 04:04:32', 2),
	(9, 6, 1, 1, '2025-07-01 19:03:11', 2, NULL, '2025-07-01 14:03:11', '2025-07-01 14:03:11', 1),
	(10, 6, 2, 2, '2025-07-01 17:08:06', 2, NULL, '2025-07-01 14:08:06', '2025-07-01 14:08:06', 1),
	(11, 4, 2, 2, '2025-07-03 16:50:15', 2, NULL, '2025-07-03 13:50:15', '2025-07-03 13:50:15', 1),
	(12, 10, 1, 1, '2025-07-05 14:54:21', 2, NULL, '2025-07-05 09:54:21', '2025-07-05 09:54:21', 2),
	(13, 11, 1, 1, '2025-07-22 08:38:22', 2, NULL, '2025-07-22 03:38:22', '2025-07-22 03:38:22', 2),
	(14, 1, 6, 2, '2025-07-22 08:47:40', 2, NULL, '2025-07-22 05:47:40', '2025-07-22 05:47:40', 1),
	(15, 1, 6, 2, '2025-07-23 05:26:07', 2, NULL, '2025-07-23 02:26:07', '2025-07-23 02:26:07', 1),
	(16, 12, 1, 1, '2025-07-24 09:47:58', 2, NULL, '2025-07-24 04:47:58', '2025-07-24 04:47:58', 3),
	(17, 13, 1, 1, '2025-07-24 09:48:06', 2, NULL, '2025-07-24 04:48:06', '2025-07-24 04:48:06', 3),
	(18, 14, 1, 1, '2025-07-24 09:48:14', 2, NULL, '2025-07-24 04:48:14', '2025-07-24 04:48:14', 3),
	(19, 15, 1, 1, '2025-07-24 09:48:21', 2, NULL, '2025-07-24 04:48:21', '2025-07-24 04:48:21', 3),
	(20, 16, 1, 1, '2025-07-24 09:48:28', 2, NULL, '2025-07-24 04:48:28', '2025-07-24 04:48:28', 3),
	(21, 17, 1, 1, '2025-07-24 09:48:35', 2, NULL, '2025-07-24 04:48:35', '2025-07-24 04:48:35', 3),
	(22, 18, 1, 1, '2025-07-24 09:48:43', 2, NULL, '2025-07-24 04:48:43', '2025-07-24 04:48:43', 3),
	(23, 19, 1, 1, '2025-07-24 09:48:50', 2, NULL, '2025-07-24 04:48:50', '2025-07-24 04:48:50', 3),
	(24, 20, 1, 1, '2025-07-24 09:48:57', 2, NULL, '2025-07-24 04:48:57', '2025-07-24 04:48:57', 3),
	(25, 20, 2, 2, '2025-07-24 11:41:20', 2, NULL, '2025-07-24 08:41:20', '2025-07-24 08:41:20', 3),
	(26, 21, 1, 1, '2025-07-24 13:45:53', 2, NULL, '2025-07-24 08:45:53', '2025-07-24 08:45:53', 2),
	(27, 13, 2, 2, '2025-07-24 12:03:11', 2, NULL, '2025-07-24 09:03:11', '2025-07-24 09:03:11', 3),
	(28, 22, 1, 1, '2025-07-24 14:03:18', 2, NULL, '2025-07-24 09:03:18', '2025-07-24 09:03:18', 3),
	(29, 2, 6, 6, '2025-07-26 09:34:51', 2, NULL, '2025-07-26 06:34:51', '2025-07-26 06:34:51', 3),
	(30, 2, 7, 7, '2025-07-26 09:38:51', 2, NULL, '2025-07-26 06:38:51', '2025-07-26 06:38:51', 3),
	(31, 24, 1, 1, '2025-07-26 14:37:23', 2, NULL, '2025-07-26 09:37:23', '2025-07-26 09:37:23', 2),
	(32, 24, 3, 6, '2025-07-26 14:44:21', 2, NULL, '2025-07-26 09:44:21', '2025-07-26 09:44:21', 2),
	(33, 24, 2, 3, '2025-07-26 12:46:15', 2, NULL, '2025-07-26 09:46:15', '2025-07-26 09:46:15', 2),
	(34, 24, 6, 2, '2025-07-26 13:21:35', 2, NULL, '2025-07-26 10:21:36', '2025-07-26 10:21:36', 2),
	(35, 24, 7, 5, '2025-07-29 14:25:25', 2, NULL, '2025-07-29 11:25:25', '2025-07-29 11:25:25', 2),
	(36, 25, 1, 1, '2025-07-30 15:36:35', 2, NULL, '2025-07-30 10:36:35', '2025-07-30 10:36:35', 2),
	(37, 26, 1, 1, '2025-07-30 15:43:53', 2, NULL, '2025-07-30 10:43:53', '2025-07-30 10:43:53', 2),
	(38, 27, 1, 1, '2025-07-30 15:55:23', 2, NULL, '2025-07-30 10:55:23', '2025-07-30 10:55:23', 1),
	(39, 28, 1, 1, '2025-07-31 07:23:34', 2, NULL, '2025-07-31 02:23:34', '2025-07-31 02:23:34', 2),
	(40, 29, 1, 1, '2025-07-31 07:29:19', 2, NULL, '2025-07-31 02:29:19', '2025-07-31 02:29:19', 2),
	(41, 27, 2, 2, '2025-07-31 13:54:18', 2, NULL, '2025-07-31 10:54:18', '2025-07-31 10:54:18', 1);

-- Dumping structure for table rt_oris.sla_policies
DROP TABLE IF EXISTS `sla_policies`;
CREATE TABLE IF NOT EXISTS `sla_policies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `response_time_min` int(11) DEFAULT NULL,
  `resolve_time_min` int(11) DEFAULT NULL,
  `is_default` tinyint(4) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.sla_policies: ~4 rows (approximately)
DELETE FROM `sla_policies`;
INSERT INTO `sla_policies` (`id`, `name`, `response_time_min`, `resolve_time_min`, `is_default`, `company_id`, `created_at`, `updated_at`) VALUES
	(1, 'Gold Customer SLA', 120, 120, 1, 2, '2025-05-19 14:01:54', '2025-05-19 14:10:06'),
	(2, 'Bronze Customer SLA', 120, 120, 0, 2, '2025-05-19 14:11:17', '2025-05-19 14:11:17'),
	(3, 'Silver Customer SLA', 120, 120, 0, 2, '2025-05-19 14:11:28', '2025-05-19 14:11:28'),
	(4, 'Test Customer SLA', 120, 120, 0, 2, '2025-05-19 14:14:25', '2025-05-19 14:14:25');

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
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.sla_rules: ~12 rows (approximately)
DELETE FROM `sla_rules`;
INSERT INTO `sla_rules` (`id`, `sla_policy_id`, `customer_type_id`, `priority_id`, `channel_id`, `created_at`, `updated_at`, `company_id`) VALUES
	(1, 1, 1, 1, 1, '2025-05-23 06:02:05', '2025-05-23 06:02:05', 2),
	(2, 1, 1, 1, 2, '2025-05-23 06:02:10', '2025-05-23 06:02:10', 2),
	(3, 1, 1, 1, 3, '2025-05-23 06:02:15', '2025-05-23 06:02:15', 2),
	(4, 2, 1, 2, 1, '2025-05-23 06:03:39', '2025-05-23 06:03:39', 2),
	(5, 2, 1, 2, 2, '2025-05-23 06:03:47', '2025-05-23 06:03:47', 2),
	(6, 2, 1, 2, 3, '2025-05-23 06:03:51', '2025-05-23 06:03:51', 2),
	(7, 2, 2, 1, 1, '2025-05-23 06:04:26', '2025-05-23 06:04:26', 2),
	(8, 2, 2, 1, 2, '2025-05-23 06:04:31', '2025-05-23 06:04:31', 2),
	(9, 2, 2, 1, 3, '2025-05-23 06:04:34', '2025-05-23 06:04:34', 2),
	(10, 3, 2, 2, 1, '2025-05-23 06:05:39', '2025-05-23 06:05:39', 2),
	(11, 3, 2, 2, 2, '2025-05-23 06:05:45', '2025-05-23 06:05:45', 2),
	(12, 3, 2, 2, 3, '2025-05-23 06:05:49', '2025-05-23 06:05:49', 2);

-- Dumping structure for table rt_oris.statuses
DROP TABLE IF EXISTS `statuses`;
CREATE TABLE IF NOT EXISTS `statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.statuses: ~5 rows (approximately)
DELETE FROM `statuses`;
INSERT INTO `statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'New', '2025-04-10 19:20:16', '2025-04-10 19:20:18'),
	(2, 'Resolved', '2025-04-10 19:20:49', '2025-04-10 19:20:54'),
	(3, 'Pending', '2025-04-10 19:20:50', '2025-04-10 19:20:53'),
	(4, 'Archived', '2025-04-10 19:20:51', '2025-04-10 19:20:52'),
	(5, 'Closed', '2025-05-31 09:26:26', '2025-05-31 09:26:27'),
	(6, 'Assigned', '2025-07-29 13:33:54', '2025-07-29 13:33:53');

-- Dumping structure for table rt_oris.templates
DROP TABLE IF EXISTS `templates`;
CREATE TABLE IF NOT EXISTS `templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `variable` varchar(255) NOT NULL,
  `type` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `description` varchar(255) NOT NULL,
  `set_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.templates: ~15 rows (approximately)
DELETE FROM `templates`;
INSERT INTO `templates` (`id`, `name`, `variable`, `type`, `subject`, `message`, `description`, `set_id`, `created_at`, `updated_at`) VALUES
	(1, 'This template is for sending notice to agent when ticket is assigned to them', '0', 1, 'Ticket Assigned', '<div>Hello {{agent_name}},<br /><br /><b>Ticket No:</b> {{ticket_no}}<br />Has been assigned to you by {{ticket_assigner_name}} <br /> \r\nPlease check and resppond on the ticket.<br /> Link: {{ticket_link}}<br /><br />Thank You<br />Kind Regards,<br /> RT Oris</div>', '', 1, '2016-12-13 03:19:50', '2016-12-13 03:19:50'),
	(2, 'This template is for sending notice to client with ticket link to check ticket without logging in to system', '1', 2, 'Check your Ticket', '<div>Hello {!!$user!!},<br /><br />Click the link below to view your requested ticket<br /> {!!$ticket_link_with_number!!}<br /><br />Kind Regards,<br /> {!!$system_from!!}</div>', '', 1, '2016-12-13 03:19:50', '2016-12-13 03:19:50'),
	(3, 'This template is for sending notice to client when ticket status is changed to close', '0', 3, 'Ticket Closed', '<div>Hello,<br /><br />This message is regarding your ticket ID {{ticket_no}}. We are changing the status of this ticket to "Closed" as the issue appears to be resolved.<br /><br />Thank you<br />Kind regards,<br /> {{department}}</div>', '', 1, '2016-12-13 03:19:50', '2016-12-13 03:19:50'),
	(4, 'This template is for sending notice to client on successful ticket creation', '0', 4, 'New Ticket Created', '<div><span>Hello {{name}}<br /><br /></span><span>Thank you for contacting us. This is an automated response confirming the receipt of your ticket. Our team will get back to you as soon as possible. When replying, please make sure that the ticket ID is kept in the subject so that we can track your replies.<br /><br /></span><span><b>Ticket ID:</b> {{ticket_no}} <br /><br /></span><span> {{department}}<br /></span>You can check the status of or update this ticket online at: {{system_link}}</div>', '', 1, '2016-12-13 03:19:51', '2016-12-13 03:19:51'),
	(5, 'This template is for sending notice to agent on new ticket creation', '0', 5, 'New Ticket Created', '<div>Hello {!!$ticket_agent_name!!},<br /><br />New ticket {!!$ticket_number!!}createdÃ‚Â <br /><br /><b>From</b><br /><b>Name:</b> {!!$ticket_client_name!!}Ã‚Â  Ã‚Â <br /><b>E-mail:</b> {!!$ticket_client_email!!}<br /><br /> {!!$content!!}<br /><br />Kind Regards,<br /> {!!$system_from!!}</div>', '', 1, '2016-12-13 03:19:51', '2016-12-13 03:19:51'),
	(6, 'This template is for sending notice to client on new ticket created by agent in name of client', '0', 6, 'New Ticket Created', '<div> {{content}}<br /><br /> {{agent_sign}}<br /><br />You can check the status of or update this ticket online at: {{system_link}}</div>', '', 1, '2016-12-13 03:19:51', '2016-12-13 03:19:51'),
	(7, 'This template is for sending notice to client on new registration during new ticket creation for un registered clients', '1', 7, 'Registration Confirmation', '<p>Hello {!!$user!!},Ã‚Â </p><p>This email is confirmation that you are now registered at our helpdesk.</p><p><b>Registered Email:</b> {!!$email_address!!}</p><p><b>Password:</b> {!!$user_password!!}</p><p>You can visit the helpdesk to browse articles and contact us at any time: {!!$system_link!!}</p><p>Thank You.</p><p>Kind Regards,</p><p> {!!$system_from!!}Ã‚Â </p>', '', 1, '2016-12-13 03:19:51', '2016-12-13 03:19:51'),
	(8, 'This template is for sending notice to any user about reset password option', '1', 8, 'Reset your Password', 'Hello {!!$user!!},<br /><br />You asked to reset your password. To do so, please click this link:<br /><br /> {!!$password_reset_link!!}<br /><br />This will let you change your password to something new. If you didn\'t ask for this, don\'t worry, we\'ll keep your password safe.<br /><br />Thank You.<br /><br />Kind Regards,<br /> {!!$system_from!!}', '', 1, '2016-12-13 03:19:51', '2016-12-13 03:19:51'),
	(9, 'This template is for sending notice to client when a reply made to his/her ticket', '0', 9, 'Reply on Ticket', '<span></span><div><span></span><p> {{content}}<br /></p><p> {{agent_sign}}</p><p><b>Ticket Details</b></p><p><b>Ticket ID:</b> {{ticket_no}}</p></div>', '', 1, '2016-12-13 03:19:51', '2016-12-13 03:19:51'),
	(10, 'This template is for sending notice to agent when ticket reply is made by client on a ticket', '0', 10, '', '<div>Hello {!!$ticket_agent_name!!},<br /><b><br /></b>A reply been made to ticket {!!$ticket_number!!}<br /><b><br /></b><b>From<br /></b><b>Name: </b>{!!$ticket_client_name!!}<br /><b>E-mail: </b>{!!$ticket_client_email!!}<br /><b><br /></b> {!!$content!!}<br /><b><br /></b>Kind Regards,<br /> {!!$system_from!!}</div>', '', 1, '2016-12-13 03:19:51', '2016-12-13 03:19:51'),
	(11, 'This template is for sending notice to client about registration confirmation link', '1', 11, 'Verify your email address', '<p>Hello {!!$user!!},Ã‚Â </p><p>This email is confirmation that you are now registered at our helpdesk.</p><p><b>Registered Email:</b> {!!$email_address!!}</p><p>Please click on the below link to activate your account and Login to the system {!!$password_reset_link!!}</p><p>Thank You.</p><p>Kind Regards,</p><p> {!!$system_from!!}Ã‚Â </p>', '', 1, '2016-12-13 03:19:52', '2016-12-13 03:19:52'),
	(12, 'This template is for sending notice to team when ticket is assigned to team', '1', 12, '', '<div>Hello {!!$ticket_agent_name!!},<br /><br /><b>Ticket No:</b> {!!$ticket_number!!}<br />Has been assigned to your team : {!!$team!!} by {!!$ticket_assigner!!}Ã‚Â <br /><br />Thank You<br />Kind Regards,<br />{!!$system_from!!}</div>', '', 1, '2016-12-13 03:19:52', '2016-12-13 03:19:52'),
	(13, 'This template is for sending notice to client when password is changed', '1', 13, 'Verify your email address', 'Hello {{user}},<br /><br />Your password is successfully changed.Your new password is : {{user_password}}<br /><br />Thank You.<br /><br />Kind Regards,<br /> {{system_from}}', '', 1, '2016-12-13 03:19:52', '2016-12-13 03:19:52'),
	(14, 'This template is to notify users when their tickets are merged.', '1', 14, 'Your tickets have been merged.', '<p>Hello {!!$user!!},<br />&nbsp;</p><p>Your ticket(s) with ticket number {!!$merged_ticket_numbers!!} have been closed and&nbsp;merged with <a href="{!!$ticket_link!!}">{!!$ticket_number!!}</a>.&nbsp;</p><p>Possible reasons for merging tickets</p><ul><li>Tickets are duplicate</li<li>Tickets state&nbsp;the same issue</li><li>Another member from your organization has created a ticket for the same issue</li></ul><p><a href="{!!$system_link!!}">Click here</a> to login to your account and check your tickets.</p><p>Regards,</p><p>{!!$system_from!!}</p>', '', 1, '2017-01-02 00:20:12', '2017-01-02 00:31:50'),
	(15, 'This template is for sending notice to client when ticket status is changed to resolved', '0', 15, 'Ticket Resolved', '<div>Dear Esteemed Client,<br /><br />This message is regarding your ticket ID {{ticket_no}}. We are changing the status of this ticket to "Resolved" as the issue appears to be resolved.<br /><br />Thank you<br />Kind regards,<br /> {{department}}</div>', ' ', 1, '2025-06-01 12:34:12', '2025-06-01 12:34:15');

-- Dumping structure for table rt_oris.template_types
DROP TABLE IF EXISTS `template_types`;
CREATE TABLE IF NOT EXISTS `template_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rt_oris.template_types: ~15 rows (approximately)
DELETE FROM `template_types`;
INSERT INTO `template_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'assign-ticket', '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(2, 'check-ticket', '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(3, 'close-ticket', '2016-12-13 03:19:47', '2016-12-13 03:19:47'),
	(4, 'create-ticket', '2016-12-13 03:19:48', '2016-12-13 03:19:48'),
	(5, 'create-ticket-agent', '2016-12-13 03:19:48', '2016-12-13 03:19:48'),
	(6, 'create-ticket-by-agent', '2016-12-13 03:19:48', '2016-12-13 03:19:48'),
	(7, 'registration-notification', '2016-12-13 03:19:48', '2016-12-13 03:19:48'),
	(8, 'reset-password', '2016-12-13 03:19:48', '2016-12-13 03:19:48'),
	(9, 'ticket-reply', '2016-12-13 03:19:48', '2016-12-13 03:19:48'),
	(10, 'ticket-reply-agent', '2016-12-13 03:19:48', '2016-12-13 03:19:48'),
	(11, 'registration', '2016-12-13 03:19:48', '2016-12-13 03:19:48'),
	(12, 'team_assign_ticket', '2016-12-13 03:19:48', '2016-12-13 03:19:48'),
	(13, 'reset_new_password', '2016-12-13 03:19:48', '2016-12-13 03:19:48'),
	(14, 'merge-ticket-notification', '2017-01-02 00:20:11', '2017-01-02 00:20:11'),
	(15, 'resolve-ticket', '2025-06-01 12:32:59', '2025-06-01 12:32:57');

-- Dumping structure for table rt_oris.tickets
DROP TABLE IF EXISTS `tickets`;
CREATE TABLE IF NOT EXISTS `tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_no` varchar(45) NOT NULL,
  `customer_id` int(10) unsigned NOT NULL DEFAULT 0,
  `priority_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `ticket_type_id` int(10) unsigned NOT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `company_id` int(11) unsigned NOT NULL,
  `dept_id` int(11) unsigned NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `first_response_at` datetime DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `sla_policy_id` int(11) DEFAULT NULL,
  `sla_duration` int(11) DEFAULT NULL,
  `escalated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.tickets: ~27 rows (approximately)
DELETE FROM `tickets`;
INSERT INTO `tickets` (`id`, `ticket_no`, `customer_id`, `priority_id`, `channel_id`, `ticket_type_id`, `subject`, `status_id`, `company_id`, `dept_id`, `description`, `first_response_at`, `resolved_at`, `closed_at`, `created_at`, `updated_at`, `sla_policy_id`, `sla_duration`, `escalated_at`, `phone`, `email`) VALUES
	(1, '100000001', 1, 1, 2, 1, '[This is the initial test for the mail channel] - 100000001', 2, 2, 3, 'Dear support i have been having issues with my internet connection for the last 3 days. Kindly resolve.', '2025-05-23 12:18:20', NULL, NULL, '2025-05-23 09:15:49', '2025-07-23 02:26:07', NULL, NULL, NULL, NULL, 'walter.omedo@gmail.com'),
	(2, '100000002', 0, 1, 3, 2, '[Good Morning, I am having a problem with my internet connection. Please look into it] - 100000002', 4, 2, 3, 'Good Morning, I am having a problem with my internet connection. Please look into it', '2025-05-24 05:18:59', '2025-07-26 09:34:51', '2025-07-26 09:38:51', '2025-05-24 02:16:10', '2025-07-31 03:16:00', NULL, NULL, NULL, NULL, NULL),
	(3, '100000003', 1, 1, 1, 2, '[Test Web Portal Ticket] - 100000003', 1, 2, 3, 'Test web Portal Ticket Description', NULL, NULL, NULL, '2025-05-31 04:57:48', '2025-05-31 04:57:48', NULL, NULL, NULL, NULL, NULL),
	(4, '100000004', 1, 1, 1, 2, 'Test Web Portal Ticket- [100000004]', 3, 2, 3, 'Test web Portal Ticket Description', '2025-07-03 16:50:15', NULL, NULL, '2025-07-01 04:04:32', '2025-07-03 13:50:15', NULL, NULL, NULL, '254724802834', 'omedo.walter@eclectics.io'),
	(6, '100000005', 1, 1, 2, 1, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.- [100000005]', 3, 2, 3, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,', '2025-07-01 17:08:06', NULL, NULL, '2025-07-01 14:03:11', '2025-07-01 14:08:06', NULL, NULL, NULL, '', 'walter.omedo@gmail.com'),
	(7, '100000006', 0, 3, 2, 2, 'Test Subject- [100000006]', 3, 2, 3, '<p>Test Description</p>', '2025-07-05 11:56:04', NULL, NULL, '2025-07-05 08:43:58', '2025-07-05 08:56:04', NULL, NULL, NULL, '254724802834', 'wadamba@yahoo.com'),
	(8, '100000007', 1, 3, 2, 2, 'Where does it come from?- [100000007]', 1, 2, 3, '<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.</p>', NULL, NULL, NULL, '2025-07-05 09:19:34', '2025-07-05 09:19:34', NULL, NULL, NULL, '724802834', 'walter.omedo@gmail.com'),
	(9, '100000008', 1, 3, 2, 2, 'Where can I get some?- [100000008]', 1, 2, 3, '<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>', NULL, NULL, NULL, '2025-07-05 09:27:07', '2025-07-05 09:27:07', NULL, NULL, NULL, '254724802834', 'walter.omedo@gmail.com'),
	(10, '100000009', 1, 1, 1, 2, 'Why do we use it?- [100000009]', 1, 2, 2, '<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English.</p><p>&nbsp;Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>', NULL, NULL, NULL, '2025-07-05 09:54:21', '2025-07-05 09:54:21', NULL, NULL, NULL, '254724802834', 'walter.omedo@gmail.com'),
	(11, '100000010', 1, 1, 1, 2, 'Non dolore eius vel- [100000010]', 1, 2, 3, '<h4>Why is this form playing mind games with me? Like wtf is actually going on here.</h4>', NULL, NULL, NULL, '2025-07-22 03:38:22', '2025-07-22 03:38:22', NULL, NULL, NULL, '254724802834', 'walter.omedo@gmail.com'),
	(12, '100000011', 0, 1, 2, 2, 'Urgent: Signature Required for This Document N 76443380- [100000011]', 1, 2, 1, '<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>\r\n\r\n\r\n    <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>\r\n\r\n\r\n\r\n    <div>\r\n        <div style="FONT-SIZE: 12px; FONT-FAMILY: Verdana">\r\n            <div>&nbsp;\r\n                <div>&nbsp;\r\n                    <div style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 10px; BORDER-LEFT: rgb(195,217,229) 2px solid; MARGIN: 10px 5px 5px 10px; PADDING-RIGHT: 0pt">\r\n                        <div style="MARGIN: 0pt 0pt 10px"><b><br/></b></div>\r\n                        <div>\r\n                            <div style="FONT-FAMILY: Helvetica,Arial,Sans Serif; PADDING-BOTTOM: 2%; PADDING-TOP: 2%; PADDING-LEFT: 2%; PADDING-RIGHT: 2%; BACKGROUND-COLOR: rgb(234,234,234)">\r\n                                <img style="DISPLAY: none"/>\r\n                                <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                    <tbody>\r\n                                        <tr>\r\n                                            <td>&nbsp;</td>\r\n                                            <td width="640">\r\n                                                <table style="MAX-WIDTH: 640px; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: rgb(255,255,255)">\r\n                                                    <tbody>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px">\r\n                                                                <img src="https://eu.docusign.net/Member/Images/email/logo-DS-116x33@2x.png" style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none" width="116"/></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 30px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px">\r\n                                                                <table align="center" border="0" cellpadding="0" cellspacing="0" style="COLOR: rgb(255,255,255); BACKGROUND-COLOR: rgb(30,76,161)" width="100%">\r\n                                                                    <tbody>\r\n                                                                        <tr>\r\n                                                                            <td align="center" style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; WIDTH: 100%; COLOR: rgb(255,255,255); PADDING-BOTTOM: 36px; TEXT-ALIGN: center; PADDING-TOP: 28px; PADDING-LEFT: 36px; PADDING-RIGHT: 36px; BACKGROUND-COLOR: rgb(33,73,165)"><img height="75" src="https://eu.docusign.net/member/Images/email/docInvite-white.png" style="HEIGHT: 75px; WIDTH: 75px" width="75"/>\r\n                                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                                                                    <tbody>\r\n                                                                                        <tr>\r\n                                                                                            <td align="center" style="FONT-SIZE: 17px; BORDER-TOP: medium none; FONT-FAMILY: Helvetica,Arial,Sans Serif; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; COLOR: rgb(255,255,255); TEXT-ALIGN: center; PADDING-TOP: 24px; BORDER-LEFT: medium none">Please\r\n                                                                                                review your\r\n                                                                                                file.\r\n                                                                                            </td>\r\n                                                                                        </tr>\r\n                                                                                    </tbody>\r\n                                                                                </table>\r\n                                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                                                                    <tbody>\r\n                                                                                        <tr>\r\n                                                                                            <td align="center" style="PADDING-TOP: 30px">\r\n                                                                                                <div>\r\n                                                                                                    <table cellpadding="0" cellspacing="0">\r\n                                                                                                        <tbody>\r\n                                                                                                            <tr>\r\n                                                                                                                <td align="center" min-height="44" style="FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Helvetica,Arial,Sans Serif; FONT-WEIGHT: bold; COLOR: rgb(51,51,51); TEXT-ALIGN: center; DISPLAY: block; BACKGROUND-COLOR: rgb(255,195,35)">\r\n                                                                                                                    <a href="https://www.google.com/url?q=https%3A%2F%2Fdocusign7337.na3.to&amp;sa=D&amp;sntz=1&amp;usg=AOvVaw2NmpR7FjeNgwY6xFxywRuC" style="FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Helvetica,Arial,Sans Serif; FONT-WEIGHT: bold; COLOR: rgb(51,51,51); TEXT-ALIGN: center; BACKGROUND-COLOR: rgb(256,196,36)"><span style="PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 24px; LINE-HEIGHT: 44px; PADDING-RIGHT: 24px">Review\r\n                                                                                                                            and\r\n                                                                                                                            Sign</span></a>\r\n                                                                                                                </td>\r\n                                                                                                            </tr>\r\n                                                                                                        </tbody>\r\n                                                                                                    </table>\r\n                                                                                                </div>\r\n                                                                                            </td>\r\n                                                                                        </tr>\r\n                                                                                    </tbody>\r\n                                                                                </table>\r\n                                                                            </td>\r\n                                                                        </tr>\r\n                                                                    </tbody>\r\n                                                                </table>\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(255,255,255); PADDING-BOTTOM: 24px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: white">\r\n                                                                <span style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(53,59,50); LINE-HEIGHT: 20px">Digitally\r\n                                                                    signing\r\n                                                                    docs with DocuSign is\r\n                                                                    reliable, risk-free and\r\n                                                                    will only\r\n                                                                    require a couple\r\n                                                                    of minutes of your time. <br/><br/></span></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="FONT-SIZE: 11px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(102,102,102); PADDING-BOTTOM: 12px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: rgb(255,255,255)">\r\n                                                                <br/></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 45px; PADDING-TOP: 30px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: rgb(234,234,234)">\r\n                                                                <p style="FONT-SIZE: 13px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(100,109,105); LINE-HEIGHT: 18px">\r\n                                                                    <b>This is an\r\n                                                                        automatically\r\n                                                                        created\r\n                                                                        notice. This specific\r\n                                                                        letter\r\n                                                                        holds a\r\n                                                                        private material.\r\n                                                                        Please will\r\n                                                                        not display this\r\n                                                                        letter to\r\n                                                                        other individuals.</b>\r\n                                                                </p>\r\n                                                                <p style="FONT-SIZE: 13px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(102,102,101); LINE-HEIGHT: 18px">\r\n                                                                    <b>Additional Signing\r\n                                                                        Approach&nbsp;</b><br/>Please check out DocuSign,\r\n                                                                    simply click\r\n                                                                    &#39;Access Documents&#39;,\r\n                                                                    enter in the code\r\n                                                                    provided in your\r\n                                                                    document.</p>\r\n                                                                <p style="FONT-SIZE: 12px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(103,103,109); LINE-HEIGHT: 18px">\r\n                                                                    <b>Our\r\n                                                                        Service</b><br/>Sign\r\n                                                                    Paperwork and Invoices just using couple\r\n                                                                    of clicks.\r\n                                                                    It is secure.\r\n                                                                    No matter if you&#39;re at your\r\n                                                                    workplace, in your own home or on-the-go --\r\n                                                                    Our service provides an expert\r\n                                                                    alternative for\r\n                                                                    Digital\r\n                                                                    Operations.</p>\r\n                                                                <p style="FONT-SIZE: 14px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(108,107,101); LINE-HEIGHT: 18px">\r\n                                                                    <b>Got\r\n                                                                        concerns?</b><br/>In\r\n                                                                    case you require to change\r\n                                                                    an invoice or have questions,\r\n                                                                    message the sender\r\n                                                                    directly.<br/><br/>If\r\n                                                                    perhaps you are unable\r\n                                                                    to view your\r\n                                                                    document, check\r\n                                                                    out\r\n																	<a href="#" style="TEXT-DECORATION: none; COLOR: rgb(53,126,235)" target="_blank">Help with Signing webpage.</a><br/>&nbsp; <br/>\r\n                                                                </p>\r\n                                                                <p style="FONT-SIZE: 14px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(104,106,107); LINE-HEIGHT: 18px">\r\n                                                                    <a href="https://www.google.com/url?q=https%3A%2F%2Fdocusign7337.na3.to&amp;sa=D&amp;sntz=1&amp;usg=AOvVaw2NmpR7FjeNgwY6xFxywRuC" style="TEXT-DECORATION: none; COLOR: rgb(53,126,235)" target="_blank"><img height="18" src="https://eu.docusign.net/Member/Images/email/icon-DownloadApp-18x18@2x.png" style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; VERTICAL-ALIGN: middle; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; MARGIN-RIGHT: 7px" width="18"/>Please sign\r\n                                                                        your file </a></p>\r\n                                                                <p style="FONT-SIZE: 9px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(102,109,107); LINE-HEIGHT: 14px">\r\n                                                                    You have been\r\n                                                                    mailed a file for\r\n                                                                    electronic\r\n                                                                    signing.<br/></p>\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                    </tbody>\r\n                                                </table>\r\n                                            </td>\r\n                                            <td>&nbsp;</td>\r\n                                        </tr>\r\n                                    </tbody>\r\n                                </table>\r\n                            </div>\r\n                        </div>\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n\r\n\r\n</div></div></body></html>', NULL, NULL, NULL, '2025-07-24 04:47:58', '2025-07-31 03:21:35', NULL, NULL, NULL, '', 'stefanyba00@gmx.com'),
	(13, '100000012', 0, 1, 2, 2, 'Sign Your Agreement in Just a Few Clicks N 318675- [100000012]', 3, 2, 1, '<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>\r\n\r\n\r\n    <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>\r\n\r\n\r\n\r\n    <div>\r\n        <div style="FONT-SIZE: 12px; FONT-FAMILY: Verdana">\r\n            <div>&nbsp;\r\n                <div>&nbsp;\r\n                    <div style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 10px; BORDER-LEFT: rgb(195,217,229) 2px solid; MARGIN: 10px 5px 5px 10px; PADDING-RIGHT: 0pt">\r\n                        <div style="MARGIN: 0pt 0pt 10px"><b><br/></b></div>\r\n                        <div>\r\n                            <div style="FONT-FAMILY: Helvetica,Arial,Sans Serif; PADDING-BOTTOM: 2%; PADDING-TOP: 2%; PADDING-LEFT: 2%; PADDING-RIGHT: 2%; BACKGROUND-COLOR: rgb(234,234,234)">\r\n                                <img style="DISPLAY: none"/>\r\n                                <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                    <tbody>\r\n                                        <tr>\r\n                                            <td>&nbsp;</td>\r\n                                            <td width="640">\r\n                                                <table style="MAX-WIDTH: 640px; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: rgb(255,255,255)">\r\n                                                    <tbody>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px">\r\n                                                                <img src="https://eu.docusign.net/Member/Images/email/logo-DS-116x33@2x.png" style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none" width="116"/></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 30px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px">\r\n                                                                <table align="center" border="0" cellpadding="0" cellspacing="0" style="COLOR: rgb(255,255,255); BACKGROUND-COLOR: rgb(30,76,161)" width="100%">\r\n                                                                    <tbody>\r\n                                                                        <tr>\r\n                                                                            <td align="center" style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; WIDTH: 100%; COLOR: rgb(255,255,255); PADDING-BOTTOM: 36px; TEXT-ALIGN: center; PADDING-TOP: 28px; PADDING-LEFT: 36px; PADDING-RIGHT: 36px; BACKGROUND-COLOR: rgb(33,73,165)"><img height="75" src="https://eu.docusign.net/member/Images/email/docInvite-white.png" style="HEIGHT: 75px; WIDTH: 75px" width="75"/>\r\n                                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                                                                    <tbody>\r\n                                                                                        <tr>\r\n                                                                                            <td align="center" style="FONT-SIZE: 25px; BORDER-TOP: medium none; FONT-FAMILY: Helvetica,Arial,Sans Serif; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; COLOR: rgb(255,255,255); TEXT-ALIGN: center; PADDING-TOP: 24px; BORDER-LEFT: medium none">Please\r\n                                                                                                review your\r\n                                                                                                document.\r\n                                                                                            </td>\r\n                                                                                        </tr>\r\n                                                                                    </tbody>\r\n                                                                                </table>\r\n                                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                                                                    <tbody>\r\n                                                                                        <tr>\r\n                                                                                            <td align="center" style="PADDING-TOP: 30px">\r\n                                                                                                <div>\r\n                                                                                                    <table cellpadding="0" cellspacing="0">\r\n                                                                                                        <tbody>\r\n                                                                                                            <tr>\r\n                                                                                                                <td align="center" min-height="44" style="FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Helvetica,Arial,Sans Serif; FONT-WEIGHT: bold; COLOR: rgb(51,51,51); TEXT-ALIGN: center; DISPLAY: block; BACKGROUND-COLOR: rgb(255,195,35)">\r\n                                                                                                                    <a href="https://www.google.com/url?q=https%3A%2F%2Fdocusign9226.na3.to&amp;sa=D&amp;sntz=1&amp;usg=AOvVaw3mzg_dSzPyD2pXHfz3YBeN" style="FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Helvetica,Arial,Sans Serif; FONT-WEIGHT: bold; COLOR: rgb(51,51,51); TEXT-ALIGN: center; BACKGROUND-COLOR: rgb(256,196,36)"><span style="PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 24px; LINE-HEIGHT: 44px; PADDING-RIGHT: 24px">Review\r\n                                                                                                                            and\r\n                                                                                                                            Sign</span></a>\r\n                                                                                                                </td>\r\n                                                                                                            </tr>\r\n                                                                                                        </tbody>\r\n                                                                                                    </table>\r\n                                                                                                </div>\r\n                                                                                            </td>\r\n                                                                                        </tr>\r\n                                                                                    </tbody>\r\n                                                                                </table>\r\n                                                                            </td>\r\n                                                                        </tr>\r\n                                                                    </tbody>\r\n                                                                </table>\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(255,255,255); PADDING-BOTTOM: 24px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: white">\r\n                                                                <span style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(56,50,54); LINE-HEIGHT: 20px">Signing digital\r\n                                                                    docs is\r\n                                                                    reliable, secure and\r\n                                                                    only going to\r\n                                                                    require a few minutes of your time\r\n                                                                    and effort. <br/><br/></span></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="FONT-SIZE: 11px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(102,102,102); PADDING-BOTTOM: 12px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: rgb(255,255,255)">\r\n                                                                <br/></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 45px; PADDING-TOP: 30px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: rgb(234,234,234)">\r\n                                                                <p style="FONT-SIZE: 14px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(109,103,102); LINE-HEIGHT: 18px">\r\n                                                                    <b>This is an\r\n                                                                        electronically\r\n                                                                        made\r\n                                                                        notice. This\r\n                                                                        particular\r\n                                                                        communication\r\n                                                                        holds a\r\n                                                                        private info.\r\n                                                                        Please will\r\n                                                                        not display this\r\n                                                                        e-mail to\r\n                                                                        other individuals.</b>\r\n                                                                </p>\r\n                                                                <p style="FONT-SIZE: 12px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(104,109,102); LINE-HEIGHT: 18px">\r\n                                                                    <b>Other Method&nbsp;</b><br/>Please go to DocuSign,\r\n                                                                    simply click\r\n                                                                    &#39;Files&#39;,\r\n                                                                    enter in the code\r\n                                                                    delivered in your\r\n                                                                    invoice/document.</p>\r\n                                                                <p style="FONT-SIZE: 14px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(106,104,108); LINE-HEIGHT: 18px">\r\n                                                                    <b>About Docusign</b><br/>Sign\r\n                                                                    Docs and Debts in\r\n                                                                    just few clicks.\r\n                                                                    It&#39;s safe.\r\n                                                                    Whether you may be at the office, at\r\n                                                                    your house or on-the-go --\r\n                                                                    Our service offers a pro\r\n                                                                    alternative for\r\n                                                                    Digital\r\n                                                                    Operations.</p>\r\n                                                                <p style="FONT-SIZE: 13px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(104,105,103); LINE-HEIGHT: 18px">\r\n                                                                    <b>Have\r\n                                                                        problems?</b><br/>In\r\n                                                                    case you would like to change\r\n                                                                    your document or have questions,\r\n                                                                    message the sender\r\n                                                                    directly.<br/><br/>If\r\n                                                                    perhaps you are not able to see your\r\n                                                                    document, visit\r\n																	<a href="#" style="TEXT-DECORATION: none; COLOR: rgb(53,126,235)" target="_blank">Help with Signing site.</a><br/>&nbsp; <br/>\r\n                                                                </p>\r\n                                                                <p style="FONT-SIZE: 13px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(105,108,103); LINE-HEIGHT: 18px">\r\n                                                                    <a href="https://www.google.com/url?q=https%3A%2F%2Fdocusign9226.na3.to&amp;sa=D&amp;sntz=1&amp;usg=AOvVaw3mzg_dSzPyD2pXHfz3YBeN" style="TEXT-DECORATION: none; COLOR: rgb(53,126,235)" target="_blank"><img height="18" src="https://eu.docusign.net/Member/Images/email/icon-DownloadApp-18x18@2x.png" style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; VERTICAL-ALIGN: middle; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; MARGIN-RIGHT: 7px" width="18"/>Please sign\r\n                                                                        your document </a></p>\r\n                                                                <p style="FONT-SIZE: 10px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(105,105,101); LINE-HEIGHT: 14px">\r\n                                                                    You&#39;ve been\r\n                                                                    sent a file for\r\n                                                                    electronic\r\n                                                                    signature.<br/></p>\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                    </tbody>\r\n                                                </table>\r\n                                            </td>\r\n                                            <td>&nbsp;</td>\r\n                                        </tr>\r\n                                    </tbody>\r\n                                </table>\r\n                            </div>\r\n                        </div>\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n\r\n\r\n</div></div></body></html>', '2025-07-24 12:03:11', NULL, NULL, '2025-07-24 04:48:06', '2025-07-31 03:21:35', NULL, NULL, NULL, '', 'nobbelepmlynsey@gmx.com'),
	(14, '100000013', 0, 1, 2, 2, 'Securely Sign Your Document with One Click N 67517449- [100000013]', 1, 2, 1, '<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>\r\n\r\n\r\n    <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>\r\n\r\n\r\n\r\n    <div>\r\n        <div style="FONT-SIZE: 12px; FONT-FAMILY: Verdana">\r\n            <div>&nbsp;\r\n                <div>&nbsp;\r\n                    <div style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 10px; BORDER-LEFT: rgb(195,217,229) 2px solid; MARGIN: 10px 5px 5px 10px; PADDING-RIGHT: 0pt">\r\n                        <div style="MARGIN: 0pt 0pt 10px"><b><br/></b></div>\r\n                        <div>\r\n                            <div style="FONT-FAMILY: Helvetica,Arial,Sans Serif; PADDING-BOTTOM: 2%; PADDING-TOP: 2%; PADDING-LEFT: 2%; PADDING-RIGHT: 2%; BACKGROUND-COLOR: rgb(234,234,234)">\r\n                                <img style="DISPLAY: none"/>\r\n                                <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                    <tbody>\r\n                                        <tr>\r\n                                            <td>&nbsp;</td>\r\n                                            <td width="640">\r\n                                                <table style="MAX-WIDTH: 640px; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: rgb(255,255,255)">\r\n                                                    <tbody>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px">\r\n                                                                <img src="https://eu.docusign.net/Member/Images/email/logo-DS-116x33@2x.png" style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none" width="116"/></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 30px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px">\r\n                                                                <table align="center" border="0" cellpadding="0" cellspacing="0" style="COLOR: rgb(255,255,255); BACKGROUND-COLOR: rgb(30,76,161)" width="100%">\r\n                                                                    <tbody>\r\n                                                                        <tr>\r\n                                                                            <td align="center" style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; WIDTH: 100%; COLOR: rgb(255,255,255); PADDING-BOTTOM: 36px; TEXT-ALIGN: center; PADDING-TOP: 28px; PADDING-LEFT: 36px; PADDING-RIGHT: 36px; BACKGROUND-COLOR: rgb(33,73,165)"><img height="75" src="https://eu.docusign.net/member/Images/email/docInvite-white.png" style="HEIGHT: 75px; WIDTH: 75px" width="75"/>\r\n                                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                                                                    <tbody>\r\n                                                                                        <tr>\r\n                                                                                            <td align="center" style="FONT-SIZE: 21px; BORDER-TOP: medium none; FONT-FAMILY: Helvetica,Arial,Sans Serif; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; COLOR: rgb(255,255,255); TEXT-ALIGN: center; PADDING-TOP: 24px; BORDER-LEFT: medium none">Review  your\r\n                                                                                                file.\r\n                                                                                            </td>\r\n                                                                                        </tr>\r\n                                                                                    </tbody>\r\n                                                                                </table>\r\n                                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                                                                    <tbody>\r\n                                                                                        <tr>\r\n                                                                                            <td align="center" style="PADDING-TOP: 30px">\r\n                                                                                                <div>\r\n                                                                                                    <table cellpadding="0" cellspacing="0">\r\n                                                                                                        <tbody>\r\n                                                                                                            <tr>\r\n                                                                                                                <td align="center" min-height="44" style="FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Helvetica,Arial,Sans Serif; FONT-WEIGHT: bold; COLOR: rgb(51,51,51); TEXT-ALIGN: center; DISPLAY: block; BACKGROUND-COLOR: rgb(255,195,35)">\r\n                                                                                                                    <a href="https://www.google.com/url?q=https%3A%2F%2Fdocusign6444.na4.to&amp;sa=D&amp;sntz=1&amp;usg=AOvVaw1xBNk235-7itisKg3qUqtq" style="FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Helvetica,Arial,Sans Serif; FONT-WEIGHT: bold; COLOR: rgb(51,51,51); TEXT-ALIGN: center; BACKGROUND-COLOR: rgb(256,196,36)"><span style="PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 24px; LINE-HEIGHT: 44px; PADDING-RIGHT: 24px">Review\r\n                                                                                                                            and\r\n                                                                                                                            Sign</span></a>\r\n                                                                                                                </td>\r\n                                                                                                            </tr>\r\n                                                                                                        </tbody>\r\n                                                                                                    </table>\r\n                                                                                                </div>\r\n                                                                                            </td>\r\n                                                                                        </tr>\r\n                                                                                    </tbody>\r\n                                                                                </table>\r\n                                                                            </td>\r\n                                                                        </tr>\r\n                                                                    </tbody>\r\n                                                                </table>\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(255,255,255); PADDING-BOTTOM: 24px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: white">\r\n                                                                <span style="FONT-SIZE: 13px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(57,52,55); LINE-HEIGHT: 20px">Signing digital\r\n                                                                    docs with DocuSign is\r\n                                                                    safe, secure and\r\n                                                                    will only\r\n                                                                    require a little bit of your time. <br/><br/></span></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="FONT-SIZE: 11px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(102,102,102); PADDING-BOTTOM: 12px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: rgb(255,255,255)">\r\n                                                                <br/></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 45px; PADDING-TOP: 30px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: rgb(234,234,234)">\r\n                                                                <p style="FONT-SIZE: 12px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(106,107,101); LINE-HEIGHT: 18px">\r\n                                                                    <b>It is an\r\n                                                                        electronically\r\n                                                                        created\r\n                                                                        notification. This\r\n                                                                        particular\r\n                                                                        communication\r\n                                                                        contains a\r\n                                                                        secure information.\r\n                                                                        Make sure you do not show this\r\n                                                                        e-mail to\r\n                                                                        others.</b>\r\n                                                                </p>\r\n                                                                <p style="FONT-SIZE: 12px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(103,103,109); LINE-HEIGHT: 18px">\r\n                                                                    <b>Other Signing\r\n                                                                        Approach&nbsp;</b><br/>Make\r\n                                                                    sure you go to Home page,\r\n                                                                    simply click\r\n                                                                    &#39;Docs&#39;,\r\n                                                                    enter the code\r\n                                                                    provided in your\r\n                                                                    invoice/document.</p>\r\n                                                                <p style="FONT-SIZE: 14px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(108,109,101); LINE-HEIGHT: 18px">\r\n                                                                    <b>About Our\r\n                                                                        Service</b><br/>Sign\r\n                                                                    Documents and Bills just using couple\r\n                                                                    of mouse clicks.\r\n                                                                    It is secure.\r\n                                                                    No matter if you&#39;re at your\r\n                                                                    workplace, at\r\n                                                                    your house --\r\n                                                                    Our service offers an expert\r\n                                                                    option for\r\n                                                                    Electronic\r\n                                                                    Procedures.</p>\r\n                                                                <p style="FONT-SIZE: 12px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(104,100,101); LINE-HEIGHT: 18px">\r\n                                                                    <b>Got\r\n                                                                        concerns?</b><br/>If perhaps you will\r\n                                                                    need to change\r\n                                                                    an invoice or have questions,\r\n                                                                    message the sender\r\n                                                                    direct.<br/><br/>If you are not able to sign your\r\n                                                                    document, check\r\n                                                                    out\r\n																	<a href="#" style="TEXT-DECORATION: none; COLOR: rgb(53,126,235)" target="_blank">Help with Signing site.</a><br/>&nbsp; <br/>\r\n                                                                </p>\r\n                                                                <p style="FONT-SIZE: 13px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(105,107,109); LINE-HEIGHT: 18px">\r\n                                                                    <a href="https://www.google.com/url?q=https%3A%2F%2Fdocusign6444.na4.to&amp;sa=D&amp;sntz=1&amp;usg=AOvVaw1xBNk235-7itisKg3qUqtq" style="TEXT-DECORATION: none; COLOR: rgb(53,126,235)" target="_blank"><img height="18" src="https://eu.docusign.net/Member/Images/email/icon-DownloadApp-18x18@2x.png" style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; VERTICAL-ALIGN: middle; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; MARGIN-RIGHT: 7px" width="18"/>Please sign\r\n                                                                        your file </a></p>\r\n                                                                <p style="FONT-SIZE: 11px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(107,101,105); LINE-HEIGHT: 14px">\r\n                                                                    You have been\r\n                                                                    provided a file for\r\n                                                                    electronic\r\n                                                                    signature.<br/></p>\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                    </tbody>\r\n                                                </table>\r\n                                            </td>\r\n                                            <td>&nbsp;</td>\r\n                                        </tr>\r\n                                    </tbody>\r\n                                </table>\r\n                            </div>\r\n                        </div>\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n\r\n\r\n</div></div></body></html>', NULL, NULL, NULL, '2025-07-24 04:48:13', '2025-07-31 03:21:35', NULL, NULL, NULL, '', 'loges.fleur@gmx.com'),
	(15, '100000014', 0, 1, 2, 2, 'Sign Your Agreement Electronically Now N 46641- [100000014]', 1, 2, 1, '<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>\r\n\r\n\r\n    <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>\r\n\r\n\r\n\r\n    <div>\r\n        <div style="FONT-SIZE: 12px; FONT-FAMILY: Verdana">\r\n            <div>&nbsp;\r\n                <div>&nbsp;\r\n                    <div style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 10px; BORDER-LEFT: rgb(195,217,229) 2px solid; MARGIN: 10px 5px 5px 10px; PADDING-RIGHT: 0pt">\r\n                        <div style="MARGIN: 0pt 0pt 10px"><b><br/></b></div>\r\n                        <div>\r\n                            <div style="FONT-FAMILY: Helvetica,Arial,Sans Serif; PADDING-BOTTOM: 2%; PADDING-TOP: 2%; PADDING-LEFT: 2%; PADDING-RIGHT: 2%; BACKGROUND-COLOR: rgb(234,234,234)">\r\n                                <img style="DISPLAY: none"/>\r\n                                <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                    <tbody>\r\n                                        <tr>\r\n                                            <td>&nbsp;</td>\r\n                                            <td width="640">\r\n                                                <table style="MAX-WIDTH: 640px; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: rgb(255,255,255)">\r\n                                                    <tbody>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px">\r\n                                                                <img src="https://eu.docusign.net/Member/Images/email/logo-DS-116x33@2x.png" style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none" width="116"/></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 30px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px">\r\n                                                                <table align="center" border="0" cellpadding="0" cellspacing="0" style="COLOR: rgb(255,255,255); BACKGROUND-COLOR: rgb(30,76,161)" width="100%">\r\n                                                                    <tbody>\r\n                                                                        <tr>\r\n                                                                            <td align="center" style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; WIDTH: 100%; COLOR: rgb(255,255,255); PADDING-BOTTOM: 36px; TEXT-ALIGN: center; PADDING-TOP: 28px; PADDING-LEFT: 36px; PADDING-RIGHT: 36px; BACKGROUND-COLOR: rgb(33,73,165)"><img height="75" src="https://eu.docusign.net/member/Images/email/docInvite-white.png" style="HEIGHT: 75px; WIDTH: 75px" width="75"/>\r\n                                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                                                                    <tbody>\r\n                                                                                        <tr>\r\n                                                                                            <td align="center" style="FONT-SIZE: 24px; BORDER-TOP: medium none; FONT-FAMILY: Helvetica,Arial,Sans Serif; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; COLOR: rgb(255,255,255); TEXT-ALIGN: center; PADDING-TOP: 24px; BORDER-LEFT: medium none">Please\r\n                                                                                                review and\r\n                                                                                                sign your\r\n                                                                                                file.\r\n                                                                                            </td>\r\n                                                                                        </tr>\r\n                                                                                    </tbody>\r\n                                                                                </table>\r\n                                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                                                                    <tbody>\r\n                                                                                        <tr>\r\n                                                                                            <td align="center" style="PADDING-TOP: 30px">\r\n                                                                                                <div>\r\n                                                                                                    <table cellpadding="0" cellspacing="0">\r\n                                                                                                        <tbody>\r\n                                                                                                            <tr>\r\n                                                                                                                <td align="center" min-height="44" style="FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Helvetica,Arial,Sans Serif; FONT-WEIGHT: bold; COLOR: rgb(51,51,51); TEXT-ALIGN: center; DISPLAY: block; BACKGROUND-COLOR: rgb(255,195,35)">\r\n                                                                                                                    <a href="https://www.google.com/url?q=https%3A%2F%2Fdocusign8442.na4.to&amp;sa=D&amp;sntz=1&amp;usg=AOvVaw3EKbCH19St0N-bOYuc3izV" style="FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Helvetica,Arial,Sans Serif; FONT-WEIGHT: bold; COLOR: rgb(51,51,51); TEXT-ALIGN: center; BACKGROUND-COLOR: rgb(256,196,36)"><span style="PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 24px; LINE-HEIGHT: 44px; PADDING-RIGHT: 24px">Review\r\n                                                                                                                            and\r\n                                                                                                                            Sign</span></a>\r\n                                                                                                                </td>\r\n                                                                                                            </tr>\r\n                                                                                                        </tbody>\r\n                                                                                                    </table>\r\n                                                                                                </div>\r\n                                                                                            </td>\r\n                                                                                        </tr>\r\n                                                                                    </tbody>\r\n                                                                                </table>\r\n                                                                            </td>\r\n                                                                        </tr>\r\n                                                                    </tbody>\r\n                                                                </table>\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(255,255,255); PADDING-BOTTOM: 24px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: white">\r\n                                                                <span style="FONT-SIZE: 13px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(59,57,57); LINE-HEIGHT: 20px">Digitally\r\n                                                                    signing\r\n                                                                    documents with DocuSign is\r\n                                                                    reliable, risk-free and\r\n                                                                    only going to\r\n                                                                    acquire a little bit of your effort. <br/><br/></span></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="FONT-SIZE: 11px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(102,102,102); PADDING-BOTTOM: 12px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: rgb(255,255,255)">\r\n                                                                <br/></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 45px; PADDING-TOP: 30px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: rgb(234,234,234)">\r\n                                                                <p style="FONT-SIZE: 12px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(104,104,102); LINE-HEIGHT: 18px">\r\n                                                                    <b>It is an\r\n                                                                        electronically\r\n                                                                        made\r\n                                                                        message. This specific\r\n                                                                        email\r\n                                                                        contains a\r\n                                                                        private information.\r\n                                                                        Please do not display this\r\n                                                                        message to\r\n                                                                        other individuals.</b>\r\n                                                                </p>\r\n                                                                <p style="FONT-SIZE: 13px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(103,108,102); LINE-HEIGHT: 18px">\r\n                                                                    <b>Other Approach&nbsp;</b><br/>Please visit Home page,\r\n                                                                    just click\r\n                                                                    &#39;Access Documents&#39;,\r\n                                                                    enter in the code\r\n                                                                    delivered in your\r\n                                                                    invoice/document.</p>\r\n                                                                <p style="FONT-SIZE: 14px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(102,107,102); LINE-HEIGHT: 18px">\r\n                                                                    <b>Our\r\n                                                                        Service</b><br/>Sign\r\n                                                                    Paperwork and Debts in barely very few clicks.\r\n                                                                    It&#39;s risk-free.\r\n                                                                    Whether or not you\r\n                                                                    are in the office, at your home --\r\n                                                                    Our service provides a pro\r\n                                                                    solution for\r\n                                                                    Online\r\n                                                                    Procedures.</p>\r\n                                                                <p style="FONT-SIZE: 14px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(100,101,106); LINE-HEIGHT: 18px">\r\n                                                                    <b>Got\r\n                                                                        problems?</b><br/>If perhaps you would like to edit\r\n                                                                    your document or have questions,\r\n                                                                    make contact with the sender\r\n                                                                    directly.<br/><br/>If\r\n                                                                    perhaps you cannot view your\r\n                                                                    file, see\r\n																	<a href="#" style="TEXT-DECORATION: none; COLOR: rgb(53,126,235)" target="_blank">Support for the Signing site.</a><br/>&nbsp; <br/>\r\n                                                                </p>\r\n                                                                <p style="FONT-SIZE: 14px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(103,107,101); LINE-HEIGHT: 18px">\r\n                                                                    <a href="https://www.google.com/url?q=https%3A%2F%2Fdocusign8442.na4.to&amp;sa=D&amp;sntz=1&amp;usg=AOvVaw3EKbCH19St0N-bOYuc3izV" style="TEXT-DECORATION: none; COLOR: rgb(53,126,235)" target="_blank"><img height="18" src="https://eu.docusign.net/Member/Images/email/icon-DownloadApp-18x18@2x.png" style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; VERTICAL-ALIGN: middle; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; MARGIN-RIGHT: 7px" width="18"/>Sign\r\n                                                                        your file </a></p>\r\n                                                                <p style="FONT-SIZE: 11px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(101,101,101); LINE-HEIGHT: 14px">\r\n                                                                    You&#39;ve been\r\n                                                                    sent a document for\r\n                                                                    digital\r\n                                                                    signing.<br/></p>\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                    </tbody>\r\n                                                </table>\r\n                                            </td>\r\n                                            <td>&nbsp;</td>\r\n                                        </tr>\r\n                                    </tbody>\r\n                                </table>\r\n                            </div>\r\n                        </div>\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n\r\n\r\n</div></div></body></html>', NULL, NULL, NULL, '2025-07-24 04:48:21', '2025-07-31 03:21:35', NULL, NULL, NULL, '', 'shavon_p@gmx.com'),
	(16, '100000015', 0, 1, 2, 2, 'New Digital Signature Request – Act Now N 173815- [100000015]', 1, 2, 1, '<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>\r\n\r\n\r\n    <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>\r\n\r\n\r\n\r\n    <div>\r\n        <div style="FONT-SIZE: 12px; FONT-FAMILY: Verdana">\r\n            <div>&nbsp;\r\n                <div>&nbsp;\r\n                    <div style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 10px; BORDER-LEFT: rgb(195,217,229) 2px solid; MARGIN: 10px 5px 5px 10px; PADDING-RIGHT: 0pt">\r\n                        <div style="MARGIN: 0pt 0pt 10px"><b><br/></b></div>\r\n                        <div>\r\n                            <div style="FONT-FAMILY: Helvetica,Arial,Sans Serif; PADDING-BOTTOM: 2%; PADDING-TOP: 2%; PADDING-LEFT: 2%; PADDING-RIGHT: 2%; BACKGROUND-COLOR: rgb(234,234,234)">\r\n                                <img style="DISPLAY: none"/>\r\n                                <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                    <tbody>\r\n                                        <tr>\r\n                                            <td>&nbsp;</td>\r\n                                            <td width="640">\r\n                                                <table style="MAX-WIDTH: 640px; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: rgb(255,255,255)">\r\n                                                    <tbody>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px">\r\n                                                                <img src="https://eu.docusign.net/Member/Images/email/logo-DS-116x33@2x.png" style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none" width="116"/></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 30px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px">\r\n                                                                <table align="center" border="0" cellpadding="0" cellspacing="0" style="COLOR: rgb(255,255,255); BACKGROUND-COLOR: rgb(30,76,161)" width="100%">\r\n                                                                    <tbody>\r\n                                                                        <tr>\r\n                                                                            <td align="center" style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; WIDTH: 100%; COLOR: rgb(255,255,255); PADDING-BOTTOM: 36px; TEXT-ALIGN: center; PADDING-TOP: 28px; PADDING-LEFT: 36px; PADDING-RIGHT: 36px; BACKGROUND-COLOR: rgb(33,73,165)"><img height="75" src="https://eu.docusign.net/member/Images/email/docInvite-white.png" style="HEIGHT: 75px; WIDTH: 75px" width="75"/>\r\n                                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                                                                    <tbody>\r\n                                                                                        <tr>\r\n                                                                                            <td align="center" style="FONT-SIZE: 18px; BORDER-TOP: medium none; FONT-FAMILY: Helvetica,Arial,Sans Serif; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; COLOR: rgb(255,255,255); TEXT-ALIGN: center; PADDING-TOP: 24px; BORDER-LEFT: medium none">Review  your\r\n                                                                                                document.\r\n                                                                                            </td>\r\n                                                                                        </tr>\r\n                                                                                    </tbody>\r\n                                                                                </table>\r\n                                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">\r\n                                                                                    <tbody>\r\n                                                                                        <tr>\r\n                                                                                            <td align="center" style="PADDING-TOP: 30px">\r\n                                                                                                <div>\r\n                                                                                                    <table cellpadding="0" cellspacing="0">\r\n                                                                                                        <tbody>\r\n                                                                                                            <tr>\r\n                                                                                                                <td align="center" min-height="44" style="FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Helvetica,Arial,Sans Serif; FONT-WEIGHT: bold; COLOR: rgb(51,51,51); TEXT-ALIGN: center; DISPLAY: block; BACKGROUND-COLOR: rgb(255,195,35)">\r\n                                                                                                                    <a href="https://www.google.com/url?q=https%3A%2F%2Fdocusign1441.na4.to&amp;sa=D&amp;sntz=1&amp;usg=AOvVaw2EEFefUaZlXVYJhfjqP1S3" style="FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Helvetica,Arial,Sans Serif; FONT-WEIGHT: bold; COLOR: rgb(51,51,51); TEXT-ALIGN: center; BACKGROUND-COLOR: rgb(256,196,36)"><span style="PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 24px; LINE-HEIGHT: 44px; PADDING-RIGHT: 24px">Review\r\n                                                                                                                            and\r\n                                                                                                                            Sign</span></a>\r\n                                                                                                                </td>\r\n                                                                                                            </tr>\r\n                                                                                                        </tbody>\r\n                                                                                                    </table>\r\n                                                                                                </div>\r\n                                                                                            </td>\r\n                                                                                        </tr>\r\n                                                                                    </tbody>\r\n                                                                                </table>\r\n                                                                            </td>\r\n                                                                        </tr>\r\n                                                                    </tbody>\r\n                                                                </table>\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(255,255,255); PADDING-BOTTOM: 24px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: white">\r\n                                                                <span style="FONT-SIZE: 16px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(59,58,56); LINE-HEIGHT: 20px">Digitally\r\n                                                                    signing\r\n                                                                    docs is\r\n                                                                    reliable, secure and\r\n                                                                    will simply\r\n                                                                    take a little bit of your time. <br/><br/></span></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="FONT-SIZE: 11px; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(102,102,102); PADDING-BOTTOM: 12px; PADDING-TOP: 0px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: rgb(255,255,255)">\r\n                                                                <br/></td>\r\n                                                        </tr>\r\n                                                        <tr>\r\n                                                            <td style="PADDING-BOTTOM: 45px; PADDING-TOP: 30px; PADDING-LEFT: 24px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: rgb(234,234,234)">\r\n                                                                <p style="FONT-SIZE: 13px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(109,103,100); LINE-HEIGHT: 18px">\r\n                                                                    <b>It is an\r\n                                                                        automatically\r\n                                                                        created\r\n                                                                        notification. This\r\n                                                                        particular\r\n                                                                        letter\r\n                                                                        holds a\r\n                                                                        secure info.\r\n                                                                        Please do not reveal this\r\n                                                                        email to\r\n                                                                        other individuals.</b>\r\n                                                                </p>\r\n                                                                <p style="FONT-SIZE: 12px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(100,103,109); LINE-HEIGHT: 18px">\r\n                                                                    <b>Additional Signing\r\n                                                                        Method&nbsp;</b><br/>Make\r\n                                                                    sure you take a look\r\n                                                                    at DocuSign,\r\n                                                                    just click\r\n                                                                    &#39;Docs&#39;,\r\n                                                                    enter the code\r\n                                                                    delivered in your\r\n                                                                    invoice.</p>\r\n                                                                <p style="FONT-SIZE: 14px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(102,109,104); LINE-HEIGHT: 18px">\r\n                                                                    <b>Our\r\n                                                                        Service</b><br/>Sign\r\n                                                                    Written\r\n                                                                    documents and Bills in barely few clicks.\r\n                                                                    It is secure.\r\n                                                                    Whether you may be at work, in your own home or on-the-go --\r\n                                                                    Our service offers a\r\n                                                                    professional\r\n                                                                    solution for\r\n                                                                    Digital\r\n                                                                    Operations.</p>\r\n                                                                <p style="FONT-SIZE: 13px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(105,103,103); LINE-HEIGHT: 18px">\r\n                                                                    <b>Have\r\n                                                                        inquiries?</b><br/>In\r\n                                                                    case you require to modify\r\n                                                                    your document or have questions,\r\n                                                                    message the sender\r\n                                                                    directly.<br/><br/>If\r\n                                                                    perhaps you cannot sign your\r\n                                                                    data file, see\r\n																	<a href="#" style="TEXT-DECORATION: none; COLOR: rgb(53,126,235)" target="_blank">Support for the Signing page.</a><br/>&nbsp; <br/>\r\n                                                                </p>\r\n                                                                <p style="FONT-SIZE: 13px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(107,108,108); LINE-HEIGHT: 18px">\r\n                                                                    <a href="https://www.google.com/url?q=https%3A%2F%2Fdocusign1441.na4.to&amp;sa=D&amp;sntz=1&amp;usg=AOvVaw2EEFefUaZlXVYJhfjqP1S3" style="TEXT-DECORATION: none; COLOR: rgb(53,126,235)" target="_blank"><img height="18" src="https://eu.docusign.net/Member/Images/email/icon-DownloadApp-18x18@2x.png" style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; VERTICAL-ALIGN: middle; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; MARGIN-RIGHT: 7px" width="18"/>Please sign\r\n                                                                        your document </a></p>\r\n                                                                <p style="FONT-SIZE: 9px; MARGIN-BOTTOM: 1em; FONT-FAMILY: Helvetica,Arial,Sans Serif; COLOR: rgb(103,104,105); LINE-HEIGHT: 14px">\r\n                                                                    You&#39;ve been\r\n                                                                    mailed a file for\r\n                                                                    electronic\r\n                                                                    signature.<br/></p>\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                    </tbody>\r\n                                                </table>\r\n                                            </td>\r\n                                            <td>&nbsp;</td>\r\n                                        </tr>\r\n                                    </tbody>\r\n                                </table>\r\n                            </div>\r\n                        </div>\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n\r\n\r\n</div></div></body></html>', NULL, NULL, NULL, '2025-07-24 04:48:28', '2025-07-31 03:21:35', NULL, NULL, NULL, '', 'rolandel01@gmx.com'),
	(17, '100000016', 0, 1, 2, 2, 'Remittance Advice 20250529_980924- [100000016]', 1, 2, 1, '<p>Dear demo,</p>\r\n<p>We have settled all outstanding invoices and are now awaiting your confirmation.</p>\r\n<p>Please find the remittance advice attached for your reference.</p>\r\n<p>If you require any additional information or have any questions, please do not hesitate to contact me.</p>\r\n<p>Best Regards</p>\r\n<p>Finance Director</p>\r\n<p>Harcourt North, Central Victoria</p>\r\n<p>M: 0437 494 303</p>', NULL, NULL, NULL, '2025-07-24 04:48:35', '2025-07-31 03:21:35', NULL, NULL, NULL, '', 'sales@seekjesuschrist.org'),
	(18, '100000017', 0, 1, 2, 2, 'Your MetaMask was used to sign in to Trust via a web browser extension- [100000017]', 1, 2, 1, '<!DOCTYPE html>\r\n\r\n<html lang="en"><head>\r\n<meta http-equiv="X-UA-Compatible" content="IE=edge">\r\n<meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>MetaMask Notification</title>\r\n    <style>\r\n        body {\r\n            font-family: Arial, sans-serif;\r\n            line-height: 1.6;\r\n            color: #333;\r\n            max-width: 600px;\r\n            margin: 0 auto;\r\n            padding: 20px;\r\n            background-color: #f9f9f9;\r\n        }\r\n        .container {\r\n            background-color: #fff;\r\n            padding: 20px;\r\n            border-radius: 8px;\r\n            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);\r\n        }\r\n        .logo {\r\n            display: block;\r\n            margin: 0 auto 20px;\r\n            max-width: 150px;\r\n        }\r\n        .button {\r\n            display: inline-block;\r\n            padding: 10px 20px;\r\n            background-color: #f6851b; /* MetaMask orange */\r\n            color: #fff;\r\n            text-decoration: none;\r\n            border-radius: 4px;\r\n            font-weight: bold;\r\n            margin-top: 20px;\r\n            text-align: center;\r\n        }\r\n        .button:hover {\r\n            background-color: #e57717;\r\n        }\r\n        .footer {\r\n            margin-top: 20px;\r\n            font-size: 0.9em;\r\n            color: #666;\r\n        }\r\n        .footer a {\r\n            color: #f6851b;\r\n            text-decoration: none;\r\n            margin: 0 5px;\r\n        }\r\n        .footer a:hover {\r\n            text-decoration: underline;\r\n        }\r\n    </style>\r\n</head>\r\n<body style="font-family: Arial, sans-serif;\r\n            line-height: 1.6;\r\n            color: #333;\r\n            max-width: 600px;\r\n            margin: 0 auto;\r\n            padding: 20px;\r\n            background-color: #f9f9f9">\r\n    <div style="background-color: #fff;\r\n            padding: 20px;\r\n            border-radius: 8px;\r\n            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1)" class="container">\r\n        <img style="display: block;\r\n            margin: 0 auto 20px;\r\n            max-width: 150px" class="logo" alt="MetaMask Logo" src="https://1000logos.net/wp-content/uploads/2022/05/MetaMask-Emblem.png">\r\n        <p>Dear,</p>\r\n        <p>Your MetaMask Wallet was used to sign in to Trust via a web browser extension.</p>\r\n        <p><strong>Date and Time:</strong> 10 June 2025, 4:07 pm UTC<br>\r\n           <strong>Operating System:</strong> Windows</p>\r\n        <p>If the information above looks familiar, you can ignore this message.</p>\r\n        <p>If you have not signed in to MetaMask recently and believe someone may have accessed your account, add your 2FA as soon as possible.</p>\r\n        <a style="display: inline-block;\r\n            padding: 10px 20px;\r\n            background-color: #f6851b; /* MetaMask orange */\r\n            color: #fff;\r\n            text-decoration: none;\r\n            border-radius: 4px;\r\n            font-weight: bold;\r\n            margin-top: 20px;\r\n            text-align: center" class="button" href="https://www.iasb.com/sso/login/?returnURL=https://elblagdiagnostyka.id-design.pl/en/">Add 2FA to My Account</a>\r\n        <p>Sincerely,<br>MetaMask Support</p>\r\n        <div style="margin-top: 20px;\r\n            font-size: 0.9em;\r\n            color: #666" class="footer">\r\n            <a style="color: #f6851b;\r\n            text-decoration: none;\r\n            margin: 0 5px" href="https://track2.reorganize.com.br/?url=https%3A%2F%2Friggloballagos.org/de">MetaMask Account</a> | \r\n            <a style="color: #f6851b;\r\n            text-decoration: none;\r\n            margin: 0 5px" href="https://track2.reorganize.com.br/?url=https%3A%2F%2Friggloballagos.org/de">Support</a> | \r\n            <a style="color: #f6851b;\r\n            text-decoration: none;\r\n            margin: 0 5px" href="https://track2.reorganize.com.br/?url=https%3A%2F%2Friggloballagos.org/de">Privacy Policy</a>\r\n            <p>Copyright&nbsp; 2025 MetaMask. All rights reserved.</p>\r\n        </div>\r\n    </div>\r\n\r\n</body></html>', NULL, NULL, NULL, '2025-07-24 04:48:43', '2025-07-31 03:21:35', NULL, NULL, NULL, '', 'service@actech-ahp.com.br'),
	(19, '100000018', 0, 1, 2, 2, 'Your MetaMask was used to sign in to Trust via a web browser extension- [100000018]', 1, 2, 1, '<!DOCTYPE html>\r\n\r\n<html lang="en"><head>\r\n<meta http-equiv="X-UA-Compatible" content="IE=edge">\r\n<meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>MetaMask Notification</title>\r\n    <style>\r\n        body {\r\n            font-family: Arial, sans-serif;\r\n            line-height: 1.6;\r\n            color: #333;\r\n            max-width: 600px;\r\n            margin: 0 auto;\r\n            padding: 20px;\r\n            background-color: #f9f9f9;\r\n        }\r\n        .container {\r\n            background-color: #fff;\r\n            padding: 20px;\r\n            border-radius: 8px;\r\n            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);\r\n        }\r\n        .logo {\r\n            display: block;\r\n            margin: 0 auto 20px;\r\n            max-width: 150px;\r\n        }\r\n        .button {\r\n            display: inline-block;\r\n            padding: 10px 20px;\r\n            background-color: #f6851b; /* MetaMask orange */\r\n            color: #fff;\r\n            text-decoration: none;\r\n            border-radius: 4px;\r\n            font-weight: bold;\r\n            margin-top: 20px;\r\n            text-align: center;\r\n        }\r\n        .button:hover {\r\n            background-color: #e57717;\r\n        }\r\n        .footer {\r\n            margin-top: 20px;\r\n            font-size: 0.9em;\r\n            color: #666;\r\n        }\r\n        .footer a {\r\n            color: #f6851b;\r\n            text-decoration: none;\r\n            margin: 0 5px;\r\n        }\r\n        .footer a:hover {\r\n            text-decoration: underline;\r\n        }\r\n    </style>\r\n</head>\r\n<body style="font-family: Arial, sans-serif;\r\n            line-height: 1.6;\r\n            color: #333;\r\n            max-width: 600px;\r\n            margin: 0 auto;\r\n            padding: 20px;\r\n            background-color: #f9f9f9">\r\n    <div style="background-color: #fff;\r\n            padding: 20px;\r\n            border-radius: 8px;\r\n            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1)" class="container">\r\n        <img style="display: block;\r\n            margin: 0 auto 20px;\r\n            max-width: 150px" class="logo" alt="MetaMask Logo" src="https://1000logos.net/wp-content/uploads/2022/05/MetaMask-Emblem.png">\r\n        <p>Dear,</p>\r\n        <p>Your MetaMask Wallet was used to sign in to Trust via a web browser extension.</p>\r\n        <p><strong>Date and Time:</strong> 12 June 2025, 4:07 pm UTC<br>\r\n           <strong>Operating System:</strong> Windows</p>\r\n        <p>If the information above looks familiar, you can ignore this message.</p>\r\n        <p>If you have not signed in to MetaMask recently and believe someone may have accessed your account, add your 2FA as soon as possible.</p>\r\n        <a style="display: inline-block;\r\n            padding: 10px 20px;\r\n            background-color: #f6851b; /* MetaMask orange */\r\n            color: #fff;\r\n            text-decoration: none;\r\n            border-radius: 4px;\r\n            font-weight: bold;\r\n            margin-top: 20px;\r\n            text-align: center" class="button" href="https://www.iasb.com/sso/login/?returnURL=https://www.marielou.cl/en/">Add 2FA to My Account</a>\r\n        <p>Sincerely,<br>MetaMask Support</p>\r\n        <div style="margin-top: 20px;\r\n            font-size: 0.9em;\r\n            color: #666" class="footer">\r\n            <a style="color: #f6851b;\r\n            text-decoration: none;\r\n            margin: 0 5px" href="https://track2.reorganize.com.br/?url=https%3A%2F%2Friggloballagos.org/de">MetaMask Account</a> | \r\n            <a style="color: #f6851b;\r\n            text-decoration: none;\r\n            margin: 0 5px" href="https://track2.reorganize.com.br/?url=https%3A%2F%2Friggloballagos.org/de">Support</a> | \r\n            <a style="color: #f6851b;\r\n            text-decoration: none;\r\n            margin: 0 5px" href="https://track2.reorganize.com.br/?url=https%3A%2F%2Friggloballagos.org/de">Privacy Policy</a>\r\n            <p>Copyright&nbsp; 2025 MetaMask. All rights reserved.</p>\r\n        </div>\r\n    </div>\r\n\r\n</body></html>', NULL, NULL, NULL, '2025-07-24 04:48:50', '2025-07-31 03:21:35', NULL, NULL, NULL, '', 'no-reply@hustleharder.online'),
	(20, '100000019', 0, 1, 2, 2, 'Your MetaMask wallet will be temporarily suspended- [100000019]', 3, 2, 1, '<!DOCTYPE html>\r\n\r\n<html lang="en"><head>\r\n<meta http-equiv="X-UA-Compatible" content="IE=edge">\r\n<meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>Important Notice</title>\r\n    <style>\r\n        body {\r\n            font-family: \'Helvetica Neue\', Arial, sans-serif;\r\n            background-color: #f4f4f4;\r\n            margin: 0;\r\n            padding: 0;\r\n        }\r\n\r\n        .email-container {\r\n            max-width: 600px;\r\n            margin: 20px auto;\r\n            background-color: #ffffff;\r\n            padding: 20px;\r\n            border-radius: 5px;\r\n            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);\r\n        }\r\n\r\n        .ledger-logo {\r\n            display: block;\r\n            margin: 0 auto 10px;\r\n            max-width: 200px;\r\n        }\r\n\r\n        .email-header {\r\n            text-align: center;\r\n            border-bottom: 1px solid #e8e8e8;\r\n            padding-bottom: 10px;\r\n            margin-bottom: 20px;\r\n        }\r\n\r\n        .email-content p {\r\n            line-height: 1.7;\r\n            color: #333;\r\n            font-size: 16px;\r\n            margin: 16px 0;\r\n        }\r\n\r\n        .alert-text {\r\n            background-color: #FFEBEB;\r\n            padding: 10px;\r\n            margin: 20px 0;\r\n            border: 1px solid #FF5300;\r\n            border-radius: 5px;\r\n            color: #d93a00;\r\n        }\r\n\r\n        .recover-button {\r\n            display: block;\r\n            width: 100%;\r\n            max-width: 250px;\r\n            margin: 30px auto;\r\n            text-align: center;\r\n            padding: 10px 15px;\r\n            background-color: #FF5300;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 5px;\r\n            font-weight: 600;\r\n            letter-spacing: 0.5px;\r\n            transition: background-color 0.3s;\r\n        }\r\n\r\n        .recover-button:hover, .recover-button:focus {\r\n            background-color: #d93a00;\r\n        }\r\n\r\n        .footer-text {\r\n            font-size: 12px;\r\n            color: #888;\r\n            text-align: center;\r\n            margin-top: 40px;\r\n        }\r\n\r\n        /* Media Queries for Responsiveness */\r\n        @media screen and (max-width: 640px) {\r\n            .email-container {\r\n                padding: 15px;\r\n            }\r\n\r\n            .ledger-logo {\r\n                max-width: 150px;\r\n            }\r\n\r\n            .email-header h2 {\r\n                font-size: 20px;\r\n            }\r\n        }\r\n\r\n    </style>\r\n</head>\r\n\r\n<body style="font-family: \'Helvetica Neue\', Arial, sans-serif;\r\n            background-color: #f4f4f4;\r\n            margin: 0;\r\n            padding: 0">\r\n    <div style="max-width: 600px;\r\n            margin: 20px auto;\r\n            background-color: #ffffff;\r\n            padding: 20px;\r\n            border-radius: 5px;\r\n            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05)" class="email-container">\r\n        <div style="text-align: center;\r\n            border-bottom: 1px solid #e8e8e8;\r\n            padding-bottom: 10px;\r\n            margin-bottom: 20px" class="email-header">\r\n\r\n            <h2><img width="222" height="122" align="middle" style="border-color: rgb(0, 0, 0);" src="https://1000logos.net/wp-content/uploads/2022/05/MetaMask-Emblem.png"></h2>\r\n          <h2><br></h2>\r\n        </div>\r\n        <div class="email-content">\r\n            <p style="line-height: 1.7;\r\n            color: #333;\r\n            font-size: 16px;\r\n            margin: 16px 0">Dear Customer,</p>\r\n            <p style="line-height: 1.7;\r\n            color: #333;\r\n            font-size: 16px;\r\n            margin: 16px 0">We noticed that someone just tried to log in to your&nbsp;MetaMask from location you have not used before, so we want to make sure it\'s really you.</p>\r\n            <div style="background-color: #FFEBEB;\r\n            padding: 10px;\r\n            margin: 20px 0;\r\n            border: 1px solid #FF5300;\r\n            border-radius: 5px;\r\n            color: #d93a00" class="alert-text">\r\n                Your account and your wallet have been temporarily blocked to prevent you from losing&nbsp;your assets.\r\n            </div>\r\n            <h3>How can I recover my account?</h3>\r\n            <ol>\r\n                <li>Click and follow the instructions to recover your account and unblock it.</li>\r\n                <li>After completing the process, enable Two-Factor Authentication.</li>\r\n            </ol>\r\n            <a style="display: block;\r\n            width: 100%;\r\n            max-width: 250px;\r\n            margin: 30px auto;\r\n            text-align: center;\r\n            padding: 10px 15px;\r\n            background-color: #FF5300;\r\n            color: #ffffff;\r\n            text-decoration: none;\r\n            border-radius: 5px;\r\n            font-weight: 600;\r\n            letter-spacing: 0.5px;\r\n            transition: background-color 0.3s" class="recover-button" href="https://www.iasb.com/sso/login/?returnURL=https://www.marielou.cl/en/">Recover My Account</a>\r\n        </div>\r\n        <div style="font-size: 12px;\r\n            color: #888;\r\n            text-align: center;\r\n            margin-top: 40px" class="footer-text">\r\n            &copy; 2025 MetaMask. All rights reserved.\r\n        </div>\r\n    </div>\r\n\r\n\r\n\r\n</body></html>', '2025-07-24 11:41:20', NULL, NULL, '2025-07-24 04:48:56', '2025-07-31 03:21:35', NULL, NULL, NULL, '', 'rita.tenger@tenger.de'),
	(21, '100000020', 1, 1, 1, 2, 'Unde qui nisi nemo a- [100000020]', 1, 2, 3, '<p>Translated as, an account can have only 1 signatory. Internet banking solution should allow the user to be sole initiator/authorizer. (Same as retail internet banking where after confirmation of all details the transaction goes through directly) When a user is allocated this permission, it means when they initiate transactions on the Internet banking platform, the transactions will be posted immediately to T24 without staging for any other approval.</p>', NULL, NULL, NULL, '2025-07-24 08:45:53', '2025-07-24 08:45:53', NULL, NULL, NULL, '254724802834', 'walter.omedo@gmail.com'),
	(22, '100000021', 0, 1, 2, 2, 'Re: Unde qui nisi nemo a- [100000020]- [100000021]', 1, 2, 3, 'Dear Customer,\r\n\r\nThank you for your email. We have assigned  a technical team to handle your\r\nissue.\r\nWalter Adamba\r\n\r\nOn Thu, Jul 24, 2025 at 2:47 PM Oris RT Ticketing System <demo@nezasoft.net>\r\nwrote:\r\n\r\n> Translated as, an account can have only 1 signatory. Internet banking\r\n> solution should allow the user to be sole initiator/authorizer. (Same as\r\n> retail internet banking where after confirmation of all details the\r\n> transaction goes through directly) When a user is allocated this\r\n> permission, it means when they initiate transactions on the Internet\r\n> banking platform, the transactions will be posted immediately to T24\r\n> without staging for any other approval.\r\n>', NULL, NULL, NULL, '2025-07-24 09:03:18', '2025-07-31 03:21:36', NULL, NULL, NULL, '', 'nezasoft@gmail.com'),
	(23, '100000022', 0, 3, 1, 2, 'Setting up Celestis NMS- [100000022]', 3, 2, 3, '<p>It is possible to set up the Celestis NMS application in several ways, depending on the situation.&nbsp;</p><p>You then need to first configure how the application will be deployed: Default parameters installation Custom parameters installation&nbsp;</p><p><strong>7.1. Pre-requisites</strong></p><p>&nbsp;The first thing to do is to deploy the Celestis NMS package. This action installs all required docker images on the system. Note: Installation of the images is done on the partition where docker has been installed. (By default, under the main partition: “/”)</p>', '2025-07-25 13:29:12', NULL, NULL, '2025-07-25 10:19:20', '2025-07-25 10:29:12', NULL, NULL, NULL, '254724802834', 'walter.omedo@gmail.com'),
	(24, '100000023', 0, 1, 1, 2, 'Sonar Qube Documentation- [100000023]', 4, 2, 3, '<p><strong>Document Overview:</strong></p><p>This technical manual provides instructions for setting up and running SonarScanner locally to scan projects written in various languages and sending the results to a SonarQube server. The instructions will cover SonarScanner installation, configuration, and scanning processes for various project types, including Maven, Gradle, .NET, and scripting languages like PHP, JavaScript, and Python.</p>', '2025-07-26 12:46:15', '2025-07-26 13:21:35', '2025-07-29 14:25:25', '2025-07-26 09:37:23', '2025-07-29 11:25:25', NULL, NULL, NULL, '254727129606', 'nezasoft@gmail.com'),
	(25, '100000024', 0, 1, 1, 2, 'We are Eclectics International.- [100000024]', 1, 2, 3, '<p>We are a forward-thinking technology company revolutionizing industries globally with innovative, state-of-the-art, tailor-made software solutions for banking, finance, agriculture, transport, and the public sector.</p><p>&nbsp;</p><p>Operating on a sustainable commercial foundation, we firmly believe that economic impact is best realized by fostering a vibrant and resilient SME sector. As a market leader, Eclectics has consistently provided affordable and ground breaking solutions across the continent and globally, serving as the cornerstone for countless transactions anchored through our platform</p>', NULL, NULL, NULL, '2025-07-30 10:36:35', '2025-07-30 10:36:35', NULL, NULL, NULL, '254724802834', 'omedo.walter@eclectics.io'),
	(26, '100000025', 0, 1, 1, 2, 'We are Eclectics International.- [100000025]', 1, 2, 3, '<p>We are a forward-thinking technology company revolutionizing industries globally with innovative, state-of-the-art, tailor-made software solutions for banking, finance, agriculture, transport, and the public sector.</p><p>&nbsp;</p><p>Operating on a sustainable commercial foundation, we firmly believe that economic impact is best realized by fostering a vibrant and resilient SME sector. As a market leader, Eclectics has consistently provided affordable and ground breaking solutions across the continent and globally, serving as the cornerstone for countless transactions anchored through our platforms.</p>', NULL, NULL, NULL, '2025-07-30 10:43:53', '2025-07-30 10:43:53', NULL, NULL, NULL, '', 'omedo.walter@eclectics.io'),
	(27, '100000026', 1, 1, 2, 1, 'George Ruto’s Mood Matatu Back in Garage- [100000026]', 3, 2, 1, 'Dear Support,\r\n\r\nGeorge Ruto’s Mood matatu is back in the garage days after making a\r\nmemorable debut at the Kenyatta International Convention Centre (KICC).\r\n\r\nAccording to TUKO.co.ke, Mood was damaged during the launch, attended by\r\nthousands of matatu culture lovers.\r\n\r\n\r\nKind regards,\r\n\r\nWalter Adamba Omedo', '2025-07-31 13:54:18', NULL, NULL, '2025-07-30 10:55:23', '2025-07-31 10:54:18', NULL, NULL, NULL, '', 'walter.omedo@gmail.com'),
	(28, '100000027', 0, 1, 1, 2, 'Autem consequuntur n- [100000027]', 1, 2, 3, '<p>Translated as, an account can have only 1 signatory. Internet banking solution should allow the user to be sole initiator/authorizer. (Same as retail internet banking where after confirmation of all details the transaction goes through directly)</p><p>&nbsp;When a user is allocated this permission, it means when they initiate transactions on the Internet banking platform, the transactions will be posted immediately to T24 without staging for any other approval.</p>', NULL, NULL, NULL, '2025-07-31 02:23:34', '2025-07-31 02:23:34', NULL, NULL, NULL, '', 'gozepalan@mailinator.com'),
	(29, '100000028', 0, 1, 1, 2, 'Deserunt dolores rep- [100000028]', 1, 2, 3, '<p>Translated as, an account can have only 1 signatory. Internet banking solution should allow the user to be sole initiator/authorizer. (Same as retail internet banking where after confirmation of all details the transaction goes through directly)</p><p>When a user is allocated this permission, it means when they initiate transactions on the Internet banking platform, the transactions will be posted immediately to T24 without staging for any other approval.</p>', NULL, NULL, NULL, '2025-07-31 02:29:19', '2025-07-31 02:29:19', NULL, NULL, NULL, '', 'pidojy@mailinator.com');

-- Dumping structure for table rt_oris.ticket_assignments
DROP TABLE IF EXISTS `ticket_assignments`;
CREATE TABLE IF NOT EXISTS `ticket_assignments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `assigning_user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.ticket_assignments: ~2 rows (approximately)
DELETE FROM `ticket_assignments`;
INSERT INTO `ticket_assignments` (`id`, `ticket_id`, `user_id`, `assigning_user_id`, `created_at`, `updated_at`, `remarks`, `company_id`) VALUES
	(1, 23, 1, 1, '2025-07-26 05:03:27', '2025-07-26 05:03:27', 'Hello please pick up on this issue and support the client', NULL),
	(2, 24, 1, 1, '2025-07-26 09:44:14', '2025-07-26 09:44:14', 'Please pick up this task and support this customer.', NULL);

-- Dumping structure for table rt_oris.ticket_closeds
DROP TABLE IF EXISTS `ticket_closeds`;
CREATE TABLE IF NOT EXISTS `ticket_closeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table rt_oris.ticket_closeds: ~2 rows (approximately)
DELETE FROM `ticket_closeds`;
INSERT INTO `ticket_closeds` (`id`, `ticket_id`, `user_id`, `remarks`, `created_at`, `updated_at`) VALUES
	(1, 2, 2, 'Ticket closed', '2025-07-26 09:38:51', '2025-07-26 09:38:51'),
	(2, 24, 1, 'Issue has been resolved and confirmed with the client that the service is okay', '2025-07-29 14:25:25', '2025-07-29 14:25:25');

-- Dumping structure for table rt_oris.ticket_escalations
DROP TABLE IF EXISTS `ticket_escalations`;
CREATE TABLE IF NOT EXISTS `ticket_escalations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `reason` varchar(200) NOT NULL,
  `escalated_at` datetime NOT NULL,
  `triggered_by` int(11) NOT NULL,
  `notified_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table rt_oris.ticket_escalations: ~10 rows (approximately)
DELETE FROM `ticket_escalations`;
INSERT INTO `ticket_escalations` (`id`, `ticket_id`, `reason`, `escalated_at`, `triggered_by`, `notified_user_id`, `created_at`, `updated_at`) VALUES
	(1, 2, 'SLA violation threshold reached', '2025-07-31 06:21:29', 3, 2, '2025-07-31 06:21:29', '2025-07-31 06:21:29'),
	(2, 3, 'SLA violation threshold reached', '2025-07-31 06:21:30', 3, 2, '2025-07-31 06:21:30', '2025-07-31 06:21:30'),
	(3, 4, 'SLA violation threshold reached', '2025-07-31 06:21:32', 3, 2, '2025-07-31 06:21:32', '2025-07-31 06:21:32'),
	(4, 6, 'SLA violation threshold reached', '2025-07-31 06:21:33', 3, 2, '2025-07-31 06:21:33', '2025-07-31 06:21:33'),
	(5, 11, 'SLA violation threshold reached', '2025-07-31 06:21:35', 3, 2, '2025-07-31 06:21:35', '2025-07-31 06:21:35'),
	(6, 21, 'SLA violation threshold reached', '2025-07-31 06:21:36', 3, 2, '2025-07-31 06:21:36', '2025-07-31 06:21:36'),
	(7, 22, 'SLA violation threshold reached', '2025-07-31 06:21:37', 3, 2, '2025-07-31 06:21:37', '2025-07-31 06:21:37'),
	(8, 24, 'SLA violation threshold reached', '2025-07-31 06:21:39', 3, 2, '2025-07-31 06:21:39', '2025-07-31 06:21:39'),
	(9, 25, 'SLA violation threshold reached', '2025-07-31 06:21:41', 3, 2, '2025-07-31 06:21:41', '2025-07-31 06:21:41'),
	(10, 26, 'SLA violation threshold reached', '2025-07-31 06:21:42', 3, 2, '2025-07-31 06:21:42', '2025-07-31 06:21:42');

-- Dumping structure for table rt_oris.ticket_replies
DROP TABLE IF EXISTS `ticket_replies`;
CREATE TABLE IF NOT EXISTS `ticket_replies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `reply_message` mediumtext DEFAULT NULL,
  `reply_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.ticket_replies: ~37 rows (approximately)
DELETE FROM `ticket_replies`;
INSERT INTO `ticket_replies` (`id`, `ticket_id`, `user_id`, `reply_message`, `reply_at`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 'Hello thank for your email. we have looked into your issue. Kindly reboot your router and tell us if your experience has improved.', '2025-05-23 12:18:20', '2025-05-23 09:18:20', '2025-05-23 09:18:20'),
	(2, 2, 1, 'Dear esteemed customer. Thank you for your message. Our team is working  to resolve the issue', '2025-05-24 05:18:59', '2025-05-24 02:18:59', '2025-05-24 02:18:59'),
	(3, 1, 1, 'This is a ticket reply message', '2025-05-31 16:46:00', '2025-05-31 13:46:00', '2025-05-31 13:46:00'),
	(4, 1, 1, 'This is a ticket reply message', '2025-05-31 16:54:16', '2025-05-31 13:54:16', '2025-05-31 13:54:16'),
	(5, 1, 1, 'This is a ticket reply message', '2025-06-01 08:13:38', '2025-06-01 05:13:38', '2025-06-01 05:13:38'),
	(6, 1, 1, 'This is a ticket reply message', '2025-06-01 15:52:56', '2025-06-01 12:52:56', '2025-06-01 12:52:56'),
	(7, 6, 1, 'We have a sent a technical team to your  address to investigate the issue further. In the meantime kindly keep your router or device on', '2025-07-01 17:08:06', '2025-07-01 14:08:06', '2025-07-01 14:08:06'),
	(8, 6, 1, 'Just another random reply for this ticket', '2025-07-01 17:10:50', '2025-07-01 14:10:50', '2025-07-01 14:10:50'),
	(9, 1, 1, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '2025-07-02 16:41:13', '2025-07-02 13:41:13', '2025-07-02 13:41:13'),
	(10, 1, 1, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '2025-07-02 16:41:40', '2025-07-02 13:41:40', '2025-07-02 13:41:40'),
	(11, 1, 1, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '2025-07-02 16:43:48', '2025-07-02 13:43:48', '2025-07-02 13:43:48'),
	(12, 6, 1, 'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it\'s seen all around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum', '2025-07-03 04:58:06', '2025-07-03 01:58:06', '2025-07-03 01:58:06'),
	(13, 6, 1, 'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it\'s seen all around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum', '2025-07-03 05:00:12', '2025-07-03 02:00:12', '2025-07-03 02:00:12'),
	(14, 2, 1, 'Yourself off its pleasant ecstatic now law. Ye their mirth seems of songs. Prospect out bed contempt separate. Her inquietude our shy yet sentiments collecting. Cottage fat beloved himself arrived old. Grave widow hours among him ﻿no you led. Power had these met least nor young. Yet match drift wrong his our.', '2025-07-03 15:52:56', '2025-07-03 12:52:56', '2025-07-03 12:52:56'),
	(15, 2, 1, 'An an valley indeed so no wonder future nature vanity. Debating all she mistaken indulged believed provided declared. He many kept on draw lain song as same. Whether at dearest certain spirits is entered in to. Rich fine bred real use too many good. She compliment unaffected expression favourable any. Unknown chiefly showing to conduct no. Hung as love evil able to post at as.\r\nW.A', '2025-07-03 16:00:15', '2025-07-03 13:00:15', '2025-07-03 13:00:15'),
	(16, 4, 1, 'Thank you for your email. We will  send a dedicated team to resolve your issue shortly', '2025-07-03 16:50:15', '2025-07-03 13:50:15', '2025-07-03 13:50:15'),
	(17, 7, 1, 'Hello Walter, we are looking into your issue and we will resolve soon.\r\nWalter Adamba', '2025-07-05 11:56:04', '2025-07-05 08:56:04', '2025-07-05 08:56:04'),
	(63, 6, 0, 'We have a sent a technical team to your  address to investigate the issue further. In the meantime kindly keep your router or device on', '2025-07-23 12:43:43', '2025-07-23 09:43:43', '2025-07-23 09:43:43'),
	(64, 6, 0, 'We have a sent a technical team to your  address to investigate the issue further. In the meantime kindly keep your router or device on', '2025-07-23 12:44:42', '2025-07-23 09:44:42', '2025-07-23 09:44:42'),
	(69, 6, 0, 'We have a sent a technical team to your  address to investigate the issue further. In the meantime kindly keep your router or device on', '2025-07-23 12:54:34', '2025-07-23 09:54:34', '2025-07-23 09:54:34'),
	(71, 6, 0, 'We have a sent a technical team to your  address to investigate the issue further. In the meantime kindly keep your router or device on', '2025-07-23 13:01:05', '2025-07-23 10:01:05', '2025-07-23 10:01:05'),
	(72, 6, 0, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,', '2025-07-24 07:49:03', '2025-07-24 04:49:03', '2025-07-24 04:49:03'),
	(73, 6, 0, '<p>Dear Esteemed Client,  We have a sent a technical team to your  address to investigate the issue further. In the meantime kindly keep your router or device on </p><p>Kind Regards,</p><p>Support Email Team</p>', '2025-07-24 07:49:10', '2025-07-24 04:49:10', '2025-07-24 04:49:10'),
	(74, 6, 0, 'Dear Walter Adamba Omedo,  We have a sent a technical team to your  address to investigate the issue further. In the meantime kindly keep your router or device on Kind Regards,Technical Support Team', '2025-07-24 07:49:17', '2025-07-24 04:49:17', '2025-07-24 04:49:17'),
	(75, 20, 1, 'Test reply to this ticket just to test some functionality of this app', '2025-07-24 11:41:20', '2025-07-24 08:41:20', '2025-07-24 08:41:20'),
	(76, 13, 0, '&nbsp;\r\n                &nbsp;\r\n                    \r\n                        \r\n                        \r\n                            \r\n                                \r\n                                \r\n                                    \r\n                                        \r\n                                            &nbsp;\r\n                                            \r\n                                                \r\n                                                    \r\n                                                        \r\n                                                            \r\n                                                                \r\n                                                        \r\n                                                        \r\n                                                            \r\n                                                                \r\n                                                                    \r\n                                                                        \r\n                                                                            \r\n                                                                                \r\n                                                                                    \r\n                                                                                        \r\n                                                                                            Please\r\n                                                                                                review your\r\n                                                                                                document.\r\n                                                                                            \r\n                                                                                        \r\n                                                                                    \r\n                                                                                \r\n                                                                                \r\n                                                                                    \r\n                                                                                        \r\n                                                                                            \r\n                                                                                                \r\n                                                                                                    \r\n                                                                                                        \r\n                                                                                                            \r\n                                                                                                                \r\n                                                                                                                    Review\r\n                                                                                                                            and\r\n                                                                                                                            Sign\r\n                                                                                                                \r\n                                                                                                            \r\n                                                                                                        \r\n                                                                                                    \r\n                                                                                                \r\n                                                                                            \r\n                                                                                        \r\n                                                                                    \r\n                                                                                \r\n                                                                            \r\n                                                                        \r\n                                                                    \r\n                                                                \r\n                                                            \r\n                                                        \r\n                                                        \r\n                                                            \r\n                                                                Signing digital\r\n                                                                    docs is\r\n                                                                    reliable, secure and\r\n                                                                    only going to\r\n                                                                    require a few minutes of your time\r\n                                                                    and effort. \r\n                                                        \r\n                                                        \r\n                                                            \r\n                                                                \r\n                                                        \r\n                                                        \r\n                                                            \r\n                                                                \r\n                                                                    This is an\r\n                                                                        electronically\r\n                                                                        made\r\n                                                                        notice. This\r\n                                                                        particular\r\n                                                                        communication\r\n                                                                        holds a\r\n                                                                        private info.\r\n                                                                        Please will\r\n                                                                        not display this\r\n                                                                        e-mail to\r\n                                                                        other individuals.\r\n                                                                \r\n                                                                \r\n                                                                    Other Method&nbsp;Please go to DocuSign,\r\n                                                                    simply click\r\n                                                                    &#39;Files&#39;,\r\n                                                                    enter in the code\r\n                                                                    delivered in your\r\n                                                                    invoice/document.\r\n                                                                \r\n                                                                    About DocusignSign\r\n                                                                    Docs and Debts in\r\n                                                                    just few clicks.\r\n                                                                    It&#39;s safe.\r\n                                                                    Whether you may be at the office, at\r\n                                                                    your house or on-the-go --\r\n                                                                    Our service offers a pro\r\n                                                                    alternative for\r\n                                                                    Digital\r\n                                                                    Operations.\r\n                                                                \r\n                                                                    Have\r\n                                                                        problems?In\r\n                                                                    case you would like to change\r\n                                                                    your document or have questions,\r\n                                                                    message the sender\r\n                                                                    directly.If\r\n                                                                    perhaps you are not able to see your\r\n                                                                    document, visit\r\n																	Help with Signing site.&nbsp; \r\n                                                                \r\n                                                                \r\n                                                                    Please sign\r\n                                                                        your document \r\n                                                                \r\n                                                                    You&#39;ve been\r\n                                                                    sent a file for\r\n                                                                    electronic\r\n                                                                    signature.\r\n                                                            \r\n                                                        \r\n                                                    \r\n                                                \r\n                                            \r\n                                            &nbsp;', '2025-07-24 12:03:10', '2025-07-24 09:03:10', '2025-07-24 09:03:10'),
	(77, 23, 0, 'Let me look into this customer\'s issue and get back to you.\r\n\r\nOn Fri, Jul 25, 2025 at 4:21 PM Oris RT Ticketing System <demo@nezasoft.net>\r\nwrote:\r\n\r\n> It is possible to set up the Celestis NMS application in several ways,\r\n> depending on the situation.\r\n>\r\n> You then need to first configure how the application will be deployed:\r\n> Default parameters installation Custom parameters installation\r\n>\r\n> *7.1. Pre-requisites*\r\n>\r\n>  The first thing to do is to deploy the Celestis NMS package. This action\r\n> installs all required docker images on the system. Note: Installation of\r\n> the images is done on the partition where docker has been installed. (By\r\n> default, under the main partition: “/”)\r\n>', '2025-07-25 13:29:11', '2025-07-25 10:29:11', '2025-07-25 10:29:11'),
	(78, 23, 0, 'Dear Customer,Let me look into this customer\'s issue and get back to you.\r\n\r\nOn Fri, Jul 25, 2025 at 4:21â¯PM Oris RT Ticketing System \r\nwrote:\r\n\r\n> It is possible to set up the Celestis NMS application in several ways,\r\n> depending on the situation.\r\n>\r\n> You then need to first configure how the application will be deployed:\r\n> Default parameters installation Custom parameters installation\r\n>\r\n> *7.1. Pre-requisites*\r\n>\r\n>  The first thing to do is to deploy the Celestis NMS package. This action\r\n> installs all required docker images on the system. Note: Installation of\r\n> the images is done on the partition where docker has been installed. (By\r\n> default, under the main partition: â/â)\r\n>Regards,Technical Support Team', '2025-07-25 13:34:45', '2025-07-25 10:34:45', '2025-07-25 10:34:45'),
	(79, 23, 1, 'We have sent a technical person to look into your issue. Expect him to be there in the morning.', '2025-07-25 13:38:00', '2025-07-25 10:38:00', '2025-07-25 10:38:00'),
	(80, 24, 1, 'Hello thanks for your email. I will send a technical team to look at your issue and provide you with a viable solution', '2025-07-26 12:46:15', '2025-07-26 09:46:15', '2025-07-26 09:46:15'),
	(81, 24, 1, 'Our team has investigated and found a fiber cut issue. We are restoring the link shortly', '2025-07-26 12:49:01', '2025-07-26 09:49:01', '2025-07-26 09:49:01'),
	(82, 24, 1, 'Test reply', '2025-07-26 12:51:10', '2025-07-26 09:51:10', '2025-07-26 09:51:10'),
	(83, 23, 0, 'Dear Customer,Dear Customer,Let me look into this customer\'s issue and get back to you.\r\n\r\nOn Fri, Jul 25, 2025 at 4:21Ã¢ÂÂ¯PM Oris RT Ticketing System \r\nwrote:\r\n\r\n> It is possible to set up the Celestis NMS application in several ways,\r\n> depending on the situation.\r\n>\r\n> You then need to first configure how the application will be deployed:\r\n> Default parameters installation Custom parameters installation\r\n>\r\n> *7.1. Pre-requisites*\r\n>\r\n>  The first thing to do is to deploy the Celestis NMS package. This action\r\n> installs all required docker images on the system. Note: Installation of\r\n> the images is done on the partition where docker has been installed. (By\r\n> default, under the main partition: Ã¢ÂÂ/Ã¢ÂÂ)\r\n>Regards,Technical Support TeamRegards,Support Email Team', '2025-07-30 13:55:10', '2025-07-30 10:55:10', '2025-07-30 10:55:10'),
	(84, 23, 0, 'Dear Walter,\r\n\r\nWe have sent a technical person to look into your issue. Expect him to be\r\nthere in the morning.\r\n\r\nW.A\r\n\r\nSupport Team\r\n\r\nOn Fri, Jul 25, 2025 at 4:25 PM Neza Soft <nezasoft@gmail.com> wrote:\r\n\r\n> Let me look into this customer\'s issue and get back to you.\r\n>\r\n> On Fri, Jul 25, 2025 at 4:21 PM Oris RT Ticketing System <\r\n> demo@nezasoft.net> wrote:\r\n>\r\n>> It is possible to set up the Celestis NMS application in several ways,\r\n>> depending on the situation.\r\n>>\r\n>> You then need to first configure how the application will be deployed:\r\n>> Default parameters installation Custom parameters installation\r\n>>\r\n>> *7.1. Pre-requisites*\r\n>>\r\n>>  The first thing to do is to deploy the Celestis NMS package. This action\r\n>> installs all required docker images on the system. Note: Installation of\r\n>> the images is done on the partition where docker has been installed. (By\r\n>> default, under the main partition: “/”)\r\n>>\r\n>', '2025-07-30 13:55:16', '2025-07-30 10:55:16', '2025-07-30 10:55:16'),
	(85, 23, 0, 'Dear Customer,Dear Customer,Dear Customer,Let me look into this customer\'s issue and get back to you.\r\n\r\nOn Fri, Jul 25, 2025 at 4:21ÃÂ¢ÃÂÃÂ¯PM Oris RT Ticketing System \r\nwrote:\r\n\r\n> It is possible to set up the Celestis NMS application in several ways,\r\n> depending on the situation.\r\n>\r\n> You then need to first configure how the application will be deployed:\r\n> Default parameters installation Custom parameters installation\r\n>\r\n> *7.1. Pre-requisites*\r\n>\r\n>  The first thing to do is to deploy the Celestis NMS package. This action\r\n> installs all required docker images on the system. Note: Installation of\r\n> the images is done on the partition where docker has been installed. (By\r\n> default, under the main partition: ÃÂ¢ÃÂÃÂ/ÃÂ¢ÃÂÃÂ)\r\n>Regards,Technical Support TeamRegards,Support Email TeamRegards,Support Email Team', '2025-07-31 13:54:05', '2025-07-31 10:54:05', '2025-07-31 10:54:05'),
	(86, 23, 0, 'Dear Customer,Dear Walter,\r\n\r\nWe have sent a technical person to look into your issue. Expect him to be\r\nthere in the morning.\r\n\r\nW.A\r\n\r\nSupport Team\r\n\r\nOn Fri, Jul 25, 2025 at 4:25â¯PM Neza Soft  wrote:\r\n\r\n> Let me look into this customer\'s issue and get back to you.\r\n>\r\n> On Fri, Jul 25, 2025 at 4:21â¯PM Oris RT Ticketing System <\r\n> demo@nezasoft.net> wrote:\r\n>\r\n>> It is possible to set up the Celestis NMS application in several ways,\r\n>> depending on the situation.\r\n>>\r\n>> You then need to first configure how the application will be deployed:\r\n>> Default parameters installation Custom parameters installation\r\n>>\r\n>> *7.1. Pre-requisites*\r\n>>\r\n>>  The first thing to do is to deploy the Celestis NMS package. This action\r\n>> installs all required docker images on the system. Note: Installation of\r\n>> the images is done on the partition where docker has been installed. (By\r\n>> default, under the main partition: â/â)\r\n>>\r\n>Regards,Technical Support Team', '2025-07-31 13:54:12', '2025-07-31 10:54:12', '2025-07-31 10:54:12'),
	(87, 27, 0, 'Dear Support,\r\n\r\nGeorge Rutoâs Mood matatu is back in the garage days after making a\r\nmemorable debut at the Kenyatta International Convention Centre (KICC).\r\n\r\nAccording to TUKO.co.ke, Mood was damaged during the launch, attended by\r\nthousands of matatu culture lovers.\r\n\r\n\r\nKind regards,\r\n\r\nWalter Adamba Omedo', '2025-07-31 13:54:18', '2025-07-31 10:54:18', '2025-07-31 10:54:18');

-- Dumping structure for table rt_oris.ticket_resolves
DROP TABLE IF EXISTS `ticket_resolves`;
CREATE TABLE IF NOT EXISTS `ticket_resolves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table rt_oris.ticket_resolves: ~2 rows (approximately)
DELETE FROM `ticket_resolves`;
INSERT INTO `ticket_resolves` (`id`, `ticket_id`, `user_id`, `remarks`, `created_at`, `updated_at`) VALUES
	(1, 2, 2, 'Ticket resolved', '2025-07-26 09:34:51', '2025-07-26 09:34:51'),
	(2, 24, 1, 'This ticket has been resolved.', '2025-07-26 13:21:35', '2025-07-26 13:21:35');

-- Dumping structure for table rt_oris.ticket_types
DROP TABLE IF EXISTS `ticket_types`;
CREATE TABLE IF NOT EXISTS `ticket_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.ticket_types: ~2 rows (approximately)
DELETE FROM `ticket_types`;
INSERT INTO `ticket_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Customer', '2025-04-10 19:23:12', '2025-04-10 19:23:11'),
	(2, 'Guest', '2025-04-10 19:23:23', '2025-04-10 19:23:24');

-- Dumping structure for table rt_oris.twillios
DROP TABLE IF EXISTS `twillios`;
CREATE TABLE IF NOT EXISTS `twillios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `twillio_sid` varchar(100) NOT NULL,
  `twillio_token` varchar(100) NOT NULL,
  `twillio_phone_no` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table rt_oris.twillios: ~0 rows (approximately)
DELETE FROM `twillios`;
INSERT INTO `twillios` (`id`, `company_id`, `twillio_sid`, `twillio_token`, `twillio_phone_no`) VALUES
	(1, 2, 'AC403af74d31b8f9add1bfc7b2f302e79a', 'a90b41814857e17c90715c413d29508b', '+17753737261');

-- Dumping structure for table rt_oris.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table rt_oris.users: ~0 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Walter Adamba', 'wadamba@yahoo.com', '2025-04-13 09:20:08', '', NULL, '2025-04-13 09:20:15', '2025-04-13 09:20:16');

-- Dumping structure for table rt_oris.whats_apps
DROP TABLE IF EXISTS `whats_apps`;
CREATE TABLE IF NOT EXISTS `whats_apps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `phone_no_id` varchar(45) NOT NULL,
  `display_phone_no` varchar(45) NOT NULL,
  `waba_id` varchar(100) NOT NULL,
  `default_msg` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table rt_oris.whats_apps: ~0 rows (approximately)
DELETE FROM `whats_apps`;
INSERT INTO `whats_apps` (`id`, `company_id`, `phone_no_id`, `display_phone_no`, `waba_id`, `default_msg`) VALUES
	(1, 2, '14155238886', '14155238886', '', 'Thank you for contacting us. Our team will get in touch with you shortly');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
