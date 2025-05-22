-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 22, 2025 at 09:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `occasio`
--

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `EventId` int(11) NOT NULL,
  `EventName` varchar(100) NOT NULL,
  `StartDate` date NOT NULL,
  `PostDate` date NOT NULL,
  `Description` varchar(2000) NOT NULL,
  `ImagePath` varchar(500) DEFAULT NULL,
  `EventLocation` varchar(50) NOT NULL,
  `Restriction` varchar(50) DEFAULT NULL,
  `PostedUserId` int(10) NOT NULL,
  `Status` varchar(20) NOT NULL,
  `ReviewNote` varchar(500) DEFAULT NULL,
  `EndDate` date NOT NULL,
  `SponsorName` varchar(50) DEFAULT NULL,
  `SponsorContact` varchar(15) DEFAULT NULL,
  `SponsorEmail` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`EventId`, `EventName`, `StartDate`, `PostDate`, `Description`, `ImagePath`, `EventLocation`, `Restriction`, `PostedUserId`, `Status`, `ReviewNote`, `EndDate`, `SponsorName`, `SponsorContact`, `SponsorEmail`) VALUES
(27, 'Futurama', '2025-05-21', '2025-05-22', 'Futurama is an annual tech and innovation event organized by Islington College in Kathmandu, Nepal.', 'resources/images/event_covers/Futurama.jpg', 'Main Block', NULL, 23, 'approved', NULL, '2025-06-28', NULL, NULL, NULL),
(28, 'Skill Enrichment', '2025-05-21', '2025-05-22', 'Skill enrichment boosts knowledge, sharpens abilities.', 'resources/images/event_covers/Skill Enrichment.png', 'Kumari Hall', NULL, 23, 'approved', NULL, '2025-06-28', NULL, NULL, NULL),
(29, 'International Exposure', '2025-06-01', '2025-05-22', 'International Trip to thailand and fun.', 'resources/images/event_covers/Thailand Tour.jpg', 'Thailand', NULL, 23, 'approved', NULL, '2025-06-22', NULL, NULL, NULL),
(30, 'Kumari Jatra', '2025-06-08', '2025-05-22', 'Kumari Jatra is newari culture festiv.', 'resources/images/event_covers/Kumari jatra.webp', 'Kumari Hall', NULL, 23, 'approved', NULL, '2025-06-28', NULL, NULL, NULL),
(31, 'Inseption', '2025-05-22', '2025-05-22', 'John rai concert is gonna be fun.', 'resources/images/event_covers/Jhon Rai Concert.jpg', 'Kumari Hall', NULL, 20, 'approved', NULL, '2025-06-28', NULL, NULL, NULL),
(32, 'Dashain Event', '2025-08-14', '2025-05-22', 'Dashain is hindu festiv.', 'resources/images/event_covers/Dashain Event.jpg', 'Main Block', NULL, 20, 'approved', NULL, '2025-08-31', NULL, NULL, NULL),
(33, 'Spring Carinival', '2025-05-21', '2025-05-22', 'Carnival live music fest.', 'resources/images/event_covers/Carnival.png', 'Uk parking', NULL, 20, 'approved', NULL, '2025-06-28', NULL, NULL, NULL),
(34, 'Ethinic Day', '2025-05-14', '2025-05-22', 'Ethicnic is a good way to have fun', 'resources/images/event_covers/Ethinic day.jpg', 'Kumari Hall', NULL, 20, 'approved', NULL, '2025-05-19', NULL, NULL, NULL),
(35, 'Nepathya live', '2025-06-16', '2025-05-22', 'Nepathy are best singer', 'resources/images/event_covers/Nepathya live.jpg', 'Godawari Resort', NULL, 21, 'approved', NULL, '2025-06-17', NULL, NULL, NULL),
(36, 'Holi', '2025-04-24', '2025-05-22', 'Holi is a color festiv.', 'resources/images/event_covers/Holi.jpg', 'Kumari Hall', NULL, 21, 'rejected', '', '2025-04-30', NULL, NULL, NULL),
(37, 'Women in Tech', '2025-05-21', '2025-05-22', 'Women are the backbone of the country.', 'resources/images/event_covers/women-in-tech-cover.jpg', 'Kumari Hall', NULL, 21, 'approved', NULL, '2025-06-28', NULL, NULL, NULL),
(38, 'Islington Yatra', '2025-05-23', '2025-05-22', 'Yatra is college best event\r\n', 'resources/images/event_covers/Event Photo.jpg', 'Kumari Hall', NULL, 21, 'approved', NULL, '2025-06-24', NULL, NULL, NULL),
(39, 'New Year', '2025-03-13', '2025-05-22', 'Newyear', 'resources/images/event_covers/nayabars.jpg', 'Kumari Hall', NULL, 22, 'rejected', 'Bad', '2025-04-29', NULL, NULL, NULL),
(40, 'International Business', '2025-06-26', '2025-05-22', 'International Business\r\n', 'resources/images/event_covers/international-business-consultant.png', 'Thailand', NULL, 22, 'approved', NULL, '2025-07-25', NULL, NULL, NULL),
(41, 'Owasp Meetup', '2025-05-20', '2025-05-22', 'Meetup to the world', 'resources/images/event_covers/Meetup.png', 'Main Block', NULL, 22, 'approved', NULL, '2025-06-10', NULL, NULL, NULL),
(42, 'Graduation', '2025-05-21', '2025-05-22', 'Student Graduation', 'resources/images/event_covers/Graduation.png', 'Yak and Yeti', NULL, 22, 'approved', NULL, '2025-06-09', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `event_interested_users`
--

CREATE TABLE `event_interested_users` (
  `EventId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event_interested_users`
--

INSERT INTO `event_interested_users` (`EventId`, `UserId`) VALUES
(27, 20),
(27, 21),
(27, 22),
(27, 23),
(28, 21),
(28, 22),
(28, 23),
(29, 23),
(30, 23),
(31, 20),
(31, 21),
(31, 22),
(31, 23),
(32, 20),
(33, 20),
(33, 21),
(33, 22),
(33, 23),
(34, 20),
(35, 21),
(36, 21),
(37, 20),
(37, 21),
(37, 22),
(37, 23),
(38, 21),
(39, 22),
(40, 22),
(41, 20),
(41, 21),
(41, 22),
(41, 23),
(42, 20),
(42, 21),
(42, 22),
(42, 23);

-- --------------------------------------------------------

--
-- Table structure for table `event_sponsor`
--

CREATE TABLE `event_sponsor` (
  `EventId` int(11) NOT NULL,
  `SponsorId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `OrgId` int(11) NOT NULL,
  `OrgName` varchar(100) NOT NULL,
  `OnboardedDate` date NOT NULL,
  `Status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `organization`
--

INSERT INTO `organization` (`OrgId`, `OrgName`, `OnboardedDate`, `Status`) VALUES
(1, 'Super Organization', '2025-05-01', 'Active'),
(2, 'Islington', '2025-05-04', 'Active'),
(5, 'Global College', '2025-05-21', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `sponsor`
--

CREATE TABLE `sponsor` (
  `SponsorId` int(11) NOT NULL,
  `SponsorName` varchar(50) NOT NULL,
  `SponsorEmail` varchar(150) DEFAULT NULL,
  `SponsorContact` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `UserId` int(11) NOT NULL,
  `FullName` varchar(255) NOT NULL,
  `UserEmail` varchar(100) NOT NULL,
  `Role` varchar(20) NOT NULL DEFAULT 'user',
  `Password` varchar(500) NOT NULL,
  `DateJoined` date NOT NULL,
  `PhoneNumber` varchar(13) DEFAULT NULL,
  `ProfilePicturePath` varchar(500) DEFAULT NULL,
  `OrgId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`UserId`, `FullName`, `UserEmail`, `Role`, `Password`, `DateJoined`, `PhoneNumber`, `ProfilePicturePath`, `OrgId`) VALUES
(11, 'Super Admin', 'superadmin@occasio.com', 'superAdmin', '$2a$12$Ua06eiI.Td9Gw1L13F3DRO.9r73SUcip87EoFSktaJPAJpCpQd4Wm', '2025-05-21', '9824038615', 'resources/images/profile_pics/event-default.png', 1),
(13, 'Shreejesh Pathak', 'admin@global.com', 'admin', '$2a$12$nweSageDyjSahX9RXOXjn.ymVrRR0cevrHP2Jh9zLHACQqOFFVgI2', '2025-05-21', NULL, NULL, 5),
(19, 'Islington Admin', 'admin@islington.com', 'admin', '$2a$12$S0pMFPZp5jNcflV7KUzIs.W7Pbnp8zyVXpljIwa.ev2ksp02u.i.K', '2025-05-22', '9812345678', 'resources/images/profile_pics/event-default.png', 2),
(20, 'Shreejesh Pathak', 'shreejeshpathak@gmail.com', 'user', '$2a$12$tC7VTPcZH1WncsaE1e3He.aJoclhwpge0mjh3HkCaP4eq/1BbRwei', '2025-05-22', '9866290535', 'resources/images/profile_pics/Screenshot 2025-01-22 165029.png', 2),
(21, 'Aayush Karki', 'karkiaayush01@gmail.com', 'user', '$2a$12$Zr/Hnat6putrqNIUJwfsQ.NUI9EvjhXEJyrWDxVPBX9ICVonUAnY2', '2025-05-22', '9824038615', 'resources/images/profile_pics/aayush.jpeg', 2),
(22, 'Srijan Shrestha', 'srijanshrestha999@gmail.com', 'user', '$2a$12$ISaaeMnpsFXgTqaQdXFfFOi8FTjCsftO/cE8u4on9C1YOvgjmvtaa', '2025-05-22', '9845674567', 'resources/images/profile_pics/Srijan.jpg', 2),
(23, 'Arpit Neupane', 'neupanearpeet@gmail.com', 'user', '$2a$12$B/GJeto0Bax4aSGl/W.ss.INul6iupKmCqEmcRCTkAPmG4p3MkmBq', '2025-05-22', '9845674569', 'resources/images/profile_pics/bday.jpg', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`EventId`),
  ADD KEY `event_poster_fk` (`PostedUserId`);

--
-- Indexes for table `event_interested_users`
--
ALTER TABLE `event_interested_users`
  ADD PRIMARY KEY (`EventId`,`UserId`),
  ADD KEY `User_Event_fk` (`UserId`);

--
-- Indexes for table `event_sponsor`
--
ALTER TABLE `event_sponsor`
  ADD PRIMARY KEY (`EventId`,`SponsorId`),
  ADD KEY `Sponsor_Event_fk` (`SponsorId`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`OrgId`);

--
-- Indexes for table `sponsor`
--
ALTER TABLE `sponsor`
  ADD PRIMARY KEY (`SponsorId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserId`),
  ADD KEY `OrgId` (`OrgId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `EventId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `organization`
--
ALTER TABLE `organization`
  MODIFY `OrgId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sponsor`
--
ALTER TABLE `sponsor`
  MODIFY `SponsorId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `event_poster_fk` FOREIGN KEY (`PostedUserId`) REFERENCES `user` (`UserId`) ON DELETE CASCADE;

--
-- Constraints for table `event_interested_users`
--
ALTER TABLE `event_interested_users`
  ADD CONSTRAINT `Event_User_fk` FOREIGN KEY (`EventId`) REFERENCES `event` (`EventId`) ON DELETE CASCADE,
  ADD CONSTRAINT `User_Event_fk` FOREIGN KEY (`UserId`) REFERENCES `user` (`UserId`) ON DELETE CASCADE;

--
-- Constraints for table `event_sponsor`
--
ALTER TABLE `event_sponsor`
  ADD CONSTRAINT `Event_Sponsor_fk` FOREIGN KEY (`EventId`) REFERENCES `event` (`EventId`) ON DELETE CASCADE,
  ADD CONSTRAINT `Sponsor_Event_fk` FOREIGN KEY (`SponsorId`) REFERENCES `sponsor` (`SponsorId`) ON DELETE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `OrgId` FOREIGN KEY (`OrgId`) REFERENCES `organization` (`OrgId`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
