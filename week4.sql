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
 
 
select name, TITLE
from MOVIE
join MOVIEEXEC on PRODUCERC# = CERT#
where CERT# = (select PRODUCERC#
				from movie
				where title = 'Star Wars')


 
 
--Напишете заявка, която извежда имената на актьорите, които не са участвали в нито един филм.  
select NAME
from MOVIESTAR
left join STARSIN on name=STARNAME
where MOVIETITLE is null

-- OR:
select name
from moviestar
where name not in (select starname from starsin);



use pc

--За всеки модел компютри да се изведат цените на различните конфигурации от този модел.
--Ако няма конфигурации за даден модел, да се изведе NULL. Резултатът да има две колони: model и price.

select * from pc	
select * from product

select distinct product.model, price 
from product
left join pc on product.model = pc.model
where product.type = 'PC';

use pc

-- Напишете заявка, която извежда производител, модел и тип на продукт за тези производители,
--за които съответният продукт не се продава (няма го в таблиците PC, Laptop или Printer).


select maker, model, type
from product
where model not in (select model from pc)
	and model not in (select model from laptop)
	and model not in (select model from printer);

select product.model, maker,type
from product
left join pc on product.model = pc.model
where type='pc' and code is null
union
select product.model, maker,type
from product
left join laptop on product.model = laptop.model
where type='laptop' and code is null
union
select product.model, maker,product.type
from product
left join printer on product.model = printer.model
where product.type='printer' and code is null


use ships
--Напишете заявка, която за всеки кораб извежда името му, държавата,
--броя оръдия и годината на пускане (launched).
select *from CLASSES
SELECT *from ships


select NAME,COUNTRY,NUMGUNS,LAUNCHED
from CLASSES
join ships on CLASSES.class=ships.CLASS


--Напишете заявка, която извежда имената на корабите, участвали в битка от 1942 г. 
select * from BATTLES
select * from OUTCOMES

select ship
from OUTCOMES
join BATTLES on outcomes.BATTLE=BATTLES.NAME
where year(date)=1942





