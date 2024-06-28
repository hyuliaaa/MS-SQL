
select distinct NAME
from ships s 
join classes c on s.CLASS = c.class
where DISPLACEMENT >=35000

select s.name, c.bore, c.NUMGUNS
from classes c
join ships s on c.class = s.class
join outcomes on s.NAME = OUTCOMES.SHIP
where BATTLE='Guadalcanal'

--Напишете заявка, която извежда имената на тези държави, които имат
--класове кораби от тип ‘bb’ и ‘bc’ едновременно.
select country
from classes
where type ='bb'
intersect
select country
from classes 
where type = 'bc'

--. Напишете заявка, която извежда имената на тези кораби, които са били
--повредени в една битка, но по-късно са участвали в друга битка.
select distinct o1.ship
from outcomes o1 
join battles b1 on o1.battle = b1.name
join outcomes o2 on o1.ship = o2.ship
join battles b2 on o2.battle = b2.name
where o1.result = 'damaged' and b1.date < b2.date;


--Напишете заявка, която извежда страните, чиито класове кораби са с
--най-голям брой оръдия.

select distinct COUNTRY
from classes
where numguns >=all(select numguns from CLASSES);

--Напишете заявка, която извежда имената на корабите с 16-инчови оръдия (bore).
select * from CLASSES;
select * from SHIPS;

select distinct s.NAME
from ships s
join classes c on s.CLASS = c.class
where bore = 16;

select distinct name
from ships
where CLASS in (select class from CLASSES where bore = 16);

--Напишете заявка, която извежда имената на битките, в които са
--участвали кораби от клас ‘Kongo’

select distinct battle
from OUTCOMES
where ship in (select name from ships where class = 'Kongo');

select *
from OUTCOMES o
join ships s on o.SHIP = s.NAME
where s.CLASS = 'KoNgo'

--Напишете заявка, която извежда имената на корабите, чиито брой
--оръдия е най-голям в сравнение с корабите със същия калибър оръдия (bore).
select *
from classes c
join ships s on c.class = s.class
where NUMGUNS >= all(select NUMGUNS from CLASSES c2 
					 where c.bore = c2.BORE)



