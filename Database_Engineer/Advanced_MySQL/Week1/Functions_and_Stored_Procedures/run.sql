-- Task 1.1: Create a SQL function that prints the cost value of a specific 
-- order based on the user input of the OrderID
delimiter $$

create function if not exists findCost(ID int) 
returns decimal(6,2) 
deterministic 
begin
    	declare return_value decimal(6,2);
    	select Cost into return_value from Orders where OrderID = ID;
    	return return_value;
end $$

delimiter ;

-- Task 1.1: Create a SQL function that prints the quantity value of a specific 
-- order based on the user input of the OrderID
delimiter $$

create function if not exists findQuantity(ID int)
returns int
deterministic
begin 
	declare return_value int;
	select Quantity into return_value from Orders where OrderID = ID;
	return return_value;
end $$

delimiter ;

-- Create a stored procedure called GetDiscount. This stored procedure must return 
-- the final cost of the customer's order after the discount value has been deducted.
delimiter $$

create procedure if not exists GetDiscount(ID int)
begin
    declare orderQuantity int;
    declare orderCost decimal(6,2);
    declare discountedOrderCost decimal(6,2);

    select findQuantity(ID) into orderQuantity;
    select findCost(ID) into orderCost;

    if     orderQuantity >= 20 then set discountedOrderCost = orderCost - (.2 * orderCost);
    elseif orderQuantity >= 10 then set discountedOrderCost = orderCost - (.1 * orderCost);
    else set discountedOrderCost = orderCost;
    end if;

    select discountedOrderCost;
end $$

delimiter ;
