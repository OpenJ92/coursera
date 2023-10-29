-- Task 1: Write a SQL statement that creates a stored procedure called 'GetOrdersData' which retrieves all data from the Orders table.
create procedure if not exists Lucky_Shrub.GetOrdersData() select * from Orders;

-- Task 2: Write a SQL statement that creates a stored procedure called “GetListOfOrdersInRange”. 
-- The procedure must contain two parameters that determine the range of retrieved data based on 
-- the user input of two cost values “MinimumValue” and “MaximumValue”.
delimiter //
create procedure if not exists Lucky_Shrub.GetListOfOrdersInRange(MinimumValue DECIMAL(6, 2), MaximumValue DECIMAL(6, 2))
begin
    select * from Orders where Cost between MinimumValue and MaximumValue;
end//
delimiter ;

