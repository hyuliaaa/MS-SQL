--Напишете заявка, която извежда всички двойки модели на компютри, които имат еднаква честота
--на процесора и памет. Двойките трябва да се показват само по веднъж, например ако вече е
--изведена двойката (i, j), не трябва да се извежда (j, i)

select *
from pc p1;

select distinct p1.model, p2.model
from pc p1
join pc p2 on p1.model < p2.model
where p1.speed = p2.speed and p1.ram = p2.ram

select distinct p1.model, p2.model
from pc p1,pc p2
where p1.speed=p2.speed and p1.ram=p2.ram and p1.model<p2.model


--. Напишете заявка, която извежда производителите
--на поне два различни компютъра с честота на
--процесора поне 1000 MHz
select *
from pc;

select maker
from pc p1
join pc p2 on p1.model = p2.model and p1.code != p2.code
join product on p1.model = product.model
where p1.speed >= 500;


SELECT DISTINCT maker
FROM product
WHERE (SELECT COUNT(pc.model)
       FROM pc
                JOIN product p ON p.model = pc.model
       WHERE pc.speed >= 500
         AND p.maker = product.maker) >= 2;



SELECT DISTINCT product1.maker
FROM pc p1
         CROSS JOIN pc p2
         JOIN product product1 ON product1.model = p1.model
         JOIN product product2 ON product2.model = p2.model
WHERE p1.code != p2.code
  AND p1.speed >= 500
  AND p2.speed >= 500
  AND product1.maker = product2.maker;
  
select distinct maker
from pc p1
join pc p2 on p1.model = p2.model and p1.code != p2.code
join product on p1.model = product.model
where p1.speed >= 500 and p2.speed >=500;

select *
from product 
join laptop on product.model = laptop.model

select *
from printer
where price >= all(select price from printer)
--да вземем всички възможни цени и да намерим такава, която е >= на всяка от тези цени
--за всяко от числата от (400,270,...) сравняваме дали 400 е >= от всички тн за другите.

--Точно един принтер с най-висока цена
select top 1*
from printer
order by price desc

select top 1*
from printer 
where price >= all(select price from printer)

--Напишете заявка, която извежда производителите на персонални компютри с
--честота на процесора поне 500 MHz.
select maker
from product
where model in (select model from pc where speed >= 500)

--Напишете заявка, която извежда лаптопите,
--чиято честота на CPU е по-ниска от
--честотата на който и да е персонален компютър.
select *
from laptop
where  speed<any(select speed
				from pc)
--all по-ниски от всички компютри
--any по-бавни от поне 1 комп

--Напишете заявка, която извежда модела на
--продукта (PC, лаптоп или принтер) с найвисока цена.
select top 1 model
from (select top 1 model, price
from printer
where price >= all (select price from printer)
UNION
select top 1 model, price
from pc
where price >= all (select price from pc)
UNION
select top 1 model, price
from laptop
where price >= all (select price from laptop)) result
order by price desc;

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
select product.maker
from printer
join product on printer.model = product.model
where price <= all(select price from printer where color = 'y') and color = 'y'


select maker 
from product
where model = (select model
from printer
where price <=all(select price from printer where color = 'y') and color = 'y')

--Напишете заявка, която извежда производителите на тези персонални
--компютри с най-малко RAM памет, които имат най-бързи процесори.
select *
from pc 
where ram <= all(select ram from pc) and speed >=all(select speed from pc where ram <=all(select ram from pc));

--корелативна подзаявка		
select distinct maker
from product
where model in (select model
				from pc p1
				where ram <= all (select ram from pc)
					and speed >= all (select speed 
									from pc p2
									where p1.ram = p2.ram));

										
