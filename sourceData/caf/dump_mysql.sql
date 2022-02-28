/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist_information` (
  `Artist Accession Number` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `DOB` varchar(20) DEFAULT NULL,
  `DOD` varchar(20) DEFAULT NULL,
  `Gender` varchar(1) DEFAULT NULL,
  `Notes` varchar(255) DEFAULT NULL,
  `File` tinyint(1) NOT NULL,
  `Slides` tinyint(1) NOT NULL,
  `Video(s)` tinyint(1) NOT NULL,
  `Resume/Vita` tinyint(1) NOT NULL,
  `Artist Statement` tinyint(1) NOT NULL,
  `Gallery Notice` tinyint(1) NOT NULL,
  `Review` tinyint(1) NOT NULL,
  `Article` tinyint(1) NOT NULL,
  `Poster` tinyint(1) NOT NULL,
  `Folio` tinyint(1) NOT NULL,
  `CD-ROM` tinyint(1) NOT NULL,
  `Correspondance` tinyint(1) NOT NULL,
  `Library Exhibit` tinyint(1) NOT NULL,
  PRIMARY KEY (`Artist Accession Number`),
  UNIQUE KEY `Artist Accession Number` (`Artist Accession Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_art_terms` (
  `Artists Accession Number` int(11) NOT NULL,
  `Art Term` varchar(30) NOT NULL,
  PRIMARY KEY (`Artists Accession Number`,`Art Term`),
  KEY `Link Art TermsMedium` (`Art Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_cultures` (
  `Artist Accession Number` int(11) NOT NULL,
  `Culture` varchar(35) NOT NULL,
  PRIMARY KEY (`Artist Accession Number`,`Culture`),
  KEY `Link CulturesArtist Accession Number` (`Artist Accession Number`),
  KEY `Link CulturesCulture` (`Culture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_monographs` (
  `Artist Accession Number` int(11) NOT NULL,
  `call number` varchar(40) NOT NULL,
  `page number` varchar(20) DEFAULT NULL,
  `note` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Artist Accession Number`,`call number`),
  KEY `Link MonographsArtist Accession Number` (`Artist Accession Number`),
  KEY `Link Monographsnew call number` (`call number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_periodicals` (
  `Artist Accession Number` int(11) DEFAULT NULL,
  `Article Citation` varchar(100) DEFAULT NULL,
  KEY `Link PeriodicalsArtist Accession Number` (`Artist Accession Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unique_art_terms` (
  `Art Term` varchar(30) NOT NULL,
  PRIMARY KEY (`Art Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unique_cultures` (
  `Culture` varchar(35) NOT NULL,
  PRIMARY KEY (`Culture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unique_monographs` (
  `Call Number` varchar(40) NOT NULL,
  `Title` varchar(150) DEFAULT NULL,
  `Last Name` varchar(50) DEFAULT NULL,
  `First Name` varchar(30) DEFAULT NULL,
  `Year` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Call Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
