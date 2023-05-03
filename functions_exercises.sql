USE employees;

SHOW tables;

SHOW CREATE TABLE employees;
DESCRIBE employees;

-- 2.
SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';

-- 3.
SELECT first_name, last_name, UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
FROM employees 
WHERE last_name LIKE 'e%e';

-- 4. 
SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE 'e%e';

-- SELECT first_name, last_name, UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
-- FROM employees 
-- WHERE last_name LIKE 'e%e';

-- 5.
SELECT birth_date, first_name, last_name, DATEDIFF(CURDATE(), hire_date) -- AS '
FROM employees
WHERE birth_date LIKE '%12-25' AND hire_date LIKE '199%';

-- 6.
SHOW CREATE TABLE salaries;
DESCRIBE salaries;

SELECT MIN(salary), MAX(salary)
FROM salaries;

-- 7. Lowercase first character of first name
-- Lowercase first 4 characters of last name 
-- Underscore
-- Month
-- Last two digits of year

SELECT CONCAT(SUBSTR(LOWER(first_name), 1, 1), SUBSTR(LOWER(last_name), 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))AS username, 
	first_name, last_name, birth_date
FROM employees
LIMIT 10;  -- LOOK AT THE PUSH FROM TASHA!!

