CREATE TABLE employees (employee_id int, manager_id int);
insert into employees VALUES (1,1),(3,3),(2,1),(4,2),(7,4),(8,3),(9,8),(77,1);

select 
e1.employee_id
from 
employees e1 
join
employees e2
on e1.manager_id = e2.employee_id
join employees e3
on e3.employee_id = e2.manager_id
where e3.manager_id =1 and e1.employee_id !=1
