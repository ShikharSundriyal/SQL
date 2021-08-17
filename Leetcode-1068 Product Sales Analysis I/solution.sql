create table Sales (sale_id int, product_id int, year int, quantity int, price int);
insert into Sales values (1,100,2008,10,5000),(2,100,2009,12,5000),(7,200,2011,15,9000);
create table Product (product_id int, product_name varchar(200));
insert into Product values (100,'Nokia'),(200,'Apple'),(300,'Samsung');

select product_name , year,  price 
from 
Sales 
join 
Product 
on Sales.product_id = Product.product_id 
order by year,price;
