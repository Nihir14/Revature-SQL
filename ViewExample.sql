CREATE DATABASE ViewExample;
USE ViewExample;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    hire_date DATE
);


CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'IT', 'New York'),
(2, 'HR', 'Boston'),
(3, 'Finance', 'Chicago');

INSERT INTO employees VALUES
(101, 'John', 1, 75000, '2020-01-15'),
(102, 'Alice', 1, 70000, '2021-03-20'),
(103, 'Bob', 2, 60000, '2022-06-10'),
(104, 'Sarah', 3, 80000, '2019-08-05'),
(105, 'Mike', 3, 90000, '2018-02-18');


CREATE VIEW employee_details_view AS
SELECT 
    e.emp_id,
    e.emp_name,
    d.dept_name,
    d.location,
    e.salary,
    e.hire_date
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;


SELECT * FROM employee_details_view;


-- Employees working in IT department
SELECT emp_name, salary
FROM employee_details_view
WHERE dept_name = 'IT';

-- Average salary per department
SELECT dept_name, AVG(salary) AS avg_salary
FROM employee_details_view
GROUP BY dept_name;


UPDATE employee_details_view
SET salary = 78000
WHERE emp_id = 101;

SELECT * FROM employees WHERE emp_id = 101;

CREATE VIEW high_salary_employees AS
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > 75000;

SELECT * FROM high_salary_employees;

DROP VIEW employee_details_view;


-- IMPORTANT RULES (INTERVIEW GOLD)

-- View does not store data

-- View stores SQL query

-- Data always comes from base tables

-- Views improve:

-- Security

-- Simplicity

-- Reusability

-- JOIN views are read-only (mostly)

-- 🎯 2-Line Interview Answer

-- A view is a virtual table created using a SELECT query that displays data from one or more tables without storing it physically.