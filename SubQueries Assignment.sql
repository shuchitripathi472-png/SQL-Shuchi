CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id VARCHAR(5),
    salary INT
);

CREATE TABLE department (
    department_id VARCHAR(5) PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount INT,
    sale_date DATE,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

INSERT INTO employee VALUES
(101,'Abhishek','D01',62000),
(102,'Shubham','D01',58000),
(103,'Priya','D02',67000),
(104,'Rohit','D02',64000),
(105,'Neha','D03',72000),
(106,'Aman','D03',55000),
(107,'Ravi','D04',60000),
(108,'Sneha','D04',75000),
(109,'Kiran','D05',70000),
(110,'Tanuja','D05',65000);

INSERT INTO department VALUES
('D01','Sales','Mumbai'),
('D02','Marketing','Delhi'),
('D03','Finance','Pune'),
('D04','HR','Bengaluru'),
('D05','IT','Hyderabad');

INSERT INTO sales VALUES
(201,101,4500,'2025-01-05'),
(202,102,7800,'2025-01-10'),
(203,103,6700,'2025-01-14'),
(204,104,12000,'2025-01-20'),
(205,105,9800,'2025-02-02'),
(206,106,10500,'2025-02-05'),
(207,107,3200,'2025-02-09'),
(208,108,5100,'2025-02-15'),
(209,109,3900,'2025-02-20'),
(210,110,7200,'2025-03-01');

---Q1--
SELECT AVG(salary) FROM employee;
SELECT name
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);
---Q2--
SELECT department_id, AVG(salary)
FROM employee
GROUP BY department_id;
SELECT department_id, AVG(salary)
FROM employee
GROUP BY department_id;
SELECT name, department_id
FROM employee
WHERE department_id IN (
    SELECT department_id
    FROM employee
    GROUP BY department_id
    HAVING AVG(salary) = (
        SELECT MAX(avg_sal)
        FROM (
            SELECT AVG(salary) AS avg_sal
            FROM employee
            GROUP BY department_id
        ) AS temp
    )
);
---Q3--
SELECT name
FROM employee e
WHERE EXISTS (
    SELECT 1
    FROM sales s
    WHERE e.emp_id = s.emp_id
);

---Q4--
SELECT name
FROM employee
WHERE emp_id = (
SELECT emp_id
FROM sales
WHERE sale_amount = (
SELECT MAX(sale_amount)
FROM sales
));
--Q5--
SELECT name
FROM employee
WHERE salary > (
    SELECT salary
    FROM employee
    WHERE name = 'Shubham'
);
--Q6--

SELECT name
FROM employee
WHERE department_id = (
    SELECT department_id
    FROM employee
    WHERE name = 'Abhishek'
);
--Q7--
SELECT department_name
FROM department
WHERE department_id IN (
    SELECT department_id
    FROM employee
    WHERE salary > 60000
);
--Q8--
SELECT department_name
FROM department
WHERE department_id = (
SELECT department_id
FROM employee
WHERE emp_id = (
SELECT emp_id
FROM sales
WHERE sale_amount = (
SELECT MAX(sale_amount)
FROM sales)));
--Q9--
SELECT AVG(sale_amount) FROM sales;
SELECT name
FROM employee
WHERE emp_id IN (
SELECT emp_id
FROM sales
WHERE sale_amount > (
SELECT AVG(sale_amount)
FROM sales
));

--Q10--
SELECT AVG(salary) FROM employee;
SELECT SUM(sale_amount) AS total_sales
FROM sales
WHERE emp_id IN (
    SELECT emp_id
    FROM employee
    WHERE salary > (
	SELECT AVG(salary)
        FROM employee));
        
--Q11--
SELECT name
FROM employee
WHERE emp_id NOT IN (
SELECT emp_id
FROM sales
);
--or --
SELECT name
FROM employee e
WHERE NOT EXISTS (
SELECT 1
FROM sales s
WHERE e.emp_id = s.emp_id
);

--Q12--
SELECT department_name
FROM department
WHERE department_id IN (
    SELECT department_id
    FROM employee
    GROUP BY department_id
    HAVING AVG(salary) > 55000
);

--Q13--
SELECT department_name
FROM department
WHERE department_id IN (
    SELECT department_id
    FROM employee
    WHERE emp_id IN (
	SELECT emp_id
	FROM sales
	GROUP BY emp_id
	HAVING SUM(sale_amount) > 10000)
);

--Q14--
SELECT name
FROM employee
WHERE emp_id = (
SELECT emp_id
FROM sales
WHERE sale_amount = (
SELECT MAX(sale_amount)
FROM sales
WHERE sale_amount < (
SELECT MAX(sale_amount)
FROM sales))
);

--Q15--
SELECT name
FROM employee
WHERE salary > (
    SELECT MAX(sale_amount)
    FROM sales
);

