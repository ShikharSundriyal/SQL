--create table activity (player_id int,device_id int, event_date DATE,games_played int);
--INSERT INTO activity values (1,2,'2016-03-01',5),(1,2,'2016-05-02',6),(2,3,'2017-06-25',1),(3,1,'2016-03-02',0),(3,4,'2018-07-03',5)
select player_id , min(event_date) from activity GROUP by player_id order by player_id;
