

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
SELECT COUNT(DISTINCT first_name) AS unique_first_name
FROM manufacturing.employees_table;

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