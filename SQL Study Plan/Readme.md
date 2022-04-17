197. Rising Temperature:
  - Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
  - In mysql we need to use DATEDIFF to find difference between two dates normal w1.recordDate - 1 = w2.recordDate wont work but it will work in oracle
```sql
select distinct w1.id
from
Weather w1
join Weather w2
on DATEDIFF(w1.recordDate, w2.recordDate) = 1
and 
w1.temperature > w2.temperature;
```
