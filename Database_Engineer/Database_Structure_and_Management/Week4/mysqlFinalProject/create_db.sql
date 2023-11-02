delimiter //
create procedure if not exists Little_Lemon.create_db()
begin
	create database if not exists Little_Lemon;
	CREATE TABLE if not exists  Little_Lemon.Customers
	(
		CustomerID INT NOT NULL PRIMARY KEY,
	       	FullName VARCHAR(100) NOT NULL,
	       	PhoneNumber INT NOT NULL UNIQUE
	);
	CREATE TABLE if not exists  Little_Lemon.Bookings 
	(
		BookingID INT,
	       	BookingDate DATE,
		TableNumber INT,
	       	NumberOfGuests INT,
		CustomerID INT
	); 
	CREATE TABLE  Little_Lemon.Courses 
	(
		CourseName VARCHAR(255) PRIMARY KEY,
	       	Cost Decimal(4,2)
	);
end//
delimiter ;


