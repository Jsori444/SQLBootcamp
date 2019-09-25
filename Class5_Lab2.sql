use JPeck_2019

IF OBJECT_ID (N'dbo.class5Lab2', N'IF') IS NOT NULL  
    DROP FUNCTION dbo.class5Lab2;  
GO  
CREATE FUNCTION dbo.class5Lab2 (@supply int)  
RETURNS int  
AS  
BEGIN 
	DECLARE @pr int
	select @pr =  sum(price*2) from DB2_sales
	where supplyid = @supply
	return @pr
end