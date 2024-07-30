DROP TABLE IF EXISTS departments, department_employees, department_manager, employees, salaries, titles, step1, step2, step3, step4, step5, step6, step7, step8;

-- Create base tables first
CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no)
);

SELECT *
FROM employees;

CREATE TABLE departments (
    dept_no VARCHAR(10) NOT NULL,
    dept_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (dept_no)
);

SELECT *
FROM departments;

CREATE TABLE department_employees (
    emp_no INT,
    dept_no VARCHAR(10) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM department_employees;

CREATE TABLE department_manager (
    dept_no VARCHAR(10) NOT NULL,
    emp_no INT,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM department_manager;

CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    PRIMARY KEY (emp_no, salary),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM salaries;

CREATE TABLE titles (
    title_id VARCHAR(25) NOT NULL,
    title VARCHAR(25) NOT NULL,
    PRIMARY KEY (title_id, title)
);

SELECT *
FROM titles
	
-- Step 1
CREATE TABLE step1 AS	
SELECT e.emp_no, e.first_name, e.last_name, e.sex, s.salary
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no;

SELECT *
FROM step1

ALTER TABLE step1
ADD PRIMARY KEY (emp_no);

ALTER TABLE step1
ADD CONSTRAINT fk_emp_no_step1
FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

SELECT *
FROM step1
	
-- Step 2
CREATE TABLE step2 AS	
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

SELECT *
FROM step2
	
-- Step 3
CREATE TABLE step3 AS	
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM department_manager dm
INNER JOIN departments d ON dm.dept_no = d.dept_no
INNER JOIN employees e ON dm.emp_no = e.emp_no;

ALTER TABLE step3
ADD PRIMARY KEY (dept_no, emp_no);

ALTER TABLE step3
ADD CONSTRAINT fk_dept_no_step3
FOREIGN KEY (dept_no) REFERENCES departments(dept_no);

ALTER TABLE step3
ADD CONSTRAINT fk_emp_no_step3
FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

SELECT *
FROM step3
	
-- Step 4
CREATE TABLE step4 AS
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN department_employees de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no;

ALTER TABLE step4
ADD PRIMARY KEY (emp_no, dept_no);

ALTER TABLE step4
ADD CONSTRAINT fk_dept_no_step4
FOREIGN KEY (dept_no) REFERENCES departments(dept_no);

ALTER TABLE step4
ADD CONSTRAINT fk_emp_no_step4
FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

SELECT *
FROM step4
	
-- Step 5
CREATE TABLE step5 AS
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
  AND last_name LIKE 'B%';

SELECT *
FROM step5
	
-- Step 6
CREATE TABLE step6 AS
SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN department_employees de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

ALTER TABLE step6
ADD PRIMARY KEY (emp_no);

ALTER TABLE step6
ADD CONSTRAINT fk_emp_no_step6
FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

SELECT *
FROM step6
	
-- Step 7
CREATE TABLE step7 AS
SELECT e.emp_no, e.last_name, e.first_name, de.dept_no, d.dept_name
FROM employees e
JOIN department_employees de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

ALTER TABLE step7
ADD PRIMARY KEY (emp_no, dept_no);

ALTER TABLE step7
ADD CONSTRAINT fk_dept_no_step7
FOREIGN KEY (dept_no) REFERENCES departments(dept_no);

ALTER TABLE step7
ADD CONSTRAINT fk_emp_no_step7
FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

SELECT *
FROM step7
	
-- Step 8
CREATE TABLE step8 AS
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

SELECT *
FROM step8