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
-- Structure de la table `Projects`
--

CREATE TABLE `Projects` (
  `Name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Publpriv` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Encryption` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Description` varchar(2048) CHARACTER SET utf8 DEFAULT NULL,
  `License` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Tag` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Owner` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Contributor` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Admin` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Contributor_group` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `id` text CHARACTER SET utf8,
  `Rating` int(11) DEFAULT '0',
  `Fork` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
