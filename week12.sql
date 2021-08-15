

use ships
--Да се направи така, че при добавяне на нов клас
--автоматично да се добавя и нов кораб със същото
--име и с година на пускане на вода = null


create trigger t1
on  classes
after insert
as
	insert into ships(name,CLASS)
	select class,class
	from inserted


begin transaction
INSERT INTO Classes
VALUES ('Test 1', 'bb', 'Bulgaria', 20, 20, 50000),
		('Test 2', 'bc', 'Bulgaria', 18, 21, 45000);


SELECT *
FROM Ships
WHERE name LIKE 'Test %';

select *
from CLASSES

drop trigger t1
rollback transaction
		
--При изтриване на кораб автоматично да се изтрива и
--неговият клас, ако няма повече кораби от този клас

create trigger t2
on ships
after delete
as
	delete from CLASSES
	where CLASS not in (select CLASS from ships)
	and
	class in (select CLASS from deleted)

DELETE FROM Ships
WHERE name LIKE 'Test %';
SELECT *
FROM Classes
WHERE class LIKE 'Test %';
DROP TRIGGER t2;


--Да се направи така, че ако при добавяне на кораб годината му на
--пускане е по-голяма от текущата година, то годината да бъде
--променена на null

create trigger t3
on ships
instead of insert 
as
	insert into ships(name,CLASS,LAUNCHED)
	select name, CLASS
	case
		when launched > year(getdate())		 then null
		else launched
	end
	from inserted



CREATE TRIGGER tr3_2
ON Ships
AFTER INSERT
AS
 UPDATE Ships
 SET launched = NULL
 WHERE name IN (SELECT name
 FROM Inserted
 WHERE launched > YEAR(getdate()));


use movies
 --Добавете Брус Уилис в базата. Направете
--така, че при добавяне на филм, чието
--заглавие съдържа “save” или “world”, Брус save” или “save” или “world”, Брус world”, Брус
--Уилис автоматично да бъде добавен като
--актьор, играл във филма.


select * from moviestar
begin transaction
insert into MOVIESTAR
values ('Bruce Willieys', 'smw', 'M', '2021-01-01')

select * from STARSIN
select * from MOVIE


create trigger t1
on movie
after insert
as
	insert into STARSIN
	select TITLE,YEAR,'Bruce Willieys'
	from inserted
	where TITLE like '%save%' or TITLE like '%world%'

insert into MOVIE
values ('Armg,save,world',1998,120,'y','MGM',123)

drop trigger t1
rollback transaction

