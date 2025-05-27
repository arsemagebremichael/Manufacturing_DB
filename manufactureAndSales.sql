CREATE SCHEMA manufacturing;
CREATE TABLE manufacturing.employees_table(
     employee_id SERIAL PRIMARY KEY,
     first_name VARCHAR(50) NOT NULL,
     last_name VARCHAR(50) NOT NULL,
     gender VARCHAR(15),
     department VARCHAR(50) NOT NULL,
     hired_date  DATE,
     salary FLOAT   
     );

SELECT * FROM employees_table;

INSERT INTO manufacturing.employees_table(
    first_name,
    last_name,
    gender,
    department,
    hired_date,
    salary
) 
VALUES
('John', 'Doe', 'Male', 'IT', '2018-05-01', 60000.00),
('Jane', 'Smith', 'Female', 'HR', '2019-06-15', 50000.00),
('Michael', 'Johnson', 'Male', 'Finance', '2017-03-10', 75000.00),
('Emily', 'Davis', 'Female', 'IT', '2020-11-20', 70000.00),
('Sarah', 'Brown', 'Female', 'Marketing', '2016-07-30', 45000.00),
('David', 'Wilson', 'Male', 'Sales', '2019-01-05', 55000.00),
( 'Chris', 'Taylor', 'Male', 'IT', '2022-02-25', 65000.00);
;

-- UPDATE manufacturing.employees_table
-- SET department = 'HR'
-- WHERE employee_id =2;

SELECT * FROM manufacturing.employees_table;

CREATE TABLE manufacturing.products(
product_id SERIAL PRIMARY KEY,
product_name VARCHAR(50),
category VARCHAR(50),
price FLOAT,
stock INT
);

INSERT INTO manufacturing.products(product_name,category,price,stock)
values('Laptop', 'ELectronics', 1200.00, 30),
('Desk', 'Furniture', 300.00, 50),
('Chair', 'Furniture', 150.00, 200),
('Smartphone', 'Electronics', 800.00, 75),
('Monitor', 'Electronics', 250.00, 40),
('Bookshelf', 'Furniture', 100.00, 60),
('Printer', 'Electronics', 200.00, 25);

SELECT * FROM manufacturing.products;

CREATE TABLE manufacturing.sales_table(
    sales_id SERIAL PRIMARY KEY,
    product_id INT,
    employee_id INT,
    CONSTRAINT product_id
    FOREIGN KEY (product_id)
    REFERENCES manufacturing.products(product_id),
    CONSTRAINT employee_id
    FOREIGN KEY (employee_id)
    REFERENCES manufacturing.employees_table(employee_id),
    sales_date DATE NOT NULL,
    quantity INT,
    total FLOAT
);

SELECT * FROM manufacturing.sales_table;

INSERT INTO manufacturing.sales_table (product_id, employee_id, sales_date, quantity, total) VALUES
(1, 1, '2021-01-15', 2, 2400.00),
(2, 2, '2021-03-22', 1, 300.00),
(3, 3, '2021-05-10', 4, 600.00),
(4, 4, '2021-07-18', 3, 2400.00),
(5, 5, '2021-09-25', 2, 500.00),
(6, 6, '2021-11-30', 1, 100.00),
(7, 1, '2022-02-15', 1, 200.00),
(1, 2, '2022-04-10', 1, 1200.00),
(2, 3, '2022-06-20', 2, 600.00),
(3, 4, '2022-08-05', 3, 450.00),
(4, 5, '2022-10-11', 1, 800.00),
(5, 6, '2022-12-29', 4, 1000.00);


-- Number 1
-- Select all columns from the Employees table. 
SELECT * FROM manufacturing.employees_table;
-- Number 2
-- Select the first names of all employees. 
SELECT first_name FROM manufacturing.employees_table;
-- Number 3
-- Select distinct departments from the Employees table. 
SELECT DISTINCT department FROM manufacturing.employees_table;

-- Number 4
-- Select the total number of employees. 
SELECT count(*) AS employees_count FROM manufacturing.employees_table;

-- Number 5
-- Select the total salary paid to all employees. 
SELECT SUM(salary) AS total_paid FROM manufacturing.employees_table;

-- Number 6
-- Select the average salary of all employees. 
SELECT AVG(salary) AS average_employee_salary FROM manufacturing.employees_table;

-- Number 7
-- Select the highest salary in the Employees table.
SELECT MAX(salary) AS maximum_employee_salary FROM manufacturing.employees_table;

-- NUmber 8
-- Select the lowest salary in the Employees table. 
SELECT MIN(salary) AS minimum_employee_salary FROM manufacturing.employees_table;

-- Number 9
-- Select the total number of male employees. 
SELECT COUNT(*) AS male_workers_number
FROM manufacturing.employees_table 
WHERE gender = 'Male';

-- Number 10
-- Select the total number of female employees.
SELECT COUNT(*) AS female_workers_number
FROM manufacturing.employees_table
WHERE gender = 'Female';

-- NUmber 11
-- Select the total number of employees hired in the year 2020. 

SELECT COUNT(employee_id) AS employees_hired_in_2020
FROM manufacturing.employees_table
WHERE EXTRACT (YEAR FROM hired_date) = 2020
GROUP BY(hired_date);

--Number 12
-- Select the average salary of employees in the 'IT' department. 
SELECT AVG(salary) AS ave_it_employee_salary
FROM manufacturing.employees_table
WHERE department = 'IT';

-- Number 13
-- Select the number of employees in each department. 
SELECT department, COUNT(department) AS employees_number
FROM manufacturing.employees_table
GROUP BY department;

-- Number 14
-- Select the total salary paid to employees in each department. 
SELECT department, SUM(salary) AS total_department_pay
FROM manufacturing.employees_table
GROUP BY department;

-- Number 15
-- Select the maximum salary in each department. 
SELECT department, MAX(salary) AS max_department_pay
FROM manufacturing.employees_table
GROUP BY department;

-- Number 16
--  Select the minimum salary in each department. 
SELECT department, MIN(salary) AS min_department_pay
FROM manufacturing.employees_table
GROUP BY department;

-- NUmber 17
-- Select the total number of employees, grouped by gender. 
SELECT gender, COUNT(*) AS employees_number
FROM manufacturing.employees_table
GROUP BY gender;

-- 18. Select the average salary of employees, grouped by gender. 
SELECT gender, AVG(salary) AS avg_employee_salary
FROM manufacturing.employees_table
GROUP BY gender;

-- 19. Select the top 5 highest-paid employees. 
SELECT first_name, salary 
FROM manufacturing.employees_table
ORDER BY salary
DESC LIMIT 5;

-- 20. Select the total number of unique first names in the Employees table. 
SELECT first_name
FROM manufacturing.employees_table
WHERE COUNT(first_name) = 1;

--21. Select all employees and their corresponding sales 
SELECT first_name, total
FROM manufacturing.employees_table  et
JOIN manufacturing.sales_table  st ON
et.employee_id = st.employee_id;

-- 22. Select the first 10 employees hired, ordered by their HireDate.
SELECT employee_id, first_name, hired_date AS senior_employee
FROM manufacturing.employees_table
ORDER BY hired_date
LIMIT 10;

-- 23. Select the employees who have not made any sales. 
SELECT *
FROM manufacturing.employees_table
WHERE employee_id NOT IN (SELECT employee_id FROM manufacturing.sales_table);

-- 24. Select the total number of sales made by each employee. 
SELECT et.first_name, COUNT(total) AS total_sales
FROM manufacturing.employees_table et
JOIN manufacturing.sales_table st ON 
et.employee_id = st.employee_id
GROUP BY first_name;

-- 25. Select the employee who made the highest total sales. 
SELECT et.employee_id, et.first_name, et.last_name, SUM(st.total) AS total_sales_made
FROM manufacturing.sales_table st
JOIN manufacturing.employees_table et ON st.employee_id = et.employee_id
GROUP BY et.employee_id, et.first_name, et.last_name
ORDER BY total_sales_made DESC
LIMIT 1;

-- 26. Select the average quantity of products sold by employees in each department.
SELECT et.department, AVG(st.quantity) AS avg_quantity_sold
FROM manufacturing.sales_table st
JOIN manufacturing.employees_table et ON st.employee_id = et.employee_id
GROUP BY et.department;

-- 27. Select the total sales made by each employee in the year 2021.
SELECT et.employee_id, et.first_name, SUM(st.total) AS total_sales_2021
FROM manufacturing.sales_table st
JOIN manufacturing.employees_table et ON st.employee_id = et.employee_id
WHERE EXTRACT(YEAR FROM st.sales_date) = 2021
GROUP BY et.employee_id, et.first_name, et.last_name;

-- 28. Select the top 3 employees with the most sales in terms of quantity. 
SELECT et.employee_id, et.first_name, et.last_name, SUM(st.quantity) AS total_quantity_sold
FROM manufacturing.sales_table st
JOIN manufacturing.employees_table et ON st.employee_id = et.employee_id
GROUP BY et.employee_id, et.first_name, et.last_name
ORDER BY total_quantity_sold DESC
LIMIT 3;

-- 29. Select the total quantity of products sold by each department.
SELECT et.department, SUM(st.quantity) AS total_quantity_sold
FROM manufacturing.sales_table st
JOIN manufacturing.employees_table et ON st.employee_id = et.employee_id
GROUP BY et.department;

-- 30. Select the total revenue generated by sales of products in each category.
SELECT p.category, SUM(s.total) AS total_revenue
FROM manufacturing.sales_table s
JOIN manufacturing.products p ON s.product_id = p.product_id
GROUP BY p.category;