CREATE DATABASE ProcedureExample;
USE ProcedureExample;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employees VALUES
(1, 'John', 'IT', 75000, '2020-01-15'),
(2, 'Alice', 'IT', 70000, '2021-03-20'),
(3, 'Bob', 'HR', 60000, '2022-06-10'),
(4, 'Sarah', 'Finance', 80000, '2019-08-05'),
(5, 'Mike', 'Finance', 90000, '2018-02-18');


SELECT * FROM employees;

DELIMITER //

CREATE PROCEDURE getAllEmployees()
BEGIN
    SELECT * FROM employees;
END//

DELIMITER ;

CALL getAllEmployees();

DELIMITER //

CREATE PROCEDURE getEmployeesByDepartment(IN dept_name VARCHAR(30))
BEGIN
    SELECT emp_name, salary
    FROM employees
    WHERE department = dept_name;
END//

DELIMITER ;

CALL getEmployeesByDepartment('IT');


DELIMITER //

CREATE PROCEDURE getEmployeeCount(OUT total_employees INT)
BEGIN
    SELECT COUNT(*) INTO total_employees
    FROM employees;
END//

DELIMITER ;

CALL getEmployeeCount(@count);
SELECT @count AS total_employees;


DELIMITER //

CREATE PROCEDURE transferBonus(
    IN empId INT,
    IN bonus DECIMAL(10,2)
)
BEGIN
    START TRANSACTION;

    UPDATE employees
    SET salary = salary + bonus
    WHERE emp_id = empId;

    COMMIT;
END//

DELIMITER ;

CALL transferBonus(2, 3000);

SHOW PROCEDURE STATUS WHERE Db = 'ProcedureExample';

