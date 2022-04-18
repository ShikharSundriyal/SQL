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
