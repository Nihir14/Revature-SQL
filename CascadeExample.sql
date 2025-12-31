create database cascadeexample;

Use cascadeexample;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);


CREATE TABLE staff (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id)
    REFERENCES departments(dept_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO staff VALUES
(101, 'John', 1, 70000),
(102, 'Alice', 1, 75000),
(103, 'Bob', 2, 60000),
(104, 'Sarah', 3, 65000);

DELETE FROM departments WHERE dept_id = 1;

UPDATE departments SET dept_id = 10 WHERE dept_id = 2;
