create table Orders (order_id int,order_date DATE,customer_id INT,product_id int)
INSERT into orders VALUES
(1 ,'2020-07-31',1,1),
(2 ,'2020-07-30',2,2),
(3 ,'2020-08-29',3,3),
(4 ,'2020-07-29',4,1),
(5 ,'2020-06-10',1,2),
(6 ,'2020-08-01',2,1),
(7 ,'2020-08-01',3,3),
(8 ,'2020-08-03',1,2),
(9 ,'2020-08-07',2,3),
(10,'2020-07-15',1,2);


CREATE table Products (product_id int, product_name VARCHAR,price int);
INSERT INTO products VALUES
(1,'keyboard',120),
(2,'mouse',80 ),
(3,'screen',600),
(4,'hard disk',450)


--Approach 1 without window function
with tmp as (select customer_id,product_id,count(*) freq from Orders group by customer_id,product_id)
SELECT w.customer_id,tmp.product_id,P.product_name FROM
(select 
customer_id, max(freq) freq
from 
tmp
group by customer_id) w
join tmp 
on w.customer_id = tmp.customer_id
and
w.freq = tmp.freq
join
Products p
on tmp.product_id = p.product_id
ORDER BY tmp.customer_id

-- Approach 2
with tmp as (select customer_id,product_id,count(*) freq, rank() over (PARTITION by customer_id order by count(*) desc) rk
             from Orders group by customer_id,product_id)
select tb.*,products.product_name 
from (select tmp.customer_id,tmp.product_id from tmp where rk=1) tb
join 
products
on tb.product_id = products.product_id
