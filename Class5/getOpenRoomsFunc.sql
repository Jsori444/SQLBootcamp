use JPeck_2019

if object_id (N'dbo.GetOpenRoomsByDay', N'IF') is not null
	drop function dbo.GetOpenRoomsByDay;
go
create function dbo.GetOpenRoomsByDay(@d date)
	join db2_taverns t on t.TavernId = r.tavernId
	where rs.statusId = 1 and ry.date = @d
)
returns table
return(
	select r.roomNum, r.roomId, t.name from db2_rooms r
	join DB2_RoomStatus rs on r.statusId = rs.statusid
	join db2_roomstays ry on ry.roomId = r.roomId