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

1607. Sellers With No Sales :
  - Write an SQL query to report the names of all sellers who did not make any sales in 2020.
 

```sql

select seller_name
from Seller 
where 
seller_id not in
(
    select 
    seller_id
    from Orders
    where year(sale_date) = 2020
 )
order by 1 

--Approach 2

select seller_name
from seller left join orders
on seller.seller_id = orders.seller_id
AND year(sale_date) = "2020"
where order_id is null
order by seller_name
```

619. Biggest Single Number
  - A single number is a number that appeared only once in the MyNumbers table.Write an SQL query to report the largest single number. If there is no single number, report null.
```sql
select max(num) num
from
(select 
num,
count(*) cnt
from MyNumbers
group by 1
) t
where cnt = 1;
```

1112. Highest Grade For Each Student :
  - Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id.

```sql
# Write your MySQL query statement below


with ct as (select 
student_id,
course_id,
grade,
row_number() over (partition by student_id order by grade desc,course_id) rnk
from 
Enrollments)
select 
student_id,
course_id,
grade 
from ct 
where rnk =1;

--Approach 2

SELECT student_id, MIN(course_id) AS course_id,grade FROM Enrollments
WHERE (student_id,grade) IN
(SELECT DISTINCT student_id, max(grade) 
 FROM Enrollments GROUP BY student_id)
GROUP BY student_id
ORDER BY student_id;
```


1398. Customers Who Bought Products A and B but Not C
  - Write an SQL query to report the customer_id and customer_name of customers who bought products "A", "B" but did not buy the product "C" since we want to recommend them to purchase this product.

```sql
# Write your MySQL query statement below

select distinct
o1.customer_id,
c1.customer_name
from 
Orders o1
join 
Customers c1
on o1.customer_id = c1.customer_id
where
o1.customer_id in (select distinct customer_id from Orders where product_name='A')
and
o1.customer_id in (select distinct customer_id from Orders where product_name='B')
and 
o1.customer_id NOT in (select distinct customer_id from Orders where product_name='C')
order by 1

-- Approch 2
select 
customer_id,
customer_name
from
(select 
o1.customer_id,
c1.customer_name,
sum(case when product_name='A' then 1 else 0 end)ca,
sum(case when product_name='B' then 1 else 0 end)cb,
sum(case when product_name='C' then 1 else 0 end)cc
from
Orders o1
join
Customers c1
on 
c1.customer_id = o1.customer_id
group by 1,2
) ct
where 
ca>=1 and cb>=1 and cc=0
order by 1;
```

1440. Evaluate Boolean Expression :
  - Write an SQL query to evaluate the boolean expressions in Expressions table.
```sql
# Write your MySQL query statement below


with ct as(Select
        left_operand,   
v1.value left_operand1,
operator,
           right_operand,
v2.value right_operand1
from 
Expressions
join 
Variables v1
on 
left_operand = v1.name
join
Variables v2 on
right_operand = v2.name
)
select 
left_operand,
operator,
right_operand,
case 
    when operator="=" and left_operand1 = right_operand1 then 'true'
    when operator=">" and left_operand1 > right_operand1 then 'true' 
    when operator="<" and left_operand1 < right_operand1 then 'true'
    else 'false'
    END value
from ct

```

1264. Page Recommendations :
  - Write an SQL query to recommend pages to the user with user_id = 1 using the pages that your friends liked. It should not recommend pages you already liked.

```sql

select 
distinct page_id recommended_page
from 
Likes where
user_id in
(select 
user2_id
from 
Friendship where 
user1_id = 1
union
select 
user1_id
from 
Friendship where 
user2_id = 1) and page_id not in (select page_id from Likes where user_id = 1)

```

570. Managers with at Least 5 Direct Reports :
  - Write an SQL query to report the managers with at least five direct reports.

```sql
select 
name
from  
Employee 
where id  in (
select
managerId
from Employee
group by 1
having count(managerId) >=5
)
```
1303. Find the Team Size :
  - Write an SQL query to find the team size of each of the employees.

```sql
with ct as(select
team_id,
count(*) sz
from Employee
group by 1
 )
 select 
 employee_id,
 sz team_size
 from Employee
 join
 ct
 on
 Employee.team_id = ct.team_id
 
 --Approach 2
 select employee_id, count(team_id) over (partition by team_id) as team_size
from employee
```

1988. Find Cutoff Score for Each School
  - Write an SQL query to report the minimum score requirement for each school. If there are multiple score values satisfying the above conditions, choose the smallest one. If the input data is not enough to determine the score, report -1.


```sql
# Write your MySQL query statement below


with ct as (select
school_id,
min(score) score
from 
Schools,
Exam
where 
capacity >= student_count
group by 
1)

select 
Schools.school_id,
coalesce(ct.score,-1) score
from 
Schools
left join
ct
on
ct.school_id = Schools.school_id

```
