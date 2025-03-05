--1. Write an SQL statement that counts the consecutive values in the Status field.

--this aproach works even if there are gaps between stepnumbers

select min(StepNumber) as MinStepNumber, max(StepNumber) as MaxStepNumber, status, count(*) as Consecutive_Count
from 
    (select StepNumber, Status, 
        sum(pref_gr) over(order by stepnumber) as group_id
    from 
        (select StepNumber, Status, 
            iif(lag(status, 1, '-') over(order by stepnumber) != Status, 1, 0) as pref_gr
        from Groupings) 
        as t1) 
    as t2
group by group_id, status
order by group_id


--2. Find all the year-based intervals from 1975 up to current when the company did not hire employees


select concat(lag(max_year, 1) over(order by min_year), '-',min_year) as years
from(
    select group_id, min(hire_year) - 1 as min_year, max(hire_year) + 1 as max_year
    from (
        select *, hire_year - ROW_NUMBER() over(order by hire_year) as group_id
        from (
            select 1974 as hire_year
            union all
            select distinct year(hire_date)
            from [dbo].[EMPLOYEES_N]
            where year(hire_date) >= 1975
            union all
            select year(getdate()) + 1
            ) as by_year
        ) as t1
    group by group_id
) as t2
order by min_year 
offset 1 row --first row should not be included!