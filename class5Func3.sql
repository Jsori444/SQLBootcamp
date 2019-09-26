use JPeck_2019

if object_id (N'dbo.class5AssignmentFunc3', N'IF') is not null
	drop function dbo.class5AssignmentFunc3;
go
create function dbo.class5AssignmentFunc3(@d date)
returns table
return(
	select r.roomNum as 'Room Number', 'Date' as 'Date', t.name as 'Tavern' from db2_rooms r
	join DB2_RoomStatus rs on r.statusId = rs.statusid
	join db2_roomstays ry on ry.roomId = r.roomId
	join db2_taverns t on t.TavernId = r.tavernId
	where rs.statusId = 1 and ry.date = @d
)