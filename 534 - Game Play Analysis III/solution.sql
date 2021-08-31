select a1.player_id,a1.event_date, sum(a2.games_played)
from activity a1 join activity a2 
on a1.player_id = a2.player_id
and a1.event_date >= a2.event_date
GROUP by a1.player_id,a1.event_date
order by player_id
