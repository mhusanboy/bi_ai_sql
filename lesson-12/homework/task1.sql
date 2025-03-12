-- Task 1:

-- Write an SQL query to retrieve the database name, schema name, table name, column name, 
-- and column data type for all tables across all databases in a SQL Server instance. 
-- Ensure that system databases (master, tempdb, model, msdb) are excluded from the results.





declare @name varchar(255);
declare @i int = 1;
declare @count int;

select @count = count(1)
from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb');
declare @result_table table(
	DatabaseName nvarchar(255),
	SchemaName NVARCHAR(255),
	TableName NVARCHAR(255),
	ColumnName NVARCHAR(255),
	DataType NVARCHAR(63)
);

while @i <= @count
BEGIN
    with cte as (
		select name, ROW_NUMBER() OVER(order BY name) as rn
		from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')
	)
	select @name=name from cte
	where rn = @i;

	declare @query nvarchar(max)
	set @query = 'select 
				TABLE_CATALOG as DatabaseName,
				TABLE_SCHEMA as SchemaName,
				TABLE_NAME as TableName,
				COLUMN_NAME as ColumnName,
				concat(
					DATA_TYPE,''(''+ 
						case when CHARACTER_MAXIMUM_LENGTH = -1
						then ''max''
						else cast(CHARACTER_MAXIMUM_LENGTH as varchar) end
					+'')''
				) as DataType
				from' +  quoteName(@name) + '.INFORMATION_SCHEMA.COLUMNS';
	
	insert into @result_table
	EXEC(@query)
	set @i = @i + 1;
END;

select * from @result_table;