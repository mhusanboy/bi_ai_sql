--1. Given this Employee table below, find the level of depth each employee from the President.
drop table if exists employees;
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);

INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');


with cte as (
    select EmployeeID, ManagerID, JobTitle, 0 as depth from employees where ManagerID is null
    union all 
    select e.EmployeeID, e.ManagerID, e.JobTitle, depth + 1 from employees e
    join cte on cte.EmployeeID = e.ManagerID
)
select * from cte;


--2.Find Factorials up to N

with factorials(Num, Factorial) as(
    select 1, 1
    union ALL
    select Num + 1, Factorial * (Num + 1) 
    from factorials
    where Num < 10
)
select * from factorials;


--3.Find Fibonacci numbers up to  N

with fibonacci(n, Fibonacci_Number, prev) as(
    select 1, 1, 0
    union all 
    select n + 1, Fibonacci_Number + prev, Fibonacci_Number
    from fibonacci
    where n < 10
)
select n, Fibonacci_Number from fibonacci