USE employees;

SHOW tables;

SHOW CREATE TABLE employees;
DESCRIBE employees;

-- 2.  Irena Reytenauer first and Vidya Simmen last
SELECT first_name, last_name
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- 3.  Irena Acton first and Vidya Zweizig last
SELECT first_name, last_name
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;


-- 4.  Irena Acton first and Vidya Zweizig last 
-- I read the table wrong Maya Zyda is the correct answer. 
-- I didn't scroll all the way down and read off the second to last.
SELECT first_name, last_name 
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- 5.   899 rows returned 10021 Ramzi Erde 499648 Tadahiro Erde
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY emp_no;

-- 6.   899 rows returned Teiji Eldridge is newest and Sergi Erde is the oldest
SELECT first_name, last_name, hire_date
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY hire_date DESC;

-- 7. 346 rows  is oldest employee (BY AGE) who was hired last (most recently hired) is Vidya VanScheik
-- and Lena Lenart is the youngest employee (BY AGE) who was hired first (first person hired on Christmas) 
SELECT birth_date, first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '199%' AND hire_date LIKE '%12-25'
ORDER BY hire_date DESC, birth_date; -- Do I really need the ASC?
-- class did birth_date, hire_date DESC
