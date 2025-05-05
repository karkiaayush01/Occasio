-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 05, 2025 at 03:53 PM
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
  `EndDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`EventId`, `EventName`, `StartDate`, `PostDate`, `Description`, `ImagePath`, `EventLocation`, `Restriction`, `PostedUserId`, `Status`, `ReviewNote`, `EndDate`) VALUES
(1, 'Navia and Chlorinde', '2025-05-05', '2025-05-05', 'I fw lesbians.', 'resources/images/event_covers/1717171788130.jpg', 'Fontaine', NULL, 1, 'pending', NULL, '2025-05-07'),
(2, 'Champions League', '2025-05-06', '2025-05-05', 'Get together for an awesome final.', 'resources/images/event_covers/backgroundimage.jpg', 'Barcelona', NULL, 1, 'pending', NULL, '2025-05-10'),
(3, 'Test', '2025-05-07', '2025-05-05', 'test', 'resources/images/event_covers/1717171711714.jpg', 'Fontaine', NULL, 1, 'pending', NULL, '2025-05-08'),
(8, 'My Queen', '2025-04-03', '2025-05-05', 'okay', 'resources/images/event_covers/8ca9a5b66df345366c9994e16f5bcbfb.jpg', 'Solaris', NULL, 1, 'pending', NULL, '2025-05-30'),
(10, 'ABSOLUTE UI BREAKER TO THE MAX LIMIT RAHHHHHhhhhhhhhhhhhhhhhHHHHHHHHH', '2025-05-09', '2025-05-05', 'fdas', 'resources/images/event_covers/1720534840987.jpeg', 'fdasfaewgaewgewgeawgvaewfeaweawgawgewa', NULL, 1, 'pending', NULL, '2025-05-01');

-- --------------------------------------------------------

--
-- Table structure for table `event_interested_users`
--

CREATE TABLE `event_interested_users` (
  `EventId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'Islington', '2025-05-04', 'Active');

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
(1, 'Aayush Karki', 'karkiaayush01@gmail.com', 'user', '$2a$12$9rz2py5e8SGiDGtBtrL7ZeiGDPJu/P7kD21SMUd.ON7NphXWbcbz.', '2025-05-04', '9824038615', 'resources/images/profile_pics/queen.webp', 1);

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
  MODIFY `EventId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sponsor`
--
ALTER TABLE `sponsor`
  MODIFY `SponsorId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `event_poster_fk` FOREIGN KEY (`PostedUserId`) REFERENCES `user` (`UserId`);

--
-- Constraints for table `event_interested_users`
--
ALTER TABLE `event_interested_users`
  ADD CONSTRAINT `Event_User_fk` FOREIGN KEY (`EventId`) REFERENCES `event` (`EventId`),
  ADD CONSTRAINT `User_Event_fk` FOREIGN KEY (`UserId`) REFERENCES `user` (`UserId`);

--
-- Constraints for table `event_sponsor`
--
ALTER TABLE `event_sponsor`
  ADD CONSTRAINT `Event_Sponsor_fk` FOREIGN KEY (`EventId`) REFERENCES `event` (`EventId`),
  ADD CONSTRAINT `Sponsor_Event_fk` FOREIGN KEY (`SponsorId`) REFERENCES `sponsor` (`SponsorId`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `OrgId` FOREIGN KEY (`OrgId`) REFERENCES `organization` (`OrgId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
