--2019-07-09
--1
select s.name, count(m.title) as cnt
from STUDIO s 
join MOVIE m on s.name = m.STUDIONAME
group by s.NAME
having count(m.title) < 2

--2 
select name
from MOVIEEXEC
where NETWORTH <= all(select NETWORTH from MOVIEEXEC
					  WHERE NETWORTH IS NOT NULL)

SELECT NAME
FROM MOVIEEXEC
WHERE NETWORTH IN (	SELECT MIN(NETWORTH)
FROM MOVIEEXEC);
