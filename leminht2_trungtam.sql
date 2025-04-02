-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th2 28, 2025 lúc 08:09 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

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
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3', 'i:1;', 1740723006),
('livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3:timer', 'i:1740723006;', 1740723006);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `coursefees`
--

CREATE TABLE `coursefees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `total_fee` decimal(20,0) NOT NULL,
  `discount` decimal(20,0) NOT NULL DEFAULT 0,
  `gift` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `courses`
--

CREATE TABLE `courses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_code` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `subject_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('errolled','in_process','cancelled','pausing','completed') NOT NULL DEFAULT 'errolled',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `courses`
--

INSERT INTO `courses` (`id`, `course_code`, `user_id`, `subject_id`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 4, 'errolled', '2025-02-16 22:07:14', '2025-02-16 22:07:14');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
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
-- Cấu trúc bảng cho bảng `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
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
(10, '2025_02_22_073241_create_resource_table', 7);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `payment_amount` decimal(20,0) NOT NULL,
  `payment_date` datetime NOT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `personal_infos`
--

CREATE TABLE `personal_infos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `identitynumber` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `dateofbirth` date DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `placeofbirth` varchar(255) DEFAULT NULL,
  `gender` enum('Nam','Nữ') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `personal_infos`
--

INSERT INTO `personal_infos` (`id`, `identitynumber`, `name`, `dateofbirth`, `phone`, `email`, `address`, `placeofbirth`, `gender`, `created_at`, `updated_at`) VALUES
(1, '080201001657', 'Lê Minh Triết', NULL, '0946426536', 'minhtrietofficial@gmail.com', 'Số 92, Lê Văn Lương, Tân Phong, Quận 7, Hồ Chí Minh', 'Lâm Đồng', 'Nam', '2025-02-16 06:56:07', '2025-02-16 20:21:36');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `resources`
--

CREATE TABLE `resources` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `appname` varchar(255) NOT NULL,
  `version` varchar(255) DEFAULT NULL,
  `link_truycap` varchar(255) NOT NULL,
  `ten_hanhdong` varchar(255) NOT NULL,
  `trangthai_link` tinyint(1) NOT NULL DEFAULT 1,
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
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('agREVVtoRdd1Omu5RqLksckUSrbus42nr6bFr8aD', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoicmMySzhXUGFzckFuWVlpSFVLa3FwbnBFS0tJaFZraDdvNDhMWllZNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjA6e31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTIkSlhxLi90SjltakV0SFJKYW1MSlFmdUljVDA2L01HdEVIZ3lWUmUuU1d5QXVOVHlVdE1xUkciO3M6ODoiZmlsYW1lbnQiO2E6MDp7fXM6NjoidGFibGVzIjthOjE6e3M6MjI6Ikxpc3RSZXNvdXJjZXNfcGVyX3BhZ2UiO3M6MjoiMTAiO319', 1740219170),
('quSfcwwRy9LbjdmeRUrE7Sb0q1GbNONjdJ2ey0By', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiUzlwNVh4V2Y2WGt0ZEVSdEJON2RPRkh0b0FhSVdTVEFZYVJjcDNrMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjA6e31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTIkSlhxLi90SjltakV0SFJKYW1MSlFmdUljVDA2L01HdEVIZ3lWUmUuU1d5QXVOVHlVdE1xUkciO30=', 1740722947),
('U5JTw3lrxSXkGIdJOB1mu0bNK1WFl5l9WU9rZo3G', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZmQ2RWRBYWRBdDJ1M0FEWG9SaG16TW82TTJGSTZ4dWgxZ3JSc0hTTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1740219129);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `subjects`
--

CREATE TABLE `subjects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
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
(6, 'Lập trình PHP', 5, 2500000, '2025-02-16 06:12:32', '2025-02-16 06:12:32');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(12) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, '080201001657', 'minhtrietofficial@gmail.com', NULL, '$2y$12$JXq./tJ9mjEtHRJamLJQfuIcT06/MGtEHgyVRe.SWyAuNTyUtMqRG', 'dDazwb6djV2mxGID8zhV0goIYwXoIxmIjudR5l0YWq74CE52DtDCi77TPqGb', '2025-02-16 05:29:10', '2025-02-16 05:29:10');

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
-- Chỉ mục cho bảng `coursefees`
--
ALTER TABLE `coursefees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_fees_course_id_foreign` (`course_id`);

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
  ADD UNIQUE KEY `personal_infos_identitynumber_unique` (`identitynumber`);

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
  ADD UNIQUE KEY `identitynumber` (`name`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `coursefees`
--
ALTER TABLE `coursefees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `courses`
--
ALTER TABLE `courses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `personal_infos`
--
ALTER TABLE `personal_infos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `resources`
--
ALTER TABLE `resources`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `coursefees`
--
ALTER TABLE `coursefees`
  ADD CONSTRAINT `course_fees_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `courses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `subjects_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
