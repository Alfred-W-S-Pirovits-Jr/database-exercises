USE employees;

SHOW tables;

DESCRIBE departments; 
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;

-- 1.  Write a query that returns all employees, their department number, their start date, their end date, and a new column 
-- 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.

SELECT *, IF(to_date > NOW(), True, False) AS 'is_current_employee'
FROM dept_emp;


-- 2.  Write a query that returns all employee names (previous and current), and a new column 
-- 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.


/* FOR SYNTAX 
SELECT
    dept_name,
    CASE
        WHEN dept_name IN ('Marketing', 'Sales') THEN 'Money Makers'
        WHEN dept_name LIKE '%research%' OR dept_name LIKE '%resources%' THEN 'People People'
        ELSE 'Others'
    END AS department_categories
FROM departments;
*/

SELECT 
	CONCAT(first_name, ' ', last_name), 
		CASE
			WHEN last_name BETWEEN 'A' AND 'I' THEN 'A-H'
            WHEN last_name BETWEEN 'I' AND 'R' THEN 'I-Q'
            ELSE 'R-Z'
		END AS 'alpha_group'
FROM employees;

-- 3.  How many employees were born in each decade
SELECT 
	CASE
		WHEN birth_date LIKE '195%' THEN '50\'s'
        WHEN birth_date LIKE '196%' THEN '60\'s'
	END AS decade_born, COUNT(*)
FROM employees
GROUP BY decade_born;

-- 4.  
-- SELECT dept_group, salary
-- FROM (
	SELECT 
		CASE
			WHEN dept_name IN ('research', 'development') THEN 'R&D'
			WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
			WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
		ELSE dept_name
	END AS dept_group, AVG(salary)
	FROM departments AS a
    -- JOIN departments ON departments.dept_name = a.dept_name
    JOIN dept_emp ON a.dept_no = dept_emp.dept_no
    JOIN salaries USING (emp_no)
    WHERE salaries.to_date > NOW()
    GROUP BY dept_group;
 --   HAVING to_date > NOW();
    -- GROUP BY dept_group;