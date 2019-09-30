CREATE PROCEDURE SupplySale
@tavId int, 
@supply int,
@amount int
AS
begin
insert into db2_sales (supplyId, tavernid,guestid, price, amount, date)
values (@supply,@tavid,1,9999,@amount,'20190926');
end

