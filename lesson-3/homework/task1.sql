
-- three tables (employees, orders, products) were created as in ddl statement in the task description.


--1st query
select top 10 percent  * from employees order by salary desc;


--2st query

select department, avg(salary) as AverageSalary from Employees
group by Department;


--3rd query
select *, case 
    when salary > 80000 then 'High'
    when salary >= 50000 then 'Medium'
    else 'Low'
END as SalaryCategory from Employees;

--4th query
select department, avg(salary) as AverageSalary  from employees
group by department order by AverageSalary desc;


--5th query
select * from employees 
order by salary desc
OFFSET 2 ROW FETCH NEXT 5 ROWS ONLY;