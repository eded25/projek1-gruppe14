-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Erstellungszeit: 26. Sep 2025 um 19:24
-- Server-Version: 8.0.40
-- PHP-Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `thmCUT`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `appointment_slot`
--

CREATE TABLE `appointment_slot` (
  `slot_id` int UNSIGNED NOT NULL,
  `barber_id` int UNSIGNED NOT NULL,
  `date_time` datetime NOT NULL,
  `duration_min` int UNSIGNED NOT NULL DEFAULT '30',
  `is_booked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `appointment_slot`
--

INSERT INTO `appointment_slot` (`slot_id`, `barber_id`, `date_time`, `duration_min`, `is_booked`, `created_at`) VALUES
(14, 2, '2025-09-26 14:00:00', 30, 0, '2025-09-26 11:08:17'),
(15, 2, '2025-09-26 12:00:00', 30, 0, '2025-09-26 11:10:02'),
(16, 1, '2025-09-26 12:00:00', 30, 0, '2025-09-26 11:16:43'),
(19, 1, '2025-09-26 10:00:00', 30, 0, '2025-09-26 11:18:16'),
(20, 1, '2025-09-26 14:00:00', 30, 1, '2025-09-26 11:20:22'),
(21, 2, '2025-09-27 16:00:00', 30, 1, '2025-09-26 11:20:41'),
(22, 3, '2025-09-29 19:00:00', 30, 0, '2025-09-26 11:20:58'),
(23, 1, '2025-09-26 17:00:00', 30, 1, '2025-09-26 11:37:21'),
(24, 1, '2025-09-26 20:00:00', 30, 1, '2025-09-26 16:04:33'),
(25, 1, '2025-09-27 18:00:00', 30, 1, '2025-09-26 16:05:11'),
(26, 1, '2025-09-29 12:00:00', 30, 1, '2025-09-26 16:13:19'),
(27, 1, '2025-09-30 20:00:00', 30, 1, '2025-09-26 16:18:14'),
(28, 3, '2025-09-26 15:00:00', 30, 0, '2025-09-26 17:39:35'),
(29, 3, '2025-09-27 16:00:00', 30, 1, '2025-09-26 17:43:01'),
(30, 1, '2025-09-27 11:00:00', 30, 0, '2025-09-26 18:52:55'),
(31, 1, '2025-09-27 10:00:00', 30, 0, '2025-09-26 19:11:22'),
(32, 1, '2025-09-27 20:00:00', 30, 0, '2025-09-26 19:11:32'),
(33, 1, '2025-09-30 14:00:00', 30, 0, '2025-09-26 19:11:42'),
(34, 1, '2025-09-30 13:00:00', 30, 0, '2025-09-26 19:12:13'),
(35, 1, '2025-09-30 12:00:00', 30, 0, '2025-09-26 19:12:50'),
(36, 3, '2025-09-29 15:00:00', 30, 1, '2025-09-26 19:13:27');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `barber_profile`
--

CREATE TABLE `barber_profile` (
  `barber_id` int UNSIGNED NOT NULL,
  `bio` text,
  `image` varchar(255) DEFAULT NULL,
  `location` varchar(160) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `reservation`
--

CREATE TABLE `reservation` (
  `reservation_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `slot_id` int UNSIGNED NOT NULL,
  `status` enum('pending','approved','rejected','cancelled','completed') NOT NULL DEFAULT 'pending',
  `payment_method` varchar(40) DEFAULT NULL,
  `approved_by` varchar(200) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `reservation`
--

INSERT INTO `reservation` (`reservation_id`, `user_id`, `slot_id`, `status`, `payment_method`, `approved_by`, `created_at`, `updated_at`) VALUES
(21, 2, 19, 'rejected', 'cash', 'Barber1@gmail.com', '2025-09-26 11:18:16', '2025-09-26 11:19:08'),
(22, 18, 20, 'approved', 'cash', 'Barber1@gmail.com', '2025-09-26 11:20:22', '2025-09-26 11:21:30'),
(23, 18, 21, 'approved', 'cash', 'Barber2@gmail.com', '2025-09-26 11:20:41', '2025-09-26 11:21:49'),
(24, 18, 22, 'rejected', 'cash', 'Barber3@gmail.com', '2025-09-26 11:20:58', '2025-09-26 17:44:03'),
(25, 18, 23, 'approved', 'cash', 'Barber1@gmail.com', '2025-09-26 11:37:21', '2025-09-26 11:37:46'),
(26, 18, 24, 'approved', 'cash', 'Barber1@gmail.com', '2025-09-26 16:04:33', '2025-09-26 16:05:34'),
(27, 18, 25, 'approved', 'cash', 'Barber1@gmail.com', '2025-09-26 16:05:11', '2025-09-26 16:05:35'),
(28, 18, 26, 'approved', 'cash', 'Barber1@gmail.com', '2025-09-26 16:13:19', '2025-09-26 16:47:46'),
(29, 18, 27, 'approved', 'cash', 'Barber1@gmail.com', '2025-09-26 16:18:14', '2025-09-26 18:51:56'),
(30, 18, 28, 'rejected', 'cash', 'Barber3@gmail.com', '2025-09-26 17:39:35', '2025-09-26 17:44:02'),
(31, 22, 29, 'approved', 'cash', 'Barber3@gmail.com', '2025-09-26 17:43:01', '2025-09-26 17:44:04'),
(32, 18, 30, 'pending', 'cash', NULL, '2025-09-26 18:52:55', '2025-09-26 18:52:55'),
(33, 18, 30, 'pending', 'cash', NULL, '2025-09-26 18:53:01', '2025-09-26 18:53:01'),
(34, 18, 30, 'pending', 'cash', NULL, '2025-09-26 18:53:06', '2025-09-26 18:53:06'),
(35, 18, 30, 'pending', 'cash', NULL, '2025-09-26 18:57:22', '2025-09-26 18:57:22'),
(36, 18, 31, 'pending', 'cash', NULL, '2025-09-26 19:11:22', '2025-09-26 19:11:22'),
(37, 18, 32, 'pending', 'cash', NULL, '2025-09-26 19:11:32', '2025-09-26 19:11:32'),
(38, 18, 33, 'pending', 'cash', NULL, '2025-09-26 19:11:42', '2025-09-26 19:11:42'),
(39, 18, 33, 'pending', 'cash', NULL, '2025-09-26 19:12:07', '2025-09-26 19:12:07'),
(40, 18, 34, 'pending', 'cash', NULL, '2025-09-26 19:12:13', '2025-09-26 19:12:13'),
(41, 18, 34, 'pending', 'cash', NULL, '2025-09-26 19:12:37', '2025-09-26 19:12:37'),
(42, 18, 35, 'pending', 'cash', NULL, '2025-09-26 19:12:50', '2025-09-26 19:12:50'),
(43, 18, 35, 'pending', 'cash', NULL, '2025-09-26 19:13:10', '2025-09-26 19:13:10'),
(44, 18, 36, 'approved', 'cash', 'Barber3@gmail.com', '2025-09-26 19:13:28', '2025-09-26 19:13:45');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `service_type`
--

CREATE TABLE `service_type` (
  `type_id` int UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `service_type`
--

INSERT INTO `service_type` (`type_id`, `name`, `description`) VALUES
(1, 'Haarschnitt', 'Kurz/Medium/Lang'),
(2, 'Bart', 'Trimmen/Stylen'),
(3, 'Haircut', 'Verschiedene Haarschnitt-Varianten'),
(4, 'Beard', 'Bart-Pflege und Styling'),
(5, 'Combo', 'Kombination aus Haarschnitt und Bart'),
(6, 'Special', 'Spezial-Behandlungen wie Färben');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `id` int UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `role` enum('barber','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'user',
  `name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `phone`, `role`, `name`, `created_at`) VALUES
(1, 'Barber1@gmail.com', '$2y$10$TLgi97X41OwodpkCfXetXuSNHaAcG.SzqYefX5I1CJrPycSFXVKky', '1111111111122', 'barber', 'Barber', '2025-09-26 09:05:11'),
(2, 'Barber2@gmail.com', '$2y$10$VgbsPloKAL3THdmX9Oc/D.C0XTN5RmONxOuCIedcUZ33cRDbR9nVK', '1111111111122', 'barber', 'Barber 2', '2025-09-26 09:06:23'),
(3, 'Barber3@gmail.com', '$2y$10$Qcrj3ARctAqe0rh/b2UN/emt9lo7Tsks9m76zer5jHsiWsM87m4Q.', '111111111112233', 'barber', 'Barber 3', '2025-09-26 09:06:46'),
(17, 'test1758884980551@test.de', '$2y$10$oSg5R.LQNT6XS7VzPlYQhejUl6ap2d23ITqmNfYpClbYskhvT52r6', '123456789', 'user', 'Test User', '2025-09-26 09:09:40'),
(18, 'user1@gmail.com', '$2y$10$mcH84X600cOnAdLqXrBYc.BPmYKIiFa49Rwt.EmYeu01citWmAaqy', '111111111112233', 'user', '', '2025-09-26 09:09:45'),
(19, 'user2@gmail.com', '$2y$10$fQMxG1fluzfI3W9vx6FAS..LyHL5tY386HlfC5O5hklToVdf/zV.y', '11111111111', 'user', '', '2025-09-26 16:49:15'),
(20, 'user4@gmail.com', '$2y$10$RW.jUgF005YlbkS8J8/5Y.V3RrzwQ.viDb44qXlFj921Zeg6bO5g.', '123456', 'user', '', '2025-09-26 14:51:08'),
(21, 'user5@gmail.com', '$2y$10$pT7WlzmS7/B5oX9uYzF94OwCRpsLE876FwZVjgXICk7dAdscskTWm', '123456', 'user', 'Mikey Maus', '2025-09-26 14:59:37'),
(22, 'user6@gmail.com', '$2y$10$v6SiTeke8L.IbAbwGSQojO72VRykMHM6UQV59LqfJgIapxqW8yrni', '1234566', 'user', 'Yohannesblüte', '2025-09-26 15:38:24'),
(23, 'user7@gmail.com', '$2y$10$fHnzv37.auXArtro8PIm3ugxqoMPprXi9YTeEYx0DojsTWjFPym8y', '1234566', 'user', 'Kevin Eleven', '2025-09-26 17:10:34');

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_reservation_counts`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_reservation_counts` (
`today_active` decimal(23,0)
,`today_all` decimal(23,0)
,`week_active` decimal(23,0)
,`week_all` decimal(23,0)
);

-- --------------------------------------------------------

--
-- Struktur des Views `v_reservation_counts`
--
DROP TABLE IF EXISTS `v_reservation_counts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_reservation_counts`  AS SELECT sum((cast(`s`.`date_time` as date) = curdate())) AS `today_all`, sum((yearweek(`s`.`date_time`,1) = yearweek(curdate(),1))) AS `week_all`, sum(((cast(`s`.`date_time` as date) = curdate()) and (`r`.`status` in ('pending','approved')))) AS `today_active`, sum(((yearweek(`s`.`date_time`,1) = yearweek(curdate(),1)) and (`r`.`status` in ('pending','approved')))) AS `week_active` FROM (`reservation` `r` join `appointment_slot` `s` on((`s`.`slot_id` = `r`.`slot_id`))) ;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `appointment_slot`
--
ALTER TABLE `appointment_slot`
  ADD PRIMARY KEY (`slot_id`),
  ADD UNIQUE KEY `uq_barber_start` (`barber_id`,`date_time`),
  ADD KEY `idx_slot_barber` (`barber_id`),
  ADD KEY `idx_slot_datetime` (`date_time`);

--
-- Indizes für die Tabelle `barber_profile`
--
ALTER TABLE `barber_profile`
  ADD PRIMARY KEY (`barber_id`);

--
-- Indizes für die Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `idx_res_user` (`user_id`),
  ADD KEY `idx_res_slot` (`slot_id`),
  ADD KEY `idx_res_status` (`status`);

--
-- Indizes für die Tabelle `service_type`
--
ALTER TABLE `service_type`
  ADD PRIMARY KEY (`type_id`),
  ADD UNIQUE KEY `uq_service_type_name` (`name`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `appointment_slot`
--
ALTER TABLE `appointment_slot`
  MODIFY `slot_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT für Tabelle `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reservation_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT für Tabelle `service_type`
--
ALTER TABLE `service_type`
  MODIFY `type_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `appointment_slot`
--
ALTER TABLE `appointment_slot`
  ADD CONSTRAINT `fk_slot_barber` FOREIGN KEY (`barber_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `barber_profile`
--
ALTER TABLE `barber_profile`
  ADD CONSTRAINT `fk_barber_profile_user` FOREIGN KEY (`barber_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `fk_res_slot` FOREIGN KEY (`slot_id`) REFERENCES `appointment_slot` (`slot_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_res_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
