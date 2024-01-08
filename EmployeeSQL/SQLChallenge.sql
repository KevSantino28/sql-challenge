-- Data Engineering
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

--Creating the tables

CREATE TABLE titles (
    title_id VARCHAR(30) NOT NULL,
    title VARCHAR(5) NOT NULL,
    PRIMARY KEY (title_id)
   );
   

CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(5) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
    PRIMARY KEY (emp_no)
    );
    

CREATE TABLE departments (
    dept_no VARCHAR(4) NOT NULL,
    dept_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (dept_no)
    );
    
    
 
CREATE TABLE dept_manager (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
     PRIMARY KEY (emp_no, dept_no)
    ); 
    

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no,dept_no)
    );

     
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no)
    );


---- Data Analysis

-- 1 
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no;

-- 2
SELECT first_name, last_name, hire_date
FROM employees WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

-- 4
SELECT dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no;

-- 5
SELECT first_name, last_name, sex
FROM employees WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6
SELECT dept_emp.emp_no, employees.last_name, employees.first_name
FROM dept_emp JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.dept_no = 'd007';

-- 7 
SELECT dept_emp.emp_no, employees.last_name, employees.first_name
FROM dept_emp JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.dept_no = 'd007' 
OR dept_emp.dept_no = 'd005';

-- 8 
SELECT last_name,
COUNT (last_name) as "frequency"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;