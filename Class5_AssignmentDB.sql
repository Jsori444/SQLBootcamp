-- USE DATABASE --
use JPeck_2019

-- CREATE TABLES --
-------------------

drop table if exists 
	DB2_Classes,
	DB2_Class,
	DB2_BasementRats,
	DB2_SuppliesRcvd,
	DB2_RoomStays,
	DB2_Sales, 
	DB2_Guests,
	DB2_GuestStatus,
	DB2_TavernStock, 
	DB2_Rooms,
	DB2_RoomStatus,
	DB2_Taverns, 
	DB2_Supplies, 
	DB2_Services,
	DB2_ServiceStatus,
	DB2_Users,
	DB2_Location,
	DB2_Roles;
	
create table DB2_Users(
	userId int primary key identity(1,1), -- PK, Identity
	Name varchar(250), 
	RoleId int -- foreign DB2_Roles.Id
);

create table DB2_Taverns(	
	TavernId int primary key, -- PK
	name varchar(200),
	info varchar(max),
	LocationId int, -- foreign key references DB2_location(locationId), -- taverns are located at
	OwnerId int -- foreign DB2_Users.userID
	
);

create table DB2_Location(
	locationId int primary key, -- PK
	Name Varchar(250)
);

create table DB2_Roles(
	Id int primary key, -- PK
	Name varchar(50), 
	Description varchar(max) 
);

create table DB2_BasementRats(
	ratId int primary key identity(1,1), -- PK
	name varchar(100), 
	TavernId int -- foreign DB2_Taverns.TavernId 
);

create table DB2_Sales(
	saleId int primary key identity(1,1), -- PK
	supplyId int, -- foreign DB2_Supplies.supplyID
	tavernId int, -- foreign DB2_taverns.tavernId
	guestId int, -- foreign DB2_Guests.guestId
	price float,
	amount float,
	date date
);

create table DB2_Supplies(
	supplyID int primary key, -- PK
	name varchar(100),
	type varchar(100),
	unitSize varchar(30),
	serviceId int
);

create table DB2_TavernStock(
	stockId int primary key, -- PK
	TavernId int, -- foreign DB2_Taverns.tavernId
	SupplyId int, -- foreign DB2_Supplies.supplyID
	units float
);
create table DB2_SuppliesRcvd(
	rcvdId int, -- identity(1,1) primary key,
	supplyId int, -- foreign DB2_Supplies.supplyID
	tavernId int, -- foreign DB2_Taverns.tavernId
	cost float,
	amount float,
	date date
);

create table DB2_Services(
	serviceID int primary key, -- PK
	name varchar(100),
	type varchar(50),
	statusId int -- foreign DB2_ServiceStatus.statusId
);

create table DB2_ServiceStatus(
	statusID int primary key, -- PK
	status varchar(100)
);

create table DB2_Guests(
	guestId int primary key, --PK
	name varchar(250),
	notes varchar(max),
	birthday date, 
	cakeday date, 
	statusID int -- foreign DB2_GuestStatus.statusID
);

create table DB2_GuestStatus(
	statusId int primary key, -- PK
	status varchar(50)
);

create table DB2_Class( 
	guestId int, -- foreign DB2_guests.guestId
	classid int, -- PK
	level int, -- PK
	primary key (classid,level)
);

create table DB2_Classes(
	classId int primary key,
	name varchar(50)
);

create table DB2_Rooms(
	roomId int primary key identity(1,1),
	name varchar(200),
	roomNum tinyint,
	price float,
	statusId int, -- foreign
	tavernId int -- foreign
);

create table DB2_RoomStatus(
	statusId int primary key,
	status varchar(200)
);

create table DB2_RoomStays(
	stayId int primary key identity(1,1),
	roomId int, -- foreign 
	saleId int, -- foreign
	guestId int, -- foreign
	date date,
	rate float
);

-- ALTER TABLES - ADD FOREIGN KEYS --
---------------------------------------------

---- add foreign keys ----
alter table DB2_Users add foreign key (roleId) references DB2_Roles(Id);
alter table DB2_Taverns add foreign key (LocationId) references DB2_location(locationId);
alter table DB2_Taverns add foreign key (OwnerId) references DB2_Users(userId);
alter table DB2_BasementRats add foreign key (tavernId) references DB2_Taverns(tavernId);
alter table DB2_Sales add foreign key (supplyId) references DB2_Supplies(supplyId);
alter table DB2_Sales add foreign key (tavernId) references DB2_taverns(tavernId);
alter table DB2_Sales add foreign key (guestId) references DB2_Guests(guestId);
alter table DB2_TavernStock add foreign key (tavernId) references DB2_Taverns(tavernId);
alter table DB2_TavernStock add foreign key (supplyId) references DB2_supplies(supplyId);
alter table DB2_SuppliesRcvd add foreign key (supplyId) references DB2_Supplies(SupplyId);
alter table DB2_SuppliesRcvd add foreign key (tavernId) references DB2_Taverns(tavernId);
alter table DB2_Services add foreign key (statusId) references DB2_serviceStatus(statusId);
alter table DB2_Guests add foreign key (guestId) references DB2_GuestStatus(statusId);
alter table DB2_Class add foreign key (guestId) references DB2_guests(guestId);



-- INSERT SEED DATA --
----------------------


insert into DB2_Roles(Id, Name,	Description)
values
(1, 'Manager', 'Takes care of things with a vengence'),
(2, 'Bar Keep', 'Gets people drunk... with a vengence'),
(3, 'Tavern Wench', 'Takes abuse from customers and wards off unwanted advances from drunken customers'),
(5, 'Admin', 'Keeper of passwords'),
(4, 'Bouncer', 'Roughs up customers and throws the into the street... with a vengence');


insert into DB2_Users(Name, RoleId)
values
('Leroy Brown', 1),
('Stan The Man', 1),
('Slick Rick', 4),
('Fat Neck Peck', 3),
('Evan Penn', 5),
('Francis', 5)
;

insert into DB2_Location(locationId, Name) 
values
(1,'123 Fake St.'),
(2,'11 Kunkle Way'),
(3,'007 Secret Dr.'),
(4,'Under a bridge'),
(5,'29  Arlington Ave.');

insert into DB2_Taverns(TavernId, Name, info, LocationId, OwnerId)
values
(1,'The Stinky Winky','Smelly place.. smells so bad that people keep one eye closed', 2, 2),
(2,'Pickle Pickle','All the food, drinks and staff taste like pickles', 3, 4),
(3,'Super Duper','Super hero hangout', 1, 1),
(4,'Fancy Lancy','Big money, no whammy', 4, 3),
(5,'Sticky Wicket','The entire establishment is cleaned each night but mysteriously each morning when the staff arrives everything is sticky again', 5, 6),
(6,'Cheers','A place where everybody knows your name... Creepy to the max. They know your name even if you have never been there.', 4, 5)
;

insert into  DB2_BasementRats(name, TavernId)
values
('Rick the rat', 2),
('Tea Whyte', 1),
('Catrin Baldwin',5),
('Olaf Traynor',5),
('Mae Mair', 5),
('Bryony Erickson', 1)
;

insert into DB2_Supplies(supplyID, name, type,	unitSize, serviceId)
values
(1, 'Mutton', 'Food', 'Slab', 200),
(2, 'Mead', 'Beverage', 'Ounce', 301),
(3, 'Pool Cue', 'Entertainment', 'Cue', 100),
(4, 'Whiskey', 'Beverage', 'Ounce', 101),
(5, 'Club', 'Security', null, 300),
(6, 'Dart Board', 'Entertainment', 'Board', 200),
(7, 'Wine', 'Beverage', 'Ounce', 100)
;

insert into DB2_GuestStatus(statusId, status)
values
(1,'Healthy'),
(2,'Dead'),
(3,'Bad Credit'),
(4,'Undead'),
(5,'Almost Undead'),
(6,'Healing'),
(7,'Drunk'),
(8,'Exceptionally Drunk')
;

insert into DB2_Guests(guestId,name,notes,birthday,cakeday,statusId)
values
(1,'Richard','This guy is the guy','19261026','20191222',7),
(2,'Pam','Nothing to say','17551015','20190422',1),
(3,'Leroy','Related to Corn Pop','19360630','19250502',2),
(4,'Stan','Junior','20011217','20190417',8),
(5,'Prichard','Puts the P in Richard','19550408','18990211',3),
(6,'Manza','','08550226','09580510',1),
(7,'Vesti','Smells funny, probably undead','20171122','20171122',4)
;

insert into DB2_Classes(classId, name)
values
(1,'Mage'),
(2,'Theif'),
(3,'Drunk'),
(4,'Archer'),
(5,'Fighter'),
(6,'Lover'),
(7,'Fool'),
(8,'Monk'),
(9,'Fighter')
;

insert into DB2_Class(guestId, classid, level)
values
(1, 1, 2),
(3, 2, 5),
(4, 5, 10),
(2, 6, 1),
(5, 4, 9),
(5, 6, 2),
(6, 9, 6),
(7, 8, 1),
(4, 3, 5)
;

insert into  DB2_Sales(supplyId, tavernId, guestId, price, amount)
values
(1, 1, 1, 20.0, 1.5),
(1,2,2,15.5,2.3),
(2,5,1,10,2),
(7,5,3,0.5,3),
(6,3,5,6,7),
(1,1,1,33.6,2.2),
(5,5,2,1,100),
(1,2,3,6,65),
(4,2,4,2.33,2),
(1,4,5,5,2000),
(1,4,2,0.6,20),
(3,4,1,3,15.5),
(3,1,4,5,542),
(1,2,4,1,80),
(4,1,1,106,2.57)
;

insert into DB2_TavernStock(StockId,TavernId,SupplyId,units)
values
(1,1,1,15),
(2,1,2,55.6),
(3,2,3,2),
(4,2,4,10.3),
(5,3,4,20),
(6,4,5,1),
(7,3,2,10.9),
(8,5,1,2),
(9,6,2,22.5)
;

insert into  DB2_SuppliesRcvd(supplyId, tavernId, cost, amount, date)
values
(1,2,12,10,'10/11/2001'),
(2,2,4,2,'8/22/2002'),
(2,4,3.5,22,'9/20/2011'),
(4,5,6,7.8,'9/10/2011'),
(5,6,22.99,10,'9/20/2011')
;

insert into  DB2_ServiceStatus(statusId, status)
values
(1, 'Active'),
(2, 'Not-Active'),
(3, 'Awaiting Repair'),
(4, 'Discontinued'),
(5, 'Coming Soon')
;

insert into  DB2_Services(serviceId, name, type, statusId)
values
(100,'Pool', 'Entertainment', 1),
(200,'Weapon Sharpening', 'Fighting', 1),
(101,'Live Music', 'Entertainment', 2),
(300,'Bath', 'Hospitality', 4),
(301,'Bed','Hospitality', 3)
;

insert into DB2_RoomStatus(statusId, status)
values
(1,'Vacant'),
(2,'Occupied'),
(3,'Being Cleaned'),
(4,'Under Repair'),
(5,'Haunted')
;

insert into DB2_Rooms(name, roomNum,statusId,tavernId,price)
values
('Big Room', 10, 1, 1, 100),
('Empirial Suite', 1, 2, 3, 22.50),
('', 6, 4, 4, 99.99),
('', 7, 5, 5, 47.80),
('', 5, 1, 1, 25),
('Room with a view', 2, 2, 3, 252),
('Always the Cheapest Room', 99, 1, 1, 1000)
;

insert into DB2_RoomStays(roomId, saleId, guestId, date, rate)
values 
(1, 3, 5, '20190420', 10.5),
(3, 1, 1, '20190401', 33),
(3, 2, 2, '20181120', 10.5),
(2, 2, 6, '20191220', 100),
(5, 5, 1, '20170420', 99.99),
(5, 3, 5, '20181225', 100)
;


