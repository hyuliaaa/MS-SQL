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



SELECT NAME
FROM SHIPS 
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE NAME LIKE 'C%' OR NAME LIKE 'K%' -- NAME LIKE '[CK]%'

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

SELECT *
FROM OUTCOMES
LEFT JOIN SHIPS ON OUTCOMES.SHIP = SHIPS.NAME
JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
WHERE RESULT = 'SUNK'

SELECT * 
FROM CLASSES
JOIN SHIPS ON CLASSES.CLASS = SHIPS.NAME
JOIN OUTCOMES ON ships.CLASS = OUTCOMES.SHIP
WHERE RESULT = 'SUNK'


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

use ships

select * 
from classes	


select distinct c1.COUNTRY
from CLASSES c1
join CLASSES c2 on  c1.COUNTRY=c2.COUNTRY
where c1.bore!=c2.bore

--Страните, които произвеждат кораби с най-голям брой оръдия (numguns).

select * from CLASSES

select distinct COUNTRY
from CLASSES
where NUMGUNS >= all(select NUMGUNS from CLASSES)

use movies
--Всички филми, чието заглавие съдържа едновременно думите 'Star' и 'Trek' (не
--непременно в този ред). Резултатите да се подредят по година (първо най-новите
--филми), а филмите от една и съща година - по азбучен ред.


select * from movie

select *
from movie
where title like '%Star%' and title like '%Trek%'
order by year DESC,title

--Заглавията и годините на филмите, в които са играли звезди, родени между
--1.1.1970 и 1.7.1980.



select * from MOVIESTAR
select * from STARSIN


select *
from MOVIESTAR
join starsin on name=STARNAME
where BIRTHDATE >= '1970-01-01'  and BIRTHDATE <='1980-07-01'

use pc

--Компютрите, които са по-евтини от всеки лаптоп на същия производител.

select * from product
select * from pc



select * 
from pc
join product p1 on pc.model=p1.model
where price < all(select price
				from laptop
				join product p2 on p2.model=laptop.model
				where p1.maker=p2.maker)

				

--Компютрите, които са по-евтини от всеки лаптоп и принтер на същия
--производител.

select *
from pc 
join product p1 on p1.model=pc.model
where price < all(select price
				from laptop
				join product p2 on p2.model=laptop.model
				where p1.maker=p2.maker)
				and
				price <all(select  price
						from printer 
						join product p3 on p3.model=printer.model
						where p1.maker=p3.maker)


select *
from pc
join product p1 on pc.model = p1.model
where price <all(select price
				 from laptop
				 join product p2 on laptop.model = p2.model
				 where p1.maker = p2.maker
				 UNION
				 select price
				 from printer	
				 join product p3 on printer.model = p3.model
				 where p1.maker = p3.maker)




