-- JOIN EXAMPLE DATABASE

USE join_example_db;

SHOW tables;

SHOW CREATE TABLE roles;
SHOW CREATE TABLE users;
DESCRIBE roles;
DESCRIBE users;

SELECT *
FROM users;

SELECT *
FROM roles;

-- 2. Use join, left join and right join

SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;

/*SELECT *
FROM users
JOIN roles ON roles.id = users.role_id; -- no change/ order doesn't matter

SELECT * 
FROM roles
JOIN users ON roles.id = users.role_id; -- change since roles is now left table */

SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
FULL JOIN roles
ON users.role_id = roles.id;  -- JUST FOR FUN COME BACK LATER TO SEE WHATS WRONG

-- 3.  USING RIGHT OR LEFT JOIN WILL INCLUDE THE NULLS
SELECT role_id, COUNT(*)
FROM users
JOIN roles ON users.role_id = roles.id
GROUP BY role_id;
-- USING RIGHT OR LEFT JOIN WILL INCLUDE THE NULLS
SELECT role_id, COUNT(*)
FROM users
RIGHT JOIN roles ON users.role_id = roles.id
GROUP BY role_id;

SELECT role_id, COUNT(*)
FROM users
LEFT JOIN roles ON users.role_id = roles.id
GROUP BY role_id;

-- EMPLOYEES DATABASE

-- 1.
USE employees;

SHOW tables;

DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;
DESCRIBE roles;

-- 2.
SELECT *
FROM departments;

SELECT d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM departments AS d
JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no
JOIN employees AS e
ON dm.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01'
ORDER BY d.dept_name; -- , CONCAT(e.first_name, ' ', e.last_name); Concat not needed

-- 'Department Name', 'Department Manager';
	-- Cannot Group By and Order by Aliases 
		-- REMEMBER TO THINK THIS THROUGH LATER!!!
-- JOIN salaries AS s
-- ON e.emp_no = s.emp_no
-- WHERE s.to_date = '9999-01-01'
-- GROUP BY d.dept_name, CONCAT(first_name, ' ', last_name)



-- 3.  
SELECT *
FROM departments;

SELECT *
FROM dept_manager;

SELECT *
FROM employees;

-- select Department Name from departments.dept_name and Manager Name by concatinating first_name and last_name  from employees
-- join departments to dept_manager by dept_no
-- join dept_manager to employees by emp_no
-- choose female managers

SELECT d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Manager Name'
FROM departments d
JOIN dept_manager dm
ON d.dept_no = dm.dept_no
JOIN employees e
ON dm.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F'
ORDER BY d.dept_name; -- DOES ORDER BY HAVE THE SAME LIMITATIONS AS GROUP BY FOR SELECT

-- 4. 

-- join department with dept_emp by dept_no
-- Join dept_emp and titles by emp_no

SELECT t.title 'Title', COUNT(t.title) 'Count'
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN titles t
ON de.emp_no = t.emp_no
-- JOIN salaries s -- WHY DOES INNER JOINING SALARIES EXPLODE THE COUNT?
-- ON t.emp_no = s.emp_no
WHERE d.dept_no = 'd009' AND t.to_date = '9999-01-01' AND de.to_date = '9999-01-01' -- d009 is Customer Service Department Number
GROUP BY t.title
ORDER BY t.title;

SELECT *
FROM dept_manager
WHERE to_date = '9999-01-01';

-- 5. 
-- Have to join Department manager, employees and salaries
-- dept_manager to_date '9999-01-01' is the funnel
SELECT d.dept_name 'Department Name', CONCAT(e.first_name, ' ', e.last_name) 'Name', s.salary 'Salary'
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
JOIN dept_manager dm
ON dm.emp_no = s.emp_no
JOIN departments d
ON dm.dept_no = d.dept_no 
WHERE dm.to_date = '9999-01-01' AND s.to_date ='9999-01-01'
ORDER BY d.dept_name;

-- 6.   Join departments with dep_emp by dept_no
-- Group by dept_no
-- Where current employee
SELECT d.dept_no, d.dept_name, COUNT(d.dept_name)
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY d.dept_no, d.dept_name
ORDER BY d.dept_no;


-- 7.  current salaries join dept_emp to salaries current salaries (left?)
-- group by department and I have to join departments as well
SELECT d.dept_name, AVG(s.salary) -- TOMORROW SEE IF I CAN DO WITHOUT LIMIT
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN salaries s
ON de.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;

-- 8.  Join employees for the names with the dept_emp with the salaries current


SELECT e.first_name, e.last_name -- See if I can do without Limit 1
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN salaries s
ON de.emp_no = s.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Marketing' AND de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;

-- 9. Join employee salary and dept_mgr
SELECT e.first_name, e.last_name, s.salary, d.dept_name 
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
JOIN dept_manager dm
ON s.emp_no = dm.emp_no
JOIN departments d
ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY salary DESC
LIMIT 1;

-- 10. Average Salary for each department using all salaries
-- Join departments to dept_emp by dept_no and then to salaries by emp_no
-- order descending by average salary
SELECT d.dept_name, ROUND(AVG(s.salary))
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN salaries s
ON de.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY ROUND(AVG(s.salary)) DESC;


-- 11. Join employees to dept_emp by emp_no then to dept_manager by emp_no then to departments by dept_no
--  isolate current employees by salary and dept_emp to dates

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', d.dept_name AS 'Department Name', dm.dept_no
FROM employees e
LEFT JOIN dept_emp de
ON e.emp_no = de.emp_no
LEFT JOIN dept_manager dm
ON de.emp_no = dm.emp_no
LEFT JOIN departments d
ON dm.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01'
ORDER BY e.emp_no;-- OR dm.to_date ='9999-01-01');

DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;
DESCRIBE roles;

SELECT *
FROM dept_emp
WHERE to_date = '9999-01-01'