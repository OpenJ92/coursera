create database if not exists Lucky_Shrub;
use Lucky_Shrub;

CREATE TABLE IF NOT EXISTS Orders 
(
	OrderID INT NOT NULL PRIMARY KEY, 
	ClientID VARCHAR(10), 
	ProductID VARCHAR(10), 
	Quantity INT, 
	Cost DECIMAL(6,2), 
	Date DATE
);

CREATE TABLE IF NOT EXISTS Products 
(
	ProductID VARCHAR(10), 
	ProductName VARCHAR(100), 
	BuyPrice DECIMAL(6,2), 
	SellPrice DECIMAL(6,2), 
	NumberOfItems INT
);

CREATE TABLE IF NOT EXISTS Activity 
(
	ActivityID INT PRIMARY KEY, 
	Properties JSON 
); 
