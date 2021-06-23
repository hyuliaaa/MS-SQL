CREATE DATABASE test;

CREATE TABLE Product(
model varchar(4),
maker varchar(1),
type varchar(7)
)


-- Printer(co)de, mo)del, co)lo)r, price), където co)de е цяло
--число, co)lo)r е 'y' или 'n' и по подразбиране е 'n', price - y'y' или 'n' и по подразбиране е 'n', price - или 'y' или 'n' и по подразбиране е 'n', price - n'y' или 'n' и по подразбиране е 'n', price - и по подразбиране е 'y' или 'n' и по подразбиране е 'n', price - n'y' или 'n' и по подразбиране е 'n', price - , price -bit, със знак
--цена с точност до два знака след десетичната запетая;

CREATE TABLE Printer(
code int,
color char(1) default 'n',
price decimal(9,2)
)


CREATE TABLE Classes
(
	class varchar(50),
	type char(2) 
)



insert into Printer
values (1,'y', 245)

insert into Printer(code,price)
values(2,345);


insert into Product
values ('abc', '1','phone')	

select *from Product
select * from Printer


drop database test


