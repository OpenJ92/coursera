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
-- SOLUTION: There's was an ambiguity in the original in parameter productid and compariion column ProductID
-- Clearly not case sensitive. Update parameter with underscore to remove ambiguity.

delimiter //

create procedure if not exists EvaluateProduct
(
    in product_id varchar(10),
    inout Quantity2020 int,
    inout Quantity2021 int,
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
after insert on Orders
for each row insert into Audit (OrderDateTime) values (now());

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
