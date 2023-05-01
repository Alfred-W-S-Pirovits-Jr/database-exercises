-- List all the databases 
SHOW DATABASES;
-- Write the SQL code necessary to use the albums_db database 
USE albums_db;
-- Show the currently selected database
SELECT database();
-- List all the tables in the database
SHOW TABLES;
-- Write the SQL code necessary to use the employees database
USE employees;
-- Show the currently sleected database 
SELECT database();
-- List all the tables in the database 
SHOW TABLES;
-- Explore the employees table
 SHOW CREATE TABLE employees; /*
 This table has int, date, varchar(14), varchar(16), 
 enum('M','F'), and another date
 */
-- Which table(s) do you think contain a numeric type column?  
--  All of them should have a primary key.  but considering that dept_emp, dept_manager, employees, slalaries, and titles all have another numeric type column.
SHOW CREATE TABLE departments;
SHOW CREATE TABLE dept_emp;
SHOW CREATE TABLE dept_manager;
SHOW CREATE TABLE employees;
SHOW CREATE TABLE salaries;
SHOW CREATE TABLE titles;
 
--  Which table(s) do you think contain a string type column?
-- departments, dept_emp, dept_manager, employees and titles

-- What is the relationship between the employees and the departments tables?
-- They have no common fields

--  Show the SQL that created the dept_manager table.  Write the sql it takes to show this as your exercise solution
SHOW CREATE TABLE dept_manager;