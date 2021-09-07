SELECT
	
COALESCE (ROUND((
(
	SELECT
		count(DISTINCT a1.player_id)
	FROM
		activity a1
	JOIN
activity a2
ON
		a1.player_id = a2.player_id
		AND a1.event_date = a2.event_date -1
		where a1.event_date = (
		SELECT
			min(event_date)
		FROM
			activity an
		WHERE
			an.player_id = a1.player_id)
)::NUMERIC
/ (count(DISTINCT player_id))::NUMERIC) ,
	2),0)
FROM
	activity;
