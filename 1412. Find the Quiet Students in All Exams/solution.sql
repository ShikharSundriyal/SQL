create table Student (student_id int, student_name varchar(100));
insert into Student values (1,"Daniel"),(2,"Jade"),(3,"stella"),(4,"Jonathan"),(5,"Will");

create table Exam(exam_id int , student_id int, score int);
insert into Exam values (10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60),(40,2,70),(40,4,80);

-- Approach 1 
select Exam.student_id,student_name from Exam 
join Student on Exam.student_id = Student.student_id
group by student_id,student_name
having sum( (exam_id,score) in
(select exam_id, min(score) as score from Exam group by exam_id
union
select exam_id , max(score) as score from Exam group by exam_id
order by exam_id)
) = 0 
order by student_id;

-- Approach 2
select student_id, student_name
from
(
    select distinct student_id
    from Exam
    where student_id not in
    (
        select distinct student_id
        from Exam e left join
        (	-- highest and lowest scores
            select exam_id, max(score) maxs, min(score) mins
            from Exam
            group by exam_id
        ) t
        using(exam_id)
        where score = maxs or score = mins
        -- student with the highest or lowest score
    )
) t
left join Student
using(student_id)
order by student_id
