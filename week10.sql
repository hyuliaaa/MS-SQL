use movies


select * from movie


-- Да се направи така, че да не може два филма да имат еднаква дължина. 
alter table movie
add constraint U_Movie Unique(Length)


select * from movie
order by LENGTH


insert into movie
values('Hrl',1245,238,'Y', 'MGM', 564)

delete from MOVIE
where title like '%Trek%'




--) Да се направи така, че да не може едно студио да има два филма с едnakva dyljina

alter table movie
add constraint U_L unique(studioname,length)

select * from movie;

insert into movie(title, year, length, incolor, studioName, producerc#)
values('Fail', 2012, 111, 'N', 'Fox', 123);

 --горната заявка няма да тръгне, ако вече има филм на Фокс с дължина 111 минути


-- Изтрийте ограниченията, създадени в зад. 1.

alter table movie
drop constraint U_L, U_Movie



create table students(
fn int primary key check(fn>=0 and fn<=99999),
name varchar(100) not null,
egn char(10) unique not null,
email varchar(100) unique not null,
birthdate date not null,
adate date not null,
constraint at_least_18_years check(datediff(year,birthdate,adate)>=18)
)


select * from students


--добавете валидация за e-mail адреса - да бъде във формат <низ>@<низ>.<низ>
alter table students
add constraint email_valid check(email like '%_@_%.%_')

insert into students
values(81888, 'Ivan Ivanov', '9001012222', 'ivan@gmail.com', '1990-01-01', '2009-01-10');



insert into students
values(1, 'Ivan Ivanov', '9001012322', 'ivn@gmail.com', '1990-01-01', '2009-01-10');



--създайте таблица за университетски курсове -
--уникален номер и име.


create table Courses(
	course_ID int identity primary key,
	course_name varchar(100) not null


)



select * from Courses
insert into Courses
values('DB')

insert into Courses
values ('OOP')


--Всеки студент може да се запише в много курсове и
--във всеки курс може да има записани много студенти

create table studentsEnrolled
(
	student_fn int references students(fn),
	course_id int references courses(course_Id) on delete cascade,
	primary key(student_fn,course_id)
)


insert into studentsEnrolled
values (81888,2)


select * from studentsEnrolled

insert into studentsEnrolled values(81888, 2);
insert into studentsEnrolled values(81888, 3);
insert into studentsEnrolled values(81888, 4);
select * from studentsEnrolled;
-- id-тата на всички курсове, в които се е записал студент 81888:
select course_Id
from studentsEnrolled
where student_fn = 81888;
-- факултетните номера на всички студенти, записали се в курс с id=3 (Android):
select student_fn
from studentsEnrolled
where course_id = 3;

delete from courses
where course_name = 'iOS';
select * from studentsEnrolled;
-- виждаме, че вече няма студенти, записани в курс с id = 4
