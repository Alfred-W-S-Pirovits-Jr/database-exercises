USE employees;

SHOW tables;

DESCRIBE employees;
DESCRIBE titles;

SELECT DISTINCT title FROM titles;

-- 2. 
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- 3. Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup
SELECT birth_date, first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5;

-- 4.  p = page number l = limit o = offset
--  p = o/l + 1
SELECT birth_date, first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45;