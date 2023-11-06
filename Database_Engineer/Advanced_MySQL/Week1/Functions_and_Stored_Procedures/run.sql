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

delimiter $$

create procedure if not exists GetDiscount(ID int)
begin
    declare orderQuantity int;
    declare orderCost decimal(6,2);
    declare discountedOrderCost decimal(6,2);

    select Quantity into orderQuantity from Orders where OrderID = ID;
    select findCost(ID) into orderCost;

    if     orderQuantity >= 20 then set discountedOrderCost = orderCost - (.2 * orderCost);
    elseif orderQuantity >= 10 then set discountedOrderCost = orderCost - (.1 * orderCost);
    else set discountedOrderCost = orderCost;
    end if;

    select discountedOrderCost;
end $$

delimiter ;
