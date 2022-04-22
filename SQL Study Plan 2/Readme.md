1699. Number of Calls Between Two Persons
  - Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.
```sql
# Write your MySQL query statement below

Select 
case when from_id <  to_id then from_id else to_id End person1,
case when to_id <  from_id then from_id else to_id End person2,
count(*) call_count,
sum(duration) total_duration
From Calls a1
Group by 1,2
# having person2>person1
```

1251. Average Selling Price :
  - Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.
```sql
with price_units as (select 
p.product_id product_id,
price,
units
from
Prices p
join
UnitsSold u
on 
p.product_id = u.product_id
and 
(u.purchase_date >= p.start_date and  u.purchase_date <= p.end_date)
                     )
select 
product_id,
ROUND(sum(price*units)/ sum(units),2) average_price 
from 
price_units
group by 1;

#Approach 2 

select 
p.product_id product_id,
ROUND(SUM(price*units) / SUM(units),2) average_price
from
Prices p
join
UnitsSold u
on 
p.product_id = u.product_id
and 
(u.purchase_date >= p.start_date and  u.purchase_date <= p.end_date)
GROUP BY 1
                     
```

1571. Warehouse Manager :
  - Write an SQL query to report the number of cubic feet of volume the inventory occupies in each warehouse.
```sql
select
name warehouse_name,
sum(Width*Length*Height*units) volume
from Products p
join 
Warehouse w
on p.product_id = w.product_id
group by 1
```

1445. Apples & Oranges 
  - Write an SQL query to report the difference between the number of apples and oranges sold each day.
```sql
select 
sale_date,
sum(case when fruit = 'apples' then sold_num else 0 END) -
sum(case when fruit = 'oranges' then sold_num else 0 END) diff
from 
Sales
group by 1
order by sale_date;

#Approach 2 

select 
s1.sale_date,
s1.sold_num - s2.sold_num diff
from 
Sales s1
join
Sales s2
on s1.sale_date = s2.sale_date and s1.fruit='apples' and s1.fruit!=s2.fruit
order by s1.sale_date
```

1193. Monthly Transactions I
  - Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.
```sql
# Write your MySQL query statement below


select
DATE_FORMAT(trans_date,"%Y-%m") month,
country,
count(*) trans_count,
sum(case when state='approved' then 1 else 0 end) approved_count
,sum(amount) trans_total_amount,
sum(case when state='approved' then amount else 0 end) approved_total_amount
from 
Transactions
group by 1,2

```

1633. Percentage of Users Attended a Contest :
  - Write an SQL query to find the percentage of the users registered in each contest rounded to two decimals.

```sql

select 
contest_id,
Round(count(distinct user_id)/(select count(*) from Users) * 100,2)percentage
from Register
group by 1
order by 2 desc, 1 ;
```
1173. Immediate Food Delivery I
  - If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.
```sql
select 
ROUND(sum(case when order_date=customer_pref_delivery_date then 1 else 0 end) 
/ (select count(delivery_id) from Delivery) *100,2) immediate_percentage
from 
Delivery;

--Approach 2

select ROUND(count(*)/
(select count(delivery_id) from Delivery) *100,2) immediate_percentage
from 
Delivery
WHERE 
order_date=customer_pref_delivery_date
```


1211. Queries Quality and Percentage :
  - We define query quality as:
  - The average of the ratio between query rating and its position.
  - We also define poor query percentage as:
  - The percentage of all queries with rating less than 3.
  - Write an SQL query to find each query_name, the quality and poor_query_percentage.
  - Both quality and poor_query_percentage should be rounded to 2 decimal places.
  - Return the result table in any order.

```sql
SELECT 
query_name,
ROUND( sum(rating/position) / count(*),2) quality,
ROUND((1.0*sum(case when rating < 3 then 1 else 0 END)) / count(*)*100,2)  poor_query_percentage
from 
Queries
group by 1;
```
