CREATE DATABASE VideoGameParlour;
use VideoGameParlour;
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50),
    Surname VARCHAR(50),
    Address VARCHAR(100),
    Member_Type VARCHAR(20),
    Membership_Fee DECIMAL(10,2),
    Join_Date DATE,
    Date_of_Birth DATE
);
CREATE TABLE Member_Types (
    Member_Type VARCHAR(20) PRIMARY KEY,
    Membership_Fee DECIMAL(10,2)
);
CREATE TABLE Sessions (
    Session_ID INT PRIMARY KEY AUTO_INCREMENT,
    Session_Day VARCHAR(20),
    Start_Time TIME,
    End_Time TIME,
    Session_Type VARCHAR(20),
    Floor INT,
    Price DECIMAL(10,2)
);
CREATE TABLE Bookings (
    Booking_ID INT PRIMARY KEY AUTO_INCREMENT,
    Session_ID INT,
    Customer_ID INT,
    Booking_Date DATE,
    Member_Status CHAR(1),
    Fee DECIMAL(10,2),
    Prepaid CHAR(1),
    FOREIGN KEY (Session_ID) REFERENCES Sessions(Session_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);
CREATE TABLE Floors (
    Floor_ID INT PRIMARY KEY,
    Floor_Name VARCHAR(50)
);
CREATE TABLE Arcade_Machines (
    Machine_ID INT PRIMARY KEY AUTO_INCREMENT,
    Game VARCHAR(50),
    Year_Released INT,
    Floor_ID INT,
    FOREIGN KEY (Floor_ID) REFERENCES Floors(Floor_ID)
);
CREATE TABLE Games (
    Game_ID INT PRIMARY KEY AUTO_INCREMENT,
    Game_Name VARCHAR(50),
    PEGI_Rating VARCHAR(10),
    Console VARCHAR(50)
);
CREATE TABLE Consoles (
    Console_ID INT PRIMARY KEY AUTO_INCREMENT,
    Console_Name VARCHAR(50),
    Quantity INT
);
CREATE TABLE Session_Consoles (
    Session_ID INT,
    Console_ID INT,
    Quantity INT,
    PRIMARY KEY (Session_ID, Console_ID),
    FOREIGN KEY (Session_ID) REFERENCES Sessions(Session_ID),
    FOREIGN KEY (Console_ID) REFERENCES Consoles(Console_ID)
);
CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY AUTO_INCREMENT,
    Staff_Name VARCHAR(50)
);
CREATE TABLE Session_Staff (
    Session_ID INT,
    Staff_ID INT,
    Role VARCHAR(50),
    PRIMARY KEY (Session_ID, Staff_ID),
    FOREIGN KEY (Session_ID) REFERENCES Sessions(Session_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);
INSERT INTO Customers (First_Name, Surname, Address, Member_Type, Membership_Fee, Join_Date, Date_of_Birth)
VALUES 
('Saanvi', 'Bhatta', 'Baneswhor, Kathmandu', 'Standard', 1500, '2024-01-01', '2015-03-01'),
('Bill', 'Gates', 'Maitidevi, Kathmandu', 'Premium', 20000, '2024-07-06', '2001-10-12'),
('Elon', 'Musk', 'Putalisadak, Kathmandu', 'Premium', 20000, '2024-03-28', '2003-07-20'),
('Kamala', 'Harris', 'Kapan, Kathmandu', 'Standard', 1500, '2024-01-05', '1973-05-01');

INSERT INTO Sessions (Session_Day, Start_Time, End_Time, Session_Type, Floor, Price)
VALUES 
('Sunday', '09:00:00', '21:00:00', 'Free', 1, 1500),
('Sunday', '09:00:00', '21:00:00', 'Free', 2, 1000),
('Saturday', '09:00:00', '21:00:00', 'Free', 1, 1500),
('Friday', '18:00:00', '22:00:00', 'Special', 2, 1000);

INSERT INTO Bookings (Session_ID, Customer_ID, Booking_Date, Member_Status, Fee, Prepaid)
VALUES 
(1, 1, '2024-07-22', 'Y', NULL, NULL),
(1, 2, '2024-07-22', 'N', 1500, 'N'),
(1, 3, '2024-07-22', 'Y', 1000, 'Y'),
(1, 4, '2024-08-25', 'N', 1500, 'N'),
(2, 1, '2024-07-22', 'Y', 1000, 'N'),
(4, 3, '2024-07-05', 'Y', 1000, 'Y');

INSERT INTO Arcade_Machines (Game, Year_Released, Floor_ID)
VALUES 
('COC', 2010, 1),
('GTA', 2013, 1),
('Spiderman', 2016, 2),
('PUBG', 2004, 1);

INSERT INTO Consoles (Console_Name, Quantity)
VALUES 
('Xbox 360', 3),
('PS3', 2),
('PS2', 3),
('Nintendo 64', 2),
('Nintendo Switch', 4);

INSERT INTO Staff (Staff_Name)
VALUES 
('Sagar Aryal'),
('Bikesh Khagdi'),
('Saroj Sapkota'),
('Jonathan Shrestha'),
('Rohan Chaudhary'),
('Rajeev Karmacharya');

INSERT INTO Session_Staff (Session_ID, Staff_ID, Role)
VALUES 
(1, 2, 'Maintenance'),
(1, 3, 'Counter'),
(1, 1, 'Cafe'),
(2, 4, 'Counter'),
(2, 5, 'Maintenance'),
(2, 6, 'Cafe');

SELECT Customers.First_Name, Customers.Surname
FROM Bookings
JOIN Customers ON Bookings.Customer_ID = Customers.Customer_ID
WHERE Bookings.Session_ID = 1 AND Bookings.Prepaid = 'N';

SELECT Machine_ID, Game 
FROM Arcade_Machines
WHERE Floor_ID = 1
ORDER BY Machine_ID DESC;

SELECT COUNT(*) AS Total_PS3_Games
FROM Games
WHERE Console = 'PS3';

SELECT Staff.Staff_Name
FROM Session_Staff
JOIN Staff ON Session_Staff.Staff_ID = Staff.Staff_ID
WHERE Session_Staff.Session_ID = 1 AND Session_Staff.Role = 'Maintenance';

UPDATE Arcade_Machines
SET Floor_ID = 2
WHERE Game = 'PUBG' AND Floor_ID = 1;

DELETE FROM Arcade_Machines
WHERE Game = 'GTA';
