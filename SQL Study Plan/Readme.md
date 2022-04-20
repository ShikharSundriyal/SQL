197. Rising Temperature:
  - Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
  - In mysql we need to use DATEDIFF to find difference between two dates normal w1.recordDate - 1 = w2.recordDate wont work but it will work in oracle
```sql
select distinct w1.id
from
Weather w1
join Weather w2
on DATEDIFF(w1.recordDate, w2.recordDate) = 1
and 
w1.temperature > w2.temperature;
```

607. Sales Person
  - Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED".
```sql
select 
name
from SalesPerson 
where sales_id not in (
select o.sales_id
from
orders o where com_id  in (select com_id from Company where name = 'RED' )
)

```
1141. User Activity for the Past 30 Days I
  - Write an SQL query to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.

```sql
# Write your MySQL query statement below

SELECT 
activity_date day,
count(distinct user_id) active_users
FROM
Activity
where 
DATEDIFF('2019-07-27',activity_date) < 30
group by activity_date;
```

1693. Daily Leads and Partners
  - Write an SQL query that will, for each date_id and make_name, return the number of distinct lead_id's and distinct partner_id's.

```sql
select 
date_id,
make_name,
count(distinct lead_id) unique_leads,
count(distinct partner_id) unique_partners
from DailySales
group by 1,2;
```

1729. Find Followers Count
  - Write an SQL query that will, for each user, return the number of followers.
```sql
# Write your MySQL query statement below

select 
user_id,
count(distinct follower_id) followers_count
from
Followers
group by 1;
```

586. Customer Placing the Largest Number of Orders

  - Write an SQL query to find the customer_number for the customer who has placed the largest number of orders.
```sql
# Write your MySQL query statement below


with ct as (SELECT
customer_number,
count(distinct order_number) cnt
from 
Orders
group by 1)
select customer_number
from ct
where cnt in (select max(cnt) from ct)
```


511. Game Play Analysis I
  - Write an SQL query to report the first login date for each player.
```sql
# Write your MySQL query statement below

select 
player_id,
min(event_date) first_login
from Activity
group by 1

```

1741. Find Total Time Spent by Each Employee
  - Write an SQL query to calculate the total time in minutes spent by each employee on each day at the office. Note that within one day, an employee can enter and leave more than once. The time spent in the office for a single entry is out_time - in_time.

```sql
# Write your MySQL query statement below

with t as (
select emp_id,event_day,
    out_time-in_time timeSpent
    from 
    Employees
)

select 
event_day day,
emp_id,
    sum(timeSpent) total_time
    from t
    group by 1 ,2
```

1890. The Latest Login in 2020
  - Write an SQL query to report the latest login for all users in the year 2020. Do not include the users who did not login in 2020.

```sql
# Write your MySQL query statement below
with t as (select
user_id,
time_stamp
from Logins
where 
YEAR(time_stamp)  = 2020
)
SELECT
user_id,
MAX(time_stamp) last_stamp
FROM t
GROUP BY 1;
```

1393. Capital Gain/Loss :
  - Write an SQL query to report the Capital gain/loss for each stock.The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.
 
```sql
# Write your MySQL query statement below


select 
stock_name,
sum(sell_val)-sum(buy_val) capital_gain_loss
from 
(SELECT
stock_name,
CASE WHEN operation = 'Buy' THEN sum(price) else 0 END buy_val,
CASE WHEN operation ='Sell' THEN sum(price) else 0 END sell_val
from 
Stocks
group by stock_name,operation
) t
group by stock_name;
    


-- Approach 2
SELECT 
stock_name,
SUM( CASE WHEN operation = 'Buy' then price*-1 
    else price END)capital_gain_loss
from Stocks
group by stock_name
```

1407. Top Travellers :
  - Write an SQL query to report the distance traveled by each user.Return the result table ordered by travelled_distance in descending order, if two or more users traveled the same distance, order them by their name in ascending order.

```sql
# Write your MySQL query statement below


select 
name, 
coalesce(travelled_distance,0)travelled_distance
# case when travelled_distance is null then 0 ELSE travelled_distance END travelled_distance
from
(select 
user_id,
sum(distance) travelled_distance
from Rides
group by user_id) t
right join Users
on t.user_id= Users.id
order by travelled_distance desc,name

```


1158. Market Analysis I :
  - Write an SQL query to find for each user, the join date and the number of orders they made as a buyer in 2019. Return the result table in any order.

```sql
# Write your MySQL query statement beloW

Select 
user_id buyer_id,
join_date,
coalesce(order_count,0) orders_in_2019
from Users 
left join
(select 
buyer_id,
count(order_id) order_count
 from Orders
where 
year(order_date) = 2019 
group by buyer_id
) t 
on buyer_id = user_id

--Approach 2

SELECT u.user_id AS buyer_id ,u.join_date ,COUNT(o.buyer_id) AS orders_in_2019 
FROM Users u LEFT JOIN Orders o
ON u.user_id = o.buyer_id AND YEAR(o.order_date) ='2019'
GROUP BY u.user_id


```
