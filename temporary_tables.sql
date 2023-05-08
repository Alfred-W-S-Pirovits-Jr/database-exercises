USE quintela_2247;



-- 1.
/*
Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name 
for employees currently with that department. Be absolutely sure to create this table on your own database. 
If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
Update the table so that the full_name column contains the correct data.
Remove the first_name and last_name columns from the table.
What is another way you could have ended up with this same table?



*/

CREATE TEMPORARY TABLE employees_with_departments(
	first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    dept_test VARCHAR(36) NOT NULL
    );

SHOW tables; 
SELECT *
FROM employees_with_departments;
-- a
ALTER TABLE employees_with_departments ADD full_name VARCHAR(36);
-- b
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, " ", last_name);
-- c
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- part d.  Just create the concatenated column in the first place
CREATE TEMPORARY TABLE employees_with_departments(
	dept_name VARCHAR(20) NOT NULL, 
    full_name VARCHAR(36) NOT NULL
    );

-- 2.

USE sakila;

DROP TABLE if exists quintela_2247.payments;

CREATE TEMPORARY TABLE quintela_2247.payments AS
SELECT payment_id, customer_id, staff_id, rental_id, amount * 100 AS amount, payment_date, last_update 
FROM payment; 

USE quintela_2247;
SELECT * FROM payments;

-- ALTER TABLE payments MODIFY amount DECIMAL(6,2);
-- UPDATE payments SET amount = amount * 100;
ALTER TABLE payments MODIFY amount INT;

SELECT * FROM 
payments;
-- 3. 

USE employees;

/*
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
    GROUP BY dept_group;	SELECT 
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

*/
