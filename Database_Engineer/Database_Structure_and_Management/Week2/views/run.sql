create view OrdersView as select OrderID, Quantity, Cost from Orders; 
select * from OrdersView;

update OrdersView set Cost = 200 where OrderID = 2; 
select * from Orders;

rename table OrdersView to ClientsOrdersView;
select * from ClientsOrdersView;

drop view ClientsOrdersView;

source on_exit.sql;
