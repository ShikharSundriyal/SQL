create table Project( project_id int, employee_id int);
create table Employee (employee_id int, name varchar(100),experience_years int);
Insert into Project values (1,1),(1,2),(1,3),(2,1),(2,4);
Insert into Employee values (1,'Khaled',3),(2,'Ali',2),(3,'John',3),(4,'Doe',2);

-- Approach 1 
select project_id,Project.employee_id from 
Project join Employee on Project.employee_id = Employee.employee_id
where (project_id,experience_years) in
(   select project_id,max(experience_years) from 
    Project join Employee on Project.employee_id = Employee.employee_id
    group by project_id 
);

-- Approach 2
Select project_id,employee_id from (
select Project.project_id,Project.employee_id,rank() over (partition by Project.project_id order by Employee.experience_years desc) as rnk from 
Project join Employee on Project.employee_id = Employee.employee_id ) w
where w.rnk =1;
