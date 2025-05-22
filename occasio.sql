-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2025 at 01:28 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

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
(1, 'Sigewinne', '2025-05-05', '2025-05-05', 'WWWW', 'resources/images/event_covers/1718880014073.jpg', 'Marineford', NULL, 1, 'pending', NULL, '2025-05-07', '', '', ''),
(2, 'Champions League', '2025-05-06', '2025-05-05', 'Get together for an awesome final.', 'resources/images/event_covers/backgroundimage.jpg', 'Barcelona', NULL, 1, 'pending', NULL, '2025-05-10', '', '', ''),
(3, 'Test', '2025-05-07', '2025-05-05', 'test', 'resources/images/event_covers/1717171711714.jpg', 'Fontaine', NULL, 1, 'pending', NULL, '2025-05-08', '', '', ''),
(8, 'My Queen', '2025-04-03', '2025-05-05', 'okay', 'resources/images/event_covers/8ca9a5b66df345366c9994e16f5bcbfb.jpg', 'Solaris', NULL, 1, 'pending', NULL, '2025-05-30', '', '', ''),
(10, 'ABSOLUTE UI BREAKER TO THE MAX LIMIT RAHHHHHhhhhhhhhhhhhhhhhHHHHHHHHH', '2025-05-09', '2025-05-05', 'fdas', 'resources/images/event_covers/1720534840987.jpeg', 'fdasfaewgaewgewgeawgvaewfeaweawgawgewa', NULL, 1, 'pending', NULL, '2025-05-01', '', '', ''),
(16, 'Test 3', '2025-05-04', '2025-05-06', 'Test 2', 'resources/images/event_covers/Cantarella Apple @Yaoyaobae.jpg', 'Test 4', NULL, 4, 'pending', NULL, '2025-05-06', 'Coca-cola', 'no', ''),
(17, 'Neuv and Chlorinde', '2025-05-07', '2025-05-07', 'dnsnvkdnkns', 'resources/images/event_covers/290570419_349674360477901_3582246089466682745_n.jpeg', 'Solaris', NULL, 9, 'pending', NULL, '2025-05-08', 'bajeko sekuwa', 'bkjb', 'karkiaayush01@gmail.com'),
(18, ';l,', '2025-05-02', '2025-05-08', 'dsfgvbnm', 'resources/images/event_covers/290570419_349674360477901_3582246089466682745_n.jpeg', ',m ,. vhb n', NULL, 4, 'pending', NULL, '2025-05-09', 'asdfgvb', '', ''),
(19, 'Tea', '2025-05-19', '2025-05-19', 'Let\'s gooo', 'resources/images/event_covers/Cantarella Tea 1.jpg', 'Fisalia Family', NULL, 10, 'pending', NULL, '2025-05-19', 'Cantarella', '', ''),
(20, 'WuWa 1.3', '2025-05-20', '2025-05-20', 'adsfafdasf', 'resources/images/event_covers/1.3.jpg', 'Solaris', NULL, 10, 'pending', NULL, '2025-05-24', 'Coca-cola', '', ''),
(21, 'Test no img', '2025-05-20', '2025-05-20', 'fuck you', '', 'test center', NULL, 10, 'pending', NULL, '2025-05-21', 'tester', '', '');

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
(8, 1),
(8, 4),
(8, 7),
(8, 10);

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
(2, 'Islington', '2025-05-04', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `sponsor`
--

CREATE TABLE `sponsor` (
  `SponsorId` int(11) NOT NULL,
  `SponsorName` varchar(50) NOT NULL,
  `SponsorEmail` varchar(150) DEFAULT NULL,
  `SponsorContact` int(10) DEFAULT NULL
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
  `PhoneNumber` varchar(13) NOT NULL,
  `ProfilePicturePath` varchar(500) DEFAULT NULL,
  `OrgId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`UserId`, `FullName`, `UserEmail`, `Role`, `Password`, `DateJoined`, `PhoneNumber`, `ProfilePicturePath`, `OrgId`) VALUES
(1, 'Aayush Karki', 'karkiaayush01@gmail.co', 'admin', '$2a$12$47Pou2IDTl7hlK/QW6nxQ.hWMi2f090zThInb4v5rehVs4/ba1MxK', '2025-05-04', '9824386150', 'resources/images/profile_pics/290570419_349674360477901_3582246089466682745_n.jpeg', 2),
(4, 'Arpeet Neupaneb', 'neupanearpeet@gmail.com', 'user', '$2a$12$Hho2U.05u7nC.igo.6XdVOc7vLhuUx2lNnU0bh0z5.q79QsOH4cUa', '2025-05-06', '9803649735', 'resources/images/profile_pics/Brant Sparkle.jpg', 2),
(7, 'Arpit Neupane', 'neupanearpit@gmail.com', 'user', '$2a$12$SlDrmFEygRyUnh4UoGbHJ.ywygNu/IPmDpb7EgD3mF7FAXAXa5vgi', '2025-05-06', '9803649735', NULL, 2),
(9, 'rabina lamaaaaa', 'rabina12@gmail.com', 'user', '$2a$12$eivtGJ/1YvFGQwlu6YaGgeBoTX4/DdSAFIPiKdszFpQzVO.O9wE0O', '2025-05-07', '098765432', 'resources/images/profile_pics/2303230606-KVvUXgt2.jpeg', 2),
(10, 'Aayush Karki', 'karkiaayush001@gmail.com', 'user', '$2a$12$EBBYREI2bwMDDc.3TqkoOuhb7z/2rc1VwsL9fjP4rUvpI9yL6dLOm', '2025-05-19', '9824038615', 'resources/images/profile_pics/Cantarella PV V2.jpg', 2),
(11, 'Super Admin', 'superadmin@occasio.com', 'superAdmin', '$2a$12$Ua06eiI.Td9Gw1L13F3DRO.9r73SUcip87EoFSktaJPAJpCpQd4Wm', '2025-05-21', '9824038615', 'resources/images/profile_pics/event-default.png', 1);

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
  MODIFY `EventId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `organization`
--
ALTER TABLE `organization`
  MODIFY `OrgId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sponsor`
--
ALTER TABLE `sponsor`
  MODIFY `SponsorId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
