USE farmers_market;
 
 DESCRIBE vendor_booth_assignments;
 SHOW CREATE TABLE vendor_booth_assignments;
 
/* 'CREATE TABLE `vendor_booth_assignments` (
  `vendor_id` int NOT NULL,
  `booth_number` int NOT NULL,
  `market_date` date NOT NULL,
  PRIMARY KEY (`vendor_id`,`booth_number`,`market_date`),
  KEY `market_date_fk_idx` (`market_date`),
  KEY `booth_number_fk_idx` (`booth_number`),
  CONSTRAINT `booth_number_fk` FOREIGN KEY (`booth_number`) REFERENCES `booth` (`booth_number`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `market_date_fk` FOREIGN KEY (`market_date`) REFERENCES `market_date_info` (`market_date`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `vendor_id_fk` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'*/

 -- 3 Primary keys all FOREIGN KEYS.  This is a joiner table.

 SELECT * 
 FROM vendor_booth_assignments; 
 
DESCRIBE vendor; -- UNI=unique vender requirement

SHOW CREATE TABLE vendor;

/*'CREATE TABLE `vendor` (
  `vendor_id` int NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(45) NOT NULL,
  `vendor_type` varchar(45) NOT NULL,
  `vendor_owner_first_name` varchar(45) NOT NULL,
  `vendor_owner_last_name` varchar(45) NOT NULL,
  PRIMARY KEY (`vendor_id`),
  UNIQUE KEY `vendor_id_UNIQUE` (`vendor_id`),
  UNIQUE KEY `vendor_name_UNIQUE` (`vendor_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'*/

-- vendor_id and vendor_name are required to be uique

SELECT * 
FROM vendor;

SELECT *
FROM vendor_booth_assignments;

SELECT *
FROM vendor_booth_assignments
JOIN vendor ON vendor_booth_assignments.vendor_id =vendor.vendor_id;

DESCRIBE booth;
SHOW CREATE TABLE booth;

/* 'CREATE TABLE `booth` (
  `booth_number` int NOT NULL,
  `booth_price_level` varchar(45) NOT NULL,
  `booth_description` varchar(255) NOT NULL,
  `booth_type` varchar(45) NOT NULL,
  PRIMARY KEY (`booth_number`),
  UNIQUE KEY `booth_number_UNIQUE` (`booth_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'*/

SELECT *
FROM vendor_booth_assignments
JOIN vendor ON vendor_booth_assignments.vendor_id =vendor.vendor_id
JOIN booth ON booth.booth_number = vendor_booth_assignments.booth_number;

DESCRIBE booth;
DESCRIBE vendor;

SELECT vendor.vendor_name,
	booth.booth_number,
    booth.booth_description
FROM vendor_booth_assignments
JOIN vendor ON vendor_booth_assignments.vendor_id =vendor.vendor_id
JOIN booth ON booth.booth_number = vendor_booth_assignments.booth_number;

-- Clean up with aliases

SELECT v.vendor_name,
	b.booth_number,
    b.booth_description
FROM vendor_booth_assignments AS vba
JOIN vendor AS v ON vba.vendor_id =v.vendor_id
JOIN booth AS b ON b.booth_number = vba.booth_number;

SELECT *
FROM vendor_inventory;

DESCRIBE vendor_inventory;

SHOW CREATE TABLE vendor_inventory;

/*'CREATE TABLE `vendor_inventory` (
  `market_date` date NOT NULL,
  `quantity` decimal(16,2) DEFAULT NULL,
  `vendor_id` int NOT NULL,
  `product_id` int NOT NULL,
  `original_price` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`product_id`,`vendor_id`,`market_date`),
  KEY `fk_vendor_inventory_vendor1_idx` (`vendor_id`),
  KEY `fk_vendor_inventory_product1_idx` (`product_id`),
  CONSTRAINT `fk_vendor_inventory_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `fk_vendor_inventory_vendor1` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'*/

SELECT *
FROM product;

SELECT * 
FROM vendor_inventory;

SELECT *
FROM vendor;

SHOW tables; 

SELECT *
FROM vendor_inventory vi
JOIN product p ON vi.product_id = p.product_id
JOIN vendor v On vi.vendor_id = v.vendor_id;

-- Clean up
SELECT vi.market_date,
	vi.quantity,
	p.product_qty_type,
    p.product_name,
    v.vendor_name
FROM vendor_inventory vi
JOIN product p ON vi.product_id = p.product_id
JOIN vendor v On vi.vendor_id = v.vendor_id;