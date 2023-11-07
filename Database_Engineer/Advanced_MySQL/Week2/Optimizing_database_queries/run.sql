
explain select * from Orders;
explain select OrderID, ProductID, Quantity, Datet from Orders;

explain select * from Orders where ClientID = 'Cl1';
create index IdxClientID on Orders (ClientID);
explain select * from Orders where ClientID = 'Cl1';

explain select * from Employees where FullName like '%Tolo';
alter table Employees add column ReverseFullName varchar(100);
update Employees set ReverseFullName = reverse(FullName);
create index IdxReverseFullName on Employees (ReverseFullName);
explain select * from Employees where ReverseFullName like 'oloT%';
