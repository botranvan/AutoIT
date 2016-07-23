-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2016 at 05:05 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dblogin`
--

-- --------------------------------------------------------

--
-- Table structure for table `dbcode`
--

CREATE TABLE `dbcode` (
  `code` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL,
  `vaild` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `dbcode`
--

INSERT INTO `dbcode` (`code`, `vaild`) VALUES
('keytest_1', 10),
('keytest_2', 20);

-- --------------------------------------------------------

--
-- Table structure for table `dblogin`
--

CREATE TABLE `dblogin` (
  `acc` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL,
  `pass` text COLLATE utf8_vietnamese_ci NOT NULL,
  `name` text COLLATE utf8_vietnamese_ci NOT NULL,
  `email` text COLLATE utf8_vietnamese_ci NOT NULL,
  `status` text COLLATE utf8_vietnamese_ci NOT NULL,
  `type` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL DEFAULT 'member',
  `id` text COLLATE utf8_vietnamese_ci NOT NULL,
  `vaild` bigint(20) NOT NULL,
  `last_login` bigint(20) NOT NULL,
  `get_trial` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `dblogin`
--

INSERT INTO `dblogin` (`acc`, `pass`, `name`, `email`, `status`, `type`, `id`, `vaild`, `last_login`, `get_trial`) VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3', 'Admin', 'admin@opdo.vn', '', 'admin', '0x42384233374330382D453046412D333934372D384235392D464243463842304533313944', 99999999, 201607092200, ''),
('test_acc1', 'e10adc3949ba59abbe56e057f20f883e', 'Tran Thien Hoa', 'hoa@opdo.vn', '', 'member', '0x42384233374330382D453046412D333934372D384235392D464243463842304533313944', 0, 0, ''),
('test_acc2', 'e10adc3949ba59abbe56e057f20f883e', 'Nguyen Quoc Chien', 'chien@opdo.vn', '', 'member', '0x42384233374330382D453046412D333934372D384235392D464243463842304533313944', 0, 0, ''),
('test_acc3', 'e10adc3949ba59abbe56e057f20f883e', 'Le Thi Hong Tham', 'tham@opdo.vn', '', 'member', '0x42384233374330382D453046412D333934372D384235392D464243463842304533313944', 0, 0, ''),
('test_acc4', 'e10adc3949ba59abbe56e057f20f883e', 'Tran Hoai Thuong', 'thuong@opdo.vn', '', 'member', '0x42384233374330382D453046412D333934372D384235392D464243463842304533313944', 0, 0, '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dbcode`
--
ALTER TABLE `dbcode`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `dblogin`
--
ALTER TABLE `dblogin`
  ADD PRIMARY KEY (`acc`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
