-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2026 at 08:46 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smartengrave_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(120) NOT NULL,
  `otp_hash` varchar(255) NOT NULL,
  `otp_expires_at` datetime NOT NULL,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `is_used` tinyint(1) NOT NULL DEFAULT 0,
  `reset_token` varchar(64) DEFAULT NULL,
  `reset_token_expires_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `otp_hash`, `otp_expires_at`, `attempts`, `is_used`, `reset_token`, `reset_token_expires_at`, `created_at`) VALUES
(1, 'prudhvivenkata24@gmail.com', '$2b$12$QTSomI0tWxfRqVvrbjqmAumW.GbXMBtgeUhxgpEHBe4dJp4HnY1Ha', '2026-02-23 13:12:01', 0, 1, NULL, NULL, '2026-02-23 13:07:01'),
(2, 'prudhvivenkata24@gmail.com', '$2b$12$sh8G4gKhUwuHLgh4waTOJesUNr929nSYkwEn55CDN6T/HROrbNzJS', '2026-02-23 13:12:30', 0, 1, 'e562832255b65ee1dbfb742c3072216f50f7fb4b91375cb729e38439c38b7e12', '2026-02-23 13:18:02', '2026-02-23 13:07:30'),
(3, 'manojmandalapu4@gmail.com', '$2b$12$PcZuSFCkGcFU5xGSDloINu0cUOUtR0keOOTvPnc8cvScaE3Z3niVK', '2026-02-23 13:50:00', 0, 1, NULL, NULL, '2026-02-23 13:45:00'),
(4, 'manojmandalapu4@gmail.com', '$2b$12$H0aQtWq5WS8qjMTB6jQybufKVxKvp73AQ6lkZqFhTRG7ZWWVzyseu', '2026-02-23 13:50:03', 0, 1, NULL, NULL, '2026-02-23 13:45:03'),
(5, 'manojmandalapu4@gmail.com', '$2b$12$WS3SHEaSc.SgpyZCN9DHROJ6yNzK7Kpx0OeRvD3WwKtlIKxOFAix.', '2026-02-23 13:50:05', 0, 1, NULL, NULL, '2026-02-23 13:45:05'),
(6, 'manojmandalapu4@gmail.com', '$2b$12$6gDObSUQNeyxalLf/0g7IOz49PVFe9uFpckf860w2cTXl5QL8OqQe', '2026-02-23 13:50:05', 0, 1, NULL, NULL, '2026-02-23 13:45:05'),
(7, 'manojmandalapu4@gmail.com', '$2b$12$4JZIo2NpA/wyg54HBh9MheeC4t9.FPv708qEnfDjKesl5dwd4xis2', '2026-02-23 14:06:31', 0, 1, NULL, NULL, '2026-02-23 14:01:31'),
(8, 'manojmandalapu4@gmail.com', '$2b$12$u0eUp.FYT23umgiv8q7OKuFeyeHhLoEZx3/kRJ78eUDhl5LuYIVbG', '2026-02-23 14:06:37', 0, 1, NULL, NULL, '2026-02-23 14:01:37'),
(9, 'manojmandalapu4@gmail.com', '$2b$12$xp9MAcx0PbhCEbAmtaHmSur1KMqcHtU2BcIOo6DRq/gse8plb3Vga', '2026-02-23 14:06:40', 0, 1, NULL, NULL, '2026-02-23 14:01:40'),
(10, 'manojmandalapu4@gmail.com', '$2b$12$tt2IMypSux5QTCUmmLyXVeqFP1E63I8uMwBnoDyFt9LmGVQRvrVOC', '2026-02-23 14:06:40', 0, 1, NULL, NULL, '2026-02-23 14:01:40'),
(11, 'manojmandalapu4@gmail.com', '$2b$12$bywuvwAdwTMWGcyjuTA1wuoiA92RZL49RZET9FHkWWalcsnzF0/46', '2026-02-23 14:06:41', 0, 1, NULL, NULL, '2026-02-23 14:01:41'),
(12, 'manojmandalapu4@gmail.com', '$2b$12$ePRFA2Oj9b/zMPvziTy1behDqeLe9cAYpBipL3oz9RfH2jUZSz61e', '2026-02-23 14:06:54', 0, 1, NULL, NULL, '2026-02-23 14:01:54'),
(13, 'prudhvivenkata24@gmail.com', '$2b$12$0PQdmkf7J7l5wXO/4GmWy.q..GAnNwWbHfqrj/70d7eb96rdhNXse', '2026-02-23 14:07:13', 0, 1, NULL, NULL, '2026-02-23 14:02:13'),
(14, 'prudhvivenkata24@gmail.com', '$2b$12$j962tH2OmDfos9chK2hndux1HQtY/T0N.PpkWoBIcwQsZYV3NdbLq', '2026-02-23 14:07:45', 0, 1, NULL, NULL, '2026-02-23 14:02:45'),
(15, 'prudhvivenkata24@gmail.com', '$2b$12$muluFUiMLz1mQe7qZv.ylOybVcf.eP15jAZShtb542MBdqdegbwrK', '2026-02-23 14:09:59', 0, 0, NULL, NULL, '2026-02-23 14:04:59'),
(16, 'manojmandalapu4@gmail.com', '$2b$12$iFN6Uc4bEvohGs48g1rqsOaM.M5kWZL8o8sYX5inlvPMl1N.JbSJa', '2026-02-23 14:10:13', 0, 1, NULL, NULL, '2026-02-23 14:05:13'),
(17, 'manojmandalapu4@gmail.com', '$2b$12$706rjIDYnaecIRILWBEpQOtl5ddQ2cXffXC/bnhAE6g1epMkebHs6', '2026-02-23 14:10:25', 0, 1, NULL, NULL, '2026-02-23 14:05:25'),
(18, 'manojmandalapu4@gmail.com', '$2b$12$1WfC99a6dl8r6VJDtChQeu/iVDTOLCIY8eKooMFjdm2.5dnp9.BsK', '2026-02-23 14:10:39', 0, 1, NULL, NULL, '2026-02-23 14:05:39'),
(19, 'manojmandalapu4@gmail.com', '$2b$12$DcAlrHznXmGfNLoy3dGXhu50/lmXRk2hY447IQq5EzooGnyN8BRPS', '2026-02-23 14:10:41', 0, 1, NULL, NULL, '2026-02-23 14:05:41'),
(20, 'manojmandalapu4@gmail.com', '$2b$12$H2NbwLKgcHZ2A7rmS2MthOhXBgSJhFnO8b/WBxWrwMNgM7Br3cr8e', '2026-02-23 14:10:42', 0, 1, NULL, NULL, '2026-02-23 14:05:42'),
(21, 'manojmandalapu4@gmail.com', '$2b$12$zsJSjcgD5p7XUhniLQItEe5PtfqbuhkTe4mxdGS0AmjiYvUIdbsCC', '2026-02-23 14:10:42', 0, 1, NULL, NULL, '2026-02-23 14:05:42'),
(22, 'manojmandalapu4@gmail.com', '$2b$12$kmoglD8NWsE8PbYy7beNO.8WtFn14PoRqhluFG4Pt11KATlWMcWMK', '2026-02-23 14:13:25', 0, 1, '855034dc59da8fc3341b271ad4abb548dcd7ecac31fa923e119a89f80c82e482', '2026-02-23 14:19:09', '2026-02-23 14:08:25'),
(23, 'manojmandalapu4@gmail.com', '$2b$12$B1rZTQmL133ANNaln5TLf.zzu73PTpSIzFQWNJuvZ.jka5tLaGcpq', '2026-02-23 15:27:31', 0, 1, NULL, NULL, '2026-02-23 15:22:31'),
(24, 'manojmandalapu4@gmail.com', '$2b$12$A..oeOlPcZaebpnLyt/QQ.4lFbsqlMjRTcfADs4sf0mbSwNOetw6u', '2026-02-23 15:27:59', 0, 1, NULL, NULL, '2026-02-23 15:22:59'),
(25, 'manojmandalapu4@gmail.com', '$2b$12$.nxLkvDXlScSnIrg.KQCo.lnDNiZ5vJhoD8PZ5LpKUkUHgLu3cT4m', '2026-02-23 15:29:09', 0, 1, NULL, NULL, '2026-02-23 15:24:09'),
(26, 'manojmandalapu4@gmail.com', '$2b$12$TcJPl91Jvy5zx8ZD9jiLoe.mYAVJIAX53ZmbQj1zdCtI8G2PelkLu', '2026-02-23 15:29:35', 0, 1, NULL, NULL, '2026-02-23 15:24:35'),
(27, 'manojmandalapu4@gmail.com', '$2b$12$nFF.k6/NqKN3XdXqkiDEDu2xvgVSc8QL020V8AmL4EppDAbHOpMty', '2026-02-23 15:29:35', 0, 1, NULL, NULL, '2026-02-23 15:24:35'),
(28, 'manojmandalapu4@gmail.com', '$2b$12$l1ToYDxH5fBOKVQqAteTKO/kmersLmJRkFlLTYDMLIttZUYBMIJbK', '2026-02-23 15:29:35', 0, 1, NULL, NULL, '2026-02-23 15:24:35'),
(29, 'manojmandalapu4@gmail.com', '$2b$12$5JdlSOODZBKL27IlYCyQ/ecHINinni/1pZJWj2cMqCzGt9M7ddyze', '2026-02-23 15:29:36', 0, 1, NULL, NULL, '2026-02-23 15:24:36'),
(30, 'manojmandalapu4@gmail.com', '$2b$12$G6Nb9ZZRI1XW5NqWW2ZfM.Xm83hfayHmGh91fnV3O.YAUgJ9qxApG', '2026-02-23 15:29:36', 0, 1, NULL, NULL, '2026-02-23 15:24:36'),
(31, 'manojmandalapu4@gmail.com', '$2b$12$KcYVU6rqjoVQjupNsA1kF.gFD6yIQqligyj6lOB.Cum/glkR6xx3i', '2026-02-23 15:29:58', 0, 1, NULL, NULL, '2026-02-23 15:24:58'),
(32, 'manojmandalapu4@gmail.com', '$2b$12$V1c.4gXMiYCG4SSAeypiF.FrOcjFBArLsUtCMAbkgkrBNSP1R0X7O', '2026-02-24 08:52:02', 0, 1, NULL, NULL, '2026-02-24 08:47:02'),
(33, 'manojmandalapu4@gmail.com', '$2b$12$X/.XqnkoDj3E9mSX4DHx4OnV8lzz8pz/vnjxvoZ1UXKBsjRDAvkM2', '2026-02-24 08:53:18', 0, 1, '95abd3abb233146a377400fd7d01842cec908b10051e34beed7ad3146b5c0c5f', '2026-02-24 08:58:52', '2026-02-24 08:48:18'),
(34, 'manojmandalapu4@gmail.com', '$2b$12$0kdDWWu4q1VuYx5yAdu5Pe2YRT6boxiBW3O3grsaacV4nNLgeedHW', '2026-02-24 11:02:34', 0, 1, NULL, NULL, '2026-02-24 10:57:34'),
(35, 'manojmandalapu4@gmail.com', '$2b$12$rSv6uO.vMllvwwIPWahYfO/sPsHfQn8IkWcaUBU.KbgthZ9vimgay', '2026-02-24 11:02:37', 0, 1, NULL, NULL, '2026-02-24 10:57:37'),
(36, 'manojmandalapu4@gmail.com', '$2b$12$pTYVYq/415.mgvMwH5xe7u7lTOwwQDQwMOHGnxmCYtm1qmydscIXy', '2026-02-24 11:03:04', 0, 1, NULL, NULL, '2026-02-24 10:58:04'),
(37, 'manojmandalapu4@gmail.com', '$2b$12$EUwgMZXGaXZ8O8ZakGZPCunoWU4cc0E6rT2hp8DHFJNYBggl0kO7a', '2026-02-25 08:27:31', 0, 1, NULL, NULL, '2026-02-25 08:22:31'),
(38, 'manojmandalapu4@gmail.com', '$2b$12$PQ5f9baBXLOhcqR5QTsc5O3rXv/8CwxbTgqPrOhmHJubONwZ/92P.', '2026-02-25 08:28:28', 0, 1, NULL, NULL, '2026-02-25 08:23:28'),
(39, 'manojmandalapu4@gmail.com', '$2b$12$P6orVo1lbCSgYJegAHwz/Of/THS/AK2sqBkWaLjL7iarot/WUlpDa', '2026-02-25 08:28:41', 0, 1, NULL, NULL, '2026-02-25 08:23:41'),
(40, 'manojmandalapu4@gmail.com', '$2b$12$KjLwxqckdlKX2A56TsoUg.S/5J4ujfBtjVqOAMCLZtPMMXCHIy2Eu', '2026-02-25 08:28:42', 0, 1, NULL, NULL, '2026-02-25 08:23:42'),
(41, 'manojmandalapu4@gmail.com', '$2b$12$kSsgTUQL6Uys3Kg1YCOww.Hhwk4OKMbZyHqCqTvCkig9zv.eLcRX.', '2026-02-25 08:28:42', 0, 1, NULL, NULL, '2026-02-25 08:23:42'),
(42, 'manojmandalapu4@gmail.com', '$2b$12$yJxg7eh2RFzDKfxlbCUfVu8LFVIubmjMj8plRVymWvkNKuK8znRmG', '2026-02-25 08:28:42', 0, 1, NULL, NULL, '2026-02-25 08:23:42'),
(43, 'manojmandalapu4@gmail.com', '$2b$12$P5RL82IJIs9uzgBf.TzXgOvXiN1RlXV9qpdHKIVmHp9cTrjNcyV3y', '2026-02-25 08:28:42', 0, 1, NULL, NULL, '2026-02-25 08:23:42'),
(44, 'manojmandalapu4@gmail.com', '$2b$12$viHcZFhpM9k2DJGKJnMEoemyP/IM/ff1ImqB/guURYoiBu/HWaxE.', '2026-02-25 08:28:49', 0, 1, NULL, NULL, '2026-02-25 08:23:49'),
(45, 'manojmandalapu4@gmail.com', '$2b$12$VY2XYR3.UYepc3WZkU5SeeWHvx1Zu.fYGXX6d.BX4qw7IbxNfhqv2', '2026-02-25 08:29:03', 0, 1, NULL, NULL, '2026-02-25 08:24:03'),
(46, 'manojmandalapu4@gmail.com', '$2b$12$VSx36Y5ZSA/i8sR6d2bLZOhVYJf8xFNtsiUA29wWVYgdA55XEWbBC', '2026-02-25 08:29:03', 0, 1, NULL, NULL, '2026-02-25 08:24:03'),
(47, 'manojmandalapu4@gmail.com', '$2b$12$rKRIAEcswfj5LnFqU2VIXu5HWughZ1iUTj2gokUqpN0qO6yF0RpeS', '2026-02-25 08:29:03', 0, 1, NULL, NULL, '2026-02-25 08:24:03'),
(48, 'manojmandalapu4@gmail.com', '$2b$12$g9LQCvtIUg0Xxxj.m/VTd.Knjb4RhEqyZljFL3xc8JFEbL5WEoHkW', '2026-02-25 08:29:03', 0, 1, NULL, NULL, '2026-02-25 08:24:03'),
(49, 'manojmandalapu4@gmail.com', '$2b$12$BYeuMniDgAywnelofIHOK.BNdHQvC76Ogzj2WgkxNBJYy0bLY8Ykm', '2026-02-25 08:29:04', 0, 1, NULL, NULL, '2026-02-25 08:24:04'),
(50, 'manojmandalapu4@gmail.com', '$2b$12$R9Jpy1ID8j9e/9dV04jPuuJ7A3BKltMvXuzZH/mIBXMtxUb.In9b.', '2026-02-25 08:29:11', 0, 1, NULL, NULL, '2026-02-25 08:24:11'),
(51, 'manojmandalapu4@gmail.com', '$2b$12$LLugzYWcsvYIn9zUiYRrseOP5MtxIZXapZATHVDEp0tKDMGlXF8vO', '2026-02-25 08:29:24', 0, 1, NULL, NULL, '2026-02-25 08:24:24'),
(52, 'manojmandalapu4@gmail.com', '$2b$12$7qrCbB3pxfAjgGws72Yms.ID7ygrpmBVikOLsPBwCWq45ybot1Nii', '2026-02-25 08:29:25', 0, 1, NULL, NULL, '2026-02-25 08:24:25'),
(53, 'manojmandalapu4@gmail.com', '$2b$12$PdJmTPc0BrTIsKTu30rFW.pFL3AmBLrM2b/GBWbzfGeNw3jRKmUHC', '2026-02-25 08:29:25', 0, 1, NULL, NULL, '2026-02-25 08:24:25'),
(54, 'manojmandalapu4@gmail.com', '$2b$12$LsrmEMlV/wQN6o8YzY6WQuzLSR7Hn1g3Ur8zxMktIIOJLsmZQgJsu', '2026-02-25 08:29:25', 0, 1, NULL, NULL, '2026-02-25 08:24:25'),
(55, 'manojmandalapu4@gmail.com', '$2b$12$dweWHk29SNdjEMz.DJC4qOVy83J9XroX8f6yIRA3zczf2Ipw4scB2', '2026-02-25 08:29:39', 0, 1, NULL, NULL, '2026-02-25 08:24:39'),
(56, 'manojmandalapu4@gmail.com', '$2b$12$lgplXZNWv/eieHb6cMBRTeW5fSX/wUmpMag9vAMl16v2qb0ygUueK', '2026-02-25 08:42:06', 0, 1, NULL, NULL, '2026-02-25 08:37:06'),
(57, 'manojmandalapu4@gmail.com', '$2b$12$RUpierZHgOEQFSAm2IE5peXo6r/YutcVHbkDU1fpVvyQtvcMWqXJC', '2026-02-25 08:43:02', 0, 1, NULL, NULL, '2026-02-25 08:38:02'),
(58, 'manojmandalapu4@gmail.com', '$2b$12$objIzr5A6ojwNJUnYTHXkeLAOqxzeYpfmmsr.1RPT7hHa8b1P0Any', '2026-02-25 08:43:04', 0, 1, NULL, NULL, '2026-02-25 08:38:04'),
(59, 'manojmandalapu4@gmail.com', '$2b$12$uX7hddX8uwX6vG1HqsnUXO0JXXRrUWlWgVRTk8dL/3AhdlhfbuGcW', '2026-02-25 08:45:26', 0, 1, NULL, NULL, '2026-02-25 08:40:26'),
(60, 'manojmandalapu4@gmail.com', '$2b$12$vjwMyvmV3s2RBr.LNEZWDeh/cf3zdj26..2n4hA5z7FVIPyzgQwyu', '2026-02-25 08:45:53', 1, 1, 'e25e1550d66655c4eef6395c579b251381700371831817f45633528c921120d2', '2026-02-25 08:51:45', '2026-02-25 08:40:53'),
(61, 'manojmandalapu4@gmail.com', '$2b$12$7ra/28oyXNY6Jxl/3WfyZep4YzQTRIEIdwDFoJznMiT2gT3APoOSS', '2026-02-25 09:44:30', 0, 1, NULL, NULL, '2026-02-25 09:39:30'),
(62, 'manojmandalapu4@gmail.com', '$2b$12$RGtYRBKNvfhhgsEt4.GuouG84Ks9.ldQA5y9QOQjmH6PPeFDL4/tW', '2026-02-25 09:45:51', 0, 1, 'c26494e08196bbb891f9e4c1847a70afe2cd72b5b7f01891ce8165ec70e86968', '2026-02-25 09:51:27', '2026-02-25 09:40:51'),
(63, 'manojmandalapu92@gmail.com', '$2b$12$45nqHo1T1qnNFG7MkNR7iOMMODIpJYeYiZqyYVletcd6G1lvlzxE2', '2026-02-26 14:17:02', 0, 1, NULL, NULL, '2026-02-26 14:12:02'),
(64, 'manojmandalapu92@gmail.com', '$2b$12$i7Grvkg6a2T05Xu1fU4uhebQjCXkhAaB85hqc8IdEX05wdc7OBhNq', '2026-02-26 14:17:35', 0, 1, NULL, NULL, '2026-02-26 14:12:35'),
(65, 'manojmandalapu92@gmail.com', '$2b$12$skPHp7tnWYS69FFz42GB/OpPkUhjInNJWk1uslofHNoQiZ8XBzutC', '2026-02-26 14:17:45', 0, 1, NULL, NULL, '2026-02-26 14:12:45'),
(66, 'manojmandalapu92@gmail.com', '$2b$12$Gdaow4MckrRqWSX7Icrixuho0mz5PlcS1OJMwnuFuW.wUIUZUtIxe', '2026-02-26 14:18:06', 0, 1, NULL, NULL, '2026-02-26 14:13:06'),
(67, 'manojmandalapu92@gmail.com', '$2b$12$x4f8E/6UfU6p4mnwgMI/9uDKfOb4vNprXqtgF5yfpOPg2QBW67r8a', '2026-02-26 14:18:06', 0, 1, NULL, NULL, '2026-02-26 14:13:06'),
(68, 'manojmandalapu92@gmail.com', '$2b$12$.Lxnsvi3xlQFz7T53NoaueuC5gA4/Eg5LqqOHVAx8rxdTCC30vk1.', '2026-02-26 14:18:06', 0, 1, NULL, NULL, '2026-02-26 14:13:06'),
(69, 'manojmandalapu92@gmail.com', '$2b$12$EQt3mZeRkLFDSqVgqqAUve.WalgLXVl2xBVwdtGXZlbNmzUp/riqe', '2026-02-26 14:18:06', 0, 1, NULL, NULL, '2026-02-26 14:13:06'),
(70, 'manojmandalapu92@gmail.com', '$2b$12$9Hv8RXDLKBRqJfcQQWQt1usODX1LRBpkpfJLfM1VY7SJrWZSIDAyC', '2026-02-26 14:18:08', 0, 1, NULL, NULL, '2026-02-26 14:13:08'),
(71, 'manojmandalapu92@gmail.com', '$2b$12$7E.9ahr/8iakuD6kLPJT1eO64uuhDUyfh2L23VnlFUGA.D8wjyekS', '2026-02-26 14:18:28', 0, 1, NULL, NULL, '2026-02-26 14:13:28'),
(72, 'manojmandalapu92@gmail.com', '$2b$12$VtshVsK2uOBwK/YIPE919eQAf0pkwUPQug.le4mLLjPhE25dtb4Ga', '2026-02-26 14:18:28', 0, 1, NULL, NULL, '2026-02-26 14:13:28'),
(73, 'manojmandalapu92@gmail.com', '$2b$12$pMo6axtb3GpzOovnoQro5OoVnmvTyxG/TvDYCGnaGlTilMDmuLVGy', '2026-02-26 14:18:28', 0, 1, NULL, NULL, '2026-02-26 14:13:28'),
(74, 'manojmandalapu92@gmail.com', '$2b$12$tZ.SaNoqLJHyUXsUn3mRd.oVulC/TyDyGcC9mvl7LuyE0pNu2WR/2', '2026-02-26 14:18:28', 0, 1, NULL, NULL, '2026-02-26 14:13:28'),
(75, 'manojmandalapu92@gmail.com', '$2b$12$.tJg2k/uB6p7i5dBvvaI2OXQG1laVFUT25fNzkJKnSArh95PdzZla', '2026-02-26 14:18:30', 0, 1, NULL, NULL, '2026-02-26 14:13:30'),
(76, 'manojmandalapu92@gmail.com', '$2b$12$DHlkA.FheV2P5AGZQ424RepVfIR9K1PNM76Wjw5zxHdLH901921Pi', '2026-02-26 14:18:50', 0, 1, NULL, NULL, '2026-02-26 14:13:50'),
(77, 'manojmandalapu92@gmail.com', '$2b$12$onPWOzZxgVxk3gD/LfU3T.nTLGbkAxl9LgCZupFmBwPDbaJ3bjbCq', '2026-02-26 14:18:50', 0, 1, NULL, NULL, '2026-02-26 14:13:50'),
(78, 'manojmandalapu92@gmail.com', '$2b$12$oBPMbAzvY4cgAL6qbrK1sOQse7fd2uaf7uDOlCuLTvDcPMVK2kdDm', '2026-02-26 14:18:50', 0, 1, NULL, NULL, '2026-02-26 14:13:50'),
(79, 'manojmandalapu92@gmail.com', '$2b$12$Pad3sfhk1HSNNVAkttoB9OAjfWJ.x92TcgJ0M2pKPfqrkKxvx6PI6', '2026-02-26 14:19:38', 0, 1, NULL, NULL, '2026-02-26 14:14:38'),
(80, 'manojmandalapu92@gmail.com', '$2b$12$laofHFNGwwsKK6VzNboYrOOMV9HSEcW.UulqCvS9cmJ9P7pBCwr0K', '2026-02-26 14:35:38', 0, 1, NULL, NULL, '2026-02-26 14:30:38'),
(81, 'manojmandalapu92@gmail.com', '$2b$12$5cj62mN3AtwObqszPFQwROQRx8CV4UUv1WYK5f3q1D15oUy.QzTTC', '2026-02-26 14:36:28', 0, 1, '73be09e1c22b2ba6998f84d6c93660d640ab7a4e1d5c9f363381a929521f777a', '2026-02-26 14:42:03', '2026-02-26 14:31:28'),
(82, 'manojmandalapu4@gmail.com', '$2b$12$thzZzfiYCpOk3ZS/9DHu4e4hvw3lT9smNzuJ6Dhx7/VmFNuKHrRvC', '2026-03-02 12:36:31', 0, 1, NULL, NULL, '2026-03-02 12:31:31'),
(83, 'manojmandalapu92@gmail.com', '$2b$12$5gBzTAKLCCv4Qtf5pS1q7uAc.Vw5OlYIOzvWGTym8ORIyUkWbq1li', '2026-03-05 04:05:53', 0, 1, NULL, NULL, '2026-03-05 09:30:53'),
(84, 'manojmandalapu92@gmail.com', '$2b$12$4LKZTDm9/51COGEfQRGy4e/yy4qUWsV5UZ9zw5OA/RCK32PLlTWRy', '2026-03-05 04:05:54', 0, 1, NULL, NULL, '2026-03-05 09:30:54'),
(85, 'manojmandalapu92@gmail.com', '$2b$12$NEO0D1YpnvPTt/.zreX5Eu3FDzVDF6v2J1prAMOlfEZnDG/1PmPa2', '2026-03-05 04:05:57', 0, 1, NULL, NULL, '2026-03-05 09:30:57'),
(86, 'manojmandalapu92@gmail.com', '$2b$12$rfWsH.8pvRpf5YKdrUlfmOl1eewd6aeNTpcxusFP2CQ5z6KYlpavW', '2026-03-05 04:06:01', 0, 1, NULL, NULL, '2026-03-05 09:31:01'),
(87, 'manojmandalapu92@gmail.com', '$2b$12$5ITyM3WGuMMl06lHAr00buZ4zj.L4RpLHmZlN3E4xOA8diqtf4mzG', '2026-03-05 04:06:12', 0, 1, NULL, NULL, '2026-03-05 09:31:12'),
(88, 'manojmandalapu92@gmail.com', '$2b$12$NQoLIrhIXmJ9Y1bI21..tuQCgG87agf3pQZuCUc3PhxuqW1WT7ZHK', '2026-03-05 04:06:55', 0, 1, NULL, NULL, '2026-03-05 09:31:55'),
(89, 'manojmandalapu92@gmail.com', '$2b$12$5CFVmJpvo7aTYK.AgUqK3elPifpZinZ/M3GZ/gUMiTPKJKIRuDcLq', '2026-03-05 04:07:06', 0, 1, NULL, NULL, '2026-03-05 09:32:06'),
(90, 'manojmandalapu4@gmail.com', '$2b$12$.1R3MCWatxZDW.Zhnq1dt.5L1y8ImGJd1GY.EWzyWNXHpOE8mxToa', '2026-03-05 04:13:05', 0, 1, NULL, NULL, '2026-03-05 09:38:05'),
(91, 'manojmandalapu92@gmail.com', '$2b$12$K50b77mz0/RtCwlsPY9xHu4AEZ8LA95zbvKEbx69aXdx/LGsiz4ne', '2026-03-05 09:56:49', 0, 1, NULL, NULL, '2026-03-05 09:51:49'),
(92, 'manojmandalapu92@gmail.com', '$2b$12$0oFLtWa7ZLUeIQZ8Ap1cHOPs8F1g6etd0fCQXG1cx.SdD8haXxUny', '2026-03-05 09:57:42', 0, 1, NULL, NULL, '2026-03-05 09:52:42'),
(93, 'manojmandalapu92@gmail.com', '$2b$12$GuCz43/s6kysfg3dXApESeX1bGyy/l7MsFG9IeV0FE0l6SCikUANy', '2026-03-05 10:04:38', 0, 1, NULL, NULL, '2026-03-05 09:59:38'),
(94, 'manojmandalapu92@gmail.com', '$2b$12$XcjuwOOq7bP0YCya0apkZunvIAXBFCGW5JFgkryAiDRV5hFsIXJIa', '2026-03-05 10:06:13', 0, 1, NULL, NULL, '2026-03-05 10:01:13'),
(95, 'manojmandalapu92@gmail.com', '$2b$12$SmBiJkJwVojy/fdpirU76u7K2eDe6xF9YSV2rr/IHoJmNc6l/CT1i', '2026-03-05 10:06:41', 0, 1, NULL, NULL, '2026-03-05 10:01:41'),
(96, 'manojmandalapu92@gmail.com', '$2b$12$Yxrjwz9t.TVeS2ET3kKtAOQjb1jTeAqv/mTcb8b3HTRg4kTWq7cVC', '2026-03-05 10:08:12', 0, 1, NULL, NULL, '2026-03-05 10:03:12'),
(97, 'manojmandalapu4@gmail.com', '$2b$12$MLmv9J1/RMm44FqeCYQyn.yVIUvw0jsd8lC7NkrfeAc6mW6NSqbuS', '2026-03-05 11:01:52', 0, 1, NULL, NULL, '2026-03-05 10:56:52'),
(98, 'manojmandalapu4@gmail.com', '$2b$12$CKEJx.u/MkBrbqPhF8Ju9eZJPQ.Ujk5d.IgJ6SggshHUdBhTjqr2K', '2026-03-05 11:02:08', 0, 1, NULL, NULL, '2026-03-05 10:57:08'),
(99, 'manojmandalapu4@gmail.com', '$2b$12$bzZxm.iD3ZJlqPmcA6azEuJ2biM4h1qPc.tJG/jr6Teoe5vtGYCH2', '2026-03-05 11:06:02', 0, 1, NULL, NULL, '2026-03-05 11:01:02'),
(100, 'manojmandalapu4@gmail.com', '$2b$12$osH74HoV8jhL4D9MsHGKOOTWYDMkpDroPKZY91GJtHXc8cWuVv/MS', '2026-03-05 11:06:41', 0, 1, NULL, NULL, '2026-03-05 11:01:41'),
(101, 'manojmandalapu4@gmail.com', '$2b$12$21OX6qnbKwwsyTyw1PYzpOmAn0GQYefT7dBf9REpu2haZ01R20o6O', '2026-03-05 11:06:55', 0, 1, NULL, NULL, '2026-03-05 11:01:55'),
(102, 'manojmandalapu4@gmail.com', '$2b$12$vKzpwwiYDCBEgbYjyPi9eeNsC9nZltcWurE2gWm7NV9rV4CY.AcTa', '2026-03-05 12:12:41', 0, 1, NULL, NULL, '2026-03-05 12:07:41'),
(103, 'manojmandalapu4@gmail.com', '$2b$12$lzZ9RDUteqxMAGY73gBR7.dyQhPSGbx5iwaOSs80kTOdQZn8ut8N2', '2026-03-05 12:13:16', 0, 1, NULL, NULL, '2026-03-05 12:08:16'),
(104, 'manojmandalapu4@gmail.com', '$2b$12$ydmZPkiSSsXnw.PZOeKR/.3uAKKCfedNrEWiRwR0p.K5nb4B/EAzi', '2026-03-05 12:13:18', 0, 1, NULL, NULL, '2026-03-05 12:08:18'),
(105, 'manojmandalapu4@gmail.com', '$2b$12$.4N9wgfL/UKKQwgzyfcyCewUALQW0Znuikm3O5bBXWkIiHUUQrpEO', '2026-03-05 12:13:27', 0, 1, NULL, NULL, '2026-03-05 12:08:27'),
(106, 'manoj@gmail.com', '$2b$12$2FtdqCgwkPUubTEFyXw1.uQPu7Rl.hm7HLfBRG04rs5jO4m7Xs2re', '2026-03-05 07:11:46', 0, 0, NULL, NULL, '2026-03-05 07:06:46'),
(107, 'manojmandalapu92@gmail.com', '$2b$12$86zv4iV4Re/IIvKmVVVKzeuWDx2Hty7tOoXytNHCUpdpccHe2lQhu', '2026-03-05 07:24:39', 0, 1, '6c127996fef1bf8a910d65d9394a6c60eb4e93b54e7ed507ab4b5527b1de745c', '2026-03-05 07:30:23', '2026-03-05 07:19:39'),
(108, 'manojmandalapu92@gmail.com', '$2b$12$6msTnMPlkDHYaW2GSUJoxOHCqDhpmgx5x/Ly/duh7tydpAcIToqLG', '2026-03-06 07:12:34', 0, 1, NULL, NULL, '2026-03-06 07:07:34'),
(109, 'manojmandalapu92@gmail.com', '$2b$12$3oUv/xJxw5fn/XSBh2KVJOYp6Ys2bRXK9ttH0z34uPOHIqI.rLEE.', '2026-03-06 07:13:41', 0, 0, '257e83f40dd479319301c99d9db03e54f73b881c8e72a8753e218a38ab1ad987', '2026-03-06 07:19:01', '2026-03-06 07:08:41'),
(110, 'manojmandalapu4@gmail.com', '$2b$12$AbLmmxCv36nhxi.uxNGvtukEdyAkj/bszV37MAsQ5KfU.b0pse/6O', '2026-03-16 05:14:33', 0, 1, 'f03e1b94476e964798925dfda2349ffd0d60feecdc15739bf38d9b9f44e12ea7', '2026-03-16 05:19:51', '2026-03-16 05:09:33');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password_hash`, `created_at`) VALUES
(1, 'Manoj Mandalapu', 'manojmandalapu4@gmail.com', '$2b$12$zwL.LipS9Lhilqj1MMkmzejSROAZKNA0jQgvQoJ2G/me5mn7.lw9i', '2026-02-19 09:14:52'),
(2, 'B.Prudhvi', 'prudhvivenkata24@gmail.com', '$2b$12$wTKukeBe2h5SYI5viR8x9.iopN3GS.Rih7CC5v0eV55OoSCcHbRb2', '2026-02-23 13:06:35'),
(3, 'B.prudhvi', 'prudhvi24@gmail.com', '$2b$12$djAY7FxcVv4U3NrIvxk59eixclLLlJrP9rkdqcm6I/dFWXQfW9I4e', '2026-02-23 14:16:20'),
(4, 'Manoj', 'manojmandalapu92@gmail.com', '$2b$12$laK8j6j.ijavNF.DyxTpduTwa83zfd5.Fxb/YV/Qxu7oOGRmr4V1u', '2026-02-23 15:25:03'),
(5, 'Manoj', 'manojmandalapu6@gmail.com', '$2b$12$ieIo.DDty/QiEaPgEe3MUOXS2xThV4r5YQy.0FW5YDxptmLVobTXS', '2026-03-05 09:52:37'),
(6, 'Manoj Mandalapu', 'manoj@gmail.com', '$2b$12$R8PG0b4ceQjcrXyEgddCsOdOGEuEEIj0JYaKE9dPrGtbgMsau.XV2', '2026-03-05 07:05:09'),
(7, 'Manoj', 'manoj1@gmail.com', '$2b$12$z2HVru0wk6Mni8jan4TTY.2bSXxGMzzNAnqGUbg3GNBuehKLKtBpS', '2026-03-17 04:53:00'),
(8, 'test', 'test_123@business.co.in', '$2b$12$wiTcszE3ge4/q.1pkAmfI.YPXelE5Ok6Snx58P17kARSuYQ3AbbKu', '2026-03-23 04:36:59'),
(9, '54456', 't@test.com', '$2b$12$VNQvQoeA9uqvk7dU2kkUnu3AE6QdF5VU0TgcvROfCTw5YJohvFYfu', '2026-03-23 07:56:47'),
(10, '123456', 'manojmandalapu@gmail.com', '$2b$12$NBHJZCn2hQnoCzqDgFZR.uK6pdj/G13wGl1g.9b7gHQ5K.fkMo60K', '2026-03-23 13:02:00'),
(11, '12345', 'manoj2@gmail.com', '$2b$12$hwPUZCxvI3tE8Eiq60pDLuIrTDaKy8gsg/UNpt0wJ2hap428NPW1y', '2026-03-23 13:05:14'),
(12, '1234', 'manoj6@gmail.com', '$2b$12$TgzraG2J.w6Kh55HMKYDv.qaktM9RaK4TKeGePdGr.n84kxkFcVGm', '2026-03-23 13:07:19'),
(13, '1233', 'manoj32@gmail.com', '$2b$12$yBFCBtjNoyeYMTXzy6/yJeUuxiTsbgeEas7e8iiGN11BeYvDkdIai', '2026-03-23 13:11:09');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
