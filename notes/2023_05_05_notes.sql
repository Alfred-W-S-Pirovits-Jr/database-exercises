-- Subquery Lesson

USE farmers_market;

-- Let's firnd everyday where the market_min_temp is higgher than the average market_min_temp;

SELECT *
FROM market_date_info
WHERE market_min_temp < AVG(market_min_temp);  -- error because aggregate needs to be in Select

SELECT AVG(market_min_temp)
FROM market_date_info;

SELECT * 
FROM market_date_info
WHERE market_min_temp > 54.32258064516129; -- This is NOT self updating

-- Scalar subquery
/* SELECT AVG(market_min_temp)
FROM market_date_info; GOES INSIDE THE OTHER QUERY*/
SELECT * 
FROM market_date_info
WHERE market_min_temp > (
							SELECT AVG(market_min_temp)
							FROM market_date_info
                            );
                            
-- Column subquery
SHOW tables;
DESCRIBE vendor_booth_assignments;
SELECT *
FROM vendor_booth_assignments;
-- Let's find all the vendors names that worked on 2019-04-03
SELECT vendor_id
FROM vendor_booth_assignments
WHERE market_date = '2019-04-13';

SELECT * 
FROM vendor
WHERE vendor_id in (1,3,4,7,8,9);

SELECT * 
FROM vendor
WHERE vendor_id in (
					SELECT vendor_id
					FROM vendor_booth_assignments
					WHERE market_date = '2019-04-13' -- Now we can update the date directly an not have 
					);								-- to remember what to cross reference especiallly later
                    
-- Row Subquery
-- Find the first customer who bought something at the market
SELECT customer_id
FROM customer_purchases
ORDER BY market_date, transaction_time
LIMIT 1;   -- Row

SELECT * 
FROM customer
WHERE customer_id = 9; -- Hard coded not good

SELECT customer_first_name, customer_last_name
FROM customer
WHERE customer_id = (
						SELECT customer_id
						FROM customer_purchases
						ORDER BY market_date, transaction_time
						LIMIT 1
                        );
                        
-- Table Subquery

-- Let's get the purchases of all customers who live in 22821 zip code

SELECT *
FROM customer;

SELECT *
FROM customer
WHERE customer_zip = 22821;

SELECT *
FROM customer
JOIN customer_purchases USING (customer_id)
WHERE customer.customer_zip = 22821;

SELECT *
FROM customer
WHERE customer_zip = 22821;

SELECT *
FROM (
		SELECT *
		FROM customer
		WHERE customer_zip = 22821
	) AS c
JOIN customer_purchases cp ON cp.customer_id =c.customer_id;

SELECT *
FROM customer_purchases cp
JOIN (
		SELECT *
		FROM customer
		WHERE customer_zip = 22821
	) AS c ON cp.customer_id = c.customer_id