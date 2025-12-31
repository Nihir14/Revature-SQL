create database subqueries;

use subqueries;

CREATE TABLE employees (

    emp_id INT PRIMARY KEY,

    emp_name VARCHAR(50),

    department_id INT,

    salary DECIMAL(10, 2),

    hire_date DATE,

    manager_id INT

);
 
INSERT INTO employees VALUES

(1, 'John Smith', 1, 75000, '2020-01-15', NULL),

(2, 'Sarah Johnson', 1, 65000, '2021-03-20', 1),

(3, 'Mike Brown', 2, 80000, '2019-06-10', NULL),

(4, 'Emily Davis', 2, 70000, '2021-09-05', 3),

(5, 'David Wilson', 3, 55000, '2022-02-18', NULL),

(6, 'Lisa Anderson', 3, 60000, '2022-05-22', 5),

(7, 'Tom Martinez', 1, 72000, '2020-11-30', 1),

(8, 'Amy Taylor', 2, 68000, '2021-07-14', 3);
 
-- Departments Table

CREATE TABLE departments (

    dept_id INT PRIMARY KEY,

    dept_name VARCHAR(50),

    location VARCHAR(50)

);
 
INSERT INTO departments VALUES

(1, 'IT', 'New York'),

(2, 'Sales', 'Chicago'),

(3, 'HR', 'Boston');
 
-- Orders Table

CREATE TABLE orders (

    order_id INT PRIMARY KEY,

    customer_id INT,

    order_date DATE,

    total_amount DECIMAL(10, 2)

);
 
INSERT INTO orders VALUES

(101, 1, '2024-01-10', 500),

(102, 2, '2024-01-15', 750),

(103, 1, '2024-02-20', 300),

(104, 3, '2024-03-05', 1200),

(105, 2, '2024-03-18', 450);
 
-- Customers Table

CREATE TABLE customers (

    customer_id INT PRIMARY KEY,

    customer_name VARCHAR(50),

    city VARCHAR(50)

);
 
INSERT INTO customers VALUES

(1, 'ABC Corp', 'New York'),

(2, 'XYZ Ltd', 'Los Angeles'),

(3, 'Tech Solutions', 'Chicago'),

(4, 'Global Inc', 'Boston');



-- subqueries example
 
 select emp_name, salary
 from employees
 where salary > (select avg(salary) from employees);
 
select emp_name, department_id
from employees 
where department_id in (
	 select dept_id 
	 from departments
	 where dept_name IN ('IT', 'Sales')
);


select dept_name
from departments 
where dept_id not in (
	 select distinct department_id
	 from employees
);


-- Find employee(s) who earn the highest salary
SELECT emp_name, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);


-- Employees earning more than average salary of Sales department
SELECT emp_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = (
        SELECT dept_id
        FROM departments
        WHERE dept_name = 'Sales'
    )
);

-- Employees whose department is located in New York
SELECT emp_name
FROM employees
WHERE department_id IN (
    SELECT dept_id
    FROM departments
    WHERE location = 'New York'
);

-- Employees who are not managers
SELECT emp_name
FROM employees
WHERE emp_id NOT IN (
    SELECT DISTINCT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
);


-- Display employee name along with department name
SELECT emp_name,
       (SELECT dept_name
        FROM departments
        WHERE departments.dept_id = employees.department_id) AS department_name
FROM employees;


-- Correlated subquery example
SELECT emp_name, salary, department_id
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

-- Departments that have at least one employee
SELECT dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.dept_id
);

-- Departments without employees
SELECT dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.dept_id
);


-- Customers having more than one order
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
);


-- Customer(s) with highest order amount
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE total_amount = (
        SELECT MAX(total_amount)
        FROM orders
    )
);


-- Employees hired after the first employee joined
SELECT emp_name, hire_date
FROM employees
WHERE hire_date > (
    SELECT MIN(hire_date)
    FROM employees
);


-- Employees reporting to John Smith
SELECT emp_name
FROM employees
WHERE manager_id = (
    SELECT emp_id
    FROM employees
    WHERE emp_name = 'John Smith'
);



 
 
 