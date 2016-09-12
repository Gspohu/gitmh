-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Lun 12 Septembre 2016 à 16:21
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
  `Option_search_reduce` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Member`
--

INSERT INTO `Member` (`Pseudo`, `Email`, `Password`, `ID`, `Timestamp`, `Droits`, `Space`, `Tips_button`, `Tips_button_unlimited`, `Private_project`, `Private_project_unlimited`, `Encryption`, `Tech_intelligence`, `Support`, `Option_search_sort`, `Option_search_in`, `Option_search_reduce`) VALUES
('Admin', 'admin@adm.in', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 0, 'qq', '0', '1', 'none', 'none', 0, 'none', 'none', 'none', 'none', 'none', 'none', 'none'),
('Gspohu', 'pohuvalentin@gmail.com', '5d94619b4745374691d18063784a50d3ffce0a0ab172b275005eb485e7b1a0aa', NULL, 'Friday 2nd of September 2016 06:08:44 PM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '🕒', '📁', NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
