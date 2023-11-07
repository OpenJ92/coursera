-- Lucky Shrub need to find out how many orders were placed by clients with the following 
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
