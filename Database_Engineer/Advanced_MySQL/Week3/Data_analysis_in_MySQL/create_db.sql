create database if not exists Lucky_Shrub;
use Lucky_Shrub;

CREATE TABLE Clients 
(
	ClientID VARCHAR(10), 
	FullName VARCHAR(100), 
	ContactNumber INT, 
	AddressID INT
	-- PRIMARY KEY (ClientID)
);

CREATE TABLE Products 
(
	ProductID VARCHAR(10), 
	ProductName VARCHAR(100), 
	BuyPrice DECIMAL(6,2), 
	SellPrice DECIMAL(6,2), 
	NumberOfItems INT
	-- PRIMARY KEY (ProductID)
);

CREATE TABLE Orders 
(
	OrderID INT NOT NULL, 
	ClientID VARCHAR(10),  
	ProductID VARCHAR(10),  
	Quantity INT, 
	Cost DECIMAL(6,2), 
	Date DATE,
	PRIMARY KEY (OrderID)
	-- FOREIGN KEY (ClientID) REFERENCES Clients (ClientID),
	-- FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);


CREATE TABLE Addresses
(
	AddressID INT PRIMARY KEY, 
	Street VARCHAR(255), 
	County VARCHAR(100)
);
