USE employees;

SHOW tables;

SHOW CREATE TABLE employees;
DESCRIBE employees;

-- 1.  the top three are 10200, 10397, 10610
 SELECT first_name, emp_no -- SELECT * in the review
 FROM employees
 WHERE first_name IN ('Irena', 'Vidya', 'Maya');


-- 2.  no 10397, 10610, 10821 because it is searching for Irena first then Vidya and Maya instead of ordering by employee number
SELECT first_name, emp_no -- SELECT * in the review
FROM employees
WHERE first_name = 'Irena' OR 'Vidya' OR 'Maya';  -- WHERE first_name - 'Irena'
														-- OR first_name = 'Vidya'
                                                        -- OR first_name = 'Maya'. Not a decision tree like I thought it was

-- 3.  10200, 10397, 10821
SELECT first_name, emp_no
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya') AND gender = 'M';  -- Dang it I misread the OR as an IN 
-- WHERE (first_name =  'Irena'
	-- OR first_name = 'Vidya'
	-- OR first_name = 'Maya')
    -- AND gender = 'M'

-- 4. 
SELECT DISTINCT last_name -- SELECT *
FROM employees
WHERE last_name LIKE 'E%';  -- MY NOTES _ IS WILDCARD FOR ONE CHARACTER?

-- 5.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE 'E%' OR '%E';  -- WHERE last_name LIKE 'E%'
										-- OR last_name LIKE '%E'

-- 6.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%E'; -- WHERE last_name LIKE 'E%'
								-- AND last_name NOT LIKE '%E'. I NEED TO READ THE QUESTIONS MORE CAREFULLY!!!!!

-- 7.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE 'E%E';

-- 8. 10008, 10011, 10012
SELECT first_name, last_name, emp_no -- Ryan used SELECT * to get bearings first
FROM employees
WHERE hire_date LIKE '199%';

-- 9. 10078, 10115, 10261
SELECT first_name, last_name, emp_no
FROM employees
WHERE birth_date LIKE '%12-25';

-- 10. 10261, 10438, 10681
SELECT first_name, last_name, emp_no
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%12-25';

-- 11.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%';

-- 12.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';