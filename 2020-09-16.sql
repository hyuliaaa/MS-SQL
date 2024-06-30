--2020-09-16
--1
-- имената и адресите на всички студиа, които имат поне един цветен
-- и поне един черно-бял филм.
--резултатът да се сортира по възходящ ред
select * from
(select s.NAME, s.ADDRESS
from studio s
join movie m on s.NAME = m.STUDIONAME
where  INCOLOR = 'Y'
INTERSECT
select s.name, s.ADDRESS
from studio s
join movie m on s.NAME = m.STUDIONAME
where  INCOLOR = 'N') Result
order by Result.ADDRESS;


SELECT DISTINCT name, address
FROM Studio JOIN Movie ON name = studioName
WHERE inColor = 'Y' AND name IN (SELECT name 
                                 FROM Studio JOIN Movie ON name = studioName
                                 WHERE inColor = 'N')

--2
-- Да се напише заявка, която за всяко студио с най-много 3 филма извежда:
-- името му
-- адреса
-- средната дължина на филмите на това студио
--Студиа без филми също да се изведат(за ср. дължина null / 0)

select STUDIONAME, ADDRESS, avg(LENGTH)
from studio s
left join movie m on s.NAME = m.STUDIONAME
group by STUDIONAME, address
having count(TITLE) <=3
