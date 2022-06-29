alter table Product
   add constraint check_productvalue check (UnitPrice > 0)
go
