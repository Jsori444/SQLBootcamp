-- 1.	Write a query to return users who have admin roles
	-- JOIN
	-- select db2_users.name as 'User', db2_roles.name as 'Role' from db2_users inner join db2_roles on db2_users.roleid = db2_roles.id
	-- WHERE
	select db2_users.name as 'Admininstrators' from db2_users 
		where db2_users.roleid = (
			select db2_roles.id from db2_roles 
			where db2_roles.name like 'Admin')

-- 2.	Write a query to return users who have admin roles and information about their taverns
	select 
		db2_users.name as 'Admins', db2_taverns.name as 'Tavern', db2_taverns.info as 'Tavern Info' 
		from db2_users inner join db2_taverns 
		on db2_users.userid = db2_taverns.ownerid where db2_users.roleid = (select db2_roles.id from db2_roles where db2_roles.name like 'Admin')

-- 3.	Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels
	select db2_guests.name, db2_classes.name, db2_class.level from db2_guests
		inner join db2_class on db2_guests.guestId = db2_Class.guestId 
		inner join db2_classes on db2_class.classid = db2_classes.classid
			order by db2_guests.name

-- 4.	Write a query that returns the top 10 sales in terms of sales price and what the services were
	select top 10 db2_sales.price as 'Sale Price', DB2_Services.name as 'Service' from db2_sales 
		inner join DB2_Supplies on db2_sales.supplyId = DB2_Supplies.supplyID
		inner join DB2_Services on DB2_Supplies.serviceId = DB2_Services.serviceID

-- 5.	Write a query that returns guests with 2 or more classes
	select guestId from db2_class group by guestId having count(*) >1
	select db2_guests.name from db2_guests 
		inner join  db2_class on db2_class.guestId = db2_guests.guestId 
		where db2_class.guestid 
			in (select guestId from db2_class  group by guestId having count(*) >1)

-- 6.	Write a query that returns guests with 2 or more classes with levels higher than 5
	select db2_guests.name from db2_guests
		inner join  db2_class on db2_class.guestId = db2_guests.guestId 
		where db2_class.guestid 
			in (select guestId from db2_class  group by guestId having count(*) >1)

-- 7.	Write a query that returns guests with ONLY their highest level class
-- STILL NEEDS WORK
	select db2_guests.name, tbl.maxLvl from db2_guests 
	inner join (
		select db2_class.guestId, db2_guests.name, max(db2_class.level) as maxLvl
		from db2_class 
			inner join db2_guests on db2_guests.guestId = db2_class.guestId 
			inner join db2_classes on db2_classes.classId = db2_class.classId
			group by db2_class.guestId, DB2_Guests.name
		)  tbl on tbl.guestId = DB2_Guests.guestId 

-- 8.	Write a query that returns guests that stay within a date range. 
--		Please remember that guests can stay for more than one night AND not all of the dates they stay have to be in that range (just some of them)
	select db2_guests.name as 'Guests between 1-2018 - 5-2019' from db2_guests 
	inner join (select * from DB2_RoomStays where date between '20180101' and '20190501') btw
		on db2_guests.guestId = btw.guestId
		group by db2_guests.name

-- 9.	Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it.

	SELECT 
	CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece 
	FROM INFORMATION_SCHEMA.TABLES
	 WHERE TABLE_NAME = 'Db2_Taverns'
	UNION ALL
	SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, 
	(
		CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL 
		Then CONCAT
			('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') 
		Else '' 
		END)
	, 
		CASE WHEN refConst.CONSTRAINT_NAME IS NOT NULL
		Then 
			(CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')')) 
		Else '' 
		END
	, 
	',') as queryPiece FROM 
	INFORMATION_SCHEMA.COLUMNS as cols
	LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys ON 
	(keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME)
	LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst ON 
	(refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME)
	LEFT JOIN 
	(SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME 
	FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys 
	ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME)
	 WHERE cols.TABLE_NAME = 'Db2_Taverns'
	UNION ALL
	SELECT ')'; 
