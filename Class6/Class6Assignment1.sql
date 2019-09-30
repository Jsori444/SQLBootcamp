use JPeck_2019
go

-- 1.	Write a stored procedure that takes a class name and returns all guests that have any levels of that class
drop procedure if exists GetGuestsWithClass
go

create procedure GetGuestsWithClass
@cname varchar(100)
as
begin
select g.name from db2_classes cs 
join db2_class c on cs.classid = c.classid
join db2_guests g on c.guestId = g.guestid
where cs.name like @cname 
end
go

Exec GetGuestsWithClass @cname = 'Lover'
go 

-- 2.	Write a stored procedure that takes a guest id and returns the total that guest spent on services
drop procedure if exists GetTotalSalesForGuestID
go 

create procedure GetTotalSalesForGuestID
@gid int
as 
begin
select concat('$',cast(cast(sum(price) as Money) as varchar)) as 'Total Sales for Guest ID' 
	from db2_sales 
	where guestid = @gid
end
go

exec GetTotalSalesForGuestID
@gid = 2
go

-- 3.	Write a stored procedure that takes a level and an optional argument that determines whether the procedure returns guests of that level and higher or that level and lower
	-- args: level, higher/lower
drop procedure if exists GetLevelHigherLower
go
create procedure GetLevelHigherLower
@lvl int, @hiLow bit -- 0 = low, 1 = high
as 
begin
declare @where varchar(max)
if (@hiLow = 0)
	begin
		set @where = 'level <= ' + @lvl
	end
	else
	begin
		set @where = 'level >= ' + @lvl
	end
select db2_guests.name from db2_guests
/*join db2_class on db2_class.guestid = db2_guests.guestid where @where*/
end
go


exec GetLevelHigherLower
	@lvl =1, @hiLow = 0
go

exec GetLevelHigherLower
	@lvl =1, @hiLow = 1
go
-- 4.	Write a stored procedure that deletes a Tavern ( don’t run it yet or rollback your transaction if you do )
drop procedure if exists DeleteTavern
go
create procedure DeleteTavern
@TavernId int
as 
begin
delete from DB2_Taverns where db2_taverns.TavernId = @TavernId
end
go

-- 5.	Write a trigger that watches for deleted taverns and use it to remove taverns, supplies, rooms, and services tied to it
drop trigger if exists DelTavernTrigger
go
create trigger DelTavernTrigger
on dbo.db2_Taverns
after delete
as begin
declare @tid int
select @tid = tavernid from deleted
delete from DB2_rooms where tavernId = @tid
delete from DB2_TavernStock where TavernId = @tid
end
go

exec DeleteTavern @tavernId = 3

-- 6.	Write a stored procedure that uses the function from the last assignment that returns open rooms with their prices, 
	--  and automatically book the lowest price room with a guest for one day
drop procedure if exists BookLowestRoom
go
create procedure BookLowestRoom
@d date--, @g int
as begin
declare @r int
declare @rt float
select @r = roomId, @rt = min(rate) from DB2_RoomStays 
where roomID in (
select RoomId from dbo.getOpenRoomsByDay(@d))
group by roomId
insert into DB2_RoomStays(roomid,saleid,guestid,date,rate)
values(@r,2,3,@d,@rt)
end
go

exec BookLowestRoom @d = '12-25-2018'--, @g = 1


-- 7.	Write a trigger that watches for new bookings and adds a new sale for the guest for a service (for free if you can in your schema)
-- Need to change my DB to make this work...
drop trigger if exists InsertBookingTrigger
go
create trigger InsertBookingTrigger
on dbo.db2_RoomStatus
after insert
as begin
select * from db2_sales
end
go 