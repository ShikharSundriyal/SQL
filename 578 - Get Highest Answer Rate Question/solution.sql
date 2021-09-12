CREATE table survey_log ( uid int, action VARCHAR,question_id int);

INSERT into survey_log values (5,'show',285),(5,'answer',285),(5,'show',369),(5,'skip',369); 

select question_id 
	from survey_log
	group by 
	question_id
	order by sum(case when action = 'answer' then 1 else 0 end ) / sum(case when action = 'show' then 1 else 0 end ) 
 desc limit 1
