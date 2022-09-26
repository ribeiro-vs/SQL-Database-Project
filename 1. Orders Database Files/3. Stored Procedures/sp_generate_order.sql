--CREATE PROCEDURE sp_generate_order
--AS
--  BEGIN
DECLARE @customer_id INT = 1
DECLARE @product_id INT = 1
DECLARE @quantity INT = 1
DECLARE @orderdate DATETIME = Getutcdate()
DECLARE @totalamount INT 

DECLARE @order_item TABLE
  (
     orderid   INT,
     productid INT,
     unitprice INT,
     quantity  INT
  )
DECLARE @order TABLE
  (
     orderdate   DATE,
     ordernumber INT,--see how it is in the ddl query
     customerid  INT,
     totalamount INT
  )

BEGIN TRAN

DECLARE @unitprice INT

--1	  --bring unit price and other values to oi / not order_id
INSERT INTO @order_item
SELECT NULL,
       @product_id,
       unitprice,
       @quantity
FROM   product
WHERE  id = @product_id

--test
SELECT *
FROM   @order_item

--2	  --trying to bring ordernumber formatted into order
INSERT INTO @order
SELECT TOP 1 @orderdate,
             ordernumber + 1 AS new_ordernumber,
             @customer_id,
             oi.total
FROM   [order]
       CROSS apply (SELECT unitprice * quantity AS total
                    FROM   @order_item) oi
ORDER  BY new_ordernumber DESC

--test
SELECT *
FROM   @order
--test
SELECT TOP 1 ordernumber + 1
FROM   [order]
ORDER  BY 1 DESC

--3 --bring unit price and other values to oi 
UPDATE @order_item
SET    orderid = ordernumber
FROM   @order

--test
SELECT *
FROM   @order_item
--test
select format(@orderdate, 'yyyy/mm/dd, hh:mm:ss')--add utc -3

COMMIT TRAN
--END 