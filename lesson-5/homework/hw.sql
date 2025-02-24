drop table if exists employees;

create table employees(
    employeeid int,
    name varchar(50),
    department varchar(50),
    salary decimal (10, 2),
    hiredate date
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate)  
VALUES  
    -- IT Department  
    (1, 'Alice Johnson', 'IT', 75000.50, '2015-06-12'),  
    (2, 'Ethan Carter', 'IT', 81000.00, '2017-08-21'),  
    (3, 'Sophia Miller', 'IT', 92000.75, '2013-05-15'),  

    -- HR Department  
    (4, 'Bob Smith', 'HR', 62000.00, '2018-09-25'),  
    (5, 'Olivia White', 'HR', 65500.30, '2019-12-10'),  
    (6, 'Liam Harris', 'HR', 69000.80, '2016-07-18'),  

    -- Finance Department  
    (7, 'Charlie Brown', 'Finance', 89000.75, '2012-03-10'),  
    (8, 'Ava Thomas', 'Finance', 94500.20, '2014-11-22'),  
    (9, 'Noah Wilson', 'Finance', 97000.50, '2011-09-30'),  

    -- Marketing Department  
    (10, 'David Williams', 'Marketing', 54000.30, '2020-11-05'),  
    (11, 'Mia Johnson', 'Marketing', 57000.60, '2021-06-14'),  
    (12, 'Lucas Scott', 'Marketing', 60000.90, '2018-03-27'),  

    -- Sales Department  
    (13, 'Emma Davis', 'Sales', 97000.20, '2010-07-19'),  
    (14, 'James Anderson', 'Sales', 88500.40, '2013-10-29'),  
    (15, 'Amelia Robinson', 'Sales', 91500.10, '2012-12-15');  


-- task1
SELECT 
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS SalaryRank,
    EmployeeID, 
    Name, 
    Department
FROM Employees;


-- task2

WITH RankedEmployees AS (
    SELECT 
        EmployeeID, 
        Name, 
        Department, 
        Salary, 
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
)
SELECT * 
FROM RankedEmployees
WHERE SalaryRank IN (
    SELECT SalaryRank 
    FROM RankedEmployees 
    GROUP BY SalaryRank 
    HAVING COUNT(*) > 1
);


--task3
with RankedEmployees as(
SELECT *,
       ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
from employees
)
select * from RankedEmployees where SalaryRank <= 2;

--task4

SELECT * 
FROM (
    SELECT *, 
           RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank
    FROM Employees
) t
WHERE SalaryRank = 1;


--task5

SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary, 
    SUM(Salary) OVER (PARTITION BY Department ORDER BY hiredate ASC) AS RunningTotal
FROM Employees
order by department, hiredate;


--task6

select *, sum(salary) over(PARTITION by department) as total_salary
from employees;

--task7


select *, avg(salary) over(PARTITION by department) as total_salary
from employees;

--task8

select *, salary - (avg(salary) over(PARTITION by department)) as salary_difference
from employees;

--task9
select *, avg(salary) over(order by hiredate rows between 1 preceding and 1 following) as moving_average_salary
from employees
order by hiredate;

--task10
SELECT SUM(salary) 
FROM (
    SELECT top 3 salary 
    FROM employees 
    ORDER BY hiredate DESC 

) AS last_three;

--task11

select *, avg(salary) over(order by hiredate rows between unbounded preceding and current row) as running_avg_salary
from employees
order by hiredate;

--task12

select *, max(salary) over (order by hiredate rows between 2 preceding and 2 following) as  max_sal_window
from employees
order by hiredate;

--task13

select *, cast(100 * salary / (sum(salary) over(PARTITION BY department)) as decimal(4, 2)) as percent_contrib
from employees order by department;
