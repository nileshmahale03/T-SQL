
/*---------------------------------------------------------------------
Exercise 534

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
 
Write an SQL query that reports for each player and date, how many games played so far by the player. That is, the total number of games played by the player until that date. Check the example for clarity.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 1         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+------------+---------------------+
| player_id | event_date | games_played_so_far |
+-----------+------------+---------------------+
| 1         | 2016-03-01 | 5                   |
| 1         | 2016-05-02 | 11                  |
| 1         | 2017-06-25 | 12                  |
| 3         | 2016-03-02 | 0                   |
| 3         | 2018-07-03 | 5                   |
+-----------+------------+---------------------+
For the player with id 1, 5 + 6 = 11 games played by 2016-05-02, and 5 + 6 + 1 = 12 games played by 2017-06-25.
For the player with id 3, 0 + 5 = 5 games played by 2018-07-03.
Note that for each player we only care about the days when the player logged in.

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
	 , (1, 3, '2017-06-25', 1)
	 , (3, 1, '2016-03-02', 0)
	 , (3, 4, '2018-07-03', 5)

SELECT * FROM Activity

--1. WINDOW FUNCTION

SELECT player_id
     , event_date
	 , SUM(games_played) OVER(PARTITION BY player_id ORDER BY event_date) 'games_played_so_far'
FROM dbo.Activity

--2. JOIN

SELECT A1.player_id, A1.event_date
     , SUM(A2.games_played) 'games_played_so_far'
FROM dbo.Activity A1
INNER JOIN dbo.Activity A2 ON A1.player_id = A2.player_id AND A1.event_date >= A2.event_date
GROUP BY A1.player_id, A1.event_date

