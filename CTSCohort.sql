create database CTSCohort;

use CTSCohort;

create table employees (
	emp_id int primary key,
    emp_name varchar(50) not null,
    department varchar(30),
    salary decimal(10,2),
    hire_date date,
    manager_id int
);

create table departments (
	dept_id int primary key,
    dept_name varchar(50),
    location varchar(50)
);

INSERT INTO employees VALUES
	(1, 'John Doe', 'IT', 75000, '2020-01-15', NULL),
	(2, 'Jane Smith', 'HR', 65000, '2019-03-20', 1),
	(3, 'Mike Johnson', 'IT', 80000, '2018-07-10', 1),
	(4, 'Sarah Williams', 'Finance', 70000, '2021-05-12', 1),
	(5, 'Tom Brown', 'IT', 60000, '2022-02-28', 3
);
 
INSERT INTO departments VALUES
	(1, 'IT', 'Building A'),
	(2, 'HR', 'Building B'),
	(3, 'Finance', 'Building C'
);


-- DDL Data Definition language
-- create new table

create table projects (
	project_id int primary key,
    project_name varchar(100),
    budget decimal(12,2),
    start_date date
);


-- alter modifies table

alter table projects add end_date date;
alter table projects modify budget decimal(15,2);
alter table projects drop column start_date;

-- drop delete table

drop table projects;

-- truncate remove data structure will be there 

truncate table projects;

-- rename existing table

rename table employees to staff;

-- DML Data Manipulation Language

-- Insert a new employee record into staff table
INSERT INTO staff (
    emp_id,
    emp_name,
    department,
    salary,
    hire_date,
    manager_id
) VALUES (
    6,
    'Amit Verma',
    'IT',
    72000,
    '2023-06-15',
    3
);

-- Insert a new department into departments table
INSERT INTO departments (
    dept_id,
    dept_name,
    location
) VALUES (
    4,
    'Marketing',
    'Building D'
);

-- Update salary of employee with emp_id = 5
UPDATE staff
SET salary = 65000
WHERE emp_id = 5;

-- Change department of employee emp_id = 4 to IT
UPDATE staff
SET department = 'IT'
WHERE emp_id = 4;


-- Delete employee whose emp_id is 6
DELETE FROM staff
WHERE emp_id = 6;

-- Delete employees earning less than 60,000
DELETE FROM staff
WHERE salary < 60000;

-- Select all columns from staff table
SELECT * FROM staff;

-- Select specific columns
SELECT emp_name, department, salary
FROM staff;


-- Employees from IT department
SELECT *
FROM staff
WHERE department = 'IT';

-- Employees with salary greater than 70,000
SELECT emp_name, salary
FROM staff
WHERE salary > 70000;

-- Employees hired after 2020
SELECT emp_name, hire_date
FROM staff
WHERE hire_date > '2020-01-01';


-- IT employees with salary above 70,000
SELECT *
FROM staff
WHERE department = 'IT' AND salary > 70000;

-- Employees from IT or HR
SELECT *
FROM staff
WHERE department = 'IT' OR department = 'HR';

-- Employees not from Finance department
SELECT *
FROM staff
WHERE department != 'Finance';

-- Sort employees by salary (ascending)
SELECT emp_name, salary
FROM staff
ORDER BY salary ASC;

-- Sort employees by salary (descending)
SELECT emp_name, salary
FROM staff
ORDER BY salary DESC;

-- Sort by department then salary
SELECT emp_name, department, salary
FROM staff
ORDER BY department, salary DESC;

-- Top 3 highest paid employees
SELECT emp_name, salary
FROM staff
ORDER BY salary DESC
LIMIT 3;

-- Lowest paid employee
SELECT emp_name, salary
FROM staff
ORDER BY salary ASC
LIMIT 1;

-- Employees with salary between 60,000 and 75,000
SELECT emp_name, salary
FROM staff
WHERE salary BETWEEN 60000 AND 75000;

-- Employees from specific departments
SELECT emp_name, department
FROM staff
WHERE department IN ('IT', 'HR');

-- Employees whose name starts with 'J'
SELECT emp_name
FROM staff
WHERE emp_name LIKE 'J%';

-- DCL Data Ctrl Lang 

-- Allow user to read data from staff table
GRANT SELECT
ON CTSCohort.staff
TO 'user1'@'localhost';

-- Allow user to insert and update records
GRANT INSERT, UPDATE
ON CTSCohort.staff
TO 'user1'@'localhost';


-- Full access to CTSCohort database
GRANT ALL PRIVILEGES
ON CTSCohort.*
TO 'admin1'@'localhost';


-- User can grant permissions to others
GRANT SELECT
ON CTSCohort.staff
TO 'manager1'@'localhost'
WITH GRANT OPTION;

-- Remove SELECT permission from user
REVOKE SELECT
ON CTSCohort.staff
FROM 'user1'@'localhost';

-- Remove all permissions on database
REVOKE ALL PRIVILEGES
ON CTSCohort.*;

-- View privileges of a user
SHOW GRANTS FOR 'user1'@'localhost';

-- TCL controls transactions

START TRANSACTION;

-- Delete an employee
DELETE FROM staff
WHERE emp_id = 5;

-- Undo deletion
ROLLBACK;


START TRANSACTION;

-- First update
UPDATE staff
SET salary = 90000
WHERE emp_id = 2;

SAVEPOINT sp1;

-- Second update
UPDATE staff
SET salary = 95000
WHERE emp_id = 3;

-- Rollback only second update
ROLLBACK TO sp1;

-- Commit remaining changes
COMMIT;


START TRANSACTION;

INSERT INTO staff VALUES (7, 'Rahul', 'IT', 60000, '2024-01-10', 3);
SAVEPOINT add_emp;

UPDATE staff SET salary = 65000 WHERE emp_id = 7;

-- Something went wrong
ROLLBACK TO add_emp;

COMMIT;

-- Check auto-commit status
SELECT @@autocommit;


-- Disable auto-commit (for practice)
SET autocommit = 0;


