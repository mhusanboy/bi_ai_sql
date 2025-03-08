
-- ==============================================================
--                          Puzzle 2 DDL
-- ==============================================================
drop table if exists Orders_DB1;
CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

drop table if exists Orders_DB2;
CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);

-- Task:
-- Declare a table variable @MissingOrders with the same structure as Orders_DB1.
declare @MissingOrders table(
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);
-- Insert all orders that exist in Orders_DB1 but not in Orders_DB2 into @MissingOrders.

Insert INTO @MissingOrders
SELECT *
from Orders_DB1 o1 
where orderid not in (select orderid from Orders_DB2);

-- Retrieve the missing orders.

select * from @MissingOrders;