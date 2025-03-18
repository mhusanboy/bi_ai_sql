
declare @date_i DATE = '2025/03/18';

select datename(weekday, @date_i), datepart(weekday, @date_i)


with cte as(
    select 
        DATEFROMPARTS(YEAR(@date_i), MONTH(@date_i), 1) as date,
        DATEPART(weekday, DATEFROMPARTS(YEAR(@date_i), MONTH(@date_i), 1)) as weekdaynum,
        1 as weeknumber
    union all
    select DATEADD(day, 1, date), 
        DATEPART(weekday, DATEADD(day, 1, date)) as weekdaynum,
        weeknumber + iif(DATEPART(weekday, date) = 7, 1, 0)
    from cte 
    where date < EOMONTH(date)
)
select
    MAX(case when weekdaynum = 1 then DAY(date) end) as Sunday,
    MAX(case when weekdaynum = 2 then DAY(date) end) as Monday,
    MAX(case when weekdaynum = 3 then DAY(date) end) as Tuesday,
    MAX(case when weekdaynum = 4 then DAY(date) end) as Wednesday,
    MAX(case when weekdaynum = 5 then DAY(date) end) as Thursday,
    MAX(case when weekdaynum = 6 then DAY(date) end) as Friday,
    MAX(case when weekdaynum = 7 then DAY(date) end) as Saturday
from cte
group by weeknumber;