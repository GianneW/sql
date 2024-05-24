-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors,  product names are there (x)? 9*23
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

--	select DISTINCT vendor_id, product_id
-- from vendor_inventory;
-- return 8 ROWS
-- x*y = 8*26 = 208
WITH Sales_Five AS (
    SELECT DISTINCT vi.vendor_id, vi.product_id, vi.original_price,
        c.customer_id,
        5 * vi.original_price AS five_revenue
    FROM vendor_inventory vi
    CROSS JOIN customer c )

SELECT v.vendor_name, p.product_name,
    SUM(sf.five_revenue) AS total_revenue
FROM Sales_Five as sf
JOIN vendor v ON sf.vendor_id = v.vendor_id
JOIN product p ON sf.product_id = p.product_id
GROUP BY v.vendor_name, p.product_name;



-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */
DROP TABLE IF EXISTS temp.product_units;
CREATE TEMP TABLE product_units AS
	SELECT * , CURRENT_TIMESTAMP AS snapshot_timestamp
	FROM product
	WHERE product_qty_type = 'unit';
	
SELECT * FROM product_units;




/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */
INSERT INTO product_units
VALUES(8,'Cherry Pie','10" ',3,'unit', CURRENT_TIMESTAMP);

SELECT * FROM product_units;


-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/
DELETE FROM product_units
WHERE product_id = 8
  AND snapshot_timestamp < (
    SELECT MAX(snapshot_timestamp) --it will delete more than one old records, I am still thinking of it
    FROM product_units
    WHERE product_id = 8
);

SELECT * FROM product_units;

-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */

ALTER TABLE product_units
ADD current_quantity INT;

SELECT * FROM product_units;

WITH LastQuantityPerProduct AS (
    SELECT product_id,  quantity AS last_quantity
		-- since one product is only sold by one vendor, we don't need to sum here
    FROM (
        SELECT vendor_id, product_id, quantity, market_date,
            ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY market_date DESC) AS row_num
        FROM vendor_inventory) vi --I use vi and row_num to find the most recent date quantity
    WHERE row_num = 1)

UPDATE product_units
SET current_quantity = COALESCE((
    SELECT last_quantity
    FROM LastQuantityPerProduct lqp
    WHERE product_units.product_id = lqp.product_id
), 0);

SELECT * FROM product_units;

