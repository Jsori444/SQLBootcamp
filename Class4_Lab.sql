select * from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
select * from INFORMATION_SCHEMA.key_column_usage
select * from information_schema.tables


select
INFORMATION_SCHEMA.key_column_usage.CONSTRAINT_NAME as keys, 
INFORMATION_SCHEMA.key_column_usage.table_name as tbl,
INFORMATION_SCHEMA.key_column_usage.COLUMN_NAME as col,
INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS.constraint_name as refConst
	from INFORMATION_SCHEMA.key_column_usage
left join INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
	on (INFORMATION_SCHEMA.key_column_usage.CONSTRAINT_NAME = INFORMATION_SCHEMA.key_column_usage.CONSTRAINT_NAME)  where table_name like 'DB1_Taverns'
