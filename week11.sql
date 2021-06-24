--изгледи

--виртуална таблица, която не заема физическа памет върху диска
--пр: ако имаме таблица с данни, напр искаме преподавателят да вижда определена част от тези данни и затова създаваме индекс
--който е актуална извадка от таблицата


use ships
--създаване
--Всички американски класове кораби:
select * from CLASSES

CREATE VIEW am_class
as
select *
from CLASSES
where country='USA'


select * from am_class

--За всяка държава – името и средния брой оръдия на нейните класове
CREATE view cn
as
select country,avg(numguns) as avgnumg
from classes
group by country

select * from cn

--Изтриване
drop view cn


use movies

--Създайте изглед, който извежда имената и рождените дати на всички актриси
select * from MOVIESTAR

create view mov_S
as
select  name,birthdate  from MOVIESTAR

select * from mov_S


drop view mov_S


-- Създайте изглед, който за всяка филмова звезда извежда броя на филмите, в които се е снимала. Ако
--за дадена звезда не знаем какви филми има, за нея да се изведе 0.



create view ms_t
as
select name, count(MOVIETITLE) as moviecount
from MOVIESTAR
LEFT join STARSIN on NAME=STARNAME
GROUP BY name


select * from ms_t

drop view ms_T

use pc
--Създайте изглед, който показва кодовете, моделите и цените на всички лаптопи,
--PC-та и принтери. Не премахвайте повторенията
create view tab
as
select code,model,price from
laptop
union all
select code,model,price from pc
union all
select code,model, price from printer

select *from tab


--Променете изгледа, като добавите и колона type (PC, Laptop, Printer)
alter view tab
as
select code,model,price, 'laptop' as type from
laptop
union all
select code,model,price,'pc' as type from pc
union all
select code,model, price, 'printer' as type from printer


--Променете изгледа, като добавите и колона speed, която е NULL за принтерите
alter view tab
as
select code, model, price, speed, 'PC' as type
from pc
union all
select code, model, price, speed, 'Laptop'
from laptop
union all
select code, model, price, null, 'Printer'
from printer;


select * from tab


use ships

--Дефинирайте изглед BritishShips, който извежда за всеки британски кораб неговия клас, тип, брой оръдия, калибър,
--водоизместимост и годината, в която е пуснат на вода.


create view BritishShips
as
select classes.class,type,NUMGUNS,bore,DISPLACEMENT,LAUNCHED
from CLASSES
join ships on CLASSES.CLASS=ships.NAME
where COUNTRY='Gt.Britain'


select * from BritishShips
select * from CLASSES
select * from ships


--Напишете заявка, която използва изгледа от предната задача, за да покаже броя оръдия и водоизместимост на британските бойни кораби (type = 'BB'), пуснати на вода преди 1919.

select NUMGUNS,DISPLACEMENT from BritishShips
where type='bb' and LAUNCHED <=1919


create view tbt
as
select COUNTRY, max(DISPLACEMENT) as md
from CLASSES
group by COUNTRY

select avg(md)
from tbt


 --Създайте изглед за всички потънали кораби по битки.

 create view sunk
 as
 select ship,BATTLE
 from outcomes
 where RESULT='sunk'

 alter table outcomes
 add constraint
 select * from sunk

 insert into sunk(ship,BATTLE)
 values('California','Guadal canal')

	





select * from CLASSES
