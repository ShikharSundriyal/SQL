CREATE table candidate (id int, name VARCHAR);
create table vote(id int,candidateid int);
INSERT into candidate values (1,'A'),(2,'B'),(3,'C'),(4,'D'),(5,'E');
INSERT into vote values (1,2),(2,4),(3,3),(4,2),(5,5);

select name from candidate where id = (
select candidateid from (
  select candidateid,count(*) from vote group by candidateid ORDER by count(*) desc limit 1
  )w
)
