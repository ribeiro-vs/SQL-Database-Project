CREATE PROCEDURE sp_register_customer
AS
  BEGIN
      DECLARE @FirstName VARCHAR (100)
      DECLARE @LastName  VARCHAR (100)
      DECLARE @City      VARCHAR (100)
      DECLARE @Country   VARCHAR (100)
      DECLARE @Phone     VARCHAR (100)

      BEGIN TRAN

      INSERT INTO [customer]
                  ([firstname],
                   [lastname],
                   [city],
                   [country],
                   [phone])
      VALUES      (@FirstName,
                   @LastName,
                   @City,
                   @Country,
                   @Phone)

      COMMIT TRAN
  END 


