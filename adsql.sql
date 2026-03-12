--Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability? --
A Common Table Expression (CTE) is a temporary result set that you can define within a SQL query using the WITH keyword.
It exists only during the execution of that query and helps break complex queries into smaller, more readable parts.
'example'>
WITH HighSalaryEmployees AS (
    SELECT EmployeeID, Name, Salary
    FROM Employees
    WHERE Salary > 50000
)
SELECT *
FROM HighSalaryEmployees;

--Q2-- Why are some views updatable while others are read-only? Explain with an example.

In SQL, a view is a virtual table created from a SELECT query. Some views are updatable, while others are read-only, depending on how they are created.
A view is updatable when it is based on a single table and does not contain complex operations like JOIN, GROUP BY, DISTINCT, or aggregate functions. In such cases, changes made through the view are reflected in the original table.
A view becomes read-only when it contains multiple tables, joins, aggregate functions, or grouping, because the database cannot determine how to update the underlying data correctly.
'example' updatable view > 
CREATE VIEW ProductView AS
SELECT ProductID, ProductName, Price
FROM Products;
'Read-only View' >
CREATE VIEW CategorySummary AS
SELECT Category, COUNT(*) AS TotalProducts 
FROM Products GROUP BY Category;

--Q3--
Stored procedures are precompiled SQL statements stored in the database that can be executed multiple times.
Reusability: Same procedure can be used many times.
Better performance: Precompiled queries run faster.
Security: Users can execute procedures without direct access to tables.
Reduced code duplication: Avoid writing the same SQL query repeatedly.

--Q4--
A trigger is a database object that automatically executes when a specific event occurs on a table, such as INSERT, UPDATE, or DELETE.
Purpose: Triggers help enforce business rules, maintain data integrity, and automate actions in the database.
Example Use Case
When a product is deleted from the Products table, a trigger can automatically store the deleted product information in an archive table for record keeping.
--Q5--
Data modelling is the process of designing the structure of a database, including tables, relationships, and constraints.
Normalization is the process of organizing data to reduce redundancy and improve data integrity.
Importance:
Eliminates duplicate data
Improves data consistency
Makes the database easier to maintain
Optimizes storage and performance.

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);
INSERT INTO Products VALUES
(1,'Keyboard','Electronics',1200),
(2,'Mouse','Electronics',800),
(3,'Chair','Furniture',2500),
(4,'Desk','Furniture',5500);
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Sales VALUES
(1,1,4,'2024-01-05'),
(2,2,10,'2024-01-06'),
(3,3,2,'2024-01-10'),
(4,4,1,'2024-01-11');

Q6.
WITH RevenueCTE AS (
    SELECT 
        p.ProductID,
        p.ProductName,
        (p.Price * s.Quantity) AS Revenue
    FROM Products p
    JOIN Sales s
    ON p.ProductID = s.ProductID
)
SELECT *
FROM RevenueCTE
WHERE Revenue > 3000;
--Q7--
CREATE VIEW vw_CategorySummary AS
SELECT 
    Category,
    COUNT(ProductID) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;
SELECT * FROM vw_CategorySummary;
--Q8--
CREATE VIEW vw_ProductDetails AS
SELECT 
    ProductID,
    ProductName,
    Price
FROM Products;
UPDATE vw_ProductDetails
SET Price = 1500
WHERE ProductID = 1;
--Q9--
DELIMITER $$
CREATE PROCEDURE GetProductsByCategory(IN CategoryName VARCHAR(50))
BEGIN
    SELECT *
    FROM Products
    WHERE Category = CategoryName;
END $$
DELIMITER ;
CALL GetProductsByCategory('Electronics');

CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt DATETIME
);
DELIMITER $$
CREATE TRIGGER trg_AfterDeleteProduct
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive
    (ProductID, ProductName, Category, Price, DeletedAt)
    VALUES
    (OLD.ProductID, OLD.ProductName, OLD.Category, OLD.Price, NOW());
END $$
DELIMITER ;
DELETE FROM Products
WHERE ProductID = 2;
SELECT * FROM ProductArchive;