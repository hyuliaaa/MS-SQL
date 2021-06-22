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

