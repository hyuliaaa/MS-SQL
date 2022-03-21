-- Подзаявки(заявка, която е част от друга подзаявка, ограждат се със ())
/* Връщат:

-таблица с един и един стълб(скаларна ст-т)
-списък от ст-ти
-произволна таблица

*/
--Пример:Да се изведат заглавията на всички филми, които са по-дълги от Star Wars:
use movies
SELECT title
FROM movie
WHERE length > (SELECT length
 FROM movie
 WHERE title = 'Star Wars');


SELECT *
FROM StarsIn
WHERE starname IN (SELECT name
 FROM MovieStar
 WHERE gender = 'F');

use pc
--всички принтери с най-висока цена(тоест може да имаме няколко принтера с най-висока цена и искаме да ги изведем)
select *
from printer 
where price >= all(select price from printer)
--да вземем всички възможни цени и да намерим такава, която е >= на всяка от тези цени
--за всяко от числата от (400,270,...) сравняваме дали 400 е >= от всички тн за другите.


--Точно един принтер с най-висока цена

select top 1 *
from printer
order by price desc

select top 1*
from printer
where price >= all(select price from printer)


--Класовете, на които поне един от
--корабите им е потънал в битка
use ships

select distinct CLASS
from SHIPS
where name in (select ship
					from OUTCOMES
					where result='sunk')


--Класовете, на които нито един от
--корабите им не е потънал в битка
--Има кораби, които не са участвали в битки
-- Има дори класове без кораби


select class
from CLASSES
where class not in(
						select distinct CLASS
						from SHIPS
						where name in (select ship
											from OUTCOMES
											where result='sunk')

)

--можем да подаваме подзаявки във фром клаузата, като задължително тр да укажем име

use movies

select MOVIETITLE,STARNAME,BIRTHDATE
from STARSIN,(select name,BIRTHDATE
				from MOVIESTAR
				where GENDER='F') Actresses
where STARNAME=NAME

--заявките до тук бяха прости, понеже можем да изпълним подзаяките независимо без да имаме проблем
-- корелативни -подзявка , която използва ст-ти от външната заявка не са независими от външната заяка()


--Напишете заявка, която  извежда имената на  актрисите, които са също и продуценти с нетна стойност, поголяма от 10 милиона.


select name
from MOVIEEXEC
where networth > 10000000 and name in (select name			
										from moviestar	
										where gender='F') 

select name
from moviestar
where gender = 'F' and name in (select name
								from movieexec
								where networth > 10000000)

--Напишете заявка, която
--извежда имената на
--тези филмови звезди,
--които не са продуценти.

--извежда имента на всички филмови звезди, които са продуценти
select name
from MOVIEEXEC
where name in (select name from MOVIESTAR)


--отрицанието на горното твърдение
select name
from MOVIESTAR
where name not in (select name
from MOVIEEXEC
where name in (select name from MOVIESTAR))

--извежда имената на всички филмови звезди, които не са продуценти

select name
from moviestar
where name not in (select name from movieexec);


use pc

--Напишете заявка, която извежда производителите на персонални компютри с
--честота на процесора поне 500 MHz.

select distinct maker
from product
where product.model in (select pc.model
						from pc
						where speed >=500)



--Напишете заявка, която извежда лаптопите,
--чиято честота на CPU е по-ниска от
--честотата на който и да е персонален компютър.

select *
from laptop
where  speed<all(select speed
				from pc)
--all по-ниски от всички компютри
--any по-бавни от поне 1 комп



--Напишете заявка, която извежда модела на
--продукта (PC, лаптоп или принтер) с найвисока цена.
select model
from (select model, price 
			from pc	
			union all
			select model, price
			from laptop
			union all
			select model,price
			from printer) AllProducts
where price >=all(select price from pc
								union all
								select price from laptop
								union all	
								select price from printer)
								

SELECT TOP 1 *
FROM
		(SELECT MODEL,price
		FROM PC
		UNION ALL
		SELECT MODEL,price
		FROM printer 
		UNION ALL
		SELECT MODEL,PRICE
		FROM laptop) PRICE
ORDER BY PRICE DESC


--. Напишете заявка, която извежда производителите на цветните принтери с
--най-ниска цена



select maker
from product
where model in (select model
				from printer
				where color='y' and price <= all(select price from printer where color='y')

SELECT maker
FROM printer
JOIN product ON printer.model = product.model
WHERE COLOR = 'Y' AND PRICE <= ALL(SELECT PRICE FROM printer WHERE COLOR = 'Y')


--Напишете заявка, която извежда производителите на тези персонални
--компютри с най-малко RAM памет, които имат най-бързи процесори.

select maker
from product
where model in (select model
				from pc
				where ram <=all(select ram from pc) and speed >=all(select speed from pc where ram <= all (select ram from pc)));
		

SELECT maker
FROM PC
JOIN PRODUCT ON PC.model = product.model
WHERE RAM <= ALL(SELECT RAM FROM PC) AND SPEED >=ALL(SELECT SPEED FROM PC WHERE RAM <=ALL(SELECT RAM FROM PC))

--корелативна подзаявка		
select distinct maker
from product
where model in (select model
				from pc p1
				where ram <= all (select ram from pc)
					and speed >= all (select speed 
									from pc p2
									where p1.ram = p2.ram));



use ships

--Напишете заявка, която извежда страните, чиито класове кораби са с
--най-голям брой оръдия.


select distinct country
from CLASSES 
where NUMGUNS >=all(select NUMGUNS from CLASSES)

--Напишете заявка, която извежда имената на корабите с 16-инчови оръдия (bore).

select distinct name
from ships
where class in (select class
				from CLASSES
				where bore=16)
	
--Напишете заявка, която извежда имената на битките, в които са
--участвали кораби от клас ‘Kongo’

select BATTLE
from OUTCOMES
where ship in (select name
				from ships
				where class='Kongo')


--Напишете заявка, която извежда имената на корабите, чиито брой
--оръдия е най-голям в сравнение с корабите със същия калибър оръдия (bore).



select name
from ships s
join classes c on s.class = c.class
where numguns >= all (select numguns
				from classes c2
				where c2.bore = c.bore);



