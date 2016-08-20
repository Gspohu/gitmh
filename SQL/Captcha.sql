-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Sam 20 Août 2016 à 15:20
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
-- Structure de la table `Captcha`
--

CREATE TABLE `Captcha` (
  `Nom` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Captcha`
--

INSERT INTO `Captcha` (`Nom`) VALUES
('A'),
('a'),
('Z'),
('z'),
('e'),
('E'),
('r'),
('R'),
('t'),
('T'),
('y'),
('Y'),
('u'),
('U'),
('i'),
('I'),
('O'),
('o'),
('P'),
('p'),
('Q'),
('q'),
('S'),
('s'),
('d'),
('D'),
('F'),
('f'),
('g'),
('G'),
('H'),
('h'),
('j'),
('J'),
('k'),
('K'),
('l'),
('L'),
('m'),
('M'),
('w'),
('W'),
('x'),
('X'),
('c'),
('C'),
('v'),
('V'),
('b'),
('B'),
('n'),
('N'),
('A'),
('a'),
('Z'),
('z'),
('e'),
('E'),
('r'),
('R'),
('t'),
('T'),
('y'),
('Y'),
('u'),
('U'),
('i'),
('I'),
('O'),
('o'),
('P'),
('p'),
('Q'),
('q'),
('S'),
('s'),
('d'),
('D'),
('F'),
('f'),
('g'),
('G'),
('H'),
('h'),
('j'),
('J'),
('k'),
('K'),
('l'),
('L'),
('m'),
('M'),
('w'),
('W'),
('x'),
('X'),
('c'),
('C'),
('v'),
('V'),
('b'),
('B'),
('n'),
('N');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
