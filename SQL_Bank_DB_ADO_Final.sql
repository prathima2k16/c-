create database BankingDB

use BankingDB

create table tbl_Customers
(
CustomerID int identity(1000,1) primary key,
CustomerName varchar(100) not null,
CustomerEmail varchar(100) unique not null,
CustomerMobile varchar(10) not null,
CustomerGender varchar(100) check(CustomerGender in('Male','Female')) not null,
CustomerPassword varchar(100) not null
)



create table tbl_Accounts
(
AccountID int identity(10000,1) primary key,
CustomerID int foreign key references tbl_Customers(CustomerID) not null,
AccountBalance int not null,
AccountType varchar(100) not null,
AccountOpeningDate date not null
)
select * from tbl_Accounts


create table tbl_Transactions
(
TransactionID int identity(100000,1) primary key,
AccountID int foreign key references tbl_Accounts(AccountID)not null,
Amount int check(Amount>0) not null,
TransactionType varchar(100) not null,
TransactionDate date not null
)


select * from tbl_Transactions

create proc p_addCustomers(@name varchar(100),@email varchar(100),@mobile varchar(100),@gender varchar(100),@password varchar(100))
as
begin
insert into tbl_Customers values(@name,@email,@mobile,@gender,@password)
return @@identity
end

insert tbl_Customers values('prathima','prathima@gmail.com','8885999109','female','pathi')

create proc p_addAccounts(@cid int,@balance int,@type varchar)
as
begin
insert into tbl_Accounts values(@cid,@balance,@type,GETDATE())
return @@identity
end
create proc p_addTransactions(@aid int,@amount int,@type varchar(100))
as
begin
insert into tbl_Transactions values(@aid,@amount,@type,GETDATE())
return @@identity
end

create proc p_login(@id int,@psw varchar(100))
as
begin
declare @ch int
select @ch=COUNT(*) from tbl_Customers where CustomerID=@id and CustomerPassword=@psw
return @ch
end

create proc p_getName(@id int)
as
begin
select CustomerName from tbl_Customers where CustomerID=@id;
end

create proc p_ShowTransactions(@id int)
as
begin
select * from tbl_Transactions where AccountID=@id
end
alter proc p_getAccID(@cid int)
as
begin
declare @count int
select AccountID,CustomerID from tbl_Accounts where CustomerID=@cid
end

create proc p_GetCustomer(@id int)
as
begin
select CustomerID,CustomerName from tbl_Customers where CustomerID=@id
end

alter proc p_GetAcc(@aid int)
as
begin
select * from tbl_Accounts where AccountID=@aid
end

select * from tbl_Customers