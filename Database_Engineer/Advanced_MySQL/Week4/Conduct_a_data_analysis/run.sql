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



