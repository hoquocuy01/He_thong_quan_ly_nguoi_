-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2026 at 01:10 PM
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
-- Database: `web_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'user',
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `status`) VALUES
(1, 'uy', 'scrypt:32768:8:1$CWrLYJ73FTrpcli8$fbe69491762aeb0ae9c4a54fdde2033a6819e8b02ac993cee5cd23277337cddd454243f1f55462aba6f29b78d41ff8b959bfaea99fe90a73c6c91006f44223af', 'user', 1),
(3, 'Uy_ShaDow', 'scrypt:32768:8:1$5do5RnWuJwwYWKyt$86d1ecb6807eee1d8242dde40c072a0a3673e9715f7d2916f84fcea9f94997582144f90cec6e4b25d3432e33c22ba46a26d27e74ee3eb1b84b298a1bc4daa894', 'user', 1),
(4, 'Uy_ShaDow1', 'scrypt:32768:8:1$hJpYkOJbL25c7f09$520a1e52f518575d264f6ef959b7a366f0b818e9187206c60c4c009c3fc521f591ba09e415b5f1fd3360f75f632e31dfa728ca5aff2b66c0ddec8d8818b558d1', 'user', 1),
(6, 'Uy_ShaDow2', 'scrypt:32768:8:1$yCpvy2TerbGOyJ27$f0d01dd34835cfa9b47cfbe0e54307253d44be11e92cae0fee0678ca86ec13a13b440e3d769138bfee8744421423034547d9ca7aacb3505bb7145856d2eb3522', 'user', 1),
(11, 'admin', 'scrypt:32768:8:1$WR6bqDaCE1rYSbug$ded1a95b731d0ffedd72c055e621ecd923055ef32ba2c51e5721e7d72619bb678a147e59e37c535e76d074c8c0d4a470753f7e2312ab75da7130c90eaeb9060a', 'admin', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
