DROP TABLE IF EXISTS employees;
CREATE table employees(id int,name VARCHAR,managerId INT);
INSERT into employees values 
(101,'John',null),
(102,'Dan',101),
(103,'James',101),
(104,'Amy',101),
(105,'Renee',101),
(106,'Ron',101);

SELECT name from employees where id IN (
select managerid from employees group by managerid HAVING count(DISTINCT id)>=5);
