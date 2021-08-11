--Agregate functions
use movies

--most often we give a column from a table
select avg(networth)
from MOVIEEXEC


--count(*) returns the number of rows in a specified table, and it preserves duplicate rows
select count(*)
from STARSIN


select count(distinct STARNAME)
from STARSIN


--sum of lengths of all movies in which harisson ford is starring
SELECT SUM(length)
FROM Movie
JOIN StarsIn
ON title = movietitle AND year = movieyear
WHERE starname = 'Harrison Ford';


--За всяко студио искаме да изведем точно по един ред със следната информация:
--- Име на студиото
--– Сумарна дължина на всички негови филми

select STUDIONAME, sum(length)
from MOVIE 
group by STUDIONAME



--За всяка година да се изведе колко филмови звезди са родени:


select YEAR(birthdate),count(name)
from MOVIESTAR
group by year(BIRTHDATE)

--За всяка година да се изведе колко актриси и колко актьори мъже са родени:
select YEAR(BIRTHDATE),gender, count(*)
from MOVIESTAR
group by year(birthdate), GENDER


--we cannot use agregate functions in where clause

-- Да се изведе най-дългият филм (ако са повече от един, да се изведат всички най-дълги):

select *
from MOVIE
WHERE LENGTH= (select MAX(length) from movie)



SELECT studioName, SUM(length)
FROM Movie
GROUP BY studioName
HAVING COUNT(*) >= 2;

--null values are ignored when agregating
--null values are not ignored when grouping


--● За всяка филмова звезда да се изведе броят на филмите, в които се е снимала.
--● Ако за дадена звезда не знаем какви филми има, за нея да се изведе 0.

select *
from MOVIESTAR

select *
from STARSIN

select name, COUNT(STARNAME)
from MOVIESTAR
left join STARSIN on name=STARNAME

group by NAME

--Да се изведе средният брой филми, в които са се снимали актьорите


select AVG(movieNumber)
from (	
select name, COUNT(STARNAME)  as movieNumber
from MOVIESTAR
left join STARSIN on name=STARNAME
group by NAME ) stat



use pc
--Напишете заявка, която извежда средната честота на процесорите на компютрите.



select avg(speed)
from pc

--Напишете заявка, която за всеки производител извежда средния
--размер на екраните на неговите лаптопи.

select maker, avg(screen)
from laptop
join product on laptop.model=product.model
group by maker

--Напишете заявка, която извежда средната честота на лаптопите с цена над 1000.

select avg(speed)
from laptop
where price > 1000

--Напишете заявка, която извежда средната цена на компютрите и
--лаптопите на производител ‘B’ (едно число).

select avg(price)
from
(
	select price
	from product p join pc
	on p.model=pc.model 
	where maker='B'

	union all

	select price
	from product p join laptop l
	on p.model=l.model 
	where maker='B'
) AllPrices;


--Напишете заявка, която извежда средната цена на компютрите
--според различните им честоти на процесорите.

select *from pc

select speed,avg(price)
from pc
group by speed

--Напишете заявка, която извежда производителите, които са
--произвели поне по 3 различни модела компютъра.

select *
from product

select maker
from product
where type='PC'
group by maker
having count(*)>=3

--Напишете заявка, която извежда производителите на компютрите с най-висока цена.
select *
from product

select distinct maker
from product
join pc on product.model=pc.model
where price= (select max(price) from pc)


--Напишете заявка, която извежда средната цена на компютрите за
--всяка честота, по-голяма от 800 MHz.

select speed,avg(price)
from pc
where speed > 800
group by speed

--Напишете заявка, която извежда средния размер на диска на тези
--компютри, произведени от производители, които произвеждат и принтери.


select avg(hd)
from pc 
join product p on p.model=pc.model
where maker in
	(select maker
	from product
	where type='Printer');

--Напишете заявка, която за всеки размер на лаптоп намира
--разликата в цената на най-скъпия и най-евтиния лаптоп със същия
--размер.


select *from laptop


select screen,max(price)-min(price)
from laptop
group by screen


--Напишете заявка, която извежда броя на класовете кораби.

use ships

select * from CLASSES
select count(*)
from CLASSES

--Напишете заявка, която извежда средния брой на оръдията (numguns) за всички
--кораби, пуснати на вода (т.е. изброени са в  таблицата Ships).

select avg(NUMGUNS)
from CLASSES
join ships on CLASSES.CLASS=ships.CLASS


--Напишете заявка, която извежда за всеки клас първата и последната година, в която
--кораб от съответния клас е пуснат на вода.

select * from ships

select class, min(launched) as F, max(launched) as L
from ships
group by CLASS

--Напишете заявка, която за всеки клас
--извежда броя на корабите, потънали в битка

select * from ships
select * from OUTCOMES


select class, count(result)
from ships
join OUTCOMES on name=ship
where result='sunk'
group by CLASS

--(не се включват класове без потънали кораби)

--Напишете заявка, която за всеки клас с над 4 пуснати на вода кораба извежда
--броя на корабите, потънали в битка.

select *from SHIPS

select class, count (name)
from ships s 
join outcomes o on s.name=o.ship
where result='sunk' and class in 
		(select class
		from ships
		group by class
		having count(*)>4)

--Напишете заявка, която извежда средното
--тегло на корабите (displacement) за всяка страна. 

select country,AVG(DISPLACEMENT)
from CLASSES
group by COUNTRY

use movies

--За всеки актьор/актриса изведете броя на 
-- различните студиа, с които са записвали филми.

select STARNAME, count(distinct STUDIONAME)
from  starsin
join MOVIE on MOVIETITLE=TITLE and MOVIEYEAR=YEAR
group by STARNAME

--За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми.
--Включете и тези, за които няма информация в кои филми са играли.


select name, count(distinct STUDIONAME)
from MOVIESTAR
left join STARSIN on name=STARNAME
left join movie on MOVIETITLE=TITLE and MOVIEYEAR=YEAR
group by name



select name, count(distinct studioname)
from movie
join starsin on movietitle=title and movieyear=year
right join moviestar on name=starname 
group by name;




--Изведете имената на актьорите, участвали в поне 3 филма след 1990 г




select * from STARSIN



select STARNAME
from starsin
where MOVIEYEAR>1990
group by STARNAME
having COUNT(MOVIETITLE)>=3

use pc

--Да се изведат различните модели компютри, подредени по цена на най-скъпия конкретен
--компютър от даден модел.



select model,  max(price)
from pc
group by model




