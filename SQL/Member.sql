-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Mer 12 Octobre 2016 à 15:55
-- Version du serveur :  5.7.15-0ubuntu0.16.04.1
-- Version de PHP :  7.0.8-0ubuntu0.16.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `cairngit`
--

-- --------------------------------------------------------

--
-- Structure de la table `Member`
--

CREATE TABLE `Member` (
  `Pseudo` varchar(255) CHARACTER SET utf8 NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8 NOT NULL,
  `Password` text CHARACTER SET utf8 NOT NULL,
  `ID` int(11) DEFAULT NULL,
  `Timestamp` text CHARACTER SET utf8,
  `Droits` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Space` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Tips_button` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Tips_button_unlimited` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Private_project` int(255) DEFAULT NULL,
  `Private_project_unlimited` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Encryption` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Tech_intelligence` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Support` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Option_search_sort` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `Option_search_in` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `Option_search_reduce` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Stars` int(11) DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
