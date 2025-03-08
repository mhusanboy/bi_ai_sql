-- ==============================================================
--                          Puzzle 1 DDL                         
-- ==============================================================
drop table if exists employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);


--TASKS:
-- Create a temporary table #EmployeeTransfers with the same structure as Employees.
drop table if exists #employeetransfers;
create table #EmployeeTransfers(
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);


-- Swap departments for each employee in a circular manner:
    -- HR → IT → Sales → HR
    -- Example: Alice (HR) moves to IT, Bob (IT) moves to Sales, Charlie (Sales) moves to HR.
--and insert the updated records into #EmployeeTransfers.
Insert INTO #EmployeeTransfers
SELECT 
    EmployeeID,
    Name,
    CASE 
        WHEN Department = 'HR' THEN 'IT'
        WHEN Department = 'IT' THEN 'Sales'
        WHEN Department = 'Sales' THEN 'HR'
        ELSE Department -- Keep others unchanged
    END AS Department,
    Salary
FROM Employees;

-- Retrieve all records from #EmployeeTransfers.
Select * from #EmployeeTransfers;
