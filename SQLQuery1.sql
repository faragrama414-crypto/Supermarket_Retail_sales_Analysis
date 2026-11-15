create table customer (
customerID int primary key,
customerName varchar(100),
city varchar(30),
age int);

go

create table products(
productID int primary key, 
productName varchar(150) not null ,
category varchar (50),
price decimal (10,2),
cost decimal (10,2);

go

create table orders(
orderID int primary key,
orderdate date,
orderstatus varchar(150),
customerID int, 
constraint orders_customers_fk
foreign key (customerID) references customer(customerID));
go
INSERT INTO Customers
(CustomerID, CustomerName, City, Age)
VALUES
(1, 'Ahmed Hassan', 'Cairo', 28),
(2, 'Mona Ali', 'Giza', 34),
(3, 'Omar Mohamed', 'Alexandria', 25);
go
INSERT INTO Products
(ProductID, ProductName, Category, Price, Cost)
VALUES
(1, 'Rice', 'Grocery', 80.00, 60.00),
(2, 'Milk', 'Dairy', 40.00, 30.00),
(3, 'Chicken', 'Meat', 150.00, 120.00);
go
INSERT INTO Orders
(OrderID, CustomerID, OrderDate, Status)
VALUES
(1, 1, '2026-01-05', 'Completed'),
(2, 2, '2026-01-06', 'Completed'),
(3, 3, '2026-01-08', 'Cancelled');
go
INSERT INTO OrderDetails
(OrderDetailID, OrderID, ProductID, Quantity, Discount)
VALUES
(1, 1, 1, 2, 0),
(2, 1, 3, 1, 5),
(3, 2, 2, 3, 10);
go
select* from Customers
select* from Products
select* from Orders
select* from OrderDetails
select*
from orders
where Status ='completed';
SELECT *FROM Products
WHERE Category = 'Dairy';
select* from Orders
WHERE OrderDate >= '2026-01-01'
AND OrderDate < '2026-02-01';
go

SELECT
    Customers.CustomerID,
    Customers.CustomerName,
    Customers.City,
    Orders.OrderID,
    Orders.OrderDate,
    Orders.Status

FROM Customers

INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;
go
SELECT
    Orders.OrderID,
    Orders.OrderDate,
    Products.ProductID,
    Products.ProductName,
    Products.Category,
    OrderDetails.Quantity,
    Products.Price,
    OrderDetails.Discount

FROM Orders

INNER JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID

INNER JOIN Products
ON OrderDetails.ProductID = Products.ProductID;
go
SELECT
    Customers.CustomerName,
    Customers.City,
    Orders.OrderID,
    Products.ProductName,
    Products.Category,
    OrderDetails.Quantity

FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products
ON OrderDetails.ProductID = Products.ProductID;
go
SELECT
    Customers.CustomerName,
    Customers.City,
    Orders.OrderID,
    Orders.OrderDate,
    Orders.Status,
    Products.ProductName,
    Products.Category,
    OrderDetails.Quantity,
    Products.Price,
    Products.Cost,
    OrderDetails.Discount

FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products
ON OrderDetails.ProductID = Products.ProductID;
go
SELECT COUNT(*) AS TOTALORDERS
FROM Orders
go
SELECT SUM(quantity) AS SUMSOLD
from OrderDetails
GO
SELECT AVG(price) AS PRICEAVG
from Products
GO
SELECT MIN(PRICE) AS MINPRICE,
MAX (PRICE) AS MAXPRICE 
FROM PRODUCTS
go
SELECT CUSTOMERID, 
COUNT(*) AS TOTALORDER
FROM ORDERS
GROUP BY CUSTOMERID;
go
SELECT Category,
AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

SELECT
    SUM(Products.Price * OrderDetails.Quantity *
        (1 - OrderDetails.Discount / 100.0)) AS TotalRevenue,

    SUM((Products.Price * (1 - OrderDetails.Discount / 100.0)
        - Products.Cost) * OrderDetails.Quantity) AS TotalProfit

FROM Orders
JOIN OrderDetails
    ON Orders.OrderID = OrderDetails.OrderID
JOIN Products
    ON OrderDetails.ProductID = Products.ProductID
WHERE Orders.Status = 'Completed';


SELECT
    YEAR(Orders.OrderDate) AS SalesYear,
    MONTH(Orders.OrderDate) AS SalesMonth,
    SUM(Products.Price * OrderDetails.Quantity *
        (1 - OrderDetails.Discount / 100.0)) AS MonthlyRevenue
FROM Orders
JOIN OrderDetails
    ON Orders.OrderID = OrderDetails.OrderID
JOIN Products
    ON OrderDetails.ProductID = Products.ProductID

WHERE Orders.Status = 'Completed'
GROUP BY YEAR(Orders.OrderDate), MONTH(Orders.OrderDate)
ORDER BY SalesYear, SalesMonth;

SELECT
    Customers.CustomerID,
    Customers.CustomerName,
    Customers.City,
    COUNT(DISTINCT Orders.OrderID) AS TotalOrders,
    SUM(OrderDetails.Quantity) AS TotalQuantity,
    SUM(Products.Price * OrderDetails.Quantity *
        (1 - OrderDetails.Discount / 100.0)) AS TotalSpent

FROM Customers
JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails
    ON Orders.OrderID = OrderDetails.OrderID
JOIN Products
    ON OrderDetails.ProductID = Products.ProductID

WHERE Orders.Status = 'Completed'

GROUP BY
    Customers.CustomerID,
    Customers.CustomerName,
    Customers.City

ORDER BY TotalSpent DESC;

SELECT
    ProductID,
    ProductName,
    Category,
    Price
FROM Products
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
)
ORDER BY Price DESC;