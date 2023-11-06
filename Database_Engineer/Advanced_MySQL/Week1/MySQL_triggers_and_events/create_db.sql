create database if not exists Lucky_Shrub;
use Lucky_Shrub;

create table if not exists Products
(
    ProductID varchar(10),
    ProductName varchar(100),
    BuyPrice decimal(6,2),
    SellPrice decimal(6,2),
    NumberOfItems int
);

create table if not exists Notifications
(
    NotificationID int auto_increment,
    Notification varchar(255),
    DateTime timestamp not null,
    primary key(NotificationID)
);
