--Имената и годините на пускане на всички кораби, които имат 
--същото име като своя клас

select name,LAUNCHED from ships
where name=CLASS


---Имената на всички кораби, за които 
--едновременно са изпълнени следните условия:
--(1) участвали са в поне една битка 
--(2) имената им (на корабите) започват с C или K.

select distinct ship 
from ships
left join outcomes on  ships.name=outcomes.ship
where battle is not null and (ship  like 'C%' or name like 'K%')

select distinct ship 
from outcomes
where ship like 'C%' or ship like 'K%';

--Всички държави, които имат потънали в битка кораби



select distinct COUNTRY
from ships
join CLASSES on CLASSES.CLASS=ships.CLASS
where name in (select ship from OUTCOMES
				where result='sunk')

SELECT DISTINCT CLASSES.COUNTRY
FROM SHIPS
         INNER JOIN CLASSES on CLASSES.CLASS = SHIPS.CLASS
         INNER JOIN OUTCOMES on SHIPS.NAME = OUTCOMES.SHIP
WHERE OUTCOMES.RESULT = 'sunk';

-- Всички държави, които нямат нито един потънал кораб.


select distinct COUNTRY from CLASSES
left join ships on CLASSES.CLASS=ships.CLASS
where name is null or name in (select ship from OUTCOMES
				where result!='sunk')
				
select distinct COUNTRY
from CLASSES
left join ships on CLASSES.CLASS=ships.CLASS
where name is null or name not in (select ship from OUTCOMES
				where result='sunk')



--(От държавен изпит) Имената на класовете, за които няма кораб, пуснат на вода
--(launched) след 1921 г. Ако за класа няма пуснат никакъв кораб, той също трябва
--да излезе в резултата.

select classes.class
from classes
left join ships on classes.class = ships.class and launched > 1921
where name is null;

select class
from classes
where class not in (select class from ships where launched > 1921);

--Името, държавата и калибъра (bore) на всички класове кораби с 6, 8 или 10
--оръдия. Калибърът да се изведе в сантиметри (1 инч е приблизително 2.54 см).


select class, country, bore * 2.54 as bore_cm
from classes
where numguns in (6, 8, 10);


--Държавите, които имат класове с различен калибър (напр. САЩ имат клас с 14
--калибър и класове с 16 калибър, докато Великобритания има само класове с 15).
