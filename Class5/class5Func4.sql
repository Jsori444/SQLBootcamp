/*
	FUNCTION TO UNDERCUT THE LOWEST PRICE ROOM IN THE PRICE RANGE
*/

use JPeck_2019

if object_id (N'dbo.class5AssignmentFunc4', N'IF') is not null
	drop function dbo.class5AssignmentFunc4;
go
create function dbo.class5AssignmentFunc4(@minP float, @maxP float)
	returns float 
	begin
	declare @under float
		select @under = min(r.price - 0.01) from DB2_Rooms r
		join DB2_Taverns t on r.tavernId = t.TavernId
		where r.price between @minP and @maxP
	return @under
	end