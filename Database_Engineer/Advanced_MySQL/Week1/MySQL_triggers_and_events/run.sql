delimiter //

create trigger if not exists ProductSellPriceInsertCheck
after insert on Products
for each row
begin
    if new.SellPrice <= new.BuyPrice then 
        insert into Notifications (Notification, DateTime) 
        values (concat('A SellPrice less than the BuyPrice was inserted for ProductID: ', new.ProductID), now());
    end if;
end//

delimiter ;

delimiter //

create trigger if not exists ProductSellPriceUpdateCheck
before update on Products
for each row
begin
    if new.SellPrice < new.BuyPrice then
        insert into Notifications (Notification, DateTime)
        values (concat( "ProductID ", new.ProductID, 
                        " was updated with a SellPrice of ", new.SellPrice, 
                        " which is the same or less than the BuyPrice ", new.BuyPrice
                       ), 
                now());
    end if;
end//

delimiter ;

delimiter //

create trigger if not exists NotifyProductDelete
after delete on Products
for each row
begin 
    insert into Notifications (Notification, DateTime)
    values (concat("The product with a ProductID " , old.ProductID , " was deleted."), now());
end//

delimiter ;
