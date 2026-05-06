USE EventManagementDB;
-- Indexing EventName to speed up event lookups
CREATE INDEX idx_event_name ON Events(EventName);

-- Indexing GuestEmail to optimize guest verification and login simulations
CREATE INDEX idx_guest_email ON Guests(Email);
SELECT * FROM Events WHERE EventName = 'Cloned global monitoring';

CREATE VIEW View_EventAttendeeSummary AS 
SELECT 
               e.EventID, 
               e.EventName, 
               e.EventDate,
               v.VenueName,
              COUNT(r.RegistrationID) AS TotalAttendees 
FROM Events e 
JOIN Venues v ON e.VenueID = v.VenueID 
LEFT JOIN Registrations r ON e.EventID = r.EventID 
GROUP BY e.EventID;
SELECT * FROM View_EventAttendeeSummary

DELIMITER // 
CREATE PROCEDURE GetGuestActivity (IN targetGuestID INT) 
BEGIN 
          SELECT e.EventName, e.EventDate, r.RegistrationDate 
          FROM Registrations r 
          JOIN Events e ON r.EventID = e.EventID 
          WHERE r.GuestID =targetGuestID; 
END // 
DELIMITER ;
CALL GetGuestActivity(5);

CREATE TRIGGER trg_lowercase_email 
BEFORE INSERT ON Guests 
FOR EACH ROW 
SET NEW.Email = LOWER(NEW.Email);
INSERT INTO Guests (GuestName, Email, PhoneNumber) 
VALUES ('Vu Kim Minh', 'vukimminh2006@GMAIL.COM', '0123456789');
SELECT * FROM Guests WHERE GuestName = 'Vu Kim Minh';


--  Implementation Scripts
CREATE ROLE 'event_manager';
CREATE ROLE 'reporting_viewer';
-- Assign privileges to the Manager role
GRANT SELECT, INSERT, UPDATE, DELETE ON EventManagementDB.Events TO 'event_manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON EventManagementDB.Registrations TO 'event_manager';
GRANT SELECT ON EventManagementDB.Venues TO 'event_manager';
-- Assign privileges to the Analyst role
GRANT SELECT ON EventManagementDB.View_EventAttendeeSummary TO 'reporting_viewer';
-- Create a dedicated user for data analysis (for Python integration)
CREATE USER 'da_specialist'@'localhost' IDENTIFIED BY 'SecurePass123!';
GRANT 'reporting_viewer' TO 'da_specialist'@'localhost';
SET DEFAULT ROLE 'reporting_viewer' TO 'da_specialist'@'localhost';


SHOW GRANTS FOR 'da_specialist'@'localhost';

FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '18021507';