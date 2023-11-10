-- Task 1: Lucky Shrub need to find out what their average sale price, or cost was for a product in 2022.
-- You can help them with this task by creating a FindAverageCost() function that returns the 
-- average sale price value of all products in a specific year. This should be based on the user input.

delimiter //

create function if not exists FindAverageCost (__year__ int)
returns decimal(6,2)
deterministic
begin 
        declare return_value decimal(6,2);
        select avg(Cost) into return_value from Orders where year(Date) = __year__ group by year(Date);
        return return_value;
end //

delimiter ;

-- Task 2: Lucky Shrub need to evaluate the sales patterns for bags of artificial grass over the last three 
-- years. Help them out using the following steps:

-- Step 1: Create the EvaluateProduct stored procedure that outputs the total number of items sold during 
--           the last three years for the P1 Product ID. Input the ProductID when invoking the procedure.
-- Step 2: Call the procedure.
-- Step 3: Output the values into outside variables.

-- I'm getting an improper output on the call to this procedure. It's as if the three internal queries are 
-- not applying the ProductID = productid constraint in the where clause. What's going on here?
-- SOLUTION: There's was an ambiguity in the original in parameter productid and comparison column ProductID
-- Clearly not case sensitive. Update parameter with underscore to remove ambiguity. 

delimiter //

create procedure if not exists EvaluateProduct
(
    in    product_id   varchar(10) , 
    inout Quantity2020 int         , 
    inout Quantity2021 int         , 
    inout Quantity2022 int
)
begin
        select sum(Quantity) into Quantity2020 from Orders where (ProductID = product_id and year(Date) = 2020);
        select sum(Quantity) into Quantity2021 from Orders where (ProductID = product_id and year(Date) = 2021);
        select sum(Quantity) into Quantity2022 from Orders where (ProductID = product_id and year(Date) = 2022);
end //

delimiter ;

-- Task 3:
-- Lucky Shrub need to automate the orders process in their database. The database must insert a new record of 
-- data in response to the insertion of a new order in the Orders table. This new record of data must contain 
-- a new ID and the current date and time.

-- You can help Lucky Shrub by creating a trigger called UpdateAudit. This trigger must be invoked automatically 
-- AFTER a new order is inserted into the Orders table.

create trigger if not exists UpdateAudit
after insert on Orders for each row 
insert into Audit (OrderDateTime) values (now());

-- Task 4: Lucky Shrub need location data for their clients and employees. To help them out, create an optimized 
-- query that outputs the following data:
--
-- 	The full name of all clients and employees from the Clients and Employees tables in the Lucky 
-- 		Shrub database.
--
-- 	The address of each person from the Addresses table.

delimiter //

create procedure if not exists GetPersonsAddresses()
begin
	with address_clients as 
	(
		select FullName, County, Street
		from Addresses 
		inner join Clients
		on Addresses.AddressID = Clients.AddressID
	),    address_employees as
	(
		select FullName, County, Street
		from Addresses 
		inner join Employees
		on Addresses.AddressID = Employees.AddressID
	) table address_clients
	  union
	  table address_employees
	  order by Street;
end //

delimiter ;

-- Task 5: Lucky Shrub need to find out what quantities of wood panels they are selling. The wood 
-- panels product has a Product ID of P2. The following query returns the total quantity of this 
-- product as sold in the years 2020, 2021 and 2022. Your task is to optimize this query by 
-- recreating it as a common table expression (CTE).

delimiter //

create procedure if not exists TotalSumProduct2020to2022(pid varchar(10))
begin
	with quantity2020 as
	(
		SELECT CONCAT(SUM(Cost), " (2020)") as "Total Sum Product 2020 - 2022"
		FROM Orders WHERE YEAR (Date) = 2020 AND ProductID = pid 
	),   quantity2021 as
	(
		SELECT CONCAT(SUM(Cost), "(2021)") 
		FROM Orders WHERE YEAR (Date) = 2021 AND ProductID = pid
	),   quantity2022 as
	(
		SELECT CONCAT(SUM(Cost), "(2022)") 
		FROM Orders WHERE YEAR (Date) = 2022 AND ProductID = pid 
	)  	table quantity2020 
	  union table quantity2021
	  union table quantity2022;
end //

delimiter ;

-- Lucky Shrub want to know more about the activities of the clients who use their 
-- online store. The system logs the ClientID and the ProductID information for 
-- each activity in a JSON Properties column inside the Activity table. This occurs 
-- while clients browse through Lucky Shrub products online.

-- Utilize the Properties data to output the following information:
--		1. The full name and contact number of each client from the Clients table.
--		2. The ProductID for all clients who performed activities.

delimiter //

create procedure if not exists GetActivityInfo()
begin
	with activityinfo as
	(
		select 
			Properties->>'$.ClientID' as activityClientID,
			Properties->>'$.ProductID' as ProductID
		from Activity
	), 	  clientinfo as
	(
		select
			ClientID,
			FullName,
			ContactNumber
		from Clients
	)	 
	select 
		ClientID,
		ProductID,
		FullName,
		ContactNumber
	from activityinfo inner join clientinfo
	on activityinfo.activityClientID = clientinfo.ClientID;
end //

delimiter ;

-- Task 7:
-- Lucky Shrub need to find out how much revenue their top selling product 
-- generated. 
--
-- Create a stored procedure called GetProfit that returns the overall 
-- profits generated by a specific product in a specific year. This should 
-- be based on the user input of the ProductID and Year. 

delimiter //

create procedure GetProfit(product_id varchar(10), year_date int)
begin
	with orders_info as
	(
		select
			ProductID as orders_ProductID,
			Quantity
		from Orders
		where ProductID = product_id and year(Date) = year_date
	),   product_info as
	(
		select
			ProductID as products_ProductID,
			BuyPrice,
			SellPrice
		from Products
		where ProductID = product_id
	)
	select sum(orders_info.Quantity) * (product_info.SellPrice - product_info.BuyPrice) as Profit
	from orders_info inner join product_info
	on orders_info.orders_ProductID = product_info.products_ProductID
	group by product_info.products_ProductID;

end //

delimiter ;

-- Solution from Meta. Call in analysis.sql to test against my solution.
DELIMITER //
CREATE PROCEDURE GetProfit2(IN product_id VARCHAR(10), IN YearInput INT)
BEGIN
	DECLARE profit DEC(7,2) DEFAULT 0.0; 
	DECLARE sold_quantity, buy_price, sell_price INT DEFAULT 0;
	SELECT SUM(Quantity) INTO sold_quantity FROM Orders WHERE ProductID = product_id AND YEAR(Date) = YearInput; 
	SELECT BuyPrice INTO buy_price FROM Products WHERE ProductID = product_id; 
	SELECT SellPrice INTO sell_price FROM Products WHERE ProductID = product_id;
	SET profit = (sell_price * sold_quantity) - (buy_price * sold_quantity);
	Select profit; 
END //
DELIMITER ;

-- Task 8: Lucky Shrub need a summary of their client's details, including 
-- their addresses, order details and the products they purchased. Help them 
-- out by creating a virtual table called DataSummary that joins together the 
-- four tables that contain this data

create or replace view DataSummary as select 
		Clients.FullName,
		Clients.ContactNumber,
		Addresses.County,
		Products.ProductName,
		Orders.ProductID,
		Orders.Cost,
		Orders.Date
	from Orders 
	inner join Clients
		  on Orders.ClientID = Clients.ClientID
	inner join Products
		  on Orders.ProductID = Products.ProductID
	inner join Addresses
		  on Clients.AddressID = Addresses.AddressID;
