USE 311_data;

-- LIMIT limits the number of return rows
SELECT * 
FROM cases;

SELECT *
FROM cases
LIMIT 10;

-- OFFSET lets us skip ahead
SELECT *
FROM cases
LIMIT 10 OFFSET 10;

 -- Functions Lesson
 
 -- Numeric Functions
 
 USE farmers_market;
 
 SELECT *
 FROM customer_purchases;
 
SELECT AVG(quantity)
FROM customer_purchases;

SELECT AVG(quantity), MIN(quantity), MAX(quantity)
FROM customer_purchases;

-- String Functions

SELECT *
FROM customer;

SELECT customer_first_name, customer_last_name, CONCAT(customer_first_name, ' ', customer_last_name)
FROM customer;

-- or better formatting with an alias
Select customer_first_name, 
	customer_last_name, 
    Concat(customer_first_name, ' ', customer_last_name) AS customer_full_name 
FROM customer;

-- SUBSTR index starts with one
SELECT product_name, SUBSTR(product_name, 1, 10) -- SUBSTR(string, start_index, length) indices start with 1 in SQL 
FROM product;

-- UPPER AND LOWER
SELECT customer_first_name, UPPER(customer_first_name), LOWER(customer_first_name)
FROM customer;

-- REPLACE replace medium with m in procuct_size
SELECT product_size, REPLACE(product_size, 'medium', 'M')
FROM product;

-- Date Functions
SELECT NOW(); -- Get the datetime for right now

SELECT CURDATE();  -- Get the date for right now

SELECT CURTIME(); -- Get the time for right now

SELECT UNIX_TIMESTAMP();  -- unix epoch

SELECT UNIX_TIMESTAMP('1982-08-23 21:30:00');

-- SELECT CONCAT(
	-- 'Teaching data science at Codeup for '
	-- UNIX_TIMESTAMP() - UNIX_TIMESTAMP('2022-05-23'),
    -- ' seconds'
-- );
   
   SELECT CONCAT(
    'Teaching people to code for ',
    UNIX_TIMESTAMP() - UNIX_TIMESTAMP('2014-02-04'),
    ' seconds'
);

-- Casting 
SELECT 2 + '2';

SELECT '10' - 5;

SELECT CONCAT('HERE IS A NUMBER ', 5000)	

SELECT COUNT(first_name)
FROM employees
WHERE first_name NOT LIKE '%a%';



USE farmers_market;

SELECT DISTINCT customer_first_name
FROM customer;

SELECT customer_first_name
FROM customer
GROUP BY customer_first_name;

-- these two do the same

SELECT customer_first_name, customer_last_name
FROM customer
GROUP BY customer_first_name, customer_last_name;

-- you can use Group by with aggregation functions
SELECT customer_id
FROM customer_purchases
GROUP BY customer_id; -- customer id one time

SELECT customer_id, -- customer_id id,
	COUNT(*) n_of_purchases-- COUNT ALL  and you don't need AS for any renaming
FROM customer_purchases
GROUP BY customer_id; -- customer id one time aggregated with the purchases giving us 
-- the number of purchases for that customer 246 rows customer id 1 appears

SELECT customer_id,
	COUNT(*) n_of_purchases
FROM customer_purchases
GROUP BY customer_id
HAVING COUNT(*) > 200;
/* SQL queries run in this order FROM + JOIN, WHERE, GROUP BY, HAVING, SELECT, ORDER BY, LIMIT
WHERE IS INFORMATION ALREADY IN THE TABLE
HAVING IS INFORMATION YOU ARE CREATING */

SELECT *
FROM customer_purchases
WHERE cost_to_customer_per_qty > 4
GROUP BY customer_id; -- error because you didn't specifically customer_id in statemnt

SELECT customer_id,
	COUNT(*) n_of_high_end_purchases
FROM customer_purchases
WHERE cost_to_customer_per_qty > 4 -- WHERE based on columns already in the table
GROUP BY customer_id
HAVING n_of_high_end_purchases < 100; -- HAVING is for columns created by aggregations we cooked up 