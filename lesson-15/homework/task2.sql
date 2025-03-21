
--ddl process
drop table if exists items;
go

create table items
(
	ID						varchar(10),
	CurrentQuantity			int,
	QuantityChange   		int,
	ChangeType				varchar(10),
	Change_datetime			datetime
);
go


insert into items values
('A0013', 278,   99 ,   'out', '2020-05-25 0:25'), 
('A0012', 377,   31 ,   'in',  '2020-05-24 22:00'),
('A0011', 346,   1  ,   'out', '2020-05-24 15:01'),
('A0010', 347,   1  ,   'out', '2020-05-23 5:00'),
('A009',  348,   102,   'in',  '2020-04-25 18:00'),
('A008',  246,   43 ,   'in',  '2020-04-25 2:00'),
('A007',  203,   2  ,   'out', '2020-02-25 9:00'),
('A006',  205,   129,   'out', '2020-02-18 7:00'),
('A005',  334,   1  ,   'out', '2020-02-18 6:00'),
('A004',  335,   27 ,   'out', '2020-01-29 5:00'),
('A003',  362,   120,   'in',  '2019-12-31 2:00'),
('A002',  242,   8  ,   'out', '2019-05-22 0:50'),
('A001',  250,   250,   'in',  '2019-05-20 0:45');


-- select * from items;

/*
You should dynamically split into time interval groups by adding +90 days to create new group and 
find the count of items by measuring their age in days considering change types.
For example: 'in' means item arrived in warehouse while 'out' means item exited the warehouse
for each time interval groups. Like: in A001 250 ('2019-05-20 0:45') items intered the warehouse
and in A002 ('2019-05-22 0:50') 8 of them left the warehouse so by that time there are 242 items
with the age of 2 days since they all stayed there at least 2 days. That is how you should calculate
the age of each item.
*/

--======================Expected Output=======================----------
------------------------------------------------------------------------
--||0-90 days old||91-180 days old||181-270 days old||271-365 days old||
--||-------------||---------------||----------------||----------------||
--||   	         || 	          || 	            ||  			  ||
------------------------------------------------------------------------


--======================Expected Output=======================----------------------------
------------------------------------------------------------------------------------------
--||1-90 days old||91-180 days old||181-270 days old||271-360 days old||361-450 days old||
--||-------------||---------------||----------------||----------------||----------------||
--||184	         ||120	          ||27	            ||132			  ||83				||
------------------------------------------------------------------------------------------


drop FUNCTION if EXISTS get_interval;

GO

CREATE FUNCTION get_interval(@i INT)
RETURNS VARCHAR(50)
AS
BEGIN
    if @i = 1
    begin
        return '0-90 days old';
    end;
    
    return concat((@i - 1) * 90 + 1, '-', @i * 90, ' days old');
END;

GO


declare mycursor cursor for 
select *
from items order by Change_datetime;


declare @queue table(
    queue_id varchar(10),
    Quantity int,
    date_added datetime
);

drop table if exists #result;
create table #result(
    interval_id int,
    quantity int
);



declare @CurrentQuantity int;
declare @mx_date datetime = (select max(Change_datetime) from items);
declare @mx_interval int = (DATEDIFF(day, (select min(Change_datetime) from items), @mx_date) + 89) / 90;
declare @id VARCHAR(10);
DECLARE @QuantityChange int;
declare @ChangeType varchar(10);
DECLARE @Change_datetime datetime;
declare @queue_id varchar(10);
declare @quantity int;
declare @date_added datetime;
declare @count int;
declare @interval_id int;
declare @i int = 1;

while @i <= @mx_interval
BEGIN
    insert into #result
    values(@i, 0);
    set @i = @i + 1
end;



open mycursor;

fetch next from mycursor into @id, @CurrentQuantity, @QuantityChange, @ChangeType, @Change_datetime;
while @@FETCH_STATUS = 0
BEGIN
    if @ChangeType = 'out'
    begin 

        while @QuantityChange > 0
        begin 
            select top 1 @queue_id = queue_id, @quantity = quantity, @date_added = date_added
            from @queue order by date_added;

            delete from @queue
            where queue_id = @queue_id;

            if @QuantityChange >= @quantity
            begin
                set @count = @quantity;
                set @QuantityChange = @QuantityChange - @quantity;
            end 
            else 
            begin
                set @count = @QuantityChange;
                set @quantity = @quantity - @QuantityChange;
                set @QuantityChange = 0;

                insert into @queue
                values(@queue_id, @quantity, @date_added);
                
            end;
            set @interval_id = (DATEDIFF(day, @date_added, @Change_datetime) + 89) / 90;

            UPDATE #result 
            set quantity = quantity + @count
            where interval_id = @interval_id;
        end;
    end
    else 
    begin 
        insert into @queue 
        values(@id, @QuantityChange, @Change_datetime);
    end;

    fetch next from mycursor into @id, @CurrentQuantity, @QuantityChange, @ChangeType, @Change_datetime;
end;


close mycursor;
DEALLOCATE mycursor;


declare @intervals nvarchar(max) = (select STRING_AGG(QUOTENAME(dbo.get_interval(interval_id)), ',') from #result);
declare @query nvarchar(max);

set @query = CONCAT(
    'SELECT ', @intervals,
    'FROM (
        SELECT [dbo].[get_interval](interval_id) as interval, quantity FROM #result
    ) AS t
    PIVOT (
        sum(quantity) FOR interval IN (', @intervals,')
    ) AS pvt'
)

exec(@query);