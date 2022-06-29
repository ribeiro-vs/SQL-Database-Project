alter table Product
   add constraint check_orderitem_value check (UnitPrice > 0)
go
