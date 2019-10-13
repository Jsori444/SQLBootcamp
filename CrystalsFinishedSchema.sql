/* My Schema */
 
-- USE FantasyTaverns;

use JPeck_2019;

DROP TABLE IF EXISTS RoomStays;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS ServiceSales;
DROP TABLE IF EXISTS GuestsClasses;
DROP TABLE IF EXISTS InventorySales;
DROP TABLE IF EXISTS Guests;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS TavernServices;
DROP TABLE IF EXISTS ServiceStatus;
DROP TABLE IF EXISTS LineItems;
DROP TABLE IF EXISTS Invoices;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Taverns;

CREATE TABLE Taverns (
ID INT PRIMARY KEY IDENTITY,
TavernName VARCHAR(100)
);

INSERT INTO Taverns (TavernName) VALUES
('Moe''s Tavern'),
('Joe''s Tavern'),
('Blasphemy Bar'),
('Rejected Reality'),
('Brianna''s');


CREATE TABLE Locations (
ID INT IDENTITY PRIMARY KEY,
LocationName VARCHAR(100),
TavernID INT FOREIGN KEY REFERENCES Taverns(ID) ON DELETE CASCADE,
Floors INT
);

INSERT INTO Locations (LocationName, TavernID, Floors) VALUES
('''Moe''town',1,1),
('''NotMoe''town',2,2),
('Anytown',2,2),
('Egypt',3,1),
('M5',4,714),
('Monongahela National Forest',5,1);

CREATE TABLE Roles (
ID INT IDENTITY PRIMARY KEY,
RoleName VARCHAR(100),
RoleDescription VARCHAR(255)
);
INSERT INTO Roles (RoleName,RoleDescription) VALUES
('Owner','Owner of the Establishment.'),
('Manager','Manages the Establishment in lieu of the Owner.'),
('Thief','Literally stole the Establishment. Literally.');

CREATE TABLE Users (
ID INT IDENTITY PRIMARY KEY,
UserName VARCHAR(50),
RoleID INT,
TavernID INT,
Password VARCHAR(255)
);
ALTER TABLE [Users] ADD CONSTRAINT FK_Users_Roles FOREIGN KEY ([RoleID]) REFERENCES [Roles]([ID]) ON DELETE CASCADE;
ALTER TABLE [Users] ADD CONSTRAINT FK_Users_Taverns FOREIGN KEY ([TavernID]) REFERENCES [Taverns]([ID]) ON DELETE CASCADE;

INSERT INTO Users (UserName, RoleID, TavernID) VALUES
('Moe',1,1),
('Joe',1,2),
('JHVH',2,3),
('Adam Savage',1,4),
('Ned',3,5);


CREATE TABLE Supplies (
ID INT IDENTITY PRIMARY KEY,
SupplyName VARCHAR(100),
Units VARCHAR(20),
Price MONEY
);
INSERT INTO Supplies (SupplyName, Units, Price) VALUES
('Rat Poison','Ounce',14.71),
('Ale','Barrel',20.50),
('Turkey','Giant Legs',2.00),
('Chair','Chair',100.00),
('Kender Repellent','Orc',4.82);

CREATE TABLE Inventory (
SupplyID INT FOREIGN KEY REFERENCES Supplies(ID) ON DELETE CASCADE,
TavernID INT FOREIGN KEY REFERENCES Taverns(ID) ON DELETE CASCADE,
DateUpdated DATETIME DEFAULT CURRENT_TIMESTAMP,
Quantity INT,
PRIMARY KEY (SupplyID, TavernID)
);
INSERT INTO Inventory (SupplyID, TavernID, Quantity, DateUpdated) VALUES
(1,1,2,DEFAULT),
(2,1,5,'20180925 10:10:10AM'),
(3,1,25,DEFAULT),
(4,1,1,'20180925 10:10:10AM'),
(5,1,2,'20180924 12:01:40AM'),
(1,2,1,DEFAULT),
(2,2,5,DEFAULT),
(3,2,10,DEFAULT),
(4,2,1,'20000404 04:15:23PM'),
(1,3,1,DEFAULT),
(5,3,5,DEFAULT),
(4,4,4,'20040404 04:04:04AM'),
(2,5,20,DEFAULT);


CREATE TABLE Invoices (
ID INT IDENTITY PRIMARY KEY,
TavernID INT FOREIGN KEY REFERENCES Taverns(ID) ON DELETE CASCADE,
ShipmentDate DATETIME DEFAULT GETDATE()
);
INSERT INTO Invoices (TavernID, ShipmentDate) VALUES
(1,DEFAULT),
(3,'20181001 02:10:13PM'),
(4,'20170327 12:51:00PM'),
(5,DEFAULT);

CREATE TABLE LineItems (
SupplyID INT FOREIGN KEY REFERENCES Supplies(ID) ON DELETE CASCADE,
Quantity INT,
InvoiceID INT FOREIGN KEY REFERENCES Invoices(ID) ON DELETE CASCADE,
Price MONEY,
PRIMARY KEY (SupplyID,InvoiceID)
);
INSERT INTO LineItems (SupplyID, Quantity, InvoiceID, Price) VALUES
(1,1,1,14.71),
(1,3,3,15.27),
(2,5,4,20.50),
(3,10,1,2.00),
(4,4,4,100.00),
(5,2,2,4.82);

CREATE TABLE ServiceStatus (
ID INT IDENTITY PRIMARY KEY,
StatusName VARCHAR(100)
);
INSERT INTO ServiceStatus (StatusName) VALUES
('Active'),
('Inactive'),
('Discontinued'),
('On Sale');


CREATE TABLE TavernServices (
ID INT IDENTITY PRIMARY KEY,
ServiceName VARCHAR(100),
ServiceStatus INT DEFAULT 1 FOREIGN KEY REFERENCES ServiceStatus(ID) ON DELETE CASCADE
);
INSERT INTO TavernServices (ServiceName,ServiceStatus) VALUES
('Food and a Room',DEFAULT),
('Just Food',DEFAULT),
('Just a Room',2),
('Drinks',DEFAULT),
('Being Hauled to your room after passing out drunk',3),
('Plastic Jug of Vodka',4);

CREATE TABLE Classes (
ID INT IDENTITY PRIMARY KEY,
ClassName varchar(100)
);
INSERT INTO Classes (ClassName) VALUES
('Fighter'),
('Mage'),
('Thief'),
('Cleric'),
('Vagabond'),
('Pastry Chef'),
('Death Metal Bard');

CREATE TABLE Guests (
ID INT IDENTITY PRIMARY KEY,
GuestName VARCHAR(100),
GuestStatus varchar(50),
Birthday datetime,
Cakeday datetime,
VIP BIT
);

INSERT INTO Guests (GuestName, GuestStatus, VIP, Birthday, Cakeday) VALUES
('Norbert Furrywinkle','Content',0,'20001001 02:10:13PM','20001002 02:10:13PM'),
('Frederick von Richmanz','Bummed out',1,'19810501 02:10:13PM','19810501 02:10:13PM'),
('Adon Noomerhoffen','Pompous',0,'19581104 02:10:13PM','19591104 02:10:13PM'),
('Anonymous Drunk','Drunk, duh?',0,'20111111 02:10:13PM','20111111 02:10:13PM'),
('Definitely not Gandolf','Wizarding',1,'19750101 02:10:13PM','19750101 02:10:13PM');

CREATE TABLE InventorySales (
InventorySalesID INT IDENTITY PRIMARY KEY,
SupplyID INT FOREIGN KEY REFERENCES Supplies(ID) ON DELETE CASCADE,
TavernID INT FOREIGN KEY REFERENCES Taverns(ID) ON DELETE CASCADE,
SoldTo INT FOREIGN KEY REFERENCES Guests(ID) ON DELETE CASCADE,
DateOfSale DATETIME DEFAULT CURRENT_TIMESTAMP,
Quantity INT,
Price money
);

CREATE TABLE GuestsClasses (
GuestID int FOREIGN KEY REFERENCES Guests(ID) ON DELETE CASCADE,
GuestClass int FOREIGN KEY REFERENCES Classes(ID) ON DELETE CASCADE,
GuestLevel int,
PRIMARY KEY (GuestId, GuestClass));

INSERT INTO GuestsClasses (GuestID, GuestClass, GuestLevel) VALUES
(1,1,1),
(1,3,1),
(2,7,4),
(3,4,2),
(3,6,5),
(4,5,10),
(5,3,9001),
(5,4,500),
(5,6,1000),
(5,5,2000);

CREATE TABLE ServiceSales (
ID INT IDENTITY PRIMARY KEY,
ServiceID INT FOREIGN KEY REFERENCES TavernServices(ID) ON DELETE CASCADE,
GuestID INT FOREIGN KEY REFERENCES Guests(ID) ON DELETE CASCADE,
Quantity INT,
TavernID INT FOREIGN KEY REFERENCES Taverns(ID) ON DELETE CASCADE,
Price MONEY,
PurchaseDate DATETIME DEFAULT CURRENT_TIMESTAMP,
);
INSERT INTO ServiceSales (ServiceID, GuestID, Quantity, TavernID, Price, PurchaseDate) VALUES
(1,1,1,1,51.00,DEFAULT),
(2,3,4,2,20.17,DEFAULT),
(4,5,50,3,110.00,'20171004 11:42:00PM'),
(4,5,30,5,60.00,'20171004 11:42:00PM'),
(6,5,1,4,2.70,'20180915 11:43:00PM'),
(1,1,1,1,1.00,'20180901 01:00:00AM'),
(5,5,1,4,985.00,'20181002 11:53:00PM');

UPDATE TavernServices
SET ServiceName = 'Wooden tub of Vodka'
WHERE ServiceName like 'Plastic Jug of Vodka';
GO

CREATE TABLE Rooms (
ID INT IDENTITY PRIMARY KEY,
RoomName VARCHAR(100) DEFAULT 'Unnamed Room' NOT NULL,
RoomStatus BIT NOT NULL,
TavernID INT FOREIGN KEY REFERENCES Taverns(ID) ON DELETE CASCADE NOT NULL,
DailyRate MONEY NOT NULL
);
INSERT INTO Rooms (RoomName, RoomStatus, TavernID, DailyRate) VALUES
('King''s Quarters',0,1,1100.00),
('Jester''s Roost',1,1,185.00),
('Haystack in the Barn',1,1,15.00),
(DEFAULT,1,1,85.00),
(DEFAULT,1,2,105.00),
(DEFAULT,1,3,95.00),
(DEFAULT,1,4,75.00),
(DEFAULT,1,5,65.00),
('The Root Cellar',1,2,25.00),
('Literally a dungeon',1,1,00.50),
(DEFAULT,1,1,105.00);

CREATE TABLE RoomStays (
ID INT IDENTITY PRIMARY KEY,
BookingDate DATETIME DEFAULT GetDate() NOT NULL,
GuestID INT FOREIGN KEY REFERENCES Guests(ID) NOT NULL,
RoomID INT FOREIGN KEY REFERENCES Rooms(ID) ON DELETE CASCADE NOT NULL,
StayDateStart DATETIME default GetDate() NOT NULL,
StayLength INT NOT NULL,
DailyRate MONEY NOT NULL
);
INSERT INTO RoomStays (GuestID, RoomID, StayLength, DailyRate) VALUES
(1,1,5,1100.00),
(2,2,1,185.00),
(3,2,2,370.00),
(4,10,8124,4112.00),
(5,11,1,105.00),
(1,8,1,65.00);
GO
