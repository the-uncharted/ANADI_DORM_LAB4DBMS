-- An E-commerce website manages its data in the form of various tables.
-- 1). You are required to create tables for supplier,customer,category,product,supplier_pricing,order,rating to store the data for the E-commerce with the schema definition given below.

-- CREATE DATABASE OF E-COMMERCE WEBSITE
CREATE DATABASE Website;
USE website;

-- CREATE TABLE FOR SUPPLIER
CREATE TABLE supplier(
SUPP_ID INT PRIMARY KEY,
SUPP_NAME VARCHAR(50) NOT NULL,
SUPP_CITY VARCHAR(50) NOT NULL,
SUPP_PHONE VARCHAR(50) NOT NULL
);

-- CREATE TABLE FOR CUSTOMER
CREATE TABLE customer(
CUS_ID INT PRIMARY KEY,
CUS_NAME VARCHAR(20) NOT NULL,
CUS_PHONE VARCHAR(10) NOT NULL,
CUS_CITY VARCHAR(30) NOT NULL,
CUS_GENDER CHAR
);

-- CREATE TABLE FOR CATEGORY
CREATE TABLE category(
CAT_ID INT PRIMARY KEY,
CAT_NAME VARCHAR(20) NOT NULL
);

-- CREATE TABLE FOR PRODUCT
CREATE TABLE product(
PRO_ID INT PRIMARY KEY,
PRO_NAME VARCHAR(20) NOT NULL DEFAULT "Dummy",
PRO_DESC VARCHAR(60),
CAT_ID INT,
FOREIGN KEY (CAT_ID) REFERENCES category(CAT_ID)
);

-- CREATE TABLE FOR SUPPLIER_PRICING
CREATE TABLE supplier_pricing(
PRICING_ID INT PRIMARY KEY,
PRO_ID INT,
FOREIGN KEY(PRO_ID) REFERENCES product(PRO_ID),
SUPP_ID INT,
FOREIGN KEY(SUPP_ID) REFERENCES supplier(SUPP_ID),
SUPP_PRICE INT DEFAULT 0
);

-- CREATE TABLE FOR ORDER
CREATE TABLE orders(
ORD_ID INT PRIMARY KEY,
ORD_AMOUNT INT NOT NULL,
ORD_DATE DATE NOT NULL,
CUS_ID INT ,
FOREIGN KEY(CUS_ID) REFERENCES customer(CUS_ID),
PRICING_ID INT ,
FOREIGN KEY(PRICING_ID) REFERENCES supplier_pricing(PRICING_ID)
);

-- CREATE TABLE FOR RATING
CREATE TABLE rating(
RAT_ID INT PRIMARY KEY,
ORD_ID INT,
FOREIGN KEY(ORD_ID) REFERENCES orders(ORD_ID),
RAT_RATSTARS INT NOT NULL
);


-- 2). Insert the following data in the table created above

-- INSERT RECORDS IN SUPPLIER TABLE
INSERT INTO supplier VALUES(1,'Rajesh Retails','Delhi',1234567890),
			   (2,'Appario Ltd.','Mumbai',2589631470),
                           (3,'Knome products','Banglore',9785462315),
                           (4,'Bansal Retails','Kochi',8975463285),
                           (5,'Mittal Ltd.','Lucknow',7898456532);

 -- INSERT RECORDS IN CUSTOMER TABLE
INSERT INTO customer VALUES(1,'AAKASH',9999999999,'DELHI','M'),
			   (2,'AMAN',9785463215	,'NOIDA','M'),
                           (3,'NEHA',9999999999,'MUMBAI','F'),
                           (4,'MEGHA',9994562399,'KOLKATA','F'),
                           (5,'PULKIT',7895999999,'LUCKNOW','M');
                           
-- INSERT RECORDS IN CATEGORY TABLE
INSERT INTO category VALUES(1,'BOOKS'),
			   (2,'GAMES'),
                           (3,'GROCERIES'),
                           (4,'ELECTRONICS'),
                           (5,	'CLOTHES');
                            
-- INSERT RECORDS IN PRODUCT TABLE
INSERT INTO product VALUES(1,'GTA V','Windows 7 and above with i5 processor and 8GB RAM	',2),
			  (2,'TSHIRT','SIZE-L with Black, Blue and White variations',5),
			  (3,'ROG LAPTOP',' Windows 10 with 15inch screen, i7 processor, 1TB SSD',4),
			  (4,'OATS ','Highly Nutritious from Nestle',3),
			  (5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1),
			  (6,'MILK','1L Toned MIlk',3),
			  (7,'Boat Earphones','1.5Meter long Dolby Atmos',4),
			  (8,'Jeans','Stretchable Denim Jeans with various sizes and color',5),
			  (9,'Project IGI','compatible with windows 7 and above',2),
			  (10,'Hoodie','Black GUCCI for 13 yrs and above',5),
			  (11,'Rich Dad Poor Dad','Written by RObert Kiyosaki',1),
			  (12,'Train Your Brain','By Shireen Stephen',1);
                          
-- INSERT RECORDS IN SUPPLIER_PRICING TABLE
INSERT INTO supplier_pricing VALUES(1,1,2,1500),
			           (2,3,5,30000),
                                   (3,5,1,3000),
                                   (4,2,3,2500),
			           (5,4,1,1000),
                                   (6,12,2,780),
                                   (7,12,4,789),
				   (8,3,1,31000),
				   (9,1,5,1450),
				   (10,4,2,999),
				   (11,7,3,549),
				   (12,7,4,529),
				   (13,6,2,105),
				   (14,6,1,99),
				   (15,2,5,2999),
				   (16,5,2,2999);
				   
-- INSERT RECORDS IN ORDER TABLE
INSERT INTO orders VALUES(101,1500,'2021-10-06',2, 1),
			 (102,1000,'2021-10-12',3, 5),
			 (103,30000,'2021-09-16',5,2),
			 (104,1500,'2021-10-05',1, 1),
			 (105,3000,'2021-08-16',4, 3),
			 (106,1450,'2021-08-18',1, 9),
			 (107,789,'2021-09-01', 3, 7),
			 (108,780,'2021-09-07',5,  6),
			 (109,3000,'2021-09-10',5, 3),
			 (110,2500,'2021-09-10',2, 4),
			 (111,1000,'2021-09-15',4, 5),
			 (112,789,'2021-09-16',4,  7),
			 (113,31000,'2021-09-16',1,8),
			 (114,1000,'2021-09-16',3, 5),
			 (115,3000,'2021-09-16',5, 3),
			 (116,99,'2021-09-17',2 , 14);
                                                   
-- INSERT RECORDS IN RATING TABLE
INSERT INTO rating VALUES(1,101,4),
			 (2,102,3),
			 (3,103,1),
			 (4,104,2),
			 (5,105,4),
			 (6,106,3),
			 (7,107,4),
			 (8,108,4),
			 (9,109,3),
			 (10,110,5),
			 (11,111,3),
			 (12,112,4),
			 (13,113,2),
			 (14,114,1),
			 (15,115,1),
			 (16,116,0);



-- 3).Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.

SELECT COUNT(CUS_GENDER) AS TotalNoOfCustomers,CUS_GENDER
FROM
(
SELECT CUS_GENDER,CUS_NAME FROM customer AS CUS
INNER JOIN
(
SELECT ORD_ID,CUS_ID FROM orders WHERE ORD_AMOUNT >=3000
)
AS O
ON CUS.CUS_ID = O.CUS_ID
GROUP BY CUS.CUS_ID
)
AS T
GROUP BY CUS_GENDER;



-- 4).Display all the orders along with product name ordered by a customer having Customer_Id=2.

SELECT product.PRO_NAME, orders.* 
FROM orders, supplier_pricing, product
WHERE orders.CUS_ID=2 
AND orders.PRICING_ID=supplier_pricing.PRICING_ID 
AND supplier_pricing.PRO_ID=product.PRO_ID;

-- 5).Display the Supplier details who can supply more than one product.

 SELECT supplier.* 
FROM supplier 
WHERE supplier.SUPP_ID in
( SELECT SUPP_ID
   FROM supplier_pricing
   GROUP BY SUPP_ID
   having count(SUPP_ID)>1)
GROUP BY supplier.SUPP_ID;

-- 6). Find the least expensive product from each category and print the table with category id, name, product name and price of the product

SELECT category.CAT_ID,category.CAT_NAME, MIN(t3.min_price) as Min_Price
 FROM category 
 INNER JOIN
   (SELECT product.CAT_ID, PRO_NAME, t2.*
    FROM  product 
     INNER JOIN
       (SELECT PRO_ID, MIN(SUPP_PRICE) as Min_Price
        FROM  supplier_pricing GROUP BY PRO_ID)
        as t2 WHERE t2.PRO_ID = product.PRO_ID)
        as t3 WHERE t3.CAT_ID = category.CAT_ID GROUP BY t3.CAT_ID;
        
-- 7). Display the Id and Name of the Product ordered after “2021-10-05”.

 SELECT product.PRO_ID,product.PRO_NAME
FROM orders
  INNER JOIN
	supplier_pricing ON supplier_pricing.PRICING_ID = orders.PRICING_ID 
	 INNER JOIN
	  product on product.PRO_ID = supplier_pricing.PRO_ID
	  WHERE orders.ORD_DATE>"2021-10-05";
 
 -- 8). Display customer name and gender whose names start or end with character 'A'.
 
   SELECT customer.CUS_NAME,customer.CUS_GENDER
  FROM customer 
  WHERE customer.CUS_NAME LIKE 'A%' OR customer.CUS_NAME LIKE '%A';
  
  -- 9).Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.
  
 --  Step-1. Create a new procedure using MySQL Workbench.
DELIMITER //
CREATE PROCEDURE proc()
--  Step-2. Embed the following block of code within the BEGIN and END statements
BEGIN
SELECT report.supp_id,report.supp_name,report.Average,
CASE
WHEN report.Average =5 THEN 'Excellent Service'
WHEN report.Average >4 THEN 'Good Service'
WHEN report.Average >2 THEN 'Average Service'
ELSE 'Poor Service'
END AS Type_of_Service FROM
(SELECT final.SUPP_ID, supplier.SUPP_NAME, final.Average 
FROM
   (SELECT test2.SUPP_ID, SUM(test2.rat_ratstars)/COUNT(test2.rat_ratstars) AS Average 
     FROM
        (SELECT supplier_pricing.SUPP_ID, test.ORD_ID, test.RAT_RATSTARS 
              FROM supplier_pricing 
                INNER JOIN
                    (SELECT orders.PRICING_ID, rating.ORD_ID, rating.RAT_RATSTARS  
                          FROM orders  
                             INNER JOIN  
                                  rating ON rating.ORD_ID = orders.ORD_ID ) AS test
                                     ON test.PRICING_ID = supplier_pricing.PRICING_ID)
                                          AS test2 group by supplier_pricing.SUPP_ID)
                                             AS final 
                                               INNER JOIN 
                                                 supplier WHERE final.SUPP_ID = supplier.SUPP_ID) AS report;
END 
//
DELIMITER ;
 -- Step-3. Invoke the procedure using the following statement
 call proc();
