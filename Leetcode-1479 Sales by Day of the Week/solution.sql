
create table orders(order_id int, customer_id int,order_date date,item_id varchar(100),quantity int);

insert into orders values (1,1,'2020-06-01',"1",10 ), (2,1,'2020-06-07',"1",10 );

create table items(item_id varchar(100), item_name varchar(100),item_category varchar(100));

insert into items values ('1','LC Alg. Book','Book');

select items.item_category as 'Category',
sum(case when weekday(orders.order_date) = 0 then orders.quantity else 0 end) as 'Monday',
sum(case when weekday(orders.order_date) = 1 then orders.quantity else 0 end) as 'Tuesday',
sum(case when weekday(orders.order_date) = 2 then orders.quantity else 0 end) as 'Wednesday',
sum(case when weekday(orders.order_date) = 3 then orders.quantity else 0 end) as 'Thursday',
sum(case when weekday(orders.order_date) = 4 then orders.quantity else 0 end) as 'Friday',
sum(case when weekday(orders.order_date) = 5 then orders.quantity else 0 end) as 'Saturday',
sum(case when weekday(orders.order_date) = 6 then orders.quantity else 0 end) as 'Sunday'
from items 
left join 
orders 
on items.item_id = orders.item_id
group by items.item_category;
