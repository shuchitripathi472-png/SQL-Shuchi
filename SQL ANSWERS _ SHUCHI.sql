--Q6. Create Sales Table--

CREATE TABLE sales (
 sale_id INT PRIMARY KEY,
 customer_name VARCHAR(50),
 amount INT,
 sale_date DATE
);

--INSERT INTO sales VALUES---
(1,'Aditi',1500,'2024-08-01'),
(2,'Rohan',2200,'2024-08-03'),
(3,'Aditi',3500,'2024-09-05'),
(4,'Meena',2700,'2024-09-15'),
(5,'Rohan',4500,'2024-09-25');

Q7-
SELECT * FROM sales ORDER BY amount DESC;

 Q8- 
 SELECT * FROM sales WHERE customer_name='Aditi';

Q9- Primary Key uniquely identifies records.
Foreign Key links tables.

	Q10. Rules to ensure data accuracy and integrity.