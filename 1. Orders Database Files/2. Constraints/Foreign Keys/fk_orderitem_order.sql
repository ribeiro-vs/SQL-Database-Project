alter table OrderItem
   add constraint fk_orderitem_order foreign key (OrderId)
      references "Order" (Id)
go
