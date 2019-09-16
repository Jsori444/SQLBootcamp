-- USE DATABASE --
use JPeck_2019


-- CREATE TABLES --
-------------------

drop table if exists 
	DB1_Users, 
	DB1_Taverns, 
	DB1_Location, 
	DB1_Roles, 
	DB1_BasementRats, 
	DB1_Sales, 
	DB1_Supplies, 
	DB1_TavernStock, 
	DB1_Supplies, 
	DB1_SuppliesRcvd, 
	DB1_Services, 
	DB1_ServiceStatus;

create table DB1_Users(
	userId int, -- PK, Identity
	Name varchar(250), 
	RoleId int -- foreign DB1_Roles.Id
);

create table DB1_Taverns(	
	TavernId int, -- PK
	name varchar(200),
	LocationId int, -- foreign key references DB1_location(locationId), -- taverns are located at
	OwnerId int -- foreign DB1_Users.userID
);

create table DB1_Location(
	locationId int, -- PK
	Name Varchar(250)
);

create table DB1_Roles(
	Id int, -- PK
	Name varchar(50), 
	Description varchar(max) 
);

create table DB1_BasementRats(
	ratId int, -- PK
	name varchar(100), 
	TavernId int -- foreign DB1_Taverns.TavernId 
);

create table DB1_Sales(
	saleId int, -- PK
	supplyId int, -- foreign DB1_Supplies.supplyID
	tavernId int, -- foreign DB1_taverns.tavernId
	guestId int, -- foreign DB1_Guests.guestId
	price float,
	amount float,
	date date
);

create table DB1_Supplies(
	supplyID int, -- PK
	name varchar(100),
	type varchar(100),
	unitSize varchar(30),
	serviceId int
);

create table DB1_TavernStock(
	stockId int, -- PK
	TavernId int, -- foreign DB1_Taverns.tavernId
	SupplyId int, -- foreign DB1_Supplies.supplyID
	units float
);
create table DB1_SuppliesRcvd(
	rcvdId int, -- identity(1,1) primary key,
	supplyId int, -- foreign DB1_Supplies.supplyID
	tavernId int, -- foreign DB1_Taverns.tavernId
	cost float,
	amount float,
	date date
);

create table DB1_Services(
	serviceID int, -- PK
	name varchar(100),
	type varchar(50),
	statusId int -- foreign DB1_ServiceStatus.statusId
);

create table DB1_ServiceStatus(
	statusID int, -- PK
	status varchar(100)
);

create table DB1_Guests(
	guestId int, --PK
	name varchar(250),
	notes varchar(max),
	birthday date, 
	cakeday date, 
	statusID int -- foreign DB1_GuestStatus.statusID
);

create table DB1_GuestStatus(
	statusId int, -- PK
	status varchar(50)
);

create table DB1_Class(
	guestId int, -- foreign DB1_guests.guestId
	class varchar, -- PK
	level int -- PK
);

-- ALTER TABLES - ADD PKs AND FOREIGN KEYS --
---------------------------------------------



---- add primary keys ----
alter table DB1_Users alter column userId int not null;
alter table DB1_Users add primary key (userId);
alter table DB1_Taverns add primary key (TavernId);
alter table DB1_Location add primary key (locationId);
alter table DB1_Roles add primary key (Id);
alter table DB1_BasementRats add primary key (ratId);
alter table DB1_Sales add primary key (salesId);
alter table DB1_Supplies add primary key (supplyId);
alter table DB1_TavernStock add primary key (stockId);
alter table DB1_SuppliesRcvd add primary key (rcvdId);
alter table DB1_Services add primary key (sericeId);
alter table DB1_ServiceStatus add primary key (statusId);
alter table DB1_Guests add primary key (guestId);
alter table DB1_GuestStatus add primary key (statusId);
-- alter table DB1_Class add constraint pk_classLevel (class, level);

---- add foreign keys ----
alter table DB1_Users add foreign key (roleId) references DB1_Roles(Id);
alter table DB1_Taverns add foreign key (LocationId) references DB1_location(locationId);
alter table DB1_Taverns add foreign key (OwnerId) references DB1_Users(userId);
alter table DB1_BasementRats add foreign key (tavernId) references DB1_Taverns(tavernId);
alter table DB1_Sales add foreign key (supplyId) references DB1_Supplies(supplyId);
alter table DB1_Sales add foreign key (tavernId) references DB1_taverns(tavernId);
alter table DB1_Sales add foreign key (guestId) references DB1_Guests(guestId);
alter table DB1_TavernStock add foreign key (tavernId) references DB1_Taverns(tavernId);
alter table DB1_TavernStock add foreign key (supplyId) references DB1_supplies(supplyId);
alter table DB1_SuppliesRcvd add foreign key (supplyId) references DB1_Supplies(SupplyId);
alter table DB1_SuppliesRcvd add foreign key (tavernId) references DB1_Taverns(tavernId);
alter table DB1_Services add foreign key (statusId) references DB1_serviceStatus(statusId);
alter table DB1_Guests add foreign key (guestId) references DB1_GuestStatus(guestId);
alter table DB1_Class add foreign key (guestId) references DB1_guests(guestId);


/*
-- INSERT SEED DATA --
----------------------
insert into DB1_Users(Name, RoleId)
values
('Leroy Brown', 1),
('Stan The Man', 1),
('Fat Neck Peck', 3);

insert into DB1_Taverns(Name, LocationId, OwnerId)
values
('The Stinky Winky', 2, 4),
('Pickle Pickle', 3, 4);

insert into DB1_Location(locationId, Name) 
values
(1,'123 Fake St.'),
(2,'11 Kunkle Way'),
(3,'007 Secret Dr.'),
(4,'Under a bridge'),
(5,'29  Arlington Ave.');

insert into DB1_Roles(Id, Name,	Description)
values
(1, 'Manager', 'Takes care of things with a vengence'),
(2, 'Bar Keep', 'Gets people drunk... with a vengence'),
(3, 'Tavern Wench', 'Takes abuse from customers and wards off unwanted advances from drunken customers'),
(4, 'Bouncer', 'Roughs up customers and throws the into the street... with a vengence');

insert into  DB1_BasementRats(name, TavernId)
values
('Rick', 14);

insert into  DB1_Sales(supplyId, tavernId, guestId, price, amount)
values
(1, 1, 1, 20.0, 1.5),
(1,2,2,15.5,2.3),
(2,5,1,10,2),
(7,5,8,0.5,3),
(6,3,5,6,7),
(3,4,4,6.6,22.22),
(4,6,1,106,2.57)
;

insert into DB1_Supplies(supplyID, name, type,	unitSize, serviceId)
values
(1, 'Mutton', 'Food', 'Slab', 2),
(2, 'Mead', 'Beverage', 'Ounce', 1),
(3, 'Pool Cue', 'Entertainment', 'Cue', 3),
(4, 'Whiskey', 'Beverage', 'Ounce', 2),
(5, 'Club', 'Security', null, null)
;

insert into DB1_TavernStock(TavernId,SupplyId,units)
values
(1,1,15),
(1,2,55.6),
(2,3,2),
(2,4,10.3),
(3,4,20),
(4,5,1),
(3,2,10.9),
(5,1,2),
(6,2,22.5)
;

insert into  DB1_SuppliesRcvd(supplyId, tavernId, cost, amount, date)
values
(1,2,12,10,'10/11/2001'),
(2,2,4,2,'8/22/2002'),
(2,4,3.5,22,'9/20/2011'),
(4,5,6,7.8,'9/10/2011')
;

insert into  DB1_Services(serviceId, name, type, statusId)
values
(100,'Pool', 'Entertainment', 1),
(200,'Weapon Sharpening', 'Fighting', 1),
(101,'Live Music', 'Entertainment', 2),
(300,'Bath', 'Hospitality', 4),
(301,'Bed','Hospitality', 3)
;

insert into  DB1_ServiceStatus(statusId, status)
values
(1, 'Active'),
(2, 'Not-Active'),
(3, 'Awaiting Repair'),
(4, 'Discontinued'),
(5, 'Coming Soon')
;
*/