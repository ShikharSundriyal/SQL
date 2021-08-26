-- Window function
select Department,Employee,Salary from 
(select e.name employee,d.name department,e.salary,dense_rank() over (partition by d.name order by e.salary desc) as rnk from department d join employee e on e.DepartmentId=d.id) as k 
where rnk in ('1','2','3')

--without window function

select d.Name Department, e1.name as Employee, e1.Salary as Salary
from Employee e1
join 
Department d 
on e1.DepartmentId = d.Id
where 3 > 
    (select count(distinct Salary) 
     from Employee e2 
     join 
     Department d1
     on d1.id = e2.DepartmentId
     where
     e2.salary > e1.salary
     and 
     d.id = d1.id
    ) 
