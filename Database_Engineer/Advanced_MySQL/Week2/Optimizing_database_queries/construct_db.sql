create database if not exists Lucky_Shrub;
use Lucky_Shrub;

create table if not exists Orders
(
	OrderID int not null, 
	ClientID varchar(10) default null, 
	ProductID varchar(10) default null, 
	Quantity int default null, 
	Cost decimal(6,2) default null, 
	Datet date default null, 
	primary key (orderid)
);

create table if not exists employees
(
	EmployeeID int default null, 
	FullName varchar(100) default null, 
	Role varchar(50) default null, 
	Department varchar(255) default null
); 
