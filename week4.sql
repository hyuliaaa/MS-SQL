--Съединения

--За всеки актьор и/или продуцент да се изведе името му,
--рождената му дата и networth:

use movies


select coalesce(ms.NAME,me.name),BIRTHDATE,NETWORTH
from MOVIESTAR ms
full join MOVIEEXEC me on ms.name=me.NAME


--заявки с повече от 1 оператor join


use ships
--За всяка държава да се изведат имената на корабите, които
--никога не са участвали в битка

select *from CLASSES

select * from ships

select *from OUTCOMES


select country,ships.NAME
from CLASSES
join ships on CLASSES.CLASS=ships.CLASS
left join OUTCOMES on ships.name=ship
where OUTCOMES.ship is null

--За всеки клас британски кораби да се изведат имената им (на класовете) и имената на всички битки, в които са
--участвали кораби от този клас. Ако даден клас няма кораби или има, но те не са
--участвали в битка, също да се изведат (със стойност NULL за име на битката).

select distinct classes.class, battle
from outcomes
join ships on ship = name
right join classes
 on ships.class = classes.class
where country = 'Gt.Britain';

--Напишете заявка, която за всеки филм,
--по-дълъг от 120 минути, извежда
--заглавие, година, име и адрес на студио.


select TITLE,YEAR,STUDIONAME,ADDRESS
from movie
join STUDIO on STUDIONAME=NAME
where LENGTH > 120

-- Напишете заявка, която извежда името
--на студиото и имената на актьорите,
--участвали във филми, произведени от
--това студио, подредени по име на студио.

select distinct STUDIONAME, STARNAME
from MOVIE
join STARSIN on TITLE=MOVIETITLE and YEAR=MOVIEYEAR
order by STUDIONAME

--Напишете заявка, която извежда имената
--на продуцентите на филмите, в които е
--играл Harrison Ford.

select distinct NAME
from STARSIN
join movie on TITLE=MOVIETITLE and YEAR=MOVIEYEAR
join MOVIEEXEC on CERT#=PRODUCERC#
where STARNAME='Harrison Ford'

--Напишете заявка, която извежда имената
--на актрисите, играли във филми на MGM.

select NAME
from MOVIESTAR
join STARSIN on NAME=STARNAME
join movie on TITLE=MOVIETITLE and YEAR=MOVIEYEAR
where GENDER='F'  and STUDIONAME = 'MGM'

--Напишете заявка, която извежда името
--на продуцента и имената на филмите,
--продуцирани от продуцента на ‘Star Wars’.

select name, TITLE
from MOVIEEXEC
join movie on CERT#=PRODUCERC#
where name=(select NAME
			from MOVIEEXEC
			join movie on CERT#=PRODUCERC#
			where TITLE='Star Wars')
 
 
 
--Напишете заявка, която извежда имената на актьорите, които не са участвали в нито един филм.  
select NAME
from MOVIESTAR
left join STARSIN on name=STARNAME
where MOVIETITLE is null

-- OR:
select name
from moviestar
where name not in (select starname from starsin);




