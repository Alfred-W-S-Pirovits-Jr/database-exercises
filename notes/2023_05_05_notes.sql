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
JOIN customer_purchases USING (customer_id);
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
	) AS c ON cp.customer_id = c.customer_id;
    
USE farmers_market;

SELECT *,
	CASE booth_type
		WHEN 'Standard' THEN 1
        ELSE 0 -- CASE STATEMENT IS A NEW COLLLUM
	END AS is_standard
FROM booth;

SELECT *
FROM product_category;

SELECT product_category_name,
	CASE
		WHEN product_category_name LIKE '%fresh%' THEN 'Fresh'
		WHEN product_category_name LIKE '%packaged%' THEN 'Packaged'
        -- MISSED STUFF FROM LECTURE
        ELSE 'Non-Edible'
        -- ELSE procuct_category_name
	END
FROM product_category;

SELECT DISTINCT cost_to_customer_per_quy
FROM customer_purchases
ORDER BY cost_to_customer_per_gty;
-- 'Low-end <= 1, 'MID-RANGE' > 1 AND <5, High-end > 5
SELECT *,
	CASE
		WHEN cost_to_customer_per_qty <= 1 THEN 'Low-end'
        WHEN cost_to_customer_per_qty BETWEEN 1 AND 5 THEN 'MID RANGE'
        WHEN cost_to_customer_per_qty >= 5 THEN 'High-End'
    END
FROM customer_purchases;

-- IF() function
SELECT *,
	IF(quantity > (SELECT AVG(quantity) FROM customer_purchases), 'Large Purchases', 'Normal Purchase') AS purchase_type
FROM customer_purchases;

-- Rewritting a SIMPLE case as an if
SELECT *,
	CASE booth_type
		WHEN 'Standard' THEN 1
        ELSE 0 -- CASE STATEMENT IS A NEW COLLLUM
	END AS is_standard
FROM booth;

SELECT *,
	IF(booth_type = 'Standard', 1, 0)
FROM booth;

-- Pivot Table
-- need info from booth and vendors but need a joiner table
SELECT vendor_name,
	COUNT(CASE WHEN booth_type = 'Standard' THEN booth_type ELSE NULL END) AS 'Standard',
    COUNT(CASE WHEN booth_type = 'Large' THEN booth_type ELSE NULL END) AS 'Large',
    COUNT(CASE WHEN booth_type = 'Small' THEN booth_type ELSE NULL END) AS 'Small'
FROM vendor_booth_assignments vba
JOIN vendor v USING (vendor_id) -- USING FOR WHEN JOINING ON A COMMON COLUMN NAME
JOIN booth b USING (booth_number)
GROUP BY vendor_name; -- since using aggregates group by non-aggregates

SELECT vendor_name,
	COUNT(CASE WHEN booth_type = 'Standard' THEN booth_type ELSE NULL END) AS 'Standard',
    
       COUNT(CASE WHEN booth_type = 'Large' THEN booth_type ELSE NULL END) AS 'Large',
    COUNT(CASE WHEN booth_type = 'Small' THEN booth_type ELSE NULL END) AS 'Small'
FROM vendor_booth_assignments vba
JOIN vendor v ON v.vendor_id = vba.vendor_id AND v.vendor_type LIKE '%fresh%' -- USING FOR WHEN JOINING ON A COMMON COLUMN NAME
JOIN booth b USING (booth_number)
GROUP BY vendor_name; -- since using aggregates group by non-aggregates