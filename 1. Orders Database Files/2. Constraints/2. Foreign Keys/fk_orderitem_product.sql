alter table OrderItem
   add constraint fk_orderitem_product  foreign key (ProductId)
      references Product (Id)
go
