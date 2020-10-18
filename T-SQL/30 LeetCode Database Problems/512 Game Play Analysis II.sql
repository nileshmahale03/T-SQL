
/*---------------------------------------------------------------------
Exercise 512

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
 
Write a SQL query that reports the device that is first logged in for each player.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+

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
     , (1, 2, '2016-05-02', 6)
	 , (2, 3, '2016-06-25', 1)
	 , (3, 1, '2016-03-02', 0)
	 , (3, 4, '2016-07-03', 5)

SELECT * FROM Activity

--1. JOIN

SELECT * 
FROM Activity

SELECT player_id
     , MIN(event_date) 'event_date'
FROM Activity
GROUP BY player_id


SELECT A1.player_id
     , A1.device_id
FROM Activity A1
INNER JOIN (
	SELECT player_id
		 , MIN(event_date) 'event_date'
	FROM Activity
	GROUP BY player_id
) A2 ON A2.player_id = A1.player_id AND A2.event_date = A1.event_date

--2. EXITS

; WITH CTEEventDate AS (
SELECT player_id
		, MIN(event_date) 'event_date'
FROM Activity
GROUP BY player_id
)

SELECT * 
FROM dbo.Activity A
WHERE EXISTS (
	SELECT *
	FROM CTEEventDate C
	WHERE C.player_id = A.player_id AND C.event_date = A.event_date
)