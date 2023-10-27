#!/usr/bin/mysql

source on_enter.sql;

select * 
from Bookings 
where BookingSlot > all
(
    select BookingSlot 
    from Bookings 
    where GuestFirstName = "Vanessa" and GuestLastName = "McCarthy"
);

select *
from MenuItems
where Price > all
(
    select Price
    from MenuItems
    where Type = "Desserts" and Type = "Starters"
) and Type <> "Desserts" and Type <> "Starters";

select *
from MenuItems
where Price = all
(
    select Price
    from MenuItems
    inner join Menus on MenuItems.ItemID = Menus.ItemID
    where Menus.Cuisine = 'Italian' and MenuItems.Type = 'Starters'
);

select *
from MenuItems
where not exists
(
    select *
    from Menus 
    inner join TableOrders on Menus.MenuID = TableOrders.MenuID and Menus.ItemID = MenuItems.ItemID
);

source on_exit.sql;
