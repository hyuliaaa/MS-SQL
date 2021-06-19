
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


--всички принтери с най-висока цена


