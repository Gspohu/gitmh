-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Sam 20 Août 2016 à 15:30
-- Version du serveur :  5.7.13-0ubuntu0.16.04.2
-- Version de PHP :  7.0.8-0ubuntu0.16.04.2

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
  `Name` varchar(255) NOT NULL,
  `Publpriv` varchar(255) NOT NULL,
  `Encryption` varchar(255) NOT NULL,
  `Type` varchar(255) NOT NULL,
  `Description` varchar(2048) NOT NULL,
  `License` varchar(255) NOT NULL,
  `Tag` varchar(255) NOT NULL,
  `Owner` varchar(255) NOT NULL,
  `Contributor` varchar(255) NOT NULL,
  `Admin` varchar(255) NOT NULL,
  `Contributor_group` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `id` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Projects`
--

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
