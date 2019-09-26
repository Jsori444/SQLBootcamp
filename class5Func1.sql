use JPeck_2019

if object_id (N'dbo.class5AssignmentFunc1', N'IF') is not null
	drop function dbo.class5AssignmentFunc1;
go
create function dbo.class5AssignmentFunc1(@lvl int)
		returns varchar(50) as		
		begin
		declare @ranking varchar(50)
			select @ranking = 
			case	
				when @lvl <= 5 then 'Beginner'
				when @lvl < 10 then 'Intermediate'
				when @lvl >= 10 then 'Expert'
				else '???????'
			end
			return @ranking 
		end