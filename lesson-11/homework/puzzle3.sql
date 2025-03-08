
-- ==============================================================
--                          Puzzle 3 DDL
-- ==============================================================
drop table if exists worklog;
CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

-- Task:
-- 1. Create a view vw_MonthlyWorkSummary that calculates:
    -- EmployeeID, EmployeeName, Department, TotalHoursWorked (SUM of hours per employee).
    -- Department, TotalHoursDepartment (SUM of all hours per department).
    -- Department, AvgHoursDepartment (AVG hours worked per department).

CREATE VIEW vw_MonthlyWorkSummary AS
SELECT  EmployeeID, 
        EmployeeName, 
        Department, 
        Sum(HoursWorked) TotalHoursWorked,
        (SELECT SUM(HoursWorked) FROM WorkLog w2 WHERE w2.Department = w1.Department) AS TotalHoursDepartment,
        (SELECT AVG(HoursWorked) FROM WorkLog w2 WHERE w2.Department = w1.Department) AS AvgHoursDepartment
from WorkLog w1
group by EmployeeID, 
        EmployeeName,
        Department;

-- 2. Retrieve all records from vw_MonthlyWorkSummary.
select * from vw_MonthlyWorkSummary;