USE farmers_market;

SELECT database();

SHOW tables;

SELECT * FROM customer;

SELECT *
FROM product; -- another formatting option especially for longer queries

SELECT product_id, product_name -- Selecting columns from a table
FROM product;

 -- Aliases use AS to change the name
 SELECT product_id AS id_of_product, product_name AS name_of_product
 FROM product;
 
  -- Aliases use AS to change the name
 SELECT product_id AS id_of_product, 
	product_name AS name_of_product
 FROM product;
 
SELECT * 
 FROM product;
 
 -- To filter rows, we need to use the WHERE clause
 -- FORMAT: SELECT * FROM [table] WHERE [condition]
 -- condition FORMAT: [column_name] operator [value]
 
 -- only the products sold by the pound
 SELECT * 
 FROM product
 WHERE product_qty_type = 'lbs';
 -- only the products sold by the size medium
 SELECT * 
 FROM product 
 WHERE product_size = 'medium';
 
 -- not equal: != or <>
 SELECT * 
 FROM product
 WHERE product_category_id != 1;
 
 -- switch to the product category table
 SELECT *
 FROM product_category;
 
 SELECT * 
 FROM customer_purchases;
 
 SELECT *
 FROM customer_purchases
 WHERE cost_to_customer_per_qty < 1;
 
 SELECT * 
 FROM customer_purchases
 WHERE cost_to_customer_per_gty > 1;
 
 SELECT * 
 FROM customer_purchases
 WHERE cost_to_customer_per_qty BETWEEN 0.99 AND 3.00; -- EXCLUSIVE ON THE LEFT SIDE AND INCLUSIVE ON THE RIGHT
 
 -- DISTINCT - show me all the unique thing s of this
 SELECT DISTINCT vendor_id
 FROM customer_purchases;
 -- only vendors 7,8 and 4 are on the customer_purchases table
 
 SELECT DISTINCT product_id, vendor_id
 FROM customer_purchases;
 -- distinct combinations of product_id and vendor_id 
 
 SELECT 'I am output';
 
 
 -- Clauses: WHERE Advanced
 
 --  BETWEEN already done
 
 
 -- LIKE / NOT LIKE
 
 USE farmers_market;
 
 
 SELECT *
 FROM customer
 WHERE customer_first_name LIKE '%ll%';
 
  SELECT * 
  FROM customer
  WHERE customer_first_name NOT LIKE 'J%';
  
  -- IN 
  SELECT * 
  FROM customer 
  WHERE customer_first_name IN ('Bob', 'Betty');  
  
  SELECT * 
  FROM customer
  WHERE customer_first_name IN ('Bob', 'Betty');
  
   -- NULL / NOT NULL
   SELECT *
   FROM product
   WHERE product_qty_type IS NULL;
   
   SELECT *
   FROM product
   WHERE product_qty_type IS NOT NULL;
   
   SELECT *
   FROM product
   WHERE product_size = 'medium'
		AND product_qty_type = 'lbs';
        
	SELECT *
    FROM product
    WHERE product_size = 'medium'
		OR product_qty_type = 'lbs';
        
	SELECT *
    FROM produc†s
    -- product_category_id 1 is FRESH PRODUCE 
	WHERE (product_size = 'medium' AND product_category_id = 1) 
		OR product_qty_type = 'lbs';
        
	
	
   