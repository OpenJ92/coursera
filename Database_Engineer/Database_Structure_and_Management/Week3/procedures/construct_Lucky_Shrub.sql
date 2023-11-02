-- procedures to declare and populate Lucky Shrub database
delimiter // 
create procedure if not exists mysql.create_Lucky_Shrub() 
begin
    CREATE DATABASE if not exists Lucky_Shrub;
    CREATE TABLE if not exists Lucky_Shrub.Orders
    (
        OrderID INT, 
        ClientID VARCHAR(10), 
        ProductID VARCHAR(10), 
        Quantity INT, 
        Cost DECIMAL(6, 2)
    );
end//
delimiter ;

delimiter //
create procedure if not exists mysql.populate_Lucky_Shrub()
begin
    REPLACE INTO Lucky_Shrub.Orders (OrderID, ClientID, ProductID , Quantity, Cost) 
    VALUES  (1, "Cl1", "P1", 10, 500), 
            (2, "Cl2", "P2", 5, 100), 
            (3, "Cl3", "P3", 20, 800), 
            (4, "Cl4", "P4", 15, 150), 
            (5, "Cl3", "P3", 10, 450), 
            (6, "Cl2", "P2", 5, 800), 
            (7, "Cl1", "P4", 22, 1200), 
            (8, "Cl1", "P1", 15, 150);
end//
delimiter ;

