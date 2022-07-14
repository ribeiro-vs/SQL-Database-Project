--CREATE PROCEDURE sp_generate_order
--AS
--  BEGIN

      DECLARE @customer_id int  = 1
      DECLARE @product_id  int  = 1
      DECLARE @quantity    int  = 1
	  DECLARE @orderdate   datetime = getdate()
	  DECLARE @totalamount int 	--bring this value
 
	  DECLARE @order_item   table
	  (OrderId  int,
	  ProductId int,
	  UnitPrice int,
	  Quantity  int)

	  DECLARE @order table
	  (OrderDate  date,
	  OrderNumber int, --see how it is in the ddl query
	  CustomerId  int,
	  TotalAmount int)

      BEGIN TRAN

	  declare @unitprice int

--1	  --bring unit price and other values to oi / not order_id
 	  insert into @order_item
	  select null,
			 @product_id, 
			 UnitPrice, 
			 @quantity 
	  from Product
		--cross apply(select OrderNumber from @order) o
	  where Id = @product_id
	  select * from @order_item


--2	  --trying to bring ordernumber formatted
	  insert into @order  
	  select top 1 @orderdate, OrderNumber+1 as new_ordernumber, @customer_id, oi.total
	  from [order] 
		cross apply (select UnitPrice*Quantity as total from @order_item) oi
	  order by new_ordernumber desc

	  select * from @order
	  select top 1 OrderNumber+1
	  from [order] 
	  order by 1 desc

--3 --bring unit price and other values to oi 
	  
	  update @order_item
	  set OrderId = OrderNumber from @order

	  select * from @order_item
	    
      --INSERT INTO @order_item
      --VALUES      (--orderid
				  -- @product_id,
				  -- @unitprice,
      --             @quantity)

      --INSERT INTO @order
      --VALUES      (--orderid
				  -- @product_id,
				  -- @customer_id,
      --             @quantity)
				   
      COMMIT TRAN
  --END 

   

