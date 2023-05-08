--  Temporary Tables

USE curie_949;

CREATE TEMPORARY TABLE my_numbers_2(
	n INT UNSIGNED NOT NULL -- n is the name of the column
);

SELECT * FROM my_numbers_2;

INSERT INTO my_numbers_2(n) VALUES (1), (2), (3), (4), (5);

SELECT * FROM my_numbers_2;

CREATE TEMPORARY TABLE student_names(
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);

SELECT * FROM student_names;

INSERT INTO student_names(first_name, last_name) VALUES('Ryan', 'McCall'), ('John', 'Grinstead'), ('Brooke', 'Holyoak');

SELECT * FROM student_names;

SELECT * FROM my_numbers;

UPDATE my_numbers SET n = n+1;

DELETE FROM my_numbers WHERE N % 2 = 0;

SELECT * FROM my_numbers;