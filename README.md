# SQL

## Subquery vs corelated query vs Join

Subquery : the inner query is executed first and then the outer query is executed.
Example : Find 2nd highest salary</br>
select id , max(salary) from emp where salary not in (select max(salary) from emp); 

Co-related query : here for each row of outer query the inner query is executed.
Example : Find 2nd highest salary</br>
select id , salary from emp emp1 where 1 =  (select count(distinct salary) from emp emp2 where emp2.salary > emp1.salary); 

Join : the two tables are joined and put into a buffer space .
