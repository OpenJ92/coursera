-- Task 1: Lucky Shrub need to find out how many orders were placed by clients with the following 
-- Client IDs in 2022; Cl1, Cl2 and Cl3.

-- 		SELECT CONCAT("Cl1: ", COUNT(OrderID), "orders") AS "Total number of orders" 
-- 		FROM Orders 
-- 		WHERE YEAR(Date) = 2022 AND ClientID = "Cl1" 
-- 		
-- 		UNION 
-- 		
-- 		SELECT CONCAT("Cl2: ", COUNT(OrderID), "orders") 
-- 		FROM Orders 
-- 		WHERE YEAR(Date) = 2022 AND ClientID = "Cl2" 
-- 		
-- 		UNION 
-- 		
-- 		SELECT CONCAT("Cl3: ", COUNT(OrderID), "orders") 
-- 		FROM Orders 
-- 		WHERE YEAR(Date) = 2022 AND ClientID = "Cl3";  

-- Help Lucky Shrub to optimize this query by recreating it as a common table expression (CTE).

-- There's good opportunity to supply a stored procedure here.

delimiter //

create function if not exists getYearClientOrders(order_year date, client varchar(10))
returns varchar(100)
deterministic
begin
	declare return_value varchar(100);
	SELECT CONCAT(client, ": ", COUNT(OrderID), " orders") into return_value 
	FROM Orders 
	WHERE YEAR(Date) = YEAR(order_year) AND ClientID = client ;
	return return_value;
end //

delimiter ;

with CL1_Orders as 
(
	select getYearClientOrders('2022-01-01', "Cl1") as "Total number of orders." 

),   CL2_Orders as
(
	select getYearClientOrders('2022-01-01', "Cl2")
),   CL3_Orders as
(
	select getYearClientOrders('2022-01-01', "Cl3")
)
select * from CL1_Orders union
select * from CL2_Orders union
select * from CL3_Orders;


-- Task 2: Lucky Shrub need you to help them to create a prepared statement called GetOrderDetail. 
-- The prepared statement should accept two input arguments: a ClientID value and a year value. 
-- The statement should return the order id, the quantity, the order cost and the order 
-- date from the Orders table.

prepare GetOrderDetail from 
	'select OrderID, Quantity, Cost 
	 from Orders 
	 where ClientID = ? and year(Date) = ?';

set @ID = "Cl1";
set @Year = 2020;
execute GetOrderDetail using @ID, @Year;

-- Task 3: The Lucky Shrub system logs the ClientID of each client, and the ProductID of the 
-- products they order, in a JSON Properties column in the Activity table. 

with activity as
(
	select
		Properties->>'$.ProductID' as ProductID,
		Properties->>'$.Order' as IsOrdered
	from Activity
), products as
(
	select
		ProductID,
		ProductName,
		BuyPrice,
		SellPrice
	from Products
)
select products.ProductID, products.ProductName, products.BuyPrice, products.SellPrice
from products join activity
on products.ProductID = activity.ProductID
where activity.IsOrdered = "True";
