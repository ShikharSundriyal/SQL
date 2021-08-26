-- Approach 1 using joins
select 
Request_at as Day,
Round(sum(case when status != 'completed' then 1 else 0 end)/count(status),2) as "Cancellation Rate"
from Trips t
join 
Users u 
on t.Client_Id = u.Users_Id
join 
Users u1
on u1.Users_Id = t.Driver_Id
where
u.Banned = 'No' 
and u1.banned = 'No'
and Request_at between '2013-10-01' and '2013-10-03'
group by Request_at

--Approach 2 subquery
select 
Request_at as Day,
Round(sum(case when status != 'completed' then 1 else 0 end)/count(status),2) as "Cancellation Rate"
from Trips t
where 
 Request_at between '2013-10-01' and '2013-10-03'
 and Client_Id not in (select Users_Id from Users where Banned = 'Yes')
 and Driver_Id not in (select Users_Id from Users where Banned = 'Yes')
group by Request_at
