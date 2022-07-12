alter table [Order]
   add constraint check_ordervalue check (TotalAmount > 0)
go
