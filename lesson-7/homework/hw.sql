--ddl process
drop table if exists Customers;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

drop table if exists Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);
 
drop table if exists OrderDetails;
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

drop table if exists Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

-- Insert into Customers
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Brown'),
(4, 'David White'),
(5, 'Eva Green'),
(6, 'Frank Black'),
(7, 'Husanboy Mansuraliyev');

-- Insert into Products
INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Smartphone', 'Electronics'),
(3, 'Desk Chair', 'Furniture'),
(4, 'Coffee Table', 'Furniture'),
(5, 'Headphones', 'Electronics'),
(6, 'Notebook', 'Stationery');

-- Insert into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(7, 1, '2025-02-28'),
(1, 1, '2025-02-25'),
(2, 2, '2025-02-26'),
(3, 3, '2025-02-26'),
(4, 4, '2025-02-27'),
(5, 5, '2025-02-27'),
(6, 6, '2025-02-27');

-- Insert into OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1, 1000.00),
(2, 1, 5, 2, 200.00),
(3, 2, 2, 1, 800.00),
(4, 3, 3, 1, 150.00),
(5, 4, 4, 1, 300.00),
(6, 5, 6, 3, 15.00);

select * from orders;
select * from Customers;
select * from Products;
select * from OrderDetails;

--TASKS

--task1

select c.CustomerName, o.OrderID, o.orderDate 
from Orders o right join Customers c 
    on o.CustomerID = c.CustomerID;

--task2

select c.CustomerID, c.CustomerName 
from Customers c left JOIN Orders o
    on c.CustomerID = o.CustomerID
group by c.CustomerID, c.CustomerName 
having count(o.OrderID) = 0;


--task3

select o.OrderID, p.ProductName, o.Quantity

from OrderDetails o join Products p
    on o.ProductID = p.ProductID;


--task4

select c.CustomerID, c.CustomerName 
from Customers c left JOIN Orders o
    on c.CustomerID = o.CustomerID
group by c.CustomerID, c.CustomerName 
having count(o.OrderID) > 1;


--task5

select od.orderId, p.productID, p.ProductName, od.price
from OrderDetails od inner join
(select o.OrderID, max(od.price) as maxprice
from orders o inner join OrderDetails od
    on o.OrderID = od.OrderID
group by o.OrderID) max_prices
    on od.OrderID = max_prices.OrderID and od.Price = max_prices.maxprice
inner join Products p
    on p.ProductID = od.ProductID;


--task6
-- select * from orders;

select dates_table.CustomerId, dates_table.CustomerName, o.OrderID, o.OrderDate
from (select 
        c.CustomerID, c.CustomerName, max(o.OrderDate) as latest_date
    from Customers c LEFT JOIN orders o
        on c.CustomerID = o.CustomerID
    group by c.CustomerID, c.CustomerName) as dates_table
    left join Orders o 
    on dates_table.CustomerID = o.CustomerID and dates_table.latest_date = o.OrderDate;



--task7

select c.CustomerID, c.CustomerName
from Customers c 
    JOIN Orders o
    on c.CustomerID = o.CustomerID
    join OrderDetails od
    on od.OrderID = o.OrderID
    join Products p 
    on p.ProductID = od.ProductID
group by c.CustomerID, c.CustomerName
having min(p.Category) = max(p.Category) and max(p.Category) = 'Electronics';


--task8
select c.CustomerID, c.CustomerName
from Customers c 
    JOIN Orders o
    on c.CustomerID = o.CustomerID
    join OrderDetails od
    on od.OrderID = o.OrderID
    join Products p 
    on p.ProductID = od.ProductID
group by c.CustomerID, c.CustomerName
having sum(IIf(p.Category = 'Stationery', 1, 0)) > 0;

--task9

select c.CustomerID, c.CustomerName, COALESCE(SUM(od.Price), 0) as TotalSpent
from Customers c left join Orders o 
    on c.CustomerID = o.CustomerID
    left join OrderDetails od 
    on od.OrderID = o.OrderID
group by c.CustomerID, c.CustomerName;