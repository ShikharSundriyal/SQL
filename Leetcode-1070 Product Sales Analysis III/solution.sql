create table Sales (sale_id int, product_id int, year int, quantity int, price int);
insert into Sales values (1,100,2008,10,5000),(2,100,2009,12,5000),(7,200,2011,15,9000);
create table Product (product_id int, product_name varchar(200));
insert into Product values (100,'Nokia'),(200,'Apple'),(300,'Samsung');

Approach 1 :
select product_id,year as first_year, quantity, price from Sales where (product_id,year) in
(select product_id, min(year) from Sales group by product_id);

Approach 2 :
select product_id, first_year, quantity, price from
(select product_id, year as first_year, quantity, price, rank() over (partition by product_id order by year) as rnk from Sales)w where w.rnk =1
