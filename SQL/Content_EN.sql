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
-- Structure de la table `Content_EN`
--

CREATE TABLE `Content_EN` (
  `Name` text NOT NULL,
  `Content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='English';

--
-- Contenu de la table `Content_EN`
--

INSERT INTO `Content_EN` (`Name`, `Content`) VALUES
('Nav_menu_1', 'Open-Hardware'),
('Nav_menu_2', 'Explore'),
('Nav_menu_3', 'Pricing'),
('Nav_placeholder_search', ' Search'),
('Nav_button_connexion', 'Sign in'),
('Nav_button_inscription', 'Sign up'),
('Connexion_title', 'Sign in'),
('Connexion_form_1', 'Username'),
('Connexion_form_2', 'Passphrase'),
('Connexion_text_1', 'Forgot passphrase ?'),
('Connexion_submit', 'Submit'),
('Inscription_title', 'Sign up'),
('Inscription_form_1', 'Username'),
('Inscription_form_2', 'Passphrase'),
('Inscription_form_3', 'Re-passphrase'),
('Inscription_form_4', 'Email'),
('Inscription_form_5', 'Captcha'),
('Inscription_submit', 'Submit'),
('Inscription_form_placeholder_2', 'Must be at least 8 characters'),
('Inscription_form_placeholder_3', 'Repeat your passphrase'),
('Inscription_form_placeholder_5', 'Copy the text to your right'),
('Footer_copyR', 'GPLv3 Cairn-devices 2016'),
('Footer_link_1', 'Map'),
('Footer_link_2', 'Cairn Devices'),
('Footer_link_3', 'Legal'),
('Footer_link_4', 'Privacy'),
('Footer_link_5', 'Language'),
('Footer_link_6', 'News'),
('Footer_link_7', 'Contact'),
('Footer_link_8', 'Support'),
('Footer_link_9', 'Press'),
('Contact_title', 'Contact us'),
('Contact_form_1', 'Email'),
('Contact_form_2', 'Message'),
('Contact_form_3', 'Captcha'),
('Contact_form_placeholder_3', 'Copy the text to your right'),
('Contact_submit', 'Submit'),
('Nav_menu_1', 'Open-Hardware'),
('Nav_menu_2', 'Explore'),
('Nav_menu_3', 'Pricing'),
('Nav_placeholder_search', ' Search'),
('Nav_button_connexion', 'Sign in'),
('Nav_button_inscription', 'Sign up'),
('Connexion_title', 'Sign in'),
('Connexion_form_1', 'Username'),
('Connexion_form_2', 'Passphrase'),
('Connexion_text_1', 'Forgot passphrase ?'),
('Connexion_submit', 'Submit'),
('Inscription_title', 'Sign up'),
('Inscription_form_1', 'Username'),
('Inscription_form_2', 'Passphrase'),
('Inscription_form_3', 'Re-passphrase'),
('Inscription_form_4', 'Email'),
('Inscription_form_5', 'Captcha'),
('Inscription_submit', 'Submit'),
('Inscription_form_placeholder_2', 'Must be at least 8 characters'),
('Inscription_form_placeholder_3', 'Repeat your passphrase'),
('Inscription_form_placeholder_5', 'Copy the text to your right'),
('Footer_copyR', 'GPLv3 Cairn-devices 2016'),
('Footer_link_1', 'Map'),
('Footer_link_2', 'Cairn Devices'),
('Footer_link_3', 'Legal'),
('Footer_link_4', 'Privacy'),
('Footer_link_5', 'Language'),
('Footer_link_6', 'News'),
('Footer_link_7', 'Contact'),
('Footer_link_8', 'Support'),
('Footer_link_9', 'Press'),
('Contact_title', 'Contact us'),
('Contact_form_1', 'Email'),
('Contact_form_2', 'Message'),
('Contact_form_3', 'Captcha'),
('Contact_form_placeholder_3', 'Copy the text to your right'),
('Contact_submit', 'Submit');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
