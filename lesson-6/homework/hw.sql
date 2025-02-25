-- table creation (DDL) process

drop table if EXISTS projects;
drop table if exists employees;
drop table if exists departments;

create table departments(
    departmentId int PRIMARY key IDENTITY(101, 1),
    departmentName varchar(50)
);

create table employees(
    employeeId int PRIMARY KEY IDENTITY(1,1),
    name varchar(50),
    departmentId int FOREIGN KEY REFERENCES departments(departmentid),
    salary decimal(10,2)
);

create table projects(
    projectId int PRIMARY KEY IDENTITY(1,1),
    projectName varchar(50),
    employeeId int FOREIGN KEY REFERENCES employees(employeeId)
);

insert into departments
VALUES ('IT'), ('HR'), ('Finance'), ('Marketing');

insert into employees
VALUES ('Alice', 101, 60000), 
    ('Bob', 102, 70000), 
    ('Charlie', 101, 65000), 
    ('David', 103, 72000),
    ('Eva', NULL, 68000);

insert into projects
VALUES ('Alpha', 1),
    ('Beta', 2),
    ('Gamma', 1),
    ('Delta', 4),
    ('Omega', NULL);


-- TASKS

-- task1

select e.employeeId, e.name as employeeName, d.departmentName 
from employees e INNER JOIN departments d 
    on e.departmentId = d.departmentId;

--task2

SELECT e.employeeId, e.name as employeeName, d.departmentId, d.departmentName
from employees e LEFT JOIN departments d 
    on e.departmentId = d.departmentId;

--task3

SELECT d.departmentId, d.departmentName, e.employeeId, e.name as employeeName
FROM employees e RIGHT JOIN departments d 
    ON e.departmentid = d.departmentId;

--task4
SELECT e.employeeId, e.name as employeeName, d.departmentId, d.departmentName
from employees e full outer JOIN departments d 
    on e.departmentId = d.departmentId;


--task5
SELECT d.departmentId, d.departmentName, IIF(count(salary) > 0, sum(e.salary), 0) as TotalSalary
from departments d LEFT JOIN employees e
    on d.departmentId = e.departmentId
group by d.departmentId, d.departmentName


-- task6
select * from 
employees cross JOIN departments;


--task7
select e.employeeId, e.Name as employeeName, d.departmentName, p.projectName
from employees e LEFT JOIN departments d 
    on e.departmentId = d.departmentId
    LEFT JOIN projects p 
    on e.employeeId = p.employeeId;
    