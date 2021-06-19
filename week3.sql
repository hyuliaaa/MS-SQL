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



