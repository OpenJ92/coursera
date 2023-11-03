create table Lucky_Shrub.Orders
(
	OrderID INT NOT NULL PRIMARY KEY,
       	ClientID VARCHAR(10),
       	ProductID VARCHAR(10),
       	Quantity INT,
       	Cost DECIMAL(6,2), 
	DateOrdered DATE
); 
