CREATE DATABASE AggregateDB;
USE AggregateDB;

CREATE TABLE staff (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    hire_date DATE
);

INSERT INTO staff VALUES
(1, 'John',  'IT',      70000, '2020-01-15'),
(2, 'Alice', 'IT',      75000, '2019-03-20'),
(3, 'Bob',   'HR',      60000, '2021-06-10'),
(4, 'Sarah', 'HR',      65000, '2022-02-12'),
(5, 'Mike',  'Finance', 80000, '2018-07-25'),
(6, 'Emma',  'Finance', 90000, '2017-05-30');

SELECT * FROM staff;

-- Total number of employees
SELECT COUNT(*) AS total_employees
FROM staff;

-- Count employees per department
SELECT department, COUNT(*) AS emp_count
FROM staff
GROUP BY department;

-- Total salary of all employees
SELECT SUM(salary) AS total_salary
FROM staff;

-- Department-wise total salary
SELECT department, SUM(salary) AS dept_salary
FROM staff
GROUP BY department;

-- Average salary of all employees
SELECT AVG(salary) AS avg_salary
FROM staff;


-- Department-wise average salary
SELECT department, AVG(salary) AS avg_salary
FROM staff
GROUP BY department;

-- Minimum salary in company
SELECT MIN(salary) AS min_salary
FROM staff;


-- Minimum salary per department
SELECT department, MIN(salary) AS min_salary
FROM staff
GROUP BY department;


-- Maximum salary in company
SELECT MAX(salary) AS max_salary
FROM staff;

-- Maximum salary per department
SELECT department, MAX(salary) AS max_salary
FROM staff
GROUP BY department;

-- Departments with average salary greater than 75000
SELECT department, AVG(salary) AS avg_salary
FROM staff
GROUP BY department
HAVING AVG(salary) > 75000;

-- Average salary of IT department only
SELECT AVG(salary) AS avg_it_salary
FROM staff
WHERE department = 'IT';


-- Employees earning more than average salary
SELECT emp_name, salary
FROM staff
WHERE salary > (
    SELECT AVG(salary) FROM staff
);


