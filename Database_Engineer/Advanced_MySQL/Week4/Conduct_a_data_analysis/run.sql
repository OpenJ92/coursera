source create_db.sql;
source populate_db.sql;
source analysis.sql;

-- Task 1
select FindAverageCost(2022);

-- Task 2
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

-- Task 4 
call GetPersonsAddresses();

-- Task 5
call TotalSumProduct2020to2022("P2");

-- Task 6: 
call GetActivityInfo();

-- Task 7: (expected -> 350, actual -> 450)
-- I pulled in the given solution from course to test against my 
-- solution and the output is the same. Perhaps the data has changed
-- since the writing of the original prompts.
call GetProfit("P1", 2020);
call GetProfit2("P1", 2020);

-- Task 8: 
select * from DataSummary 
where year(Date) = 2022
order by Date, Cost desc;
