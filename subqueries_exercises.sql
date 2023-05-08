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

-- 3.  GET BACK TO IT. 59900 -- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT COUNT(*) 
FROM employees;

SELECT COUNT(*)-- (DISTINCT emp_no) -- NOW() BETTER THAN NOT LIKE '9%'
FROM salaries
WHERE to_date > NOW();  -- no subquery needed

SELECT COUNT(DISTINCT(employees.emp_no)) - COUNT(DISTINCT(s.emp_no)) -- RIGHT JOIN PRACTICE also discovered don't need nother subquery in select statement
FROM (
		SELECT emp_no-- (DISTINCT emp_no) -- NOW() BETTER THAN NOT LIKE '9%'
		FROM salaries
		WHERE to_date >  NOW()
		) AS s
RIGHT JOIN employees ON s.emp_no = employees.emp_no;

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
/* How many current salaries are within 1 standard deviation of the current highest salary?
(Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

Hint You will likely use multiple subqueries in a variety of ways
Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. 
You will use this number (or the query that produced it) in other, larger queries. */

SELECT COUNT(*)
FROM salaries
WHERE salary > (
					SELECT MAX(salary) - STDDEV(salary) -- CURRENT MAX MINUS STANDARD DEVIATION
					FROM salaries
					WHERE to_date > NOW()
				) AND to_date > NOW();
                
SELECT COUNT(*)
FROM salaries
WHERE to_date > NOW();

-- Combine into one table

SELECT (SELECT COUNT(*)
			FROM salaries
			WHERE salary > (
					SELECT MAX(salary) - STDDEV(salary) -- CURRENT MAX MINUS STANDARD DEVIATION
					FROM salaries
					WHERE to_date > NOW()
		) AND to_date > NOW()) AS number_of_current_employees, 
        
		((SELECT COUNT(*)
			FROM salaries
			WHERE salary > (
					SELECT MAX(salary) - STDDEV(salary) -- CURRENT MAX MINUS STANDARD DEVIATION
					FROM salaries
					WHERE to_date > NOW()
		) AND to_date > NOW()) / (SELECT COUNT(*)
										FROM salaries
										WHERE to_date > NOW()) * 100) AS percent_of_current_employees
										FROM salaries
										LIMIT 1;

-- BONUS

-- 1.  Departments with female managers between department manager and employees
-- subquery on Female capture the department numbers
SELECT emp_no
FROM (
		SELECT emp_no
		FROM dept_manager
		WHERE to_date > now()
		) AS dm
JOIN employees e ON dm.emp_no = e.emp_no
WHERE e.gender = 'F';

-- LEFT JOIN department d ON dm.emp_no = d.emp_no;
        
        
        /*AND 
    	
		SELECT emp_no
		FROM employees.employees
		WHERE gender = 'F'
	);*/
	  
SELECT emp_no
FROM employees.employees
WHERE gender = 'F';

describe dept_manager;
SHOW TABLES;
                


