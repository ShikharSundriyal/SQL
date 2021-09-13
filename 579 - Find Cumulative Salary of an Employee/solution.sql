CREATE table Employee(id int,month int, salary int)
INSERT into employee VALUES (1,1,20 ),
(2,1,20 ),
(1,2,30 ),
(2,2,30 ),
(3,2,40 ),
(1,3,40 ),
(3,3,60 ),
(1,4,60 ),
(3,4,70 );

with temp as (
select * from Employee where (id,month) not in (select id,max(month) val from Employee group by id) 
)
select id,month,
sum(salary) over (partition by id order by month range between unbounded preceding and current row) as salary
from temp;
