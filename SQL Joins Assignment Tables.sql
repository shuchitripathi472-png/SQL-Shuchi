Create table Customers
(CustomerID int, CustomerName varchar (50), City Varchar (50));
INSERT INTO Customers (CustomerID, CustomerName, City)
Values
(1, 'John Smith', 'New York'),
(2, 'Mary Johnson', 'Chicago'),
(3, 'Peter Adams', 'Los Angeles'),
(4, 'Nancy Miller' , 'Houston'),
(5,  'Robert White', 'Miami');

Create table Orders
(OrderID int, CustomerID int, OrderDate date, Amount decimal (10,2));
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount)
Values
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 3, '2024-10-10', 450),
(105, 6, '2024-10-12', 400);

Create table Payments
(PaymentID varchar(5), CustomerID int, PaymentDate date, Amount decimal(10,2));
INSERT INTO Payments (PaymentID, CustomerID, PaymentDate, Amount)
Values
('P001', 1, '2024-10-02', 250),
('P002', 2, '2024-10-06', 300),
('P003', 3, '2024-10-11', 450),
('P004', 4, '2024-10-15', 200);

Create table Employees
(EmployeeID int, EmployeeName Varchar(30), ManagerID int);
INSERT INTO Employees (EmployeeID, EmployeeName, ManagerID)
Values
(1, 'Alex Green', NULL),
(2, 'Brian Lee', 1),
(3, 'Carol Ray', 1),
(4, 'David Kim', 2),
(5, 'Eva Smith', 2);
---Question 1---
SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;

---Question 2---

SELECT c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate, o.Amount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

---Question 3---

SELECT o.OrderID, o.CustomerID, c.CustomerName, o.OrderDate, o.Amount
FROM Orders o
LEFT JOIN Customers c
ON o.CustomerID = c.CustomerID;

--Question 4---
SELECT c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate, o.Amount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
UNION
SELECT c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate, o.Amount
FROM Orders o
LEFT JOIN Customers c
ON o.CustomerID = c.CustomerID;

---Question 5---
SELECT c.CustomerID, c.CustomerName, c.City
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

---Question 6--
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
INNER JOIN Payments p
ON c.CustomerID = p.CustomerID
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

--Question 7--
SELECT c.CustomerName, o.OrderID
FROM Customers c
CROSS JOIN Orders o;

---Question 8--
SELECT c.CustomerID, c.CustomerName,
o.Amount AS OrderAmount,
p.Amount AS PaymentAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p
ON c.CustomerID = p.CustomerID;

---Question 9--
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
INNER JOIN Payments p
ON c.CustomerID = p.CustomerID;




