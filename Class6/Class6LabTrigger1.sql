drop trigger if exists AddTavernTrigger
go
create trigger AddTavernTrigger
on dbo.db2_sales
after insert
as begin
declare @sid int
declare @tid int
declare @amt float

select @sid = supplyid, @tid = tavernid, @amt = amount
from inserted
update DB2_TavernStock
set units = (select top 1 units from db2_taverns where supplyid = @sid and tavernid = @tid) + @amt
where supplyid = @sid and tavernid = @tid
end
