--Пример:Да се изведат заглавията на всички филми, които са по-дълги от Star Wars:
select title
from MOVIE
where LENGTH > (select LENGTH from movie where title = 'Star Wars')

select m1.title
from movie m1, movie m2
where m2.title='Star Wars' and m1.LENGTH>m2.LENGTH

select *
from movie 
where LENGTH > all(select length from movie where title like 'Star%')

select *
from MOVIE
where year in (1980, 1985,1990) --year = 1980 or year = 1985 or year = 1990

--можем да подаваме подзаявки във фром клаузата, като задължително тр да укажем име
select *
from MOVIESTAR

SELECT movietitle, starname, birthdate
FROM StarsIn, (SELECT name, birthdate
FROM MovieStar
WHERE gender = 'F') Actresses
WHERE starname = Actresses.name;

select *
from MOVIE m 
where year < any (select year from movie where title = m.title)

--Напишете заявка, която  извежда имената на  актрисите, които са също и продуценти с нетна стойност, поголяма от 10 милиона.

select NAME
from MOVIESTAR
where GENDER = 'F' and name in (select name from MOVIEEXEC where NETWORTH > 10000000)


--Напишете заявка, която
--извежда имената на
--тези филмови звезди,
--които не са продуценти.

select *
from MOVIESTAR
where name  not in (select name from MOVIEEXEC)

