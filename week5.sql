--Agregate functions
use movies

--most often we give a column from a table
select avg(networth)
from MOVIEEXEC


--count(*) returns the number of rows in a specified table, and it preserves duplicate rows
select count(*)
from STARSIN


select count(distinct STARNAME)
from STARSIN


--sum of lengths of all movies in which harisson ford is starring
SELECT SUM(length)
FROM Movie
JOIN StarsIn
ON title = movietitle AND year = movieyear
WHERE starname = 'Harrison Ford';


--За всяко студио искаме да изведем точно по един ред със следната информация:
--- Име на студиото
--– Сумарна дължина на всички негови филми

select STUDIONAME, sum(length)
from MOVIE 
group by STUDIONAME



--За всяка година да се изведе колко филмови звезди са родени:


select YEAR(birthdate),count(name)
from MOVIESTAR
group by year(BIRTHDATE)

--За всяка година да се изведе колко актриси и колко актьори мъже са родени:
select YEAR(BIRTHDATE),gender, count(*)
from MOVIESTAR
group by year(birthdate), GENDER


--we cannot use agregate functions in where clause

-- Да се изведе най-дългият филм (ако са повече от един, да се изведат всички най-дълги):

select *
from MOVIE
WHERE LENGTH= (select MAX(length) from movie)



SELECT studioName, SUM(length)
FROM Movie
GROUP BY studioName
HAVING COUNT(*) >= 2;

--null values are ignored when agregating
--null values are not ignored when grouping


--● За всяка филмова звезда да се изведе броят на филмите, в които се е снимала.
--● Ако за дадена звезда не знаем какви филми има, за нея да се изведе 0.

select *
from MOVIESTAR

select *
from STARSIN

select name, COUNT(STARNAME)
from MOVIESTAR
left join STARSIN on name=STARNAME
group by NAME

--Да се изведе средният брой филми, в които са се снимали актьорите


select AVG(movieNumber)
from (	
select name, COUNT(STARNAME)  as movieNumber
from MOVIESTAR
left join STARSIN on name=STARNAME
group by NAME ) stat
