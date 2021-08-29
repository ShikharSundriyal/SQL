--Approach1 (window function)
WITH a AS (
    SELECT 
        id, 
        visit_date, 
        people,
        LAG(id,2) OVER(ORDER BY visit_date) AS before_yesterday,
        LAG(id,1) OVER(ORDER BY visit_date) AS yesterday,
        LEAD(id,1) OVER(ORDER BY visit_date) AS tmr,
        LEAD(id,2) OVER(ORDER BY visit_date) AS day_after_tmr    
    FROM Stadium
    WHERE people >= 100
    ORDER BY id
    )
SELECT a.id, a.visit_date, a.people
FROM a
WHERE 
    (a.id+1=a.tmr AND a.id+2=a.day_after_tmr) OR
    (a.id-1=a.yesterday AND a.id+1=a.tmr) OR
    (a.id-2=a.before_yesterday AND a.id-1=a.yesterday)
;

--Approach2 (self join)
select  distinct s1.*
from
Stadium s1 join Stadium s2 join Stadium s3
on s1.id = s2.id-1 and s1.id = s3.id-2
or
s1.id = s2.id-1 and s1.id = s3.id+1
 or
s1.id=s2.id+1 and s1.id=s3.id+2
where s1.people >= 100 and s2.people >= 100 and s3.people >= 100
order by visit_date
