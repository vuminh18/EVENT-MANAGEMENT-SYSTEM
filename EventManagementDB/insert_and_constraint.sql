-- Initializing the Database
CREATE DATABASE EventManagementDB;
USE EventManagementDB;

-- 1. Create Venues Table
CREATE TABLE Venues (
    VenueID INT PRIMARY KEY AUTO_INCREMENT,
    VenueName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL
);

-- 2. Create Organizers Table
CREATE TABLE Organizers (
    OrganizerID INT PRIMARY KEY AUTO_INCREMENT,
    OrganizerName VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15)
);

-- 3. Create Guests Table
CREATE TABLE Guests (
    GuestID INT PRIMARY KEY AUTO_INCREMENT,
    GuestName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15)
);

-- 4. Create Events Table
CREATE TABLE Events (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    EventName VARCHAR(150) NOT NULL,
    EventDate DATETIME NOT NULL,
    VenueID INT,
    CONSTRAINT fk_event_venue FOREIGN KEY (VenueID) 
    REFERENCES Venues(VenueID) ON DELETE SET NULL
);

-- 5. Create Registrations Table
CREATE TABLE Registrations (
    RegistrationID INT PRIMARY KEY AUTO_INCREMENT,
    EventID INT NOT NULL,
    GuestID INT NOT NULL,
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_reg_event FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE,
    CONSTRAINT fk_reg_guest FOREIGN KEY (GuestID) REFERENCES Guests(GuestID) ON DELETE CASCADE
);

-- 1. Linking Organizers to Events (One-to-Many)
-- This ensures every event has a designated managing entity.
ALTER TABLE Events 
ADD COLUMN OrganizerID INT;

ALTER TABLE Events 
ADD CONSTRAINT fk_event_organizer 
FOREIGN KEY (OrganizerID) REFERENCES Organizers(OrganizerID) 
ON DELETE SET NULL; 

-- 2. Refining Registrations Integrity
-- Ensuring that registration records are linked to existing guests and events.
ALTER TABLE Registrations 
MODIFY COLUMN EventID INT NOT NULL,
MODIFY COLUMN GuestID INT NOT NULL;
