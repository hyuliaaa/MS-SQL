use movies

select * from MOVIEEXEC

--да добавим в таблицата Studio всички студиа, споменати в Movie, но липсващи в Studio:
insert into STUDIO (name)	 
select distinct studioname from MOVIE
where STUDIONAME not in (select name from STUDIO)



-- Да се добави информация за актрисата Nicole Kidman. За
--нея знаем само, че е родена на 20-и юни 1967.


begin transaction;

select * from MOVIESTAR


Insert into MOVIESTAR (name,birthdate)
values ('Nicole Kidman','1976-06-20')


--Да се изтрият всички продуценти с печалба (networth) под 10 милиона.) под 10 милиона
select * from MOVIEEXEC
where NETWORTH < 10000000;
delete 
from MOVIEEXEC
where NETWORTH < 10000000;



--Да се изтрие информацията за всички филмови звезди, за които не се знае адресът
select * from MOVIESTAR
delete from MOVIESTAR
where ADDRESS is null


--Да се добави титлата „Pres.“ пред името на всеки продуцент, който е и президент на студио. 

select * from MOVIEEXEC
select * from studio


UPDATE MovieExec
SET name = 'Pres. ' + name
WHERE cert# IN (SELECT presC# FROM Studio);


use pc

-- Използвайки две INSERT заявки, съхранете в базата от данни факта, че персонален компютър модел 1100 е направен от
--производителя C, има процесор 2400 MHz, RAM 2048 MB, твърд диск 500 GB, 52x DVD устройство и струва $299. Нека
--новият компютър има код 12. Забележка: моделът и CD са от тип низ.

select * from pc
select * from product

INSERT INTO Product(maker, model, type)
VALUES('C', '1100', 'PC');
INSERT INTO PC(code, model, speed, ram, hd, cd, price)
VALUES(12, '1100', 2400, 2048, 500, '52x', 299);


--Да се изтрие всичката налична информация за компютри модел 1100.
delete from product
where model='1100'
delete from pc
where model='1100'


--За всеки персонален компютър се продава и 15-инчов лаптоп със същите параметри, но с $500 по-скъп. Кодът на такъв
--лаптоп е със 100 по-голям от кода на съответния компютър. Добавете тази информация в базата.

select * from pc
select * from laptop
select *from product


insert into laptop(code, model, speed, ram, hd, price, screen)
select code+100, model, speed, ram, hd, price+500, 15
from pc;

--Да се изтрият всички лаптопи, направени от производител, който не
-- произвежда принтери.



select * from laptop
WHERE model IN ( SELECT model 
		         FROM product 
                 WHERE type='Laptop' AND
 		         maker NOT IN (SELECT maker
	                           FROM product
		                       WHERE type='Printer'));

--Производител А купува производител B. На всички продукти
--на В променете производителя да бъде А.


select * from product
update	product
set maker='A'
where maker='B'


--Да се намали два пъти цената на всеки компютър и да се
--добавят по 20 GB към всеки твърд диск. Упътване: няма нужда от две отделни заявки.
select * from pc

begin transaction

update pc
set price=price/2 , hd=hd+20

rollback transaction

--За всеки лаптоп от производител B добавете по един инч към диагонала на екрана.

select * from laptop
select * from product


UPDATE laptop
SET screen=screen+1
WHERE model IN (SELECT model
		      FROM product
		      WHERE maker='B');


use ships

--Два британски бойни кораба (type = 'bb') от класа Nelson - Nelson и Rodney - са били
--пуснати на вода едновременно през 1927 г. Имали са девет 16-инчови оръдия (bore) и
--водоизместимост от 34 000 тона (displacement). Добавете тези факти към базата от данни.

select * from CLASSES

select * from ships

insert into classes
values('Nelson', 'bb', 'Gt.Britain', 9, 16, 34000);

insert into ships
values('Nelson', 'Nelson', 1927);

insert into ships
values('Rodney', 'Nelson', 1927);



select * from OUTCOMES
select * from ships

select *
from SHIPS
join OUTCOMES on NAME=SHIP
where result='damaged'
--Изтрийте от Ships  всички кораби, които са потънали в битка  

begin transaction

delete from ships
where name in (select NAME
from SHIPS
join OUTCOMES on NAME=SHIP
where result='damaged')

delete from ships
where name in (select ship from outcomes where result='sunk');

rollback




--Променете данните в релацията Classes така, че калибърът (bore) да се измерва в
--сантиметри (в момента е в инчове, 1 инч ~2.54 см) и водоизместимостта да се измерва в метрични тонове (1 м.т. = 1.1 т.)

update classes
set bore=bore*2.54, displacement=displacement/1.1;





--Изтрийте всички класове, от които има по-малко от три кораба.
 
 select * from CLASSES
 select * from ships

delete from classes
where class NOT in
(select class
from ships
group by class
having count(*) >= 3);








