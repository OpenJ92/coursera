use Little_Lemon;

-- Task 1: Filter data using the WHERE clause and logical operators.
-- Create SQL statement to print all records from Bookings table for the 
-- following bookings dates using the BETWEEN operator: 2021-11-11, 2021-11-12 and 2021-11-13.
select * from Bookings where BookingDate between '2021-11-11' and '2021-11-13';

-- Task 2: Create a JOIN query.
-- Create a JOIN SQL statement on the Customers and Bookings tables. The statement must 
-- print the customers full names and related bookings IDs from the date 2021-11-11.
select 
    FullName, 
    BookingID
from Customers inner join Bookings
on Customers.CustomerID = Bookings.CustomerID
where BookingDate = '2021-11-11';

-- Task 3: Create a GROUP BY query
-- Create a SQL statement to print the bookings dates from Bookings table. The statement 
-- must show the total number of bookings placed on each of the printed dates using the GROUP BY BookingDate. 
select BookingDate, count(BookingDate) from Bookings group by BookingDate;

-- Task 4:  Create a REPLACE statement.
-- Create a SQL REPLACE statement that updates the cost of the Kabsa course from $17.00 to $20.00. 
-- The expected output result should be the same as that shown in the following screenshot:
replace into Courses
(CourseName, Cost)
values
('Kabsa', 17);

-- Task 5: Create constraints
-- Create a new table called "DeliveryAddress" in the Little Lemon database with the following columns and constraints:

-- ID: INT PRIMARY KEY
-- Address: VARCHAR(255) NOT NULL
-- Type: NOT NULL DEFAULT "Private"
-- CustomerID: INT NOT NULL FOREIGN KEY referencing CustomerID in the Customers table
create table if not exists DeliveryAddress
(
    ID int primary key,
    Address varchar(250) not null,
    Type varchar(100) not null default "Private",
    CustomerID int not null,
    foreign key (CustomerID) references Customers(CustomerID)
);

-- Task 6:  Alter table structure
-- Create a SQL statement that adds a new column called 'Ingredients' to the Courses table.
-- Ingredients: VARCHAR(255)
alter table Courses add Ingredients varchar(255);

-- Task 7: Create a subquery
-- Create a SQL statement with a subquery that prints the full names of all customers who 
-- made bookings in the restaurant on the following date: 2021-11-11.
select FullName
from Customers
where CustomerID in  
(
    select CustomerID from Bookings where BookingDate = '2021-11-11.'
);

-- Task 8: Create a virtual table
-- Create the "BookingsView" virtual table to print all bookings IDs, bookings dates and 
-- the number of guests for bookings made in the restaurant before 2021-11-13 and 
-- where number of guests is larger than 3.
create view BookingsView as
(
    select BookingID, BookingDate, NumberOfGuests from Bookings
);

-- Task 9: Create a stored procedure
-- Create a stored procedure called 'GetBookingsData'. The procedure must contain one date parameter 
-- called "InputDate". This parameter retrieves all data from the Bookings table based on the user input of the date.
-- After executing the query, call the "GetBookingsData" with '2021-11-13' as the input date passed to 
-- the stored procedure to show all bookings made on that date.
delimiter //
create procedure if not exists GetBookingsData(InputDate date)
begin
    select * from Bookings where BookingDate = InputDate;
end//
delimiter ;

call GetBookingsData('2021-11-13');

-- Task 10: Use the String function
-- Create a SQL SELECT query using appropriate MySQL string function to list "Booking Details" including booking ID, 
-- booking date and number of guests. The data must be listed in the same format as the following example:
select 
concat("ID: ", BookingID, ", Date: ", BookingDate, ", Number of guests: ", NumberOfGuests) as 'Booking Details'
from Bookings;
