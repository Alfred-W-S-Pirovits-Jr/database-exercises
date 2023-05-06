USE employees;

SHOW tables;

-- 1.
/*
SELECT *
FROM employees
WHERE emp_no = 101010;

SELECT hire_date
FROM employees
WHERE emp_no = 101010;
*/

SELECT CONCAT(first_name, ' ', last_name)
FROM employees
WHERE hire_date = (
					SELECT hire_date
					FROM employees
					WHERE emp_no = 101010
					);
                    
-- 2. 
SELECT *
FROM titles;

SELECT emp_no
FROM employees
WHERE first_name LIKE 'Aamod' AND titles.to_date LIKE '9999-01-01'; -- cnat draw for

SELECT DISTINCT title
FROM
	(SELECT emp_no
	FROM employees e
	WHERE first_name LIKE 'Aamod') AS am
JOIN titles ON am.emp_no = titles.emp_no
WHERE titles.to_date LIKE '9999-01-01';

-- 3.  GET BACK TO IT
SELECT * 
FROM employees;

SELECT COUNT(*)-- (DISTINCT emp_no) -- NOW() BETTER THAN NOT LIKE '9%'
FROM salaries
WHERE to_date < NOW();  -- no subquery needed

SELECT COUNT(*)
FROM (
		SELECT emp_no-- (DISTINCT emp_no) -- NOW() BETTER THAN NOT LIKE '9%'
		FROM salaries
		WHERE to_date < NOW()
		)as s
JOIN employees ON s.emp_no = employees.emp_no;

DESCRIBE salaries;

-- 4.  department manager with F subquery from 
/* My subquery
SELECT emp_no
FROM employees
WHERE gender = 'F';*/

SELECT CONCAT(first_name, ' ', last_name)
FROM (
		SELECT emp_no, first_name, last_name 
		FROM employees
		WHERE gender = 'F') AS e
JOIN dept_manager ON e.emp_no = dept_manager.emp_no
where dept_manager.to_date = '9999-01-01';

-- 5.  employees table and salaries table
SELECT AVG(salary)
FROM salaries; 
		
SELECT COUNT(DISTINCT CONCAT(first_name, ' ', last_name))
FROM employees e
JOIN (
		SELECT *
        FROM salaries 
        WHERE salary > (SELECT AVG(salary)
						FROM salaries) AND salaries.to_date = '9999-01-01'
	 ) AS s ON e.emp_no = s.emp_no;
     
     -- 6.  > (MAX(salary)-STDDEV(salary))
     SELECT emp_no -- STDDEV(salary), AVG(salary), MAX(salary)
     FROM salaries
     WHERE salary > (MAX(salary) - STDDEV(salary));