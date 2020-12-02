-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 02, 2020 at 09:30 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vehicle`
--

-- --------------------------------------------------------

--
-- Table structure for table `alerts`
--

CREATE TABLE `alerts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `plateNo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `alerts`
--

INSERT INTO `alerts` (`id`, `plateNo`, `state`, `created_at`, `updated_at`) VALUES
(1, '2342', '1', '2020-11-07 08:23:02', '2020-11-07 08:23:02'),
(2, '2342', '0', '2020-11-07 08:23:04', '2020-11-07 08:23:04'),
(3, '2342', '1', '2020-11-07 08:23:05', '2020-11-07 08:23:05'),
(4, '2342', '0', '2020-11-07 08:23:06', '2020-11-07 08:23:06'),
(5, '2342', '1', '2020-11-07 08:37:26', '2020-11-07 08:37:26'),
(6, '2342', '0', '2020-11-07 08:37:27', '2020-11-07 08:37:27'),
(7, '33333', '0', '2020-11-07 08:37:27', '2020-11-07 08:37:27'),
(8, '33333', '1', '2020-11-07 08:37:28', '2020-11-07 08:37:28'),
(9, '32568', '1', '2020-11-07 08:37:29', '2020-11-07 08:37:29'),
(10, '32568', '0', '2020-11-07 08:37:29', '2020-11-07 08:37:29'),
(11, '32568', '1', '2020-11-07 08:37:29', '2020-11-07 08:37:29'),
(12, '56289', '1', '2020-11-07 08:37:30', '2020-11-07 08:37:30'),
(13, '56289', '0', '2020-11-07 08:37:30', '2020-11-07 08:37:30'),
(14, '56289', '1', '2020-11-07 08:37:30', '2020-11-07 08:37:30'),
(15, '32568', '0', '2020-11-07 08:37:31', '2020-11-07 08:37:31');

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_conversations`
--

CREATE TABLE `chat_conversations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `private` tinyint(1) NOT NULL DEFAULT 1,
  `direct_message` tinyint(1) NOT NULL DEFAULT 0,
  `data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `participation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_message_notifications`
--

CREATE TABLE `chat_message_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `message_id` bigint(20) UNSIGNED NOT NULL,
  `messageable_id` bigint(20) UNSIGNED NOT NULL,
  `messageable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `participation_id` bigint(20) UNSIGNED NOT NULL,
  `is_seen` tinyint(1) NOT NULL DEFAULT 0,
  `is_sender` tinyint(1) NOT NULL DEFAULT 0,
  `flagged` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_participation`
--

CREATE TABLE `chat_participation` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `messageable_id` bigint(20) UNSIGNED NOT NULL,
  `messageable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dailyinfos`
--

CREATE TABLE `dailyinfos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `set_date` date NOT NULL,
  `status` enum('active','non-active','refresh','present') COLLATE utf8mb4_unicode_ci NOT NULL,
  `morning` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `night` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gotime` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reachtime` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `eat` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sleep` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `private_comment` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activeImgPathInMor` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actionNotesInMor` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activeImgPathInAft` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actionNotesInAft` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `daytype` enum('normal','acclimatization','additive') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dailyinfos`
--

INSERT INTO `dailyinfos` (`id`, `user_id`, `set_date`, `status`, `morning`, `night`, `gotime`, `reachtime`, `eat`, `sleep`, `private_comment`, `activeImgPathInMor`, `actionNotesInMor`, `activeImgPathInAft`, `actionNotesInAft`, `daytype`, `created_at`, `updated_at`) VALUES
(2, 2, '2020-07-30', 'active', NULL, NULL, '8:30 PM', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 'normal', '2020-08-01 06:30:50', '2020-08-05 10:18:02'),
(3, 23, '2020-07-30', 'active', NULL, NULL, '8:33 PM', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 'normal', '2020-08-01 06:33:35', '2020-08-05 10:17:59'),
(10, 23, '2020-08-05', 'active', NULL, NULL, '9:33 PM', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 'normal', '2020-08-05 07:33:47', '2020-08-05 09:18:56'),
(12, 23, '2020-08-06', 'non-active', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 'normal', '2020-08-05 10:14:37', '2020-08-07 19:56:49'),
(13, 2, '2020-08-06', 'non-active', NULL, NULL, '9:06 AM', '9:56 AM', NULL, NULL, '', NULL, NULL, NULL, NULL, 'normal', '2020-08-05 19:06:42', '2020-08-07 19:56:38'),
(14, 23, '2020-08-11', 'active', NULL, NULL, '9:44 PM', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 'normal', '2020-08-11 07:44:19', '2020-08-11 07:44:19'),
(15, 2, '2020-08-11', 'non-active', NULL, NULL, '9:44 PM', '9:44 PM', NULL, NULL, '', NULL, NULL, NULL, NULL, 'normal', '2020-08-11 07:44:23', '2020-08-11 07:44:37'),
(16, 23, '2020-08-12', 'non-active', NULL, NULL, '3:21 PM', '10:28 PM', NULL, NULL, '', NULL, NULL, NULL, NULL, 'normal', '2020-08-12 01:21:49', '2020-08-12 08:28:55'),
(17, 2, '2020-08-12', 'non-active', NULL, NULL, '3:22 PM', '10:28 PM', NULL, NULL, '', NULL, NULL, NULL, NULL, 'normal', '2020-08-12 01:22:15', '2020-08-12 08:28:48'),
(18, 23, '2020-08-13', 'active', NULL, 'dddd', NULL, NULL, 'dddd', NULL, '', NULL, NULL, NULL, NULL, 'normal', '2020-08-13 01:39:30', '2020-08-13 01:39:30'),
(19, 2, '2020-08-14', 'active', NULL, NULL, '4:52 AM', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 'normal', '2020-08-13 14:52:10', '2020-08-13 14:52:10'),
(20, 23, '2020-08-17', 'active', NULL, NULL, '11:57 PM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'normal', '2020-08-17 09:57:41', '2020-08-17 09:57:41'),
(21, 2, '2020-08-18', 'active', 'Good morning!', 'cwew', '1:49 PM', '01:41', 'dwwewe', 'Good Sleep!', NULL, NULL, NULL, NULL, NULL, 'additive', '2020-08-17 23:49:26', '2020-08-18 09:39:37'),
(22, 23, '2020-08-18', 'non-active', NULL, NULL, '10:56 PM', '23:19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'additive', '2020-08-18 08:56:16', '2020-08-18 09:40:05'),
(23, 2, '2020-08-20', 'active', NULL, NULL, '11:04 PM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'normal', '2020-08-18 09:04:43', '2020-08-18 09:05:02'),
(26, 23, '2020-08-20', 'active', NULL, NULL, '8:17 PM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'normal', '2020-08-19 06:17:27', '2020-08-19 06:17:27'),
(31, 25, '2020-08-20', 'present', NULL, NULL, '8:57 PM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'normal', '2020-08-20 06:57:49', '2020-08-21 07:05:34'),
(32, 25, '2020-08-18', 'active', NULL, NULL, '10:02 PM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'normal', '2020-08-20 08:02:14', '2020-08-20 08:02:14');

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `imei` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plateNo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phoneNumber` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `userId` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `wifi` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gyro` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gps` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `powerSupply` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isArm` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number1` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number2` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number3` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number4` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number5` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `engine` int(5) NOT NULL DEFAULT 0,
  `battery` float NOT NULL DEFAULT 0,
  `alarm` int(5) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`id`, `imei`, `name`, `plateNo`, `phoneNumber`, `email`, `created_at`, `updated_at`, `userId`, `wifi`, `gyro`, `gps`, `powerSupply`, `isArm`, `number1`, `number2`, `number3`, `number4`, `number5`, `engine`, `battery`, `alarm`) VALUES
(15, '123456789123456', 'Niclass', '2342', '123', 'www@niclasdsf.gmail', '2020-10-31 09:58:55', '2020-11-09 23:32:10', '29', '1', '0', '1', '0', '0', '', '', '', '', '', 1, 14, 0),
(17, '123456789456789', 'Alfa Romeo: Mito', '32568', '542351685', 'www@alfaromeo.gmail', '2020-11-02 17:45:15', '2020-11-07 08:37:31', '29', '0', '0', '0', '0', '0', '', '', '', '', '', 1, 0, 0),
(18, '123456123456123', 'BMW:x7', '56289', '234814', 'www@bmwx7.gmail', '2020-11-02 17:46:18', '2020-11-07 08:37:30', '29', '0', '0', '0', '0', '1', '', '', '', '', '', 0, 0, 0),
(19, '123456789456132', 'Flat Uno Cargo', '65231', '8456152', 'www@flatunocargo.gmail', '2020-11-03 17:55:39', '2020-11-03 19:23:08', '30', '0', '0', '0', '0', '0', '', '', '', '', '', 1, 0, 0),
(22, '123456789456123', 'Ford 350', '12485', '5482', 'www@fordwe.com', '2020-11-03 19:20:16', '2020-11-03 19:20:16', '30', '0', '0', '0', '0', '0', '', '', '', '', '', 0, 0, 0),
(23, '123456789456123', 'Flat', '56718', '5481436', 'www@flatdd.gmail', '2020-11-03 19:21:57', '2020-11-03 19:21:57', '30', '0', '0', '0', '0', '0', '', '', '', '', '', 0, 0, 0),
(24, '222222222222222', 'ddd', '3243', '23424', 'www@lkdjafisdfls.gmail', '2020-11-20 01:03:19', '2020-11-20 01:03:19', '29', '0', '0', '0', '0', '0', '', '', '', '', '', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forgotpasswords`
--

CREATE TABLE `forgotpasswords` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verifyCode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sessionTime` int(11) NOT NULL,
  `attemptNum` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groupchats`
--

CREATE TABLE `groupchats` (
  `id` int(10) UNSIGNED NOT NULL,
  `sender_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(11) NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `groupname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `groupname`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Äffli', 'Group 1', '2020-07-21 05:42:19', '2020-08-05 09:18:23'),
(3, 'New 2', '1231231412', '2020-07-21 05:42:29', '2020-07-21 08:56:10'),
(4, '34234', '2341234', '2020-07-21 05:42:43', '2020-07-21 05:42:43'),
(6, 'School - 1', 'New Group', '2020-07-21 08:56:39', '2020-07-21 08:56:39');

-- --------------------------------------------------------

--
-- Table structure for table `kitas`
--

CREATE TABLE `kitas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kitaname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefon` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ort` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kanton` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plz` int(11) NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uImageKita` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kidsCounter` int(11) NOT NULL,
  `groupCounter` int(11) NOT NULL,
  `adminCounter` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kitas`
--

INSERT INTO `kitas` (`id`, `kitaname`, `description`, `telefon`, `email`, `ort`, `kanton`, `plz`, `address`, `uImageKita`, `kidsCounter`, `groupCounter`, `adminCounter`, `created_at`, `updated_at`) VALUES
(1, 'Kita Eigerplatz', 'Description', '12345678', 'test@test.com', 'Ort', 'Kanton', 123, 'Shen Yang', '\\images\\kita\\kita_1595346930.png', 123, 123, 123, '2020-07-21 05:41:04', '2020-08-05 09:17:38'),
(2, 'Second Kita', 'Kita Secription', '12345678', 'tester123@123.com', 'Ort', '12345', 1234, '1234', '\\images\\kita\\kita_1595346921.png', 1234, 1234, 12314, '2020-07-21 05:41:57', '2020-07-21 08:55:23'),
(3, 'School', 'New Schol', '1123', 'test@test.com', 'Ort', 'K', 123, 'Shen', '\\images\\kita\\kita_1595346852.png', 12, 2, 1, '2020-07-21 08:55:09', '2020-07-21 08:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `kitasupers`
--

CREATE TABLE `kitasupers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kitaId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `superId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kita_group_users`
--

CREATE TABLE `kita_group_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kita_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `set_date` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kita_group_users`
--

INSERT INTO `kita_group_users` (`id`, `kita_id`, `group_id`, `admin_id`, `set_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 7, '2020-08-06', '2020-08-06 05:40:37', '2020-08-06 05:40:37'),
(2, 1, 1, 24, '2020-08-07', '2020-08-06 05:47:51', '2020-08-06 05:47:51'),
(3, 1, 1, 7, '2020-08-07', '2020-08-06 05:50:43', '2020-08-06 05:50:43'),
(4, 1, 1, 7, '2020-08-05', '2020-08-06 05:56:44', '2020-08-06 05:56:44'),
(5, 1, 1, 24, '2020-08-05', '2020-08-06 05:56:44', '2020-08-06 05:56:44'),
(6, 1, 1, 25, '2020-08-06', '2020-08-06 05:59:33', '2020-08-06 05:59:33'),
(7, 1, 1, 7, '2020-08-10', '2020-08-06 11:56:37', '2020-08-06 11:56:37'),
(8, 1, 1, 24, '2020-08-10', '2020-08-06 11:56:37', '2020-08-06 11:56:37'),
(9, 1, 1, 7, '2020-08-08', '2020-08-08 07:27:36', '2020-08-08 07:27:36'),
(10, 1, 1, 24, '2020-08-08', '2020-08-08 07:27:36', '2020-08-08 07:27:36'),
(11, 1, 1, 7, '2020-08-12', '2020-08-12 01:21:46', '2020-08-12 01:21:46'),
(12, 1, 1, 24, '2020-08-12', '2020-08-12 01:21:46', '2020-08-12 01:21:46'),
(13, 1, 1, 25, '2020-08-12', '2020-08-12 01:21:46', '2020-08-12 01:21:46'),
(14, 1, 1, 7, '2020-08-19', '2020-08-19 07:38:32', '2020-08-19 07:38:32'),
(15, 1, 1, 24, '2020-08-19', '2020-08-19 07:38:32', '2020-08-19 07:38:32');

-- --------------------------------------------------------

--
-- Table structure for table `kita_vs_groups`
--

CREATE TABLE `kita_vs_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kita_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kita_vs_groups`
--

INSERT INTO `kita_vs_groups` (`id`, `kita_id`, `group_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2020-07-21 05:42:19', '2020-08-05 09:18:23'),
(2, 1, 2, '2020-07-21 05:42:24', '2020-07-21 05:42:24'),
(3, 1, 3, '2020-07-21 05:42:29', '2020-07-21 08:56:10'),
(4, 2, 4, '2020-07-21 05:42:43', '2020-07-21 05:42:43'),
(5, 2, 5, '2020-07-21 05:42:49', '2020-07-21 05:42:49'),
(6, 3, 6, '2020-07-21 08:56:39', '2020-07-21 08:56:39');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `sender_id` int(10) UNSIGNED NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_group` tinyint(1) NOT NULL DEFAULT 0,
  `is_seen` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(3, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(4, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(5, '2016_06_01_000004_create_oauth_clients_table', 1),
(6, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(7, '2019_08_19_000000_create_failed_jobs_table', 1),
(8, '2020_07_02_094504_create_blogs_table', 1),
(9, '2020_07_09_213339_create-groups-table', 1),
(10, '2020_07_13_031030_create_kitas_table', 1),
(11, '2020_07_13_092154_create_kita_vs_group', 1),
(12, '2020_07_21_144554_create_user_extra_email', 2),
(13, '2020_07_21_152626_create_user_extra_kita', 3),
(14, '2020_07_25_070913_create_sessions_table', 4),
(15, '2020_07_27_014937_create_dailies_table', 5),
(16, '2020_07_27_015345_create_daily_vs_admins', 5),
(20, '2020_07_27_015825_create_dailyinfos_table', 6),
(21, '2020_08_06_022738_create_kita_group_users_table', 7),
(23, '2020_08_20_064046_create_temp_users_table', 8),
(24, '2020_08_27_210358_create_chat_tables', 9),
(25, '2020_08_28_170407_create_messages_table', 9),
(26, '2020_09_23_161158_create_groupchats_table', 9),
(27, '2020_10_16_172100_create_forgotpasswords_table', 9),
(28, '2020_10_21_185402_create_relationships_table', 9),
(29, '2020_10_26_170110_create_kitasupers_table', 9),
(30, '2020_10_30_083133_create_devices_table', 9),
(31, '2020_11_07_145714_create_alerts_table', 10),
(32, '2020_11_10_070018_create_wifis_table', 11),
(33, '2020_11_10_073525_create_vehicles_table', 12);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('0117344566e715fe081f926118581b9408ccfb570f309b6a80e34a8c4b69034169a211fddbb6cb61', 29, 1, 'authToken', '[]', 0, '2020-11-08 17:40:00', '2020-11-08 17:40:00', '2021-11-09 00:40:00'),
('01ed61571eaf766f2325caf4dedbfce1ed8fe2b60ff6a90ebaf3ffd4ccf975ee5cc054e57c3dab0b', 29, 1, 'authToken', '[]', 0, '2020-11-09 23:31:53', '2020-11-09 23:31:53', '2021-11-10 06:31:53'),
('04dd50bbef7a10f8dafa93d6e20194e4e7b51c53ae025a850d58af6a22d1991964c71fde332e6c1b', 30, 1, 'authToken', '[]', 0, '2020-11-03 17:46:02', '2020-11-03 17:46:02', '2021-11-04 00:46:02'),
('053fe44fb0e412e8384eda7fb368a45ab88b23be29da1379588589e981bab473e14a118994d31a50', 29, 1, 'authToken', '[]', 0, '2020-11-05 00:46:47', '2020-11-05 00:46:47', '2021-11-05 07:46:47'),
('05a5acd80d5b757c28072bc31f3fb614ad5d21b576eb73051dfc17cb785905905888b302cfcd50b1', 29, 1, 'authToken', '[]', 0, '2020-10-29 18:38:07', '2020-10-29 18:38:07', '2021-10-30 01:38:07'),
('08f24f6f2257c5b390c08e1f58306d105f9260eeb498bf8520cfbbe5bbdbea40129de82ae427304d', 29, 1, 'authToken', '[]', 0, '2020-11-05 22:49:01', '2020-11-05 22:49:01', '2021-11-06 05:49:01'),
('0956e37e4556fd54b6333705898193eb05781d78b4e3ccf5a03f27b7db524f0e0ba065708cadce31', 29, 1, 'authToken', '[]', 0, '2020-11-06 00:01:50', '2020-11-06 00:01:50', '2021-11-06 07:01:50'),
('0f4895ce8aeffd1cf2b983ce3da7bbb20996b6edbc5a2254306b8d11730e062b2f4225e34a41c62f', 29, 1, 'authToken', '[]', 0, '2020-10-30 08:05:47', '2020-10-30 08:05:47', '2021-10-30 15:05:47'),
('0f7747f3e10e22ca2fd231c5b296c9a76c3280ad7729165b66b12d381892355bf252326e1f0fd376', 29, 1, 'authToken', '[]', 0, '2020-11-06 07:47:30', '2020-11-06 07:47:30', '2021-11-06 14:47:30'),
('111b4963045de182de2b44fae07ac4344c628ca4b621e2708a977bae1e477845f5a676f4f2824341', 2, 1, 'authToken', '[]', 0, '2020-08-14 06:58:23', '2020-08-14 06:58:23', '2021-08-14 13:58:23'),
('112705a2adb2694f1723d01643781fb361b0107651ecd5d837b782dcd06d19826f774f508b996986', 29, 1, 'authToken', '[]', 0, '2020-10-30 06:56:14', '2020-10-30 06:56:14', '2021-10-30 13:56:14'),
('123af68a525e47eaad1cdc292c08dc2e0e17943a80e56ac1616e0be654e74102ae302b0084f04903', 29, 1, 'authToken', '[]', 0, '2020-11-10 00:50:04', '2020-11-10 00:50:04', '2021-11-10 07:50:04'),
('12ef7dddd94c778ffcd7f535a6233c174d390324360dd914f374e8ceadf82ddab7a1b57ad21427d8', 30, 1, 'authToken', '[]', 0, '2020-11-03 18:40:57', '2020-11-03 18:40:57', '2021-11-04 01:40:57'),
('14111765c0891933ea69def1226a6185c7f88d505ad8fd3e7e57d6d3fc3cf2fcfe4f280c274c0fad', 29, 1, 'authToken', '[]', 0, '2020-11-06 08:50:59', '2020-11-06 08:50:59', '2021-11-06 15:50:59'),
('176d3f1e1ee097e1305a08e043038d032d5679dfccfaf25f1875979254ac993d46f4d08ffba09ef9', 29, 1, 'authToken', '[]', 0, '2020-11-06 07:50:49', '2020-11-06 07:50:49', '2021-11-06 14:50:49'),
('1acbccee0818f8f4a94becd98d94c5924f1767a9ebc054288efc8036b0468b2cb1bcdc4ac096c401', 29, 1, 'authToken', '[]', 0, '2020-11-03 08:51:38', '2020-11-03 08:51:38', '2021-11-03 15:51:38'),
('1cc895c1e2d612f430a9180b9e05e156605ac437a002ad29f1c23716b6073af3eaa61598d75a5337', 29, 1, 'authToken', '[]', 0, '2020-11-07 17:46:53', '2020-11-07 17:46:53', '2021-11-08 00:46:53'),
('1cd8fe277c2122c695e5a6f7dc49beab8261f7aedba62190fe3933fe1e2236deef94cdee43c1a091', 29, 1, 'authToken', '[]', 0, '2020-10-31 19:07:58', '2020-10-31 19:07:58', '2021-11-01 02:07:58'),
('1d283af0298208b17bfee91412210a30e1c2195c06d3b941e97509837a96f24a1eabdb963d97453d', 29, 1, 'authToken', '[]', 0, '2020-11-02 05:51:07', '2020-11-02 05:51:07', '2021-11-02 12:51:07'),
('1d7c77efa77f9bad93e86cec831ec00848f073b3f9fe7456bf0bae8ac4d80b870de733f7e6cffa3a', 29, 1, 'authToken', '[]', 0, '2020-11-06 09:57:31', '2020-11-06 09:57:31', '2021-11-06 16:57:31'),
('21540959df6eca4c8402e0339ec1bafd063742dbbf96ca73780f4c5602dae14a1760f795151c71b9', 29, 1, 'authToken', '[]', 0, '2020-11-04 17:43:16', '2020-11-04 17:43:16', '2021-11-05 00:43:16'),
('2246eb2548d431c7e4da0e735d34ee9fa29bc44decc46a3dbcd6d2e622790c436517c640fb3c5eb8', 29, 1, 'authToken', '[]', 0, '2020-11-06 09:38:50', '2020-11-06 09:38:50', '2021-11-06 16:38:50'),
('22ff1fa7410b76e4ab58d667194d07e47e3f37bbf629e624b9b8414efcd4cf5a51ae4de052082019', 29, 1, 'authToken', '[]', 0, '2020-10-31 19:36:26', '2020-10-31 19:36:26', '2021-11-01 02:36:26'),
('234b3c2973572f234b3a35a1b046e2ec8b11340ea141e76057be170eacee969212628fb229afd481', 29, 1, 'authToken', '[]', 0, '2020-11-05 22:35:56', '2020-11-05 22:35:56', '2021-11-06 05:35:56'),
('2413399e1f6d2be8ad9508be83fa354f7939f93a97e80caa6a5b599940f9dc88d45ab2301f16365e', 30, 1, 'authToken', '[]', 0, '2020-11-03 18:01:14', '2020-11-03 18:01:14', '2021-11-04 01:01:14'),
('2413839482fad0dd123163e9d93c83d64bb2db48b78cc4136a54d868d538708dd0ac2cd3ab132527', 29, 1, 'authToken', '[]', 0, '2020-10-29 18:27:27', '2020-10-29 18:27:27', '2021-10-30 01:27:27'),
('241a8af78b58f9b20c40b55d9c87deaf19e69a85caa076079b489cfc109b56267ec39f5e8813af95', 29, 1, 'authToken', '[]', 0, '2020-10-30 07:50:30', '2020-10-30 07:50:30', '2021-10-30 14:50:30'),
('241bb9ae714ede56399d31345ef0fb4ca3147ea1b212f0a80ed4ec45984993823defb0fc3ae3a50b', 29, 1, 'authToken', '[]', 0, '2020-10-29 18:04:34', '2020-10-29 18:04:34', '2021-10-30 01:04:34'),
('2459685f9b1f17b72c48e601cfe1f63ecb8eb653222e65f16b4962d4ecd1aa0db7accc7b30c77d47', 29, 1, 'authToken', '[]', 0, '2020-11-04 19:17:25', '2020-11-04 19:17:25', '2021-11-05 02:17:25'),
('281acb7c1d13e3ed5dce6a2c18a270b18c2ef7c20e4bcf3008aa18db99a25d359844bee36f6daa87', 29, 1, 'authToken', '[]', 0, '2020-10-29 22:53:04', '2020-10-29 22:53:04', '2021-10-30 05:53:04'),
('28659ca57524f99e783fd2954501ae5a5c3c83fd0db894d3e94ead299f98ec027ff897aa19e33068', 29, 1, 'authToken', '[]', 0, '2020-11-07 17:23:03', '2020-11-07 17:23:03', '2021-11-08 00:23:03'),
('2872260fbd76a10e0332bc9889b67509c5fb71609f03570924dc8afbe7438403d55688f2b26ac01d', 29, 1, 'authToken', '[]', 0, '2020-11-07 17:17:46', '2020-11-07 17:17:46', '2021-11-08 00:17:46'),
('2899f802ea7b9254423d960b5ce8561987843ac0a0921b7d0d2f47e2fde19b53e7bbbbfead09a38d', 2, 1, 'authToken', '[]', 0, '2020-07-21 08:53:55', '2020-07-21 08:53:55', '2021-07-21 15:53:55'),
('289cd7295f6736418cbb3c2d3c2b3af081f4672d9a2279ef7c638edec43dd6c96e2b18aa02156ca8', 29, 1, 'authToken', '[]', 0, '2020-11-06 08:01:27', '2020-11-06 08:01:27', '2021-11-06 15:01:27'),
('2902aa238dfdeb4ff219002834ddf81757632c3c8be5f468884016a3e712649ddd623c1d11d7f02e', 29, 1, 'authToken', '[]', 0, '2020-10-30 04:23:25', '2020-10-30 04:23:25', '2021-10-30 11:23:25'),
('2a4f07186109658e66aa5f52ae4594c725127bc3d020759b78488dfbe2f7b89ab5262f7ddb8df908', 29, 1, 'authToken', '[]', 0, '2020-11-06 07:13:01', '2020-11-06 07:13:01', '2021-11-06 14:13:01'),
('2af2218765b980d85bc01883aa6ca10c90c43ce2cea3248e02f801fdb0fbfb9aab4fb4c91746d1a7', 29, 1, 'authToken', '[]', 0, '2020-11-07 08:45:01', '2020-11-07 08:45:01', '2021-11-07 15:45:01'),
('2bbc5cbde831783647887fb18534c595fa94020504e0babcc2dd0bc6f538cb015778d1ce2287d3d1', 29, 1, 'authToken', '[]', 0, '2020-10-30 08:01:55', '2020-10-30 08:01:55', '2021-10-30 15:01:55'),
('2cbc27c50704588a79dbac5c0bd73eb2d93d27d5bd6659a932a7c26cea9499d6589eb0dc1033b852', 29, 1, 'authToken', '[]', 0, '2020-10-29 18:06:41', '2020-10-29 18:06:41', '2021-10-30 01:06:41'),
('2ed2d5563ccd5d75e91a393b5a18f079259a8bf08d4f6d70309ea65f33e39b1c32f6cf3112a782cf', 30, 1, 'authToken', '[]', 0, '2020-11-03 08:50:53', '2020-11-03 08:50:53', '2021-11-03 15:50:53'),
('2f85e1f30f2818f9f9e769ef2709420f2a740682664d594f9864d8a3b5b952d1d6db5e52e4456da9', 29, 1, 'authToken', '[]', 0, '2020-11-04 23:53:01', '2020-11-04 23:53:01', '2021-11-05 06:53:01'),
('300df69f209cfb0336ab6012b68ef0eba5980bb51d00e87b3fda9fb6bbe7a5f29a538ed86f8d6ca6', 29, 1, 'authToken', '[]', 0, '2020-11-04 17:42:11', '2020-11-04 17:42:11', '2021-11-05 00:42:11'),
('315c468bbb751eda344c898df16541559df3624a7ac79fcffd64749a20f3913582693667cb48245a', 29, 1, 'authToken', '[]', 0, '2020-11-20 01:02:53', '2020-11-20 01:02:53', '2021-11-20 08:02:53'),
('31aef65137b4d61f5d9b99cecfd64f409fca1fe54206eb9e07aa23e9bcbc2690b844ad69444adbed', 30, 1, 'authToken', '[]', 0, '2020-11-03 17:58:16', '2020-11-03 17:58:16', '2021-11-04 00:58:16'),
('35571243ae451c9ddb2d16c5f18e40b098febf286b6a4594817453192db4eb5105d65febf12e0d95', 29, 1, 'authToken', '[]', 0, '2020-11-04 23:05:02', '2020-11-04 23:05:02', '2021-11-05 06:05:02'),
('35fa89319ffc73a4978ca13b036b56d1c83e941ae42c7e638a49cfb9d4ab4e716bf704d0c9199b35', 29, 1, 'authToken', '[]', 0, '2020-10-30 07:04:30', '2020-10-30 07:04:30', '2021-10-30 14:04:30'),
('3a641ceecdeeadb964bd87f1eb6151c3b7aabda38633cfaa115a98781ffc57f03da3d5ac0ceed178', 29, 1, 'authToken', '[]', 0, '2020-11-04 17:53:56', '2020-11-04 17:53:56', '2021-11-05 00:53:56'),
('3bd8322f2ff05964da93935eb006030fa0ad1721a3e33f97521e4e096167ed8e63bcb67f59a666ff', 29, 1, 'authToken', '[]', 0, '2020-11-05 00:38:48', '2020-11-05 00:38:48', '2021-11-05 07:38:48'),
('3d07c62766c7780f6a60f0da87f95d26d3280f1f3ef53d50573085537d3853882dc962c914feec72', 29, 1, 'authToken', '[]', 0, '2020-11-06 08:23:08', '2020-11-06 08:23:08', '2021-11-06 15:23:08'),
('40e8316846e55c2fac87ddc37021714c25c682e2100397640a0fdcd9062466729edae2d5b2090e34', 26, 1, 'authToken', '[]', 0, '2020-10-28 22:00:28', '2020-10-28 22:00:28', '2021-10-29 05:00:28'),
('439dfd5ef0047cb0e8c00a651e8c59a91dfbe96339b9de29719ed87146ce352173190f7464c1717e', 29, 1, 'authToken', '[]', 0, '2020-11-06 08:19:06', '2020-11-06 08:19:06', '2021-11-06 15:19:06'),
('446cc57a101f43985fcfdcc70c416ab3e5b6c6496a61ae8b07aa1e9a79f22c917350b796c455ed13', 29, 1, 'authToken', '[]', 0, '2020-10-29 19:08:04', '2020-10-29 19:08:04', '2021-10-30 02:08:04'),
('4530e74d6bba300cb98b237bd5634c08e5af280c78ebdc196d2bd187e734afa3a3df68e421b10af7', 29, 1, 'authToken', '[]', 0, '2020-11-06 09:54:01', '2020-11-06 09:54:01', '2021-11-06 16:54:01'),
('4537ff7675b8ff49c08a021a046e2330c35a06b5c304671f9cf56b9a33bede12d3b6d7758b3163bb', 29, 1, 'authToken', '[]', 0, '2020-11-06 06:45:43', '2020-11-06 06:45:43', '2021-11-06 13:45:43'),
('466de54e50f52bd526e73b12699e6def691213b617ceb817afc8a7f7a5ed5f8c9b114a325e7be2cc', 29, 1, 'authToken', '[]', 0, '2020-11-04 23:06:15', '2020-11-04 23:06:15', '2021-11-05 06:06:15'),
('49466e627869dd4024a32d7f3ef6a1c515946c69518edb89e018e9cdd0c196308ec38b2df6d5c7a5', 29, 1, 'authToken', '[]', 0, '2020-11-06 08:15:49', '2020-11-06 08:15:49', '2021-11-06 15:15:49'),
('4a73f1f218da8b3c2f7070c641e3d46e5231e11bbdba427ae511f10d8f149aaf7b4858b984e73df7', 29, 1, 'authToken', '[]', 0, '2020-11-04 23:12:49', '2020-11-04 23:12:49', '2021-11-05 06:12:49'),
('4e86a91b0b4d8e671aee510e7e4550b1daf93cd6aa5bdf226ed48ebcc16a30e897a68493b33b5aaa', 29, 1, 'authToken', '[]', 0, '2020-11-06 10:06:08', '2020-11-06 10:06:08', '2021-11-06 17:06:08'),
('5020358348771e9963c352a017cd70f74c21ac7c53d467a55a8f1694bfe8876cdc3ddab9c073c329', 26, 1, 'authToken', '[]', 0, '2020-10-28 21:59:42', '2020-10-28 21:59:42', '2021-10-29 04:59:42'),
('50b9cab7e2c9ce704b0a34b7b089ed72503c99682fea0b6a73d487fad759c427c0d413cd4ddb33e8', 29, 1, 'authToken', '[]', 0, '2020-10-29 19:00:48', '2020-10-29 19:00:48', '2021-10-30 02:00:48'),
('50f59da5700790d568ad6242791862c15e240e7acc4b0f0160991fff8c39f6d438988f4749fc7b14', 29, 1, 'authToken', '[]', 0, '2020-11-04 19:29:34', '2020-11-04 19:29:34', '2021-11-05 02:29:34'),
('53a5a62d999d4ffbeec149b14244e46cb4152eb91a5d7da5f9a3613a7094cfe61600d66117307beb', 30, 1, 'authToken', '[]', 0, '2020-11-03 19:19:43', '2020-11-03 19:19:43', '2021-11-04 02:19:43'),
('546a44a6154ff0cd14b8465df37bedee026b8f5076c19ad66a1d85a98dfafa04a9b8770c0c0f62ce', 29, 1, 'authToken', '[]', 0, '2020-10-29 19:10:08', '2020-10-29 19:10:08', '2021-10-30 02:10:08'),
('54dff9b729c9dfa52cc021fc53f45231a6bd4d754a59da8ad3f533ef9c671683e6ec0fec82e6d6fe', 29, 1, 'authToken', '[]', 0, '2020-11-04 22:55:37', '2020-11-04 22:55:37', '2021-11-05 05:55:37'),
('54efb8bb688886fdeded06acf6ab4e4da8d92ae0c2e51a7e404b4453008e61a51931a933906656e9', 29, 1, 'authToken', '[]', 0, '2020-11-06 09:08:15', '2020-11-06 09:08:15', '2021-11-06 16:08:15'),
('589aa1883be3bc5c4c8a8d0ee492022a5667973447988d7b59058805a7df246ea4a77f13cf22ab96', 29, 1, 'authToken', '[]', 0, '2020-11-07 19:28:04', '2020-11-07 19:28:04', '2021-11-08 02:28:04'),
('59caaa6bc2c2f9e19c69ff915d89afc712e6a7fc6077b2aebdd3f7e751dcaf5ff5f163960924ffcc', 29, 1, 'authToken', '[]', 0, '2020-11-09 11:48:42', '2020-11-09 11:48:42', '2021-11-09 18:48:42'),
('5c1586d9124cf6f54bed7191ca6b49edbcef6d01cb0ace0a0fb0f43159f30f5ea4bc81009d299237', 29, 1, 'authToken', '[]', 0, '2020-11-03 06:52:03', '2020-11-03 06:52:03', '2021-11-03 13:52:03'),
('5c7069840c0d58cfaed284f1ae522ba75f82325aa2861355e4640c0e5ac1e3aa24d96bb4df643763', 29, 1, 'authToken', '[]', 0, '2020-11-03 19:21:14', '2020-11-03 19:21:14', '2021-11-04 02:21:14'),
('5f307c974ae7d2cb20eed3baaf2ae01dec78532a544f9525215b1de7f7656f040d84fdf3e644ca91', 2, 1, 'authToken', '[]', 0, '2020-07-21 10:13:51', '2020-07-21 10:13:51', '2021-07-21 17:13:51'),
('5f850122b0ef1e4d4e868a5053c4fad620f2dcf012d319b8b917747f04b64d22732fdaa14ce7b9ab', 29, 1, 'authToken', '[]', 0, '2020-11-05 00:33:32', '2020-11-05 00:33:32', '2021-11-05 07:33:32'),
('615646f2a37babdfbaa4a52529afcdfb092a8dc110f7ab88a7f081fa0c6bf5bf42620db566f1b3fe', 29, 1, 'authToken', '[]', 0, '2020-10-30 07:02:14', '2020-10-30 07:02:14', '2021-10-30 14:02:14'),
('62995a00bc77d36c97bb711e1487e4edbc0e1466ff53abd73d4a79242cc6ad29bca3dd36c026791f', 29, 1, 'authToken', '[]', 0, '2020-11-03 18:47:21', '2020-11-03 18:47:21', '2021-11-04 01:47:21'),
('62e499f05335117913ad28c358541bc0cb96a022aa25ddbdc0da7ba4769b4d96f84c83d6bfd251d9', 26, 1, 'authToken', '[]', 0, '2020-10-28 21:59:35', '2020-10-28 21:59:35', '2021-10-29 04:59:35'),
('63dda132f5db054cd21441d9be7d8b763a2ca4a0aa8d875945d84da513dcd3e97c8f8954aa9929af', 29, 1, 'authToken', '[]', 0, '2020-10-30 06:59:15', '2020-10-30 06:59:15', '2021-10-30 13:59:15'),
('651d1dbcfa42ea856c77a591c83c3ad2d793d3c86cb63806d2eb0a815e5fb9c0c1214c5e571e07a7', 29, 1, 'authToken', '[]', 0, '2020-10-28 23:11:50', '2020-10-28 23:11:50', '2021-10-29 06:11:50'),
('6832acf89f7a421fdbaa97bad4174deb0762e63c3b55201b927f343439943017b7cfaf41da4f3e44', 29, 1, 'authToken', '[]', 0, '2020-10-29 18:41:24', '2020-10-29 18:41:24', '2021-10-30 01:41:24'),
('6a524dbd30fad9e36443ba99c5d61ef4eb1c0d32093ea7d8295a13e8b13ff4dd776d81f57e296b66', 29, 1, 'authToken', '[]', 0, '2020-11-02 00:07:06', '2020-11-02 00:07:06', '2021-11-02 07:07:06'),
('6a884acedf5619b4bb6a7fce807cb5ba437897dd6a2721aa7ca4da992a3019f4eb7cc4457e60dc90', 29, 1, 'authToken', '[]', 0, '2020-11-04 19:11:46', '2020-11-04 19:11:46', '2021-11-05 02:11:46'),
('6b73b9201f91960710058f33202826867e5d005fe6e6143bed86aee68acbbae16f9549654c0bc0a8', 29, 1, 'authToken', '[]', 0, '2020-10-31 22:35:54', '2020-10-31 22:35:54', '2021-11-01 05:35:54'),
('6bb3f16d4928435fb1f7b824c6e0281854ca1c57dea7058881e50d6f1da4d9a1b54a1d4504aab947', 29, 1, 'authToken', '[]', 0, '2020-11-05 23:28:39', '2020-11-05 23:28:39', '2021-11-06 06:28:39'),
('6c582ef514a476b78616e84de09604a50283057c004a794454004d97ab4759844b5ea14c1fd54fcc', 29, 1, 'authToken', '[]', 0, '2020-11-05 23:04:12', '2020-11-05 23:04:12', '2021-11-06 06:04:12'),
('6e82cac2c200e8676d42a629435ddb99cc4c3a9261623f8822f41361bcd26f4882c3569b20efaad0', 1, 1, 'laraRestApi', '[]', 0, '2020-07-21 05:33:16', '2020-07-21 05:33:16', '2021-07-21 12:33:16'),
('6e953290d9470d9813fca7724dd90568cf7715033f2a756c86bedda46f4395613a7e8e0a441e343d', 26, 1, 'authToken', '[]', 0, '2020-10-28 18:47:43', '2020-10-28 18:47:43', '2021-10-29 01:47:43'),
('702ccfff6bc1dcf96e9715c1bda86471f9d1c881cd305e2de4ac3dad5c4f2a8db2c2899a5ddcccc6', 26, 1, 'authToken', '[]', 0, '2020-10-28 23:01:00', '2020-10-28 23:01:00', '2021-10-29 06:01:00'),
('70534f8da07cf8ac55800f1416ab5029808c2b51972da5a946bd8b6b5dc35dc7f09235606f1f86e7', 29, 1, 'authToken', '[]', 0, '2020-11-04 17:42:20', '2020-11-04 17:42:20', '2021-11-05 00:42:20'),
('728f5ff310804cb21bc5ae0cf9d5e7878297a0c2fb43f87b36c6e14b59d876feb63002f070525856', 29, 1, 'authToken', '[]', 0, '2020-11-05 23:40:24', '2020-11-05 23:40:24', '2021-11-06 06:40:24'),
('73e671f12d7d09286fd3d9bed29dd0b3c6a9faff4f7fa0e528364e2f0a675bc954a9c80d9bffe524', 2, 1, 'authToken', '[]', 0, '2020-07-24 07:53:43', '2020-07-24 07:53:43', '2021-07-24 14:53:43'),
('74d7ab9908eadee051b520f58eeb4a47c048e79461499178508699916604669cb7165c1cd25fb76a', 29, 1, 'authToken', '[]', 0, '2020-11-07 17:24:54', '2020-11-07 17:24:54', '2021-11-08 00:24:54'),
('75791ea51722a802ffd7e1e3a890892f797cbbc336eb02c64f4e02fa57f18d979fdf34d311e20f34', 29, 1, 'authToken', '[]', 0, '2020-10-30 07:20:40', '2020-10-30 07:20:40', '2021-10-30 14:20:40'),
('77907c61dbd802be97ba2951a920bb3632219b6d6032ed8e67c62671d86028ffe7412145fcdab964', 29, 1, 'authToken', '[]', 0, '2020-11-03 18:48:36', '2020-11-03 18:48:36', '2021-11-04 01:48:36'),
('78d87bbf4ccd11e072237944655069628127fae8d89ef4dbf844358449e5ffa8984cc4f5d7acaee2', 29, 1, 'authToken', '[]', 0, '2020-10-30 02:00:11', '2020-10-30 02:00:11', '2021-10-30 09:00:11'),
('7962d715a936f6b4c048af6ef5cc24dac1b069b41f69d06559159fe3fc121885a6b5867b70a173f8', 29, 1, 'authToken', '[]', 0, '2020-11-07 19:32:45', '2020-11-07 19:32:45', '2021-11-08 02:32:45'),
('7bd87949dcccab612dbd52783f9a475b9344d23fcb48d3e09e74682926f1f08141abe8266c77046f', 26, 1, 'authToken', '[]', 0, '2020-10-28 22:00:20', '2020-10-28 22:00:20', '2021-10-29 05:00:20'),
('7de4f0aefa55c13cc42e7a2a0476131e706de11770002643db4b4bf620fab0f72d93380739c7f550', 29, 1, 'authToken', '[]', 0, '2020-11-06 09:05:17', '2020-11-06 09:05:17', '2021-11-06 16:05:17'),
('7e590ec31a177e0dbf83bcc849d2407b07f2f611415b63d74bf6f735f3a64384422a51c4ba0157c8', 29, 1, 'authToken', '[]', 0, '2020-11-09 04:27:36', '2020-11-09 04:27:36', '2021-11-09 11:27:36'),
('7e838dc28b47e4cea954ee526812a668bbbafd25dd4fb580b8041f3d4807a7e1539e4ffc647146d4', 29, 1, 'authToken', '[]', 0, '2020-11-02 19:45:16', '2020-11-02 19:45:16', '2021-11-03 02:45:16'),
('7fc072f5c5117ab782d8c573d917aea62287523e72abe89ea91c3439f25aa53431b95b4e92673975', 29, 1, 'authToken', '[]', 0, '2020-11-09 04:14:50', '2020-11-09 04:14:50', '2021-11-09 11:14:50'),
('80a3a7911e297826a50386b308e1c511924b12560d8dd9c17fd0b94d4e5a68008a944dc355607ca4', 29, 1, 'authToken', '[]', 0, '2020-10-30 08:03:05', '2020-10-30 08:03:05', '2021-10-30 15:03:05'),
('81d9cb5b6beae73d249f30f72be455d600145d70565e9f04b50b8c06142f8c4a0a7261c7f5b2ee70', 29, 1, 'authToken', '[]', 0, '2020-10-31 23:00:47', '2020-10-31 23:00:47', '2021-11-01 06:00:47'),
('81fc076768645f58ea7c37608b7a4a8e884e609c19d8ffed6c926e7680e5ace2f1e9d55c18577139', 29, 1, 'authToken', '[]', 0, '2020-11-03 18:01:58', '2020-11-03 18:01:58', '2021-11-04 01:01:58'),
('85e3bf96fe279ebbe347c83f61a7932045e455c22504b8836f64e31923b45802d8695d28ea5e7c02', 29, 1, 'authToken', '[]', 0, '2020-10-30 04:28:28', '2020-10-30 04:28:28', '2021-10-30 11:28:28'),
('875288d0be013636610ed928fda9682dac43395edc35514a5b1d497750b8b30f5a3a26d3cd8b8363', 29, 1, 'authToken', '[]', 0, '2020-11-06 06:52:11', '2020-11-06 06:52:11', '2021-11-06 13:52:11'),
('8c3f7781431038670f8ed1d7d5ff2eb93908fe11efffa94e53f1f154e5dbf62d46218892cfada821', 29, 1, 'authToken', '[]', 0, '2020-11-04 19:36:42', '2020-11-04 19:36:42', '2021-11-05 02:36:42'),
('8d72620d9ee717d87e98755d241d67eb5a6bc24da29488675b28a76d8acc3da7e0f0583afda6d7ee', 29, 1, 'authToken', '[]', 0, '2020-11-03 06:54:01', '2020-11-03 06:54:01', '2021-11-03 13:54:01'),
('8eac4c48543eebb96adcb4a4db56024349ce15e803d78e3dd6d8ed301d3ba12474efe4fc6563a734', 29, 1, 'authToken', '[]', 0, '2020-11-06 10:31:10', '2020-11-06 10:31:10', '2021-11-06 17:31:10'),
('8eb3acfa73574219dab2466e3cb66ab419c86fdc2a7cdb172981483bf0e7d6e62a8e980380c22a33', 29, 1, 'authToken', '[]', 0, '2020-11-05 00:22:06', '2020-11-05 00:22:06', '2021-11-05 07:22:06'),
('8ef5365cda6dbf8bc129def77274f0bb7339c2d8b60bdd488c325518ef2cf00e7abac882f49b23b6', 29, 1, 'authToken', '[]', 0, '2020-11-04 23:26:09', '2020-11-04 23:26:09', '2021-11-05 06:26:09'),
('8f669fde416f8e11863e1d658aa226702538a5848bac2a15cf5c4febb848ffcc991dd07a231733b4', 29, 1, 'authToken', '[]', 0, '2020-11-04 23:47:06', '2020-11-04 23:47:06', '2021-11-05 06:47:06'),
('8fe5e5e9296dd53d3c6e11aa52d637ed058dc97a640cb321407bdfea2c03189265689c6680e4ba47', 2, 1, 'authToken', '[]', 0, '2020-07-21 05:38:23', '2020-07-21 05:38:23', '2021-07-21 12:38:23'),
('91a5e4d3c6cea0d39a56c561c7412eb72900894068b54dada851a43c4070fd63d227a10240ad53f4', 29, 1, 'authToken', '[]', 0, '2020-11-04 19:32:52', '2020-11-04 19:32:52', '2021-11-05 02:32:52'),
('93b66f77cb1dac96072ddf969804da09d0f1704edff217c377098df588040c3c5642ee89e3b9e1f5', 30, 1, 'authToken', '[]', 0, '2020-11-03 18:12:32', '2020-11-03 18:12:32', '2021-11-04 01:12:32'),
('981716453683679579f9a05cf6cffc845b1300890c4a287602812d3e429a86f0d0359e65eb4aba1d', 29, 1, 'authToken', '[]', 0, '2020-11-06 07:52:44', '2020-11-06 07:52:44', '2021-11-06 14:52:44'),
('9953a19d25ffdc87137aa6b86737ebc28e2652adbd6888251b087eebaf038b1267f68888cbad1a01', 29, 1, 'authToken', '[]', 0, '2020-11-02 02:12:30', '2020-11-02 02:12:30', '2021-11-02 09:12:30'),
('9b63021eacf2b99e01b6f6e130edbe3c78eee4015eb41721469742b1555f585d6cbf68d829a34dbe', 29, 1, 'authToken', '[]', 0, '2020-10-29 19:09:36', '2020-10-29 19:09:36', '2021-10-30 02:09:36'),
('9e9eed15a90060b5978df7e20070597c4693904328212bf4d3a6cea99acb0415b2fc89c8de135c60', 29, 1, 'authToken', '[]', 0, '2020-11-06 00:50:00', '2020-11-06 00:50:00', '2021-11-06 07:50:00'),
('9ecf5276ea95595e2c380e8efe6ea3ce361880e0ad562b3b3047949bccc628c32a74adc135e2cc5d', 2, 1, 'authToken', '[]', 0, '2020-07-21 19:44:59', '2020-07-21 19:44:59', '2021-07-22 02:44:59'),
('9ffffc7c1c188e14a7b36d35403f08344216334c1f1eee86da242fa4cfc2826fcf890359f1c6a011', 29, 1, 'authToken', '[]', 0, '2020-10-29 19:17:50', '2020-10-29 19:17:50', '2021-10-30 02:17:50'),
('a094c92c216066a32b1c5afdef17861d35cc11d1d8e59c29fc961dabe6347108c0eb4cb4fa01d3d0', 29, 1, 'authToken', '[]', 0, '2020-11-09 04:24:11', '2020-11-09 04:24:11', '2021-11-09 11:24:11'),
('a0bdd982dcd017c312b71c445f06b0d54c0e02b1082ead79fe3d4f79ec0d1c080ef622fa13c31af1', 29, 1, 'authToken', '[]', 0, '2020-11-04 19:15:06', '2020-11-04 19:15:06', '2021-11-05 02:15:06'),
('a0dc4bb47dda0fae8a4e1f9b915a4786fba3dc963c50a9b3695e320907ddfd789fc6c6eaab39591f', 29, 1, 'authToken', '[]', 0, '2020-10-30 07:22:23', '2020-10-30 07:22:23', '2021-10-30 14:22:23'),
('a28427c59873416f6d8d2acc49cfa57bf82d59f751997c264aa8e2221a674b999e9a04ff9d871baf', 29, 1, 'authToken', '[]', 0, '2020-10-29 19:01:22', '2020-10-29 19:01:22', '2021-10-30 02:01:22'),
('a83a489bd3231b597930ce796f704b2a77b1f7e6d79277fe72bfc99d5e3182e81d6b6f75e738cf2d', 29, 1, 'authToken', '[]', 0, '2020-11-09 11:34:04', '2020-11-09 11:34:04', '2021-11-09 18:34:04'),
('a869ebec7197427a27e661ba01a0413c0ed54917cb67ef795c1615570a590720e4a4dfaf4ce673ab', 29, 1, 'authToken', '[]', 0, '2020-11-05 23:39:28', '2020-11-05 23:39:28', '2021-11-06 06:39:28'),
('a8a02e6954e5a5beacc90d01f536d2e41c818860a2c83be80071a0692e7cc9247c1620c7c498ea95', 26, 1, 'authToken', '[]', 0, '2020-10-28 18:33:54', '2020-10-28 18:33:54', '2021-10-29 01:33:54'),
('a9e36b9d8dd64cebc0b33e1452c6fe11c1c8589662e150d813e31109cc043b2be05da433be92e958', 29, 1, 'authToken', '[]', 0, '2020-11-06 10:17:20', '2020-11-06 10:17:20', '2021-11-06 17:17:20'),
('aa6e83e6b7b84aa3cefeba4758a4cbc82087d77888af097f530d70adf012eba37ab49df59b9c5654', 29, 1, 'authToken', '[]', 0, '2020-10-30 00:56:06', '2020-10-30 00:56:06', '2021-10-30 07:56:06'),
('ac3d7ceae953703f4a76ced09c6e7ed7f6d8a365e1f75506365c57f1120604fa6fa24c21c9c634b8', 29, 1, 'authToken', '[]', 0, '2020-11-04 19:18:56', '2020-11-04 19:18:56', '2021-11-05 02:18:56'),
('acce1b8daa945b2603b22ce437b8efe1bb98db8e4711a5d9366ee4fafabb402bacb3c89c4b2ae742', 29, 1, 'authToken', '[]', 0, '2020-10-29 19:06:35', '2020-10-29 19:06:35', '2021-10-30 02:06:35'),
('ad0bf7f2094d0e3b027a9ecf20a9b3431dd5e7bc50febeeab16d2eacbff02ceb657f9739d8f0d751', 2, 1, 'authToken', '[]', 0, '2020-08-04 08:54:03', '2020-08-04 08:54:03', '2021-08-04 15:54:03'),
('b1146dc637b3613b8bba28b81cbad8bd1d9b6b8e548d3b253fc531a739d8b36d3e7220aad5503f3d', 26, 1, 'authToken', '[]', 0, '2020-10-28 18:35:13', '2020-10-28 18:35:13', '2021-10-29 01:35:13'),
('b22ea4d8fde4982b580f1a966a77eeab9136e01e64ce6a8f5524e0314724cffaf3ce783a76143c4f', 29, 1, 'authToken', '[]', 0, '2020-11-07 08:56:07', '2020-11-07 08:56:07', '2021-11-07 15:56:07'),
('b2d07de094368fe1690fe0e7b44fd072fd00304f4a123835af101b9a84e1881bdf07b52be035d626', 29, 1, 'authToken', '[]', 0, '2020-11-07 07:53:56', '2020-11-07 07:53:56', '2021-11-07 14:53:56'),
('b2d21f65f4a339afe6a22598fb81b4ea51dc6e1ea688911530d77e9ea82ae0fd3c37892d09575683', 29, 1, 'authToken', '[]', 0, '2020-11-04 23:14:04', '2020-11-04 23:14:04', '2021-11-05 06:14:04'),
('b2d6b5aa9b67cdc4612b678496cad337c9b18504d8c02d207cd1cb2ce7ae474a551e6c3d2cc545ce', 29, 1, 'authToken', '[]', 0, '2020-10-31 07:07:04', '2020-10-31 07:07:04', '2021-10-31 14:07:04'),
('b372d542ffe5c632dea7d9de0aacb2e5a3c174f2d082dff9c9358b8526bae7c2efd2363066df8adc', 29, 1, 'authToken', '[]', 0, '2020-10-29 19:03:48', '2020-10-29 19:03:48', '2021-10-30 02:03:48'),
('b51421942303764836044b8947f59726c3d523c827b38686c57c20274a4eae605fa619b13c73feab', 2, 1, 'authToken', '[]', 0, '2020-07-21 20:14:08', '2020-07-21 20:14:08', '2021-07-22 03:14:08'),
('b5d92fe29ee3601899399b2be2701d7f5756c68ecf65bb23317b500b93153933b29c379dc7cfc96b', 29, 1, 'authToken', '[]', 0, '2020-10-31 10:06:00', '2020-10-31 10:06:00', '2021-10-31 17:06:00'),
('b5fb977dba7a30e548c926a48e043969b753b9b7517a21721eb62f8d85bed461a8373283d7c50c6a', 29, 1, 'authToken', '[]', 0, '2020-11-19 12:12:26', '2020-11-19 12:12:26', '2021-11-19 19:12:26'),
('b60d8abcc9b3882b5b0c833375f75141024cbd71a8fc5b9b5d55df0229d449ec60a1ce8c32d4ef05', 2, 1, 'authToken', '[]', 0, '2020-08-04 06:18:49', '2020-08-04 06:18:49', '2021-08-04 13:18:49'),
('b833cd73c57ed46d78bc7178c2515cb0d24ca3c274f0c1908f37b37dc12789f31923fb1c629f4e6a', 29, 1, 'authToken', '[]', 0, '2020-11-06 09:27:00', '2020-11-06 09:27:00', '2021-11-06 16:27:00'),
('b89f4210a779c522bf838c38a72aacf0d78cc0120bb523c347a9206f057e13b0853b59c9c75b68ba', 29, 1, 'authToken', '[]', 0, '2020-11-06 09:34:48', '2020-11-06 09:34:48', '2021-11-06 16:34:48'),
('bc3ccafe054305fb1412086e796b94cbf50698b42e0daad45ab8637b7746cf8e99b04327f5963e2d', 29, 1, 'authToken', '[]', 0, '2020-11-02 19:02:51', '2020-11-02 19:02:51', '2021-11-03 02:02:51'),
('bd6d30a87f393ae978d26b619feae776220c04c4360efe48f9960948689929ec76b16affe06beff8', 29, 1, 'authToken', '[]', 0, '2020-11-04 19:53:21', '2020-11-04 19:53:21', '2021-11-05 02:53:21'),
('becd3e654796241bee75f9eba7b038490a53f4069915acba99f19c4931dc21d996a3fa189893930a', 29, 1, 'authToken', '[]', 0, '2020-11-07 19:41:39', '2020-11-07 19:41:39', '2021-11-08 02:41:39'),
('bf8440d19c981c101426a15179c9cdc7af5d981ac83ed6d4a7637a4903f5cdc71f706fd373679c6d', 29, 1, 'authToken', '[]', 0, '2020-11-03 17:56:19', '2020-11-03 17:56:19', '2021-11-04 00:56:19'),
('c66720c1b800b11181daef749356dc3bbf10f9e6b5e66d87365d9fd77ca9c20785d3c8a4c926ee36', 29, 1, 'authToken', '[]', 0, '2020-11-07 18:01:24', '2020-11-07 18:01:24', '2021-11-08 01:01:24'),
('c7e27cdb0c780cbb00e50ab68f577cd044002764bbeb2ef280d125fe334b1edb1bb16c079c272d41', 29, 1, 'authToken', '[]', 0, '2020-11-06 06:47:32', '2020-11-06 06:47:32', '2021-11-06 13:47:32'),
('cd2181de9a98e8474e9de65c4facf1e9ce58cd1deba7686654770ed94dd0d9ff3127a55511028cfa', 29, 1, 'authToken', '[]', 0, '2020-11-06 08:47:33', '2020-11-06 08:47:33', '2021-11-06 15:47:33'),
('cf3ffaa2badbd059c6c70b3777d01c8567e6cf97a1c37556e984803d5cd0323d50e0c3824dbef9e3', 29, 1, 'authToken', '[]', 0, '2020-11-06 07:34:26', '2020-11-06 07:34:26', '2021-11-06 14:34:26'),
('cf954b0354690b384213f0735c1d1778a004129e8b66308287e8e60b971544617a96680171dd2c4f', 29, 1, 'authToken', '[]', 0, '2020-11-04 18:33:36', '2020-11-04 18:33:36', '2021-11-05 01:33:36'),
('cfee9da6f0f9ecc3eeec224e94791d06c6d41b21a7dcaa324f77e1b17aec4ab0e806db6ff49b167a', 29, 1, 'authToken', '[]', 0, '2020-11-03 08:34:29', '2020-11-03 08:34:29', '2021-11-03 15:34:29'),
('d0c111065d29e0e12148bb1a32f35c8ff1e1a58b7983373f1baf391dee9f31a660aaa2a5e024132b', 29, 1, 'authToken', '[]', 0, '2020-10-31 09:31:24', '2020-10-31 09:31:24', '2021-10-31 16:31:24'),
('d11df32bed6bf88837e02f9c8d4e25bd584bc8719f9945c06c25e1f9205e5ccafcf733face4c3bcc', 29, 1, 'authToken', '[]', 0, '2020-11-03 18:00:08', '2020-11-03 18:00:08', '2021-11-04 01:00:08'),
('d184b565196c9ca26249636bd8f25f7b78f127bfd4dd6b3be5d6ad467869c9d4ae7d8a9bacbe08f6', 29, 1, 'authToken', '[]', 0, '2020-10-29 19:13:12', '2020-10-29 19:13:12', '2021-10-30 02:13:12'),
('d40dd861c812f8f85a2c9b9a26b105c4d1ec734a0196a47fb7ef6e60e95e273eecaad28a282f6893', 29, 1, 'authToken', '[]', 0, '2020-10-30 07:37:30', '2020-10-30 07:37:30', '2021-10-30 14:37:30'),
('d879788da183432155838baff7093d94b402dbefb069d03611b098d928db08219c5b6b1b5d9c0f72', 29, 1, 'authToken', '[]', 0, '2020-11-04 23:16:56', '2020-11-04 23:16:56', '2021-11-05 06:16:56'),
('db8333ae7930355aa849d222d796fe8e831118b1aed477169892bb7674cf410f35c4900ac1036e38', 29, 1, 'authToken', '[]', 0, '2020-10-29 23:06:36', '2020-10-29 23:06:36', '2021-10-30 06:06:36'),
('de56d9d1a31799058c09a5584d582ab5414f5b2c1e60614c7a12a2d0fbc1fc6b4c2d875da4a05bc1', 29, 1, 'authToken', '[]', 0, '2020-10-30 07:00:41', '2020-10-30 07:00:41', '2021-10-30 14:00:41'),
('df34c7ea26dbd263ec4982ec9d27fe30417b3123c28cdefa6bfdcbe04488715c01ca10d091b2cc4b', 29, 1, 'authToken', '[]', 0, '2020-10-29 19:05:44', '2020-10-29 19:05:44', '2021-10-30 02:05:44'),
('e143ed6e9f9f50877e7a3bd730e9023c6aa3a035e2fd92dc0438b21f4dc712043e360b76fd28a4c5', 29, 1, 'authToken', '[]', 0, '2020-11-03 18:59:31', '2020-11-03 18:59:31', '2021-11-04 01:59:31'),
('e1c7f77ff5590164d372e953be2dcac693ee3a38a4cfe89999debb6c944df46d3ceb7924489c4bc8', 29, 1, 'authToken', '[]', 0, '2020-11-03 18:22:34', '2020-11-03 18:22:34', '2021-11-04 01:22:34'),
('e387f1d56f7489bdfc1bc1d0191b44fe356b5c96ae0f9a36025a859d7def377cefa40835eab44308', 29, 1, 'authToken', '[]', 0, '2020-11-07 17:21:02', '2020-11-07 17:21:02', '2021-11-08 00:21:02'),
('e3a590bc05d86436fd1986ded795320ff533608912d38acf899ede5e8fe54aa42e8527ebd8591a09', 2, 1, 'authToken', '[]', 0, '2020-07-23 07:03:53', '2020-07-23 07:03:53', '2021-07-23 14:03:53'),
('e44b68372c48f5b1aba2f3826e8bb0c31a57dd55153228c232612cd1ebb0d2ad740b747b74e0e2cf', 29, 1, 'authToken', '[]', 0, '2020-10-31 23:46:10', '2020-10-31 23:46:10', '2021-11-01 06:46:10'),
('e5f6069e80887de6afa40822b86a60785bcd25a9404051ed4501b6c7f5b43200bfdfeecdeceab038', 26, 1, 'authToken', '[]', 0, '2020-10-28 22:23:58', '2020-10-28 22:23:58', '2021-10-29 05:23:58'),
('eedfadf9aa489a8da21a946e5aeda6f46fa6d5932bfeedce972bbcadf30f4f5305080e45db3fa1b7', 29, 1, 'authToken', '[]', 0, '2020-11-20 00:28:47', '2020-11-20 00:28:47', '2021-11-20 07:28:47'),
('eef7d383be32dd6bd55ab121ec4088806de4ca09ea4b7d0d538e5f896f5aa0db697bf607ebd52322', 29, 1, 'authToken', '[]', 0, '2020-11-02 23:31:04', '2020-11-02 23:31:04', '2021-11-03 06:31:04'),
('efdbc382f90c2f376312af7e97c9f00e66d4a61168ec7462a3180ba9d3154555c1d129828a5ad025', 2, 1, 'authToken', '[]', 0, '2020-07-21 05:40:05', '2020-07-21 05:40:05', '2021-07-21 12:40:05'),
('f09b7b32f7d3c235e7e2e529e9f6aaedd7031ae158c64f3c13dfa52529e75373fa77fd40ee26cf75', 29, 1, 'authToken', '[]', 0, '2020-11-06 08:56:29', '2020-11-06 08:56:29', '2021-11-06 15:56:29'),
('f2b763ebca9c26ea9f4d347a76517df04d55dcc8cf162876d869212fc924124f4e678c32b3d39f36', 29, 1, 'authToken', '[]', 0, '2020-11-06 06:48:57', '2020-11-06 06:48:57', '2021-11-06 13:48:57'),
('f59a455684095ec85dc1f380686c114a2987bf321320ac4d794b8089155ecce2050db6be6b5ad24a', 26, 1, 'authToken', '[]', 0, '2020-10-28 22:01:41', '2020-10-28 22:01:41', '2021-10-29 05:01:41'),
('f61fbb937ccaeed526177757d22e961c33595dc589fc15ae31436f7d673b55a09bf4f88c6011f73c', 29, 1, 'authToken', '[]', 0, '2020-10-29 18:39:19', '2020-10-29 18:39:19', '2021-10-30 01:39:19'),
('f72c5ee8e506831344c75c249f25726f94e3e54f5f6b27512bb848f66cf61558dc875982e8ee8822', 2, 1, 'authToken', '[]', 0, '2020-07-21 20:11:36', '2020-07-21 20:11:36', '2021-07-22 03:11:36'),
('f82b526fa6a082121ab5cf2d65be374875971bd12e6b7731b0e171573262b4dacd5349033bf63433', 29, 1, 'authToken', '[]', 0, '2020-11-06 09:30:10', '2020-11-06 09:30:10', '2021-11-06 16:30:10'),
('fa6293e09f2ee7da352963c3311649609b1f98063bb7872f9971b5edfb6da4c3578bad49146480e4', 30, 1, 'authToken', '[]', 0, '2020-11-03 18:53:16', '2020-11-03 18:53:16', '2021-11-04 01:53:16'),
('fe3f3e3a63813a27faa985b1b289641906a9d0d29c84a003232950b6856f4f90fa334b2939b301ac', 28, 1, 'authToken', '[]', 0, '2020-10-28 23:06:37', '2020-10-28 23:06:37', '2021-10-29 06:06:37');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'yXNmB7oEUv7LiAcQFknV5Jse8WvMI0T7SVvXMUce', NULL, 'http://localhost', 1, 0, 0, '2020-07-21 05:29:17', '2020-07-21 05:29:17'),
(2, NULL, 'Laravel Password Grant Client', 'XF3kbjkDcvmfjja7RXeOA8DBvlcoOa8PzhOPpnlY', 'users', 'http://localhost', 0, 1, 0, '2020-07-21 05:29:17', '2020-07-21 05:29:17');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-07-21 05:29:17', '2020-07-21 05:29:17');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `relationships`
--

CREATE TABLE `relationships` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fromId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `toId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `temp_users`
--

CREATE TABLE `temp_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` bigint(20) NOT NULL,
  `setDate` date NOT NULL,
  `kita` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `temp_users`
--

INSERT INTO `temp_users` (`id`, `userId`, `setDate`, `kita`, `group`, `created_at`, `updated_at`) VALUES
(13, 25, '2020-08-20', '1', '1', '2020-08-21 07:05:30', '2020-08-21 07:05:30'),
(14, 23, '2020-08-21', '1', '1', '2020-08-24 07:55:35', '2020-08-24 07:55:35');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fullName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userType` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullName`, `username`, `email`, `email_verified_at`, `phone`, `userType`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(29, 'AdiBonchis', 'admin1234', 'www@adib.gmail', NULL, '51456258715', 'admin', '$2y$10$udmh1F/3dzDHAMVzNuqIW.xuBtWSY1FaqQaKnqXb9omtcrNGyY2OG', NULL, '2020-10-28 23:11:13', '2020-10-30 08:06:07'),
(30, 'Tom Sweda', 'user1234', 'www@sweta.gmail', NULL, '123502415', 'client', '$2y$10$5WjtBCx6NBeIHtLTn2ydhutiox5uW6Dz8aLEBkPPmM5JhOQnkrE7C', NULL, '2020-11-03 08:50:19', '2020-11-03 08:50:19'),
(31, 'Rommel Hanss', 'admiin21234', 'www@rommelhanss.gmail', NULL, '45812689', 'client', '$2y$10$Ihl19hiaGm1gi3saNWQNje7hDly2tzbjkoPfzy3SF7xocStXQ42ly', NULL, '2020-11-04 22:55:21', '2020-11-04 22:55:21'),
(32, 'AtomaMorris', 'user41234', 'www@atomamorris.gmail', NULL, '6589425', 'client', '$2y$10$bEKHEVKSHZ98IZJYuE/9geT4gIeG15d8VQrUmnT.JU4KfTt4jIx1S', NULL, '2020-11-05 23:28:27', '2020-11-05 23:28:27');

-- --------------------------------------------------------

--
-- Table structure for table `user_extra_emails`
--

CREATE TABLE `user_extra_emails` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_extra_emails`
--

INSERT INTO `user_extra_emails` (`id`, `user_id`, `email`, `created_at`, `updated_at`) VALUES
(1, 18, '2@2.com', '2020-07-21 08:09:15', '2020-07-21 08:09:15'),
(2, 18, '3@3.com', '2020-07-21 08:09:15', '2020-07-21 08:09:15'),
(3, 18, '4@4.com', '2020-07-21 08:09:15', '2020-07-21 08:09:15'),
(4, 18, '5@5.com', '2020-07-21 08:09:15', '2020-07-21 08:09:15'),
(5, 19, 'test@outlook.com', '2020-07-21 08:17:27', '2020-07-21 08:17:27'),
(6, 19, 'test@yahoo.com', '2020-07-21 08:17:27', '2020-07-21 08:17:27'),
(7, 19, 'test@gmail.com', '2020-07-21 08:17:27', '2020-07-21 08:17:27'),
(8, 20, 'King@tes.com', '2020-07-21 08:35:45', '2020-07-21 08:35:45'),
(9, 21, 'King@tes.com', '2020-07-21 08:37:24', '2020-07-21 08:37:24'),
(10, 22, 'extra@outlook.com', '2020-07-21 08:59:33', '2020-07-21 08:59:33'),
(11, 22, '1@t.com', '2020-07-21 08:59:33', '2020-07-21 08:59:33'),
(12, 25, 'smith2@outlook.com', '2020-08-06 05:59:13', '2020-08-06 05:59:13');

-- --------------------------------------------------------

--
-- Table structure for table `user_extra_kitas`
--

CREATE TABLE `user_extra_kitas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `kita_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_extra_kitas`
--

INSERT INTO `user_extra_kitas` (`id`, `user_id`, `kita_id`, `created_at`, `updated_at`) VALUES
(1, 21, '2', '2020-07-21 08:37:24', '2020-07-21 08:37:24'),
(2, 22, '1', '2020-07-21 08:59:33', '2020-07-21 08:59:33'),
(3, 22, '2', '2020-07-21 08:59:33', '2020-07-21 08:59:33');

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `deviceId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ssid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `password` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`id`, `deviceId`, `ssid`, `state`, `created_at`, `updated_at`, `password`) VALUES
(15, '14', '1', '1', '2020-11-10 01:33:41', '2020-11-10 01:33:44', 'changedPassword'),
(16, '14', '2', '0', '2020-11-10 01:33:41', '2020-11-10 01:33:41', 'changedPassword'),
(18, '17', '1', '0', '2020-11-10 01:55:58', '2020-11-10 01:55:58', 'admin'),
(19, '15', '65448721842134813158', '0', '2020-11-10 02:02:05', '2020-11-10 02:02:05', 'ddd');

-- --------------------------------------------------------

--
-- Table structure for table `wifis`
--

CREATE TABLE `wifis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ssid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wifis`
--

INSERT INTO `wifis` (`id`, `ssid`, `created_at`, `updated_at`) VALUES
(1, '123544512564825694526', NULL, NULL),
(2, '65448721842134813158', NULL, NULL),
(3, '46412318461634131832', NULL, NULL),
(4, '1564843418741248415', NULL, NULL),
(5, '98784132151842318413158', NULL, NULL),
(6, '3218468132184341813215', NULL, NULL),
(7, '447988432418431878421', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alerts`
--
ALTER TABLE `alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat_conversations`
--
ALTER TABLE `chat_conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_messages_participation_id_foreign` (`participation_id`),
  ADD KEY `chat_messages_conversation_id_foreign` (`conversation_id`);

--
-- Indexes for table `chat_message_notifications`
--
ALTER TABLE `chat_message_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `participation_message_index` (`participation_id`,`message_id`),
  ADD KEY `chat_message_notifications_message_id_foreign` (`message_id`),
  ADD KEY `chat_message_notifications_conversation_id_foreign` (`conversation_id`);

--
-- Indexes for table `chat_participation`
--
ALTER TABLE `chat_participation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `participation_index` (`conversation_id`,`messageable_id`,`messageable_type`);

--
-- Indexes for table `dailyinfos`
--
ALTER TABLE `dailyinfos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forgotpasswords`
--
ALTER TABLE `forgotpasswords`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groupchats`
--
ALTER TABLE `groupchats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kitas`
--
ALTER TABLE `kitas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kitasupers`
--
ALTER TABLE `kitasupers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kita_group_users`
--
ALTER TABLE `kita_group_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kita_vs_groups`
--
ALTER TABLE `kita_vs_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `relationships`
--
ALTER TABLE `relationships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD UNIQUE KEY `sessions_id_unique` (`id`);

--
-- Indexes for table `temp_users`
--
ALTER TABLE `temp_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indexes for table `user_extra_emails`
--
ALTER TABLE `user_extra_emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_extra_kitas`
--
ALTER TABLE `user_extra_kitas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wifis`
--
ALTER TABLE `wifis`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alerts`
--
ALTER TABLE `alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_conversations`
--
ALTER TABLE `chat_conversations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_message_notifications`
--
ALTER TABLE `chat_message_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_participation`
--
ALTER TABLE `chat_participation`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dailyinfos`
--
ALTER TABLE `dailyinfos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forgotpasswords`
--
ALTER TABLE `forgotpasswords`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `groupchats`
--
ALTER TABLE `groupchats`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `kitas`
--
ALTER TABLE `kitas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kitasupers`
--
ALTER TABLE `kitasupers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kita_group_users`
--
ALTER TABLE `kita_group_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `kita_vs_groups`
--
ALTER TABLE `kita_vs_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `relationships`
--
ALTER TABLE `relationships`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `temp_users`
--
ALTER TABLE `temp_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `user_extra_emails`
--
ALTER TABLE `user_extra_emails`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_extra_kitas`
--
ALTER TABLE `user_extra_kitas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `wifis`
--
ALTER TABLE `wifis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD CONSTRAINT `chat_messages_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `chat_conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_messages_participation_id_foreign` FOREIGN KEY (`participation_id`) REFERENCES `chat_participation` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `chat_message_notifications`
--
ALTER TABLE `chat_message_notifications`
  ADD CONSTRAINT `chat_message_notifications_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `chat_conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_message_notifications_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `chat_messages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_message_notifications_participation_id_foreign` FOREIGN KEY (`participation_id`) REFERENCES `chat_participation` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_participation`
--
ALTER TABLE `chat_participation`
  ADD CONSTRAINT `chat_participation_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `chat_conversations` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
