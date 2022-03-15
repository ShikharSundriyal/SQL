# SQL

## Order of execution : 

1. from and join
2. where
3. group by
4. having
5. select
6. distinct
7. order by
8. limit

## Subquery vs corelated query vs Join

Subquery : the inner query is executed first and then the outer query is executed.
Example : Find 2nd highest salary</br>
select id , max(salary) from emp where salary not in (select max(salary) from emp); 

Co-related query : here for each row of outer query the inner query is executed.
Example : Find 2nd highest salary</br>
select id , salary from emp emp1 where 1 =  (select count(distinct salary) from emp emp2 where emp2.salary > emp1.salary); 

Join : the two tables are joined and put into a buffer space .</br>

split in postgres : split_part(columnname, 'character on which to split', index) -> index of the element which we need to get, starting from 1 
