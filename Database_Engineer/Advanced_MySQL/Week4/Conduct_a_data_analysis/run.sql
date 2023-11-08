source create_db.sql;
source populate_db.sql;
source analysis.sql;

-- Task 1
select FindAverageCost(2022);

-- Task 2 (Not outputing correctly. See analysis.sql for more information. FIXED)
set @sold_items_2020 = 0;
set @sold_items_2021 = 0;
set @sold_items_2022 = 0;

call EvaluateProduct('P1', @sold_items_2020, @sold_items_2021, @sold_items_2022);
select @sold_items_2020, @sold_items_2021, @sold_items_2022;

-- Task 3
insert into Orders 
    (OrderID, ClientID, ProductID, Quantity, Cost, Date)
values 
    (100, "CL1", "P1", 10, 100.0, '2020-01-01');
select * from Audit;

drop database Lucky_Shrub;
