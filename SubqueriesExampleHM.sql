create database HM;

use HM;

CREATE TABLE employees (

    emp_id INT PRIMARY KEY,

    emp_name VARCHAR(50),

    department VARCHAR(50),

    salary INT,

    manager_id INT

);

 
INSERT INTO employees VALUES

(1, 'Arun', 'IT', 70000, NULL),

(2, 'Meena', 'IT', 60000, 1),

(3, 'Ravi', 'HR', 50000, NULL),

(4, 'Priya', 'HR', 45000, 3),

(5, 'Kiran', 'Finance', 65000, NULL),

(6, 'Suma', 'Finance', 55000, 5);

 
 -- Find employees whose salary is greater than the average salary
 
 select * 
 from employees
 where salary > (
	select avg(salary) from employees
 );
 
 -- Find employees who earn the highest salary in each department
 
SELECT e.department, e.emp_name AS HighestSalaryEmp, e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department = e.department
);


-- select NOW();
-- insert into logs(message,createdat) values('user logged in',now());
-- select format(1234567.8912,2)   ===>1,234,567.89   ===string
 