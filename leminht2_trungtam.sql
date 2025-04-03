-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost:3306
-- Thời gian đã tạo: Th4 03, 2025 lúc 02:29 AM
-- Phiên bản máy phục vụ: 8.0.41-0ubuntu0.24.04.1
-- Phiên bản PHP: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `leminht2_trungtam`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `courses`
--

CREATE TABLE `courses` (
  `id` bigint UNSIGNED NOT NULL,
  `course_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `subject_id` bigint UNSIGNED NOT NULL,
  `status` enum('errolled','in_process','cancelled','pausing','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'errolled',
  `enrollment_date` date DEFAULT NULL COMMENT 'Ngày đăng ký khóa học',
  `base_fee` decimal(15,0) NOT NULL DEFAULT '0' COMMENT 'Học phí gốc tại thời điểm đăng ký',
  `discount_amount` decimal(15,0) NOT NULL DEFAULT '0' COMMENT 'Số tiền giảm giá áp dụng',
  `final_amount` decimal(15,0) NOT NULL DEFAULT '0' COMMENT 'Số tiền thực tế cần thu (base_fee - discount_amount)',
  `gift` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Mô tả quà tặng kèm (nếu có)',
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid' COMMENT 'Trạng thái thanh toán (vd: unpaid, paid, partially_paid)',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `courses`
--

INSERT INTO `courses` (`id`, `course_code`, `user_id`, `subject_id`, `status`, `enrollment_date`, `base_fee`, `discount_amount`, `final_amount`, `gift`, `payment_status`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 4, 'errolled', NULL, 0, 0, 0, NULL, 'unpaid', '2025-02-16 22:07:14', '2025-02-16 22:07:14'),
(3, NULL, 1, 4, 'errolled', NULL, 0, 0, 0, NULL, 'unpaid', '2025-04-01 10:48:43', '2025-04-01 10:48:43');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `departments`
--

CREATE TABLE `departments` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `departments`
--

INSERT INTO `departments` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Tin học văn phòng', '2025-02-16 06:11:05', '2025-02-16 06:11:05'),
(2, 'Kế toán', '2025-02-16 06:11:05', '2025-02-16 06:11:05'),
(3, 'Đồ họa', '2025-02-16 06:11:05', '2025-02-16 06:11:05'),
(4, 'Vẽ kỹ thuật', '2025-02-16 06:11:05', '2025-02-16 06:11:05'),
(5, 'Lập trình', '2025-02-16 06:11:05', '2025-02-16 06:11:05');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `enrollments`
--

CREATE TABLE `enrollments` (
  `id` bigint UNSIGNED NOT NULL,
  `personal_info_id` bigint UNSIGNED NOT NULL,
  `course_id` bigint UNSIGNED NOT NULL,
  `enrollment_date` date NOT NULL,
  `base_fee` decimal(15,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `final_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `gift` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(1, 'default', '{\"uuid\":\"7166b9bc-e91a-45d7-a0a2-f49afcfc8ba3\",\"displayName\":\"Filament\\\\Notifications\\\\DatabaseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:1;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:43:\\\"Filament\\\\Notifications\\\\DatabaseNotification\\\":2:{s:4:\\\"data\\\";a:11:{s:7:\\\"actions\\\";a:0:{}s:4:\\\"body\\\";s:75:\\\"Mật khẩu tạm thời cho trungta4444mtinhocsaoviet@gmail.com: BPIcJELl\\\";s:5:\\\"color\\\";N;s:8:\\\"duration\\\";s:10:\\\"persistent\\\";s:4:\\\"icon\\\";s:29:\\\"heroicon-o-information-circle\\\";s:9:\\\"iconColor\\\";s:4:\\\"info\\\";s:6:\\\"status\\\";s:4:\\\"info\\\";s:5:\\\"title\\\";s:34:\\\"Đã tạo tài khoản User mới\\\";s:4:\\\"view\\\";s:36:\\\"filament-notifications::notification\\\";s:8:\\\"viewData\\\";a:0:{}s:6:\\\"format\\\";s:8:\\\"filament\\\";}s:2:\\\"id\\\";s:36:\\\"be49edaa-6539-42ee-a611-b15eff557979\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\"}}', 0, NULL, 1743593849, 1743593849);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_02_16_125816_create_departments_table', 2),
(5, '2025_02_16_125846_create_subjects_table', 2),
(6, '2025_02_16_133606_create_personal_infos_table', 3),
(7, '2025_02_16_140921_create_courses_table', 4),
(8, '2025_02_17_051701_create_coursesfees_table', 5),
(9, '2025_02_17_051926_create_payments_table', 6),
(10, '2025_02_22_073241_create_resource_table', 7),
(11, '2025_04_02_133024_create_enrollments_table', 8),
(12, '2025_04_02_144552_add_enrollment_details_to_courses_table', 8);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payments`
--

CREATE TABLE `payments` (
  `id` bigint UNSIGNED NOT NULL,
  `course_id` bigint UNSIGNED NOT NULL,
  `payment_amount` decimal(20,0) NOT NULL,
  `payment_date` datetime NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `personal_infos`
--

CREATE TABLE `personal_infos` (
  `id` bigint UNSIGNED NOT NULL,
  `identitynumber` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateofbirth` date DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `placeofbirth` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('Nam','Nữ') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `personal_infos`
--

INSERT INTO `personal_infos` (`id`, `identitynumber`, `name`, `dateofbirth`, `phone`, `email`, `address`, `placeofbirth`, `gender`, `created_at`, `updated_at`, `user_id`) VALUES
(1, '080201001657', 'Lê Minh Triết', NULL, '0946426536', 'minhtrietofficial@gmail.com', 'Số 92, Lê Văn Lương, Tân Phong, Quận 7, Hồ Chí Minh', 'Lâm Đồng', 'Nam', '2025-02-16 06:56:07', '2025-02-16 20:21:36', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `resources`
--

CREATE TABLE `resources` (
  `id` bigint UNSIGNED NOT NULL,
  `appname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_truycap` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ten_hanhdong` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trangthai_link` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `resources`
--

INSERT INTO `resources` (`id`, `appname`, `version`, `link_truycap`, `ten_hanhdong`, `trangthai_link`, `created_at`, `updated_at`) VALUES
(1, 'Microsoft Office', '2016', 'https://officecdn.microsoft.com/db/39168d7e-077b-48e7-872c-b232c3e72675/media/en-us/ProfessionalRetail.img', 'Truy cập', 1, '2025-02-22 00:39:44', '2025-02-22 00:39:44'),
(2, 'Microsoft Office', '2013', 'https://officecdn.microsoft.com/db/39168d7e-077b-4...', 'Truy cập', 1, '2025-02-22 00:49:35', '2025-02-22 00:49:35'),
(3, 'Microsoft Office', '2019', 'https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProPlus2019Retail.img', 'Truy cập', 1, '2025-02-22 00:49:49', '2025-02-22 00:49:49'),
(4, 'Microsoft Office', '365', 'https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/O365ProPlusRetail.img', 'Truy cập', 1, '2025-02-22 00:50:33', '2025-02-22 00:50:33'),
(5, 'Autocad', '2022', 'https://drive.google.com/file/d/1OBDh4t4jyzes96qoN...', 'Truy cập', 1, '2025-02-22 00:51:45', '2025-02-22 00:51:45'),
(6, 'Autodesk Autocad', '2024', 'https://drive.google.com/file/d/188Wek7iE7NcsFdEpmfSjntnrj0cLPuoc/view?usp=drive_link', 'Truy cập', 1, '2025-02-22 00:52:08', '2025-02-22 00:52:08'),
(7, 'SketchUp', '2022', 'https://drive.google.com/file/d/1z4Sv7SdAinwdTvtU0...', 'Truy cập', 1, '2025-02-22 00:53:40', '2025-02-22 00:53:40'),
(8, 'Windows 11 Cursor', '1.0', 'https://drive.google.com/drive/folders/1TcHbsi3eYXO52uON4wMPPkYBZ7Wxd7Fj?usp=drive_link', 'Truy cập', 1, '2025-02-22 00:53:54', '2025-02-22 00:53:54'),
(9, 'Adobe Photoshop', '2023', 'https://drive.google.com/file/d/1Qai1oojam8oWzHjSCUQv2aAtVuywFFla/view?usp=drive_link', 'Truy cập', 1, '2025-02-22 01:05:35', '2025-02-22 01:05:35'),
(10, 'Adobe Illustrator', '2023', 'https://drive.google.com/file/d/1L6cHeclUiGU_6D721xNhoEvGZMCQlDSY/view?usp=drive_link', 'Truy cập', 1, '2025-02-22 01:05:49', '2025-02-22 01:05:49'),
(11, 'Microsoft Visio', '2019', 'https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/VisioPro2019Retail.img', 'Truy cập', 1, '2025-02-22 01:06:05', '2025-02-22 01:06:05'),
(12, 'Microsoft Project', '2021', 'https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProjectPro2021Retail.img', 'Truy cập', 1, '2025-02-22 01:06:16', '2025-02-22 01:06:16'),
(13, 'CorelDraw', '25.0.0.230', 'https://drive.google.com/file/d/1fj2hgB9_qOqxGA1koXXwA-9DgVyheBuN/view?usp=drive_link', 'Truy cập', 1, '2025-02-22 01:06:31', '2025-02-22 01:06:31'),
(14, 'Adobe Photoshop', '2025', 'https://drive.google.com/file/d/1bJTe6IihIekotrusXK9AeOjsEBfYZRAa/view?usp=drive_link', 'Truy cập', 1, '2025-02-22 01:06:44', '2025-02-22 01:06:44'),
(15, 'Hướng dẫn cài đặt Misa', 'MISA SME', 'https://1drv.ms/w/s!AlpBv6aDzDoVgtpX2J9kOHFfoWnaRg?e=dBSdRz', 'Truy cập', 1, '2025-02-22 01:07:04', '2025-02-22 01:07:04'),
(16, 'IC3', 'Sparks GS6', 'https://drive.google.com/drive/folders/1LF4WasmlqyK8Jy90j8szKBxG0xhkpMqb?usp=drive_link', 'Truy cập', 1, '2025-02-22 01:07:15', '2025-02-22 01:07:15'),
(17, 'Revit', '2024', 'https://drive.google.com/file/d/1a4DIL60GFHun1qxkHVKaE00zYM5jjAvh/view?usp=drive_link', 'Truy cập', 1, '2025-02-22 01:07:26', '2025-02-22 01:07:26'),
(18, 'FastStone Capture', '10.6', 'https://drive.google.com/file/d/1AJN_JHLBqYaxXQFDhXbhhqKPzbX1NjIy/view?usp=drive_link', 'Truy cập', 1, '2025-02-22 01:07:36', '2025-02-22 01:07:36'),
(19, 'Adobe Illustrator', '2025', 'https://drive.google.com/file/d/1QgUqwbV2VRptmXw8x5ovRHbcPm2RkMx6/view?usp=drive_link', 'Truy cập', 1, '2025-02-22 01:07:59', '2025-02-22 01:07:59');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('5frbz8wygHsG0Z0mrQmUtyLkg7JFt4PpHKEOI6Us', 1, '192.168.1.22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiTUtKVWt0Y1Q5SVlQY25SNGxwelFRNFNsS05kQ1BlUWUyNTdMazNVSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHA6Ly8xOTIuMTY4LjEuMjo4MDAwL2FkbWluL3JlZ2lzdGVyLWNvdXJzZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRKWHEuL3RKOW1qRXRIUkphbUxKUWZ1SWNUMDYvTUd0RUhneVZSZS5TV3lBdU5UeVV0TXFSRyI7czo4OiJmaWxhbWVudCI7YTowOnt9fQ==', 1743607231),
('bEtrfdKZGqEhUkhyAxPQSzTHKpaideAi8s3krZxs', NULL, '109.205.213.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36 Edg/90.0.818.46', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiTExVdElhVjlncjk1bk9YMmttaWhlb2FWbmtBSTZuNmNpSUl4ZHZUNiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1743610490),
('I5KY3ohVjuAmXJX6momGgDudAEy0KQr7gVibP3Dm', NULL, '179.43.175.246', 'Hello World/1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieWtkMjZHeWo2MFVLa2JJUnZJNkNWSGx1VVcyWHYyZU9SVG9iQmloRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xNC4xODYuODQuMzY6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1743609254),
('KozTdvjF7nQD6G8N93S8hzSf3CtvKNXz7IiZEEoM', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiNk1rbEFTV0tIY25RZzNRTHRpSU0xQXhrS01YVG15R0lvNGxLdzJzayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9yZWdpc3Rlci1jb3Vyc2UiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJEpYcS4vdEo5bWpFdEhSSmFtTEpRZnVJY1QwNi9NR3RFSGd5VlJlLlNXeUF1TlR5VXRNcVJHIjtzOjg6ImZpbGFtZW50IjthOjA6e319', 1743612251),
('mRPTE953F7BTzBUsu9f7RrskVwZpBOg0eVNPu5nn', NULL, '114.35.42.104', 'curl/7.88.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOXdwcEpxUHZPZk4wMW5SOVJKRzA5ZWFVeDB0T3ZZTm9pQnBZamRwdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xNC4xODYuODQuMzY6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1743610056);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `subjects`
--

CREATE TABLE `subjects` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` bigint UNSIGNED NOT NULL,
  `price` decimal(20,0) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `subjects`
--

INSERT INTO `subjects` (`id`, `name`, `department_id`, `price`, `created_at`, `updated_at`) VALUES
(1, 'Microsoft Word 365 Basic', 1, 900000, '2025-02-16 06:12:32', '2025-02-21 03:17:32'),
(2, 'Microsoft Excel 365 Basic', 1, 900000, '2025-02-16 06:12:32', '2025-02-21 03:17:47'),
(3, 'Nguyên lý kế toán', 2, 3000000, '2025-02-16 06:12:32', '2025-02-21 03:18:00'),
(4, 'Đồ họa Photoshop', 3, 2000000, '2025-02-16 06:12:32', '2025-02-16 06:12:32'),
(5, 'Vẽ kỹ thuật cơ bản', 4, 1800000, '2025-02-16 06:12:32', '2025-02-16 06:12:32'),
(6, 'Lập trình PHP', 5, 2500000, '2025-02-16 06:12:32', '2025-02-16 06:12:32'),
(7, 'Cơ sở dữ liệu SQL', 5, 3500000, '2025-04-01 10:31:06', '2025-04-01 10:31:06');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, '080201001657', 'minhtrietofficial@gmail.com', NULL, '$2y$12$JXq./tJ9mjEtHRJamLJQfuIcT06/MGtEHgyVRe.SWyAuNTyUtMqRG', '7NJpcpC6o8GZvsjiWNILvX1JN5zsMi4btrGBJhMRiTVacl9W6kKZzDLcm7UH', '2025-02-16 05:29:10', '2025-02-16 05:29:10');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Chỉ mục cho bảng `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Chỉ mục cho bảng `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courses_course_code_unique` (`course_code`),
  ADD KEY `courses_user_id_foreign` (`user_id`),
  ADD KEY `courses_subject_id_foreign` (`subject_id`);

--
-- Chỉ mục cho bảng `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `departments_name_unique` (`name`);

--
-- Chỉ mục cho bảng `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `enrollments_personal_info_id_foreign` (`personal_info_id`),
  ADD KEY `enrollments_course_id_foreign` (`course_id`);

--
-- Chỉ mục cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Chỉ mục cho bảng `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Chỉ mục cho bảng `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Chỉ mục cho bảng `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_course_id_foreign` (`course_id`);

--
-- Chỉ mục cho bảng `personal_infos`
--
ALTER TABLE `personal_infos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_infos_identitynumber_unique` (`identitynumber`),
  ADD KEY `fk_personal_infos_users` (`user_id`);

--
-- Chỉ mục cho bảng `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Chỉ mục cho bảng `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subjects_department_id_foreign` (`department_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `identitynumber` (`name`),
  ADD UNIQUE KEY `unique_name` (`name`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `courses`
--
ALTER TABLE `courses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `personal_infos`
--
ALTER TABLE `personal_infos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT cho bảng `resources`
--
ALTER TABLE `resources`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `courses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_personal_info_id_foreign` FOREIGN KEY (`personal_info_id`) REFERENCES `personal_infos` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `personal_infos`
--
ALTER TABLE `personal_infos`
  ADD CONSTRAINT `fk_personal_infos_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `subjects_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
