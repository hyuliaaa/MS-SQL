--изгледи

--виртуална таблица, която не заема физическа памет върху диска
--пр: ако имаме таблица с данни, напр искаме преподавателят да вижда определена част от тези данни и затова създаваме индекс
--който е актуална извадка от таблицата


use ships
--създаване
--Всички американски класове кораби:
select * from CLASSES

CREATE VIEW am_class
as
select *
from CLASSES
where country='USA'


select * from am_class

--За всяка държава – името и средния брой оръдия на нейните класове
CREATE view cn
as
select country,avg(numguns) as avgnumg
from classes
group by country

select * from cn

--Изтриване
drop view cn

