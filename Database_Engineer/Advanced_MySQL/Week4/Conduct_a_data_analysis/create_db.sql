CREATE DATABASE IF NOT EXISTS Lucky_Shrub; 
USE Lucky_Shrub; 
 
CREATE TABLE Clients 
(
	ClientID VARCHAR(10) primary key, 
	FullName VARCHAR(100), 
	ContactNumber INT, 
	AddressID INT
); 
  
CREATE TABLE Products 
(
	ProductID VARCHAR(10) primary key, 
	ProductName VARCHAR(100), 
	BuyPrice DECIMAL(6,2), 
	SellPrice DECIMAL(6,2), 
	NumberOfItems INT
);  
  
Create table Addresses
(
	AddressID INT PRIMARY KEY, 
	Street VARCHAR(255), 
	County VARCHAR(100)
); 
  
CREATE TABLE Employees 
(
	EmployeeID INT primary key, 
	FullName VARCHAR(100), 
	JobTitle VARCHAR(50),
       	Department VARCHAR(200), 
	AddressID INT
);  
  
CREATE TABLE Activity
( 
	ActivityID INT PRIMARY KEY, 
	Properties JSON 
); 
  
CREATE TABLE Audit
(
	AuditID INT AUTO_INCREMENT PRIMARY KEY, 
	OrderDateTime TIMESTAMP NOT NULL  
);  
  
CREATE TABLE Orders 
(
	OrderID INT NOT NULL PRIMARY KEY,  
	ClientID VARCHAR(10), 
	ProductID VARCHAR(10), 
	Quantity INT, 
	Cost DECIMAL(6,2), 
	Date DATE,  
	FOREIGN KEY (ClientID) REFERENCES Clients(ClientID), 
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
); 
  
CREATE TABLE Notifications 
(
	NotificationID INT AUTO_INCREMENT PRIMARY KEY, 
	Notification VARCHAR(256), 
	DateTime TIMESTAMP NOT NULL
); 
 
