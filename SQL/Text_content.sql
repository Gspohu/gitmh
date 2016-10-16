-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Mer 12 Octobre 2016 à 15:56
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
-- Structure de la table `Text_content`
--

CREATE TABLE `Text_content` (
  `Name` text NOT NULL,
  `English` text,
  `French` text,
  `Spanish` text,
  `German` text,
  `Chinese` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='English';

--
-- Contenu de la table `Text_content`
--

INSERT INTO `Text_content` (`Name`, `English`, `French`, `Spanish`, `German`, `Chinese`) VALUES
('Nav_menu_1', 'Open-Hardware', NULL, NULL, NULL, NULL),
('Nav_menu_2', 'Explore', NULL, NULL, NULL, NULL),
('Nav_menu_3', 'Pricing', NULL, NULL, NULL, NULL),
('Nav_placeholder_search', ' Search', NULL, NULL, NULL, NULL),
('Nav_button_connexion', 'Sign in', NULL, NULL, NULL, NULL),
('Nav_button_inscription', 'Sign up', NULL, NULL, NULL, NULL),
('Connexion_title', 'Sign in', NULL, NULL, NULL, NULL),
('Connexion_form_1', 'Username', NULL, NULL, NULL, NULL),
('Connexion_form_2', 'Passphrase', NULL, NULL, NULL, NULL),
('Connexion_text_1', 'Forgot passphrase ?', NULL, NULL, NULL, NULL),
('Connexion_submit', 'Submit', NULL, NULL, NULL, NULL),
('Inscription_title', 'Sign up', NULL, NULL, NULL, NULL),
('Inscription_form_1', 'Username', NULL, NULL, NULL, NULL),
('Inscription_form_2', 'Passphrase', NULL, NULL, NULL, NULL),
('Inscription_form_3', 'Re-passphrase', NULL, NULL, NULL, NULL),
('Inscription_form_4', 'Email', NULL, NULL, NULL, NULL),
('Inscription_form_5', 'Captcha', NULL, NULL, NULL, NULL),
('Inscription_submit', 'Submit', NULL, NULL, NULL, NULL),
('Inscription_form_placeholder_2', 'Must be at least 8 characters', NULL, NULL, NULL, NULL),
('Inscription_form_placeholder_3', 'Repeat your passphrase', NULL, NULL, NULL, NULL),
('Inscription_form_placeholder_5', 'Copy the text to your right', NULL, NULL, NULL, NULL),
('Footer_copyR', 'GPLv3 Cairn-devices 2016', NULL, NULL, NULL, NULL),
('Footer_link_1', 'Map', NULL, NULL, NULL, NULL),
('Footer_link_2', 'Cairn Devices', NULL, NULL, NULL, NULL),
('Footer_link_3', 'Legal', NULL, NULL, NULL, NULL),
('Footer_link_4', 'Privacy', NULL, NULL, NULL, NULL),
('Footer_link_5', 'Language', NULL, NULL, NULL, NULL),
('Footer_link_6', 'Blog', NULL, NULL, NULL, NULL),
('Footer_link_7', 'Contact', NULL, NULL, NULL, NULL),
('Footer_link_8', 'Support', NULL, NULL, NULL, NULL),
('Footer_link_9', 'Press', NULL, NULL, NULL, NULL),
('Contact_title', 'Contact us', NULL, NULL, NULL, NULL),
('Contact_form_1', 'Email', NULL, NULL, NULL, NULL),
('Contact_form_2', 'Message', NULL, NULL, NULL, NULL),
('Contact_form_3', 'Captcha', NULL, NULL, NULL, NULL),
('Contact_form_placeholder_3', 'Copy the text to your right', NULL, NULL, NULL, NULL),
('Contact_submit', 'Submit', NULL, NULL, NULL, NULL),
('Nav_menu_1', 'Open-Hardware', NULL, NULL, NULL, NULL),
('Nav_menu_2', 'Explore', NULL, NULL, NULL, NULL),
('Nav_menu_3', 'Pricing', NULL, NULL, NULL, NULL),
('Nav_placeholder_search', ' Search', NULL, NULL, NULL, NULL),
('Nav_button_connexion', 'Sign in', NULL, NULL, NULL, NULL),
('Nav_button_inscription', 'Sign up', NULL, NULL, NULL, NULL),
('Connexion_title', 'Sign in', NULL, NULL, NULL, NULL),
('Connexion_form_1', 'Username', NULL, NULL, NULL, NULL),
('Connexion_form_2', 'Passphrase', NULL, NULL, NULL, NULL),
('Connexion_text_1', 'Forgot passphrase ?', NULL, NULL, NULL, NULL),
('Connexion_submit', 'Submit', NULL, NULL, NULL, NULL),
('Inscription_title', 'Sign up', NULL, NULL, NULL, NULL),
('Inscription_form_1', 'Username', NULL, NULL, NULL, NULL),
('Inscription_form_2', 'Passphrase', NULL, NULL, NULL, NULL),
('Inscription_form_3', 'Re-passphrase', NULL, NULL, NULL, NULL),
('Inscription_form_4', 'Email', NULL, NULL, NULL, NULL),
('Inscription_form_5', 'Captcha', NULL, NULL, NULL, NULL),
('Inscription_submit', 'Submit', NULL, NULL, NULL, NULL),
('Inscription_form_placeholder_2', 'Must be at least 8 characters', NULL, NULL, NULL, NULL),
('Inscription_form_placeholder_3', 'Repeat your passphrase', NULL, NULL, NULL, NULL),
('Inscription_form_placeholder_5', 'Copy the text to your right', NULL, NULL, NULL, NULL),
('Footer_copyR', 'GPLv3 Cairn-devices 2016', NULL, NULL, NULL, NULL),
('Footer_link_1', 'Map', NULL, NULL, NULL, NULL),
('Footer_link_2', 'Cairn Devices', NULL, NULL, NULL, NULL),
('Footer_link_3', 'Legal', NULL, NULL, NULL, NULL),
('Footer_link_4', 'Privacy', NULL, NULL, NULL, NULL),
('Footer_link_5', 'Language', NULL, NULL, NULL, NULL),
('Footer_link_6', 'Blog', NULL, NULL, NULL, NULL),
('Footer_link_7', 'Contact', NULL, NULL, NULL, NULL),
('Footer_link_8', 'Support', NULL, NULL, NULL, NULL),
('Footer_link_9', 'Press', NULL, NULL, NULL, NULL),
('Contact_title', 'Contact us', NULL, NULL, NULL, NULL),
('Contact_form_1', 'Email', NULL, NULL, NULL, NULL),
('Contact_form_2', 'Message', NULL, NULL, NULL, NULL),
('Contact_form_3', 'Captcha', NULL, NULL, NULL, NULL),
('Contact_form_placeholder_3', 'Copy the text to your right', NULL, NULL, NULL, NULL),
('Contact_submit', 'Submit', NULL, NULL, NULL, NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
