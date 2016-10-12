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
-- Structure de la table `Colors`
--

CREATE TABLE `Colors` (
  `Item` text CHARACTER SET utf8,
  `Design_0` text CHARACTER SET utf8
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Colors`
--

INSERT INTO `Colors` (`Item`, `Design_0`) VALUES
('background_1', '#69499C'),
('background_2', '#353E46'),
('background_3', '#00C000'),
('background_4', '#F0F0F0'),
('background_5', '#377A2E'),
('background_element', '#23282D'),
('color_temoin', '#454F5A'),
('degrade_0_p0', '#00C000'),
('degrade_0_p1', '#009900'),
('degrade_1_p0', '#5fb6e1'),
('degrade_1_p1', '#207ba9'),
('degrade_2_p0', '#f28518'),
('degrade_2_p1', '#CB6F13'),
('degrade_3_p0', '#B90000'),
('degrade_3_p1', '#920000'),
('nav_admininterface_gradiant_0', '#087BFF'),
('nav_admininterface_gradiant_1', '#3191FF'),
('text_color', '#EDEAE3'),
('text_color_sub', '#626968');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
