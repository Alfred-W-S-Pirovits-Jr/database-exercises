USE employees;

SHOW tables;

SHOW CREATE TABLE titles;
DESCRIBE titles;

SELECT DISTINCT title, -- change this tomorrow 
	COUNT(*) count_of_unique_titles
FROM titles
GROUP BY title;
