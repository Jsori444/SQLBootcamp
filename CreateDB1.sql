-- USE DATABASE --
use JPeck_2019


-- CREATE TABLES --
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
	Name varchar(250), 
	RoleId int
);

create table DB1_Taverns(Name varchar(250),	
	LocationId int, 
	OwnerId int
);

create table DB1_Location(
	locationId int primary key,
	Name Varchar(250)
);

create table DB1_Roles(
	Id int,
	Name varchar(50),
	Description varchar(max)
);

create table DB1_BasementRats(
	name varchar(100),
	TavernId int
);

create table DB1_Sales(
	supplyId int,
	tavernId int,
	guestId int, 
	price float,
	amount float
);

create table DB1_Supplies(
	supplyID int,
	name varchar(100),
	type varchar(100),
	unitSize varchar(30),
	serviceId int
);

create table DB1_TavernStock(
	TavernId int,
	SupplyId int,
	units float
);
create table DB1_SuppliesRcvd(
	rcvdId int identity(1,1) primary key,
	supplyId int,
	tavernId int,
	cost float,
	amount float,
	date date
);

create table DB1_Services(
	serviceID int,
	name varchar(100),
	type varchar(50),
	statusId int
);

create table DB1_ServiceStatus(
	statusID int,
	status varchar(100)
);

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
