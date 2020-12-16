
/*---------------------------------------------------------------------
Exercise 550

Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
 
Write an SQL query that reports the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33

*/---------------------------------------------------------------------
USE QuestionBank
GO

DROP TABLE IF EXISTS dbo.Activity
GO

CREATE TABLE dbo.Activity (
	player_id    INT  NOT NULL
  , device_id    INT  NOT NULL
  , event_date   DATE NOT NULL
  , games_played INT  NOT NULL
  CONSTRAINT PK_dbo_Activity_player_id_event_date PRIMARY KEY (player_id, event_date)
)

INSERT INTO dbo.Activity (player_id, device_id, event_date, games_played) 
VALUES (1, 2, '2016-03-01', 5)
     , (1, 2, '2016-03-02', 6)
	 , (2, 3, '2017-06-25', 1)
	 , (3, 1, '2016-03-02', 0)
	 , (3, 4, '2018-07-03', 5)

SELECT * FROM Activity

--1.
SELECT player_id
     , MIN(event_date) 'first_login_date'
	 , DATEADD(DAY, 1, MIN(event_date)) 'Next_day_after_first_login_date'
FROM dbo.Activity
GROUP BY player_id

SELECT CAST(CAST(COUNT(DISTINCT A.player_id) AS NUMERIC(5,2)) / CAST((SELECT COUNT(DISTINCT player_id) FROM Activity) AS NUMERIC(5,2)) AS NUMERIC(5,2))
FROM Activity A
JOIN (
	SELECT player_id
		 , MIN(event_date) 'first_login_date'
		 , DATEADD(DAY, 1, MIN(event_date)) 'Next_day_after_first_login_date'
	FROM dbo.Activity
	GROUP BY player_id	
) D ON A.player_id = D.player_id AND A.event_date = D.Next_day_after_first_login_date
