# MS-SQL
FMI UNI SOFIA
exercises

## Tasks
--За всеки клас британски кораби да се изведат имената им (на класовете) и имената на всички битки, в които са
--участвали кораби от този клас. Ако даден клас няма кораби или има, но те не са
--участвали в битка, също да се изведат (със стойност NULL за име на битката).
```sql
select distinct classes.class, battle
from classes
left join ships
 on classes.class = ships.class
LEFT join outcomes on ship = name
where country = 'Gt.Britain';


select distinct classes.class, battle
from outcomes
join ships on ship = name
right join classes
 on ships.class = classes.class
where country = 'Gt.Britain';
```

--За всеки клас да се изведат името му, държавата и имената
--на всички негови кораби, пуснати през 1916 г.
```sql
select classes.class, country, name
from classes
join ships on classes.class = ships.class
where launched = 1916;
```

--Да допълним горната задача, като добавим и
--класовете, които нямат нито един кораб от
--1916 - срещу тях да пише NULL: (и за другите класове, които нямат кораби пуснати през 1916 да пише нулл, тоест ако имат кораби
-- които са пуснати през година различна от 1916 срещу тях да пише null)	
```sql
select classes.class, country, name
from classes
left join ships
on classes.class = ships.class
where launched = 1916; -- това решение губи идеята на left join понеже търси всички корабити през 1916 и ако има такива с null ги изпуска

select classes.class, country, name
from classes
left join ships
 on classes.class = ships.class
where launched = 1916 or launched is null; --тук губим корабите, които са пуснати през година различна от 1916 и срещу тях трябва да сложим null
```
--правим left join и свързваме таблиците по classes и lauchned = 1916, понеже за някои редове имаме свързване по запис, но годината е различна
-- следов. условието е false ние ще изкараме реда, свързан по класа и за launched ще сложим НУЛ, ако годината е различна
```sql
select classes.class, country, name
from classes
left join ships
on classes.class = ships.class and launched = 1916;
```
Заключение:
При **left join** ползваме:
- **ON**, ако имаме условие за дясната таблица
- **where**, ако имаме условие за лявата таблица



