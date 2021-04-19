use movies;

select *
from MOVIE


select * 
from STUDIO


select title,YEAR,STUDIONAME,ADDRESS
from MOVIE,STUDIO --pravi dek proizvedenie na movie s studio , toest imame 50 reda
where STUDIONAME=NAME and INCOLOR='y'


select title,YEAR,STUDIONAME,ADDRESS
from MOVIE
join STUDIO on STUDIONAME=name
WHERE INCOLOR='y'

use pc;
	SELECT *
	from laptop

	select *
	from product


select maker, laptop.model,price
from laptop
join product on laptop.model=product.model
where screen=15;


use movies;
--zaqvka, koqto izvejda zaglaviqta na vs filmi s dyljina >	ot dyljinata na star wars
select m1.title
from movie m1, movie m2
where m2.title='Star Wars' and m1.LENGTH>m2.LENGTH

--imenata na vs aktrisi, koito sa se snimali vyv film na mgm, kakto i zaglaviqta na tezi filmi
select *
from MOVIESTAR

select *
from STARSIN
select *
from movie

select NAME,title
from MOVIESTAR
join STARSIN on name=STARNAME 
join MOVIE on title=MOVIETITLE and MOVIEYEAR=year
where gender='F' and STUDIONAME='mgm'	


--vs filmi , koito sa cvetni  i/ili v tqh e igral Harrison Ford

(select title, year
from movie
where INCOLOR='y')
union
(select MOVIETITLE,MOVIEYEAR
from STARSIN
where STARNAME='Harrison Ford')


(SELECT name, address
FROM MovieStar
WHERE gender = 'F')
INTERSECT
(SELECT name, address
FROM MovieExec
WHERE networth > 10000000)


--EXCEPT -vs redove, koito se sreshtat v 1-vata tablica, no ne se sreshtat vyv vtorata



(SELECT name, address
FROM MovieStar)
EXCEPT
(SELECT name, address
FROM MovieExec)
ORDER BY address;


(SELECT name, address
FROM MovieStar)
(SELECT name, address
FROM MovieExec)



select distinct STARNAME
from STARSIN
 
use ships;
--Имената на всички битки, в които има потънал кораб
select distinct BATTLE
from OUTCOMES 
where RESULT='sunk'



--zadachi movies
use movies

--Напишете заявка, която извежда имената на актрисите, участвали в Terms of Endearment.
select NAME
from MOVIESTAR
join STARSIN on name=STARNAME
where gender='F' and MOVIETITLE='Terms of Endearment'

--Напишете заявка, която извежда имената на филмовите звезди, участвали във филми на студио MGM през 1995 г.
select STARNAME
from STARSIN
join MOVIE on title=MOVIETITLE and year=MOVIEYEAR
where STUDIONAME='MGM' and year=1995	

--zadachi pc
use pc


--Напишете заявка, която извежда производителя и честотата на процесора на лаптопите с размер на харддиска поне 9 GB.
select maker, speed
from laptop
join product on laptop.model=product.model
where hd >=9

--Напишете заявка, която извежда номер на модел и цена на всички продукти, произведени от производител с име ‘B’. Сортирайте резултата
--така, че първо да се изведат най-скъпите продукти.


(select product.model, price
from product
join printer on product.model=printer.model
where maker='B')
union
(select product.model,price
from product
join laptop on product.model=laptop.model
where maker='B')
union
(select product.model,price
from product
join pc on product.model=pc.model
where maker='B')
order by price desc

--Напишете заявка, която извежда размерите на 
--тези харддискове, които се предлагат в поне два компютъра.

select distinct p1.hd
from pc p1
join pc p2 on p1.hd=p2.hd and p1.code!=p2.code


--Напишете заявка, която извежда всички двойки модели на компютри, които имат еднаква честота
--на процесора и памет. Двойките трябва да се показват само по веднъж, например ако вече е
--изведена двойката (i, j), не трябва да се извежда (j, i)

select distinct p1.model, p2.model
from pc p1,pc p2
where p1.speed=p2.speed and p1.ram=p2.ram and p1.model<p2.model



--Напишете заявка, която извежда производителите (pitai za tazi)
--на поне два различни компютъра с честота на процесора поне 1000 MHz.

select maker
from pc p1, pc p2
join product on p2.model=product.model and p2.model=product.model
where p1.model!=p2.model and (p1.speed>=1000 and p2.speed>=1000)

--zadachi ships
use ships

--Напишете заявка, която извежда името на корабите, 
--по-тежки (displacement) от 35000.

select distinct NAME
from CLASSES
join ships on CLASSES.CLASS=ships.CLASS
where DISPLACEMENT>35000


--Напишете заявка, която извежда имената, водоизместимостта и броя
--оръдия на всички кораби, участвали в битката при Guadalcanal.

select NAME,DISPLACEMENT,NUMGUNS
from ships
join outcomes on ship=NAME
join CLASSES on ships.CLASS=CLASSES.CLASS
where BATTLE='Guadalcanal'

--Напишете заявка, която извежда имената на тези държави, които имат
--класове кораби от тип ‘bb’ и ‘bc’ едновременно.
select COUNTRY
from CLASSES
where type='bb'
intersect 
select country
from CLASSES
where type='bc'

--. Напишете заявка, която извежда имената на тези кораби, които са били
--повредени в една битка, но по-късно са участвали в друга битка.
select distinct o1.ship
from outcomes o1 
join battles b1 on o1.battle = b1.name
join outcomes o2 on o1.ship = o2.ship
join battles b2 on o2.battle = b2.name
where o1.result = 'damaged' and b1.date < b2.date;
