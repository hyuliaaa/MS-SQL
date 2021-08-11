use movies
--1
--Без повторение заглавията и годините на всички филми, заснети преди 1982, в които е играл
--поне един актьор (актриса), чието име не съдържа нито буквата 'k', нито 'b'. Първо да се изведат
--най-старите филми.

select title,year
from movie
left join STARSIN on MOVIETITLE=TITLE and MOVIEYEAR=YEAR
where year <1982 and STARNAME not like '%[kb]%'
order by year

select * 
from movie
left join STARSIN on MOVIETITLE=TITLE and MOVIEYEAR=YEAR
where year <1982 and STARNAME not like '%k%' and STARNAME not like '%b%'

--2
-- Заглавията и дължините в часове (length е в минути) на всички филми, които са от същата
--година, от която е и филмът Terms of Endearment, но дължината им е по-малка или неизвестна
select * from movie

select title, LENGTH/60 as hrs
from MOVIE
where year = (select year
			  from MOVIE	
			  where title='Terms of Endearment')
	 and (LENGTH < (select LENGTH
					from MOVIE	
					where title='Terms of Endearment')
		or LENGTH is null)

--3
--Имената на всички продуценти, които са и филмови звезди и са играли в поне един филм
--преди 1980 г. и поне един след 1985 г.

select * from MOVIESTAR
select * from MOVIEEXEC
select * from STARSIN


select STARNAME
from STARSIN
where STARNAME in (select NAME from MOVIEEXEC)
intersect
select starname from starsin
where movieyear < 1980
intersect
select starname from starsin
where movieyear > 1985


select name from movieexec
intersect
select name from moviestar
intersect
select starname from starsin
where movieyear < 1980
intersect
select starname from starsin
where movieyear > 1985

--4
--Всички черно-бели филми, записани преди най-стария цветен филм (InColor='y'/'n') на същото студио.

select * 
from MOVIE

select *
from MOVIE m1
where INCOLOR ='N' and year <(select min(year)
								from MOVIE m2
								where INCOLOR='Y' and m1.STUDIONAME=m2.STUDIONAME)
--5
--Имената и адресите на студиата, които са работили с по-малко от 5 различни филмови звезди
--Студиа, за които няма посочени филми или има, но не се знае кои актьори са играли в тях, също
--да бъдат изведени. Първо да се изведат студиата, работили с най-много звезди.

select STUDIONAME,ADDRESS, count(distinct STARNAME)
from STUDIO
left join MOVIE on STUDIONAME=name
left join starsin on title=MOVIETITLE and YEAR=MOVIEYEAR
group by STUDIONAME,ADDRESS
having count(distinct starname) <5
order by count(distinct STARNAME) desc

--12. За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми.

select STARNAME,count(distinct STUDIONAME)
from STARSIN
left join movie on title=MOVIETITLE and year=MOVIEYEAR
group by STARNAME

--13. За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми,
--включително и за тези, за които нямаме информация в какви филми са играли.

select name,count(distinct STUDIONAME)
from MOVIESTAR
left join STARSIN on STARNAME=NAME
left join movie on title=MOVIETITLE and year=MOVIEYEAR
group by name

--14. Изведете имената на актьорите, участвали в поне 3 филма след 1990 г.

select STARNAME
from STARSIN
where movieyear > 1990
group by STARNAME
having count(movietitle)>=3




use ships

--6. За всеки кораб, който е от клас с име, несъдържащо буквите i и k, да се изведе името
--на кораба и през коя година е пуснат на вода (launched). Резултатът да бъде сортиран
--така, че първо да се извеждат най-скоро пуснатите кораби

select name,LAUNCHED
from ships
where class not like '%[ik]%'
order by LAUNCHED desc

-- 7. Да се изведат имената на всички битки, в които е повреден (damaged) поне един
--японски кораб.

select * from OUTCOMES

select BATTLE 
from CLASSES 
left join ships on CLASSES.CLASS=ships.CLASS
left join outcomes on ships.NAME=OUTCOMES.SHIP
where RESULT='damaged' and COUNTRY='Japan'

--8. Да се изведат имената и класовете на всички кораби, пуснати на вода една година след
--кораба 'Rodney' и броят на оръдията им е по-голям от средния брой оръдия на
--класовете, произвеждани от тяхната страна. (task not understood)

select *
from SHIPS
where LAUNCHED - 1 = (select LAUNCHED from ships where name='Rodney')


--9. Да се изведат американските класове, за които всички техни кораби са пуснати на вода
--в рамките на поне 10 години (например кораби от клас North Carolina са пускани в
--периода от 1911 до 1941, което е повече от 10 години, докато кораби от клас Tennessee
--са пуснати само през 1920 и 1921 г.).

select CLASSES.CLASS 
from CLASSES
join ships on CLASSES.CLASS=ships.CLASS
where COUNTRY='USA' 
group by classes.CLASS
having max(launched)-min(launched) >=10

--10. За всяка битка да се изведе средният брой кораби от една и съща държава (например в
--битката при Guadalcanal са участвали 3 американски и един японски кораб, т.е.
--средният брой е 2).

select BATTLES.name, count(ship) / count ( distinct country)
from BATTLES
left join OUTCOMES on BATTLES.NAME=OUTCOMES.BATTLE
left join ships on ships.NAME=OUTCOMES.SHIP
left join CLASSES on CLASSES.CLASS=SHIPS.CLASS
group by battles.NAME



--11. За всяка държава да се изведе: броят на корабите от тази държава; броя на битките, в
--които е участвала; броя на битките, в които неин кораб е потънал ('sunk') (ако някоя от
--бройките е 0 – да се извежда 0).

select c.country, count(ships.name), count(o1.battle), count(o2.result) 
from classes c 
left join ships on ships.class = c.class
left join outcomes o1 on name = o1.ship
left join outcomes o2 on name = o2.ship
and o2.result = 'sunk'
group by c.country



