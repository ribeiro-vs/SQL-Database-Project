alter table Product
   add constraint fk_product_supplier foreign key (SupplierId)
      references Supplier (Id)
go
