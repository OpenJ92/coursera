source create_db.sql;
source populate_db.sql;

-- Task 1: Lucky Shrub need to find out how many sycamore trees they’ve sold over the 
-- past few years. Sycamore trees have been assigned an ID of P4 in the products table 
-- in the database. Create a query that returns the total quantity of all products with 
-- the ID of P4 sold in the years 2020, 2021 and 2022. 

delimiter //

create procedure if not exists quantityPerYear(ProductsID varchar(10))
begin
	with query as 
	(
		select 
			sum(quantity) as total, 
			year(Date) as years
		from orders 
		where ProductID = ProductsID 
		group by Year(Date) 
		order by Year(Date)
	) select concat(total, " (", years, ")") as " product: Quantity Sold" from query;
end //

delimiter ;

-- delimiter //
-- 
-- create procedure if not exists __quantityPerYear__(ProductsID varchar(10))
-- begin
-- 	declare total int;
-- 	declare years date;
-- 
-- 	select 
-- 		sum(quantity) into total, 
-- 		year(Date) into years
-- 	from orders 
-- 	where ProductID = ProductsID 
-- 	group by Year(Date) 
-- 	order by Year(Date)
-- 
-- 	prepare __test__ 'select concat(?," (", ?, ")") as ?';
-- 	execute __test__ using @total, @years, @ProductsID;
-- end //
-- 
-- delimiter ;


-- Task 2: Lucky Shrub need information on all their clients and the orders that they placed in the years 2022 and 2021. See if you can help them by extracting the required information from each of the following tables:

-- • Clients table: The client id and contact number for each client who placed an order
-- • Addresses table: The street and county for each client’s address
-- • Orders table: The order id, cost and date of each client’s order.
-- • Products table: The name of each product ordered.

select
	Clients.ClientID,
	Clients.ContactNumber,
	Addresses.Street,
	Addresses.County,
	Orders.OrderID,
	Products.ProductID,
	Products.ProductName,
	Orders.Cost,
	Orders.Date
from Orders
inner join Clients
on Orders.ClientID = Clients.ClientID
inner join Products
on Orders.ProductID = Products.ProductID
inner join Addresses
on Clients.AddressID = Addresses.AddressID
where year (Orders.Date) = 2021 or year (Orders.Date) = 2022
order by Orders.Date;

-- Task 3: Lucky Shrub needs to analyze the sales performance of their Patio slates product in the 
-- year 2021. This product has a Product ID of P3. Help Lucky Shrub to analyze the performance of 
-- this product by developing a function called FindSoldQuantity that enables them to:

-- • Input a ProductID and a year from which they can capture data
-- • And display the total quantity of the product sold in the given year.

delimiter //

create function if not exists FindSoldQuantity(ProductsID varchar(10), years int)
returns int
deterministic
begin
	declare soldQuantity int;

	with query as 
	( 
		select 
			sum(Quantity) as quantity, 
			year(Date)    as orderdate 
		from 
			Orders 
		where 
			ProductID = ProductsID 
		group by 
			year(Date)
		having 
			orderdate = years
	) select quantity into soldQuantity from query;

	return soldQuantity;
end //

delimiter ;
