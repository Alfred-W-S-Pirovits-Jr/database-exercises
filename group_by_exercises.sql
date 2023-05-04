USE employees;

SHOW tables;

SHOW CREATE TABLE titles;
DESCRIBE titles;

SHOW CREATE TABLE employees;
DESCRIBE employees;

-- 2. Seven
SELECT DISTINCT title 
FROM titles;
	
-- 3.  
SELECT last_name -- Do I need distinct?  NO
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;

-- 4. 
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name, first_name;

-- OR
SELECT DISTINCT first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e';

-- 5. Chieq, Lindqvist, Qiwen
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

-- 6.  Chieq 189, Lindqvist 190, Qiwen 168
SELECT last_name, COUNT(*) n_last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

-- 7. 
SELECT first_name, gender, COUNT(*) n_last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;

-- 8. 
SELECT CONCAT(
	SUBSTR(LOWER(first_name), 1, 1), 
    SUBSTR(LOWER(last_name), 1, 4), '_', 
    SUBSTR(birth_date, 6, 2), 
    SUBSTR(birth_date, 3, 2)
    ) AS username, 
	COUNT(*)
FROM employees
GROUP BY username;

-- 9. Yes and the highest number of times a user name shows up is 6 times

SELECT CONCAT(
	SUBSTR(LOWER(first_name), 1, 1), 
    SUBSTR(LOWER(last_name), 1, 4), '_', 
    SUBSTR(birth_date, 6, 2), 
    SUBSTR(birth_date, 3, 2)
    ) AS username, 
	COUNT(*) n_users
FROM employees
GROUP BY username
ORDER BY n_users DESC;

-- 9. BONUS 13251 unique duplicated usernames 27403 total users with problem
SELECT COUNT(*), SUM(n_users)
FROM (SELECT CONCAT(  -- The Select is from the temporary table created in the previous step
	SUBSTR(LOWER(first_name), 1, 1), 
    SUBSTR(LOWER(last_name), 1, 4), '_', 
    SUBSTR(birth_date, 6, 2), 
    SUBSTR(birth_date, 3, 2)
    ) AS username, 
	COUNT(*) n_users
FROM employees
GROUP BY username
HAVING n_users > 1 
ORDER BY n_users DESC) AS duplicates;

-- MORE BONUS
SHOW tables;

DESCRIBE salaries;

-- historic average salary does not account for how long the employee had the salaries.
SELECT emp_no, AVG(salary) 
FROM salaries
GROUP BY emp_no;

-- count how many employees working currently in each department
SELECT dept_no, COUNT(emp_no) n_employees_per_dept
FROM dept_emp
WHERE to_date NOT LIKE '9999-01-01'
GROUP BY dept_no;

SELECT * 
FROM salaries;
-- how many different salaries has an employee had 
SELECT emp_no, COUNT(salary) n_different_salaries
FROM salaries
GROUP BY emp_no;

-- FIND THE MAXIMUM, MINIMUM AND STANDARD DEVIATION SALARY FOR EACH EMPLOYEE
SELECT emp_no, MAX(salary) AS max_salary, MIN(salary) AS min_salary, STDDEV(salary) AS sigma_salary
FROM salaries
GROUP BY emp_no;

-- Find max salary for each employee wheer max_salary greater than $150,000
SELECT emp_no, MAX(salary)
FROM salaries
GROUP BY emp_no
HAVING MAX(salary) > 150000;

-- Find the average salary for each employee where that average salary is between $80k and $90k
SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no
HAVING AVG(salary) BETWEEN 80000 AND 90000
ORDER BY AVG(salary);
