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
