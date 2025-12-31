CREATE DATABASE FunctionExample;
USE FunctionExample;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO employees VALUES
(1, 'John', 50000),
(2, 'Alice', 60000),
(3, 'Bob', 45000),
(4, 'Sarah', 70000);


DELIMITER //

CREATE FUNCTION getAnnualSalary(monthly_salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monthly_salary * 12;
END//

DELIMITER ;


SELECT getAnnualSalary(50000) AS annual_salary;

DELIMITER //

-- Returns salary of an employee by ID

CREATE FUNCTION getSalaryByEmpId(eid INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE empSalary DECIMAL(10,2);

    SELECT salary INTO empSalary
    FROM employees
    WHERE emp_id = eid;

    RETURN empSalary;
END//

DELIMITER ;

SELECT getSalaryByEmpId(2) AS salary;


DELIMITER //

CREATE FUNCTION salaryLevel(empSalary DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE level VARCHAR(20);

    IF empSalary >= 60000 THEN
        SET level = 'HIGH';
    ELSE
        SET level = 'LOW';
    END IF;

    RETURN level;
END//

DELIMITER ;

SELECT emp_name, salary, salaryLevel(salary) AS salary_status
FROM employees;


SELECT emp_name
FROM employees
WHERE getSalaryByEmpId(emp_id) > 55000;
