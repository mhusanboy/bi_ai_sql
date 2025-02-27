

drop table if exists department;

create TABLE department(
    id int PRIMARY KEY,
    name varchar(50)
);

drop table if exists employee;
create table employee
(
    id int PRIMARY KEY,
    name VARCHAR(50),
    salary int,
    department int FOREIGN KEY references department(id),
    mngr_id int
);


insert into department
VALUES
    (1, 'IT'),
    (2, 'Marketing'),
    (3, 'HR'),
    (4, 'Sales')


insert into employee
VALUES 
    (1, 'Mardon', 50000, 1, NULL),
    (2, 'Iskandar', 40000, 2, 1),
    (3, 'Mirshod', 45000, 1, 1),
    (4, 'Shavkat', 42000, 3, 2);



select 
    e.NAME employeeName, d.name employee_department, m.name managerName, d2.name
from employee e inner join employee m 
    on e.mngr_id = m.id 
    inner join department d
    on e.department = d.id
    INNER JOIN department d2 
    on d2.id = m.department

