DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS Information;
DROP TABLE IF EXISTS CHANGE;
DROP TABLE IF EXISTS TRACKER;
DROP TABLE IF EXISTS Link;
DROP TABLE IF EXISTS Art;
DROP TABLE IF EXISTS Terms;
DROP TABLE IF EXISTS Link;
DROP TABLE IF EXISTS Cultures;
DROP TABLE IF EXISTS Link;
DROP TABLE IF EXISTS Monographs;
DROP TABLE IF EXISTS Link;
DROP TABLE IF EXISTS Periodicals;
DROP TABLE IF EXISTS Unique;
DROP TABLE IF EXISTS Art;
DROP TABLE IF EXISTS Terms;
DROP TABLE IF EXISTS Unique;
DROP TABLE IF EXISTS Cultures;
DROP TABLE IF EXISTS Unique;
DROP TABLE IF EXISTS monographs;
DROP TABLE IF EXISTS will's;
DROP TABLE IF EXISTS Unique;
DROP TABLE IF EXISTS monographs;
DROP TABLE IF EXISTS Paste;
DROP TABLE IF EXISTS Errors;
-- ----------------------------------------------------------
-- MDB Tools - A library for reading MS Access database files
-- Copyright (C) 2000-2011 Brian Bruns and others.
-- Files in libmdb are licensed under LGPL and the utilities under
-- the GPL, see COPYING.LIB and COPYING files respectively.
-- Check out http://mdbtools.sourceforge.net
-- ----------------------------------------------------------

-- That file uses encoding UTF-8

CREATE TABLE `Artist Information`
 (
	`Artist Accession Number`			int not null auto_increment unique, 
	`Name`			varchar (50), 
	`DOB`			varchar (20), 
	`DOD`			varchar (20), 
	`Gender`			varchar (1), 
	`Notes`			varchar (255), 
	`File`			boolean NOT NULL, 
	`Slides`			boolean NOT NULL, 
	`Video(s)`			boolean NOT NULL, 
	`Resume/Vita`			boolean NOT NULL, 
	`Artist Statement`			boolean NOT NULL, 
	`Gallery Notice`			boolean NOT NULL, 
	`Review`			boolean NOT NULL, 
	`Article`			boolean NOT NULL, 
	`Poster`			boolean NOT NULL, 
	`Folio`			boolean NOT NULL, 
	`CD-ROM`			boolean NOT NULL, 
	`Correspondance`			boolean NOT NULL, 
	`Library Exhibit`			boolean NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE `Artist Information` ADD PRIMARY KEY (`Artist Accession Number`);

CREATE TABLE `CHANGE TRACKER`
 (
	`CHANGE NUMBER`			int not null auto_increment unique, 
	`DATE`			date NOT NULL, 
	`NOTE`			varchar (255)
);

-- CREATE INDEXES ...
ALTER TABLE `CHANGE TRACKER` ADD PRIMARY KEY (`CHANGE NUMBER`);

CREATE TABLE `Link Art Terms`
 (
	`Artists Accession Number`			int, 
	`Art Term`			varchar (30)
);

-- CREATE INDEXES ...
ALTER TABLE `Link Art Terms` ADD INDEX `Link Art TermsMedium` (`Art Term`);
ALTER TABLE `Link Art Terms` ADD PRIMARY KEY (`Artists Accession Number`, `Art Term`);

CREATE TABLE `Link Cultures`
 (
	`Artist Accession Number`			int, 
	`Culture`			varchar (35)
);

-- CREATE INDEXES ...
ALTER TABLE `Link Cultures` ADD INDEX `Link CulturesArtist Accession Number` (`Artist Accession Number`);
ALTER TABLE `Link Cultures` ADD INDEX `Link CulturesCulture` (`Culture`);
ALTER TABLE `Link Cultures` ADD PRIMARY KEY (`Artist Accession Number`, `Culture`);

CREATE TABLE `Link Monographs`
 (
	`Artist Accession Number`			int, 
	`call number`			varchar (40), 
	`page number`			varchar (20), 
	`note`			varchar (50)
);

-- CREATE INDEXES ...
ALTER TABLE `Link Monographs` ADD INDEX `Link MonographsArtist Accession Number` (`Artist Accession Number`);
ALTER TABLE `Link Monographs` ADD INDEX `Link Monographsnew call number` (`call number`);
ALTER TABLE `Link Monographs` ADD PRIMARY KEY (`Artist Accession Number`, `call number`);

CREATE TABLE `Link Periodicals`
 (
	`Artist Accession Number`			int, 
	`Article Citation`			varchar (100)
);

-- CREATE INDEXES ...
ALTER TABLE `Link Periodicals` ADD INDEX `Link PeriodicalsArtist Accession Number` (`Artist Accession Number`);

CREATE TABLE `Unique Art Terms`
 (
	`Art Term`			varchar (30)
);

-- CREATE INDEXES ...
ALTER TABLE `Unique Art Terms` ADD PRIMARY KEY (`Art Term`);

CREATE TABLE `Unique Cultures`
 (
	`Culture`			varchar (35)
);

-- CREATE INDEXES ...
ALTER TABLE `Unique Cultures` ADD PRIMARY KEY (`Culture`);

CREATE TABLE `Unique monographs`
 (
	`Call Number`			varchar (40), 
	`Title`			varchar (150), 
	`Last Name`			varchar (50), 
	`First Name`			varchar (30), 
	`Year`			varchar (15)
);

-- CREATE INDEXES ...
ALTER TABLE `Unique monographs` ADD PRIMARY KEY (`Call Number`);

CREATE TABLE `will's Unique monographs`
 (
	`Call Number`			varchar (40), 
	`Title`			varchar (150), 
	`Last Name`			varchar (50), 
	`First Name`			varchar (30), 
	`Year`			varchar (15)
);

-- CREATE INDEXES ...
ALTER TABLE `will's Unique monographs` ADD PRIMARY KEY (`Call Number`);

CREATE TABLE `Paste Errors`
 (
	`Art Terms`			varchar (255)
);

-- CREATE INDEXES ...


-- CREATE Relationships ...
-- Relationship from `Link Monographs` (`Artist Accession Number`) to `Artist Information`(`Artist Accession Number`) does not enforce integrity.
-- Relationship from `Link Art Terms` (`Art Term`) to `Unique Art Terms`(`Art Term`) does not enforce integrity.
-- Relationship from `Link Cultures` (`Culture`) to `Unique Cultures`(`Culture`) does not enforce integrity.
-- Relationship from `Link Cultures` (`Artist Accession Number`) to `Artist Information`(`Artist Accession Number`) does not enforce integrity.
-- Relationship from `Link Monographs` (`call number`) to `Unique monographs`(`Call Number`) does not enforce integrity.
-- Relationship from `Link Art Terms` (`Artists Accession Number`) to `Artist Information`(`Artist Accession Number`) does not enforce integrity.
-- Relationship from `Link Periodicals` (`Artist Accession Number`) to `Artist Information`(`Artist Accession Number`) does not enforce integrity.
ALTER TABLE `MSysNavPaneGroups` ADD CONSTRAINT `MSysNavPaneGroups_GroupCategoryID_fk` FOREIGN KEY (`GroupCategoryID`) REFERENCES `MSysNavPaneGroupCategories`(`Id`) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `MSysNavPaneGroupToObjects` ADD CONSTRAINT `MSysNavPaneGroupToObjects_GroupID_fk` FOREIGN KEY (`GroupID`) REFERENCES `MSysNavPaneGroups`(`Id`) ON UPDATE CASCADE ON DELETE CASCADE;
