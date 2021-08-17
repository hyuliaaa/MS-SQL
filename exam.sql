use pc

create trigger t1
on  product
instead of
	insert 

--3


select model,price
from (select pc.model,price,speed
from product
left join pc on product.model=pc.model
where type='PC'  and ram is null and (maker like '%A' or maker like 'A%')
union  all
select laptop.model,price,speed
from product
left join laptop on product.model=laptop.model
where type='laptop' and ram is null and (maker like '%A' or maker like 'A%'))  Product
order by price desc,speed asc











--4

create view p
as
select model from product

select * from p
drop view p


select *
from product

select  maker
from product
where type='laptop'


select *
from product
left join printer on printer.model=product.model and color='y'
where product.type='Printer' and maker not in (select  maker
from product
where type='laptop'
) 

create view izgled
as
select maker, avg(price)  as average
from product
left join printer on printer.model=product.model and color='y'
where product.type='Printer' and maker not in (select  maker
from product
where type='laptop'
)
group  by maker

drop view izgled
select * from izgled



--2



select maker, avg(price)  as average
from product
join printer on printer.model=product.model
where product.type='Printer'and color='y' and maker not in (select  maker
from product
where type='laptop'
)
group  by maker


--2

konf-model edin  i sash kod razlichen

update laptop
set price=0.95*price
where price=(select price
from (select l1.price
from laptop l1
join laptop l2 on l1.model =l2.model
where l1.code<l2.code
group by l1.code
having count(l1.code)<4) Product)



UPDATE laptop
SET screen=screen+1
WHERE model IN (SELECT model
		      FROM product
		      WHERE maker='B');


update price
set price=price+1
where pric

update price
set price=price+1
where price from laptop

select price
from (select l1.price
from laptop l1
join laptop l2 on l1.model =l2.model
where l1.code<l2.code ) Product


