CREATE TABLE MenuItems 
(
  ItemID INT AUTO_INCREMENT,
  Name VARCHAR(200),
  Type VARCHAR(100),
  Price INT,
  PRIMARY KEY (ItemID)
);

CREATE TABLE Menus (
MenuID INT,
ItemID INT,
Cuisine VARCHAR(100),
PRIMARY KEY (MenuID,ItemID)
);

CREATE TABLE Bookings (
BookingID INT AUTO_INCREMENT,
TableNo INT,
GuestFirstName VARCHAR(100) NOT NULL,
GuestLastName VARCHAR(100) NOT NULL,
BookingSlot TIME NOT NULL,
EmployeeID INT,
PRIMARY KEY (BookingID)
);

CREATE TABLE Orders (
OrderID INT,
TableNo INT,
MenuID INT,
BookingID INT,
BillAmount INT,
Quantity INT,
PRIMARY KEY (OrderID,TableNo)
);

CREATE TABLE Employees (
EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR (255),
Role VARCHAR (100),
Address VARCHAR (255),
Contact_Number INT,
Email VARCHAR (255),
Annual_Salary VARCHAR (100)
);

