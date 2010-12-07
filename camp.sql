-- phpMyAdmin SQL Dump
-- version 3.3.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 07, 2010 at 10:21 PM
-- Server version: 5.1.41
-- PHP Version: 5.3.2-1ubuntu4.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `port`
--

-- --------------------------------------------------------

--
-- Table structure for table `gb`
--

CREATE TABLE IF NOT EXISTS `gb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `web` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `ip` varchar(20) NOT NULL,
  `published` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `gb`
--

INSERT INTO `gb` (`id`, `from`, `title`, `content`, `web`, `email`, `ip`, `published`) VALUES
(1, 'me', 'my fuckin entry', 'yea whatever', '', 'j', '192.168.123.82', '2010-12-05 22:42:56'),
(2, 'john', '<>"hi mates<script>alert(''etwas'')</script>', 'Hahaha I''ve hacked you', 'http://juzna.cz/<script>alert()</script>', '', '1.1.1.1', '2010-12-05 22:43:44'),
(3, 'mario', 'hehe :)', '', '', '', '', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `kid`
--

CREATE TABLE IF NOT EXISTS `kid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pass` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `rate_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `kid`
--


-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE IF NOT EXISTS `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `published` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `title`, `content`, `published`) VALUES
(1, 'Hi mates', 'How are you?', '2010-12-05 22:15:04'),
(2, 'XXX', 'new item', '2010-12-05 22:15:39'),
(3, 'waqar is big', 'He is 80 years old', '2010-12-05 22:15:39');

-- --------------------------------------------------------

--
-- Table structure for table `rates`
--

CREATE TABLE IF NOT EXISTS `rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `rates`
--


-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE IF NOT EXISTS `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `name`) VALUES
(1, 'red'),
(2, 'blue');
