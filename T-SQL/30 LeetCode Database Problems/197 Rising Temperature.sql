
/*---------------------------------------------------------------------
Exercise 197

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature in a certain day.
 
Write an SQL query to find all dates' id with higher temperature compared to its previous dates (yesterday).

Return the result table in any order.

The query result format is in the following example:

Weather
+----+------------+-------------+
| id | recordDate | Temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+

Result table:
+----+
| id |
+----+
| 2  |
| 4  |
+----+
In 2015-01-02, temperature was higher than the previous day (10 -> 25).
In 2015-01-04, temperature was higher than the previous day (30 -> 20).
*/---------------------------------------------------------------------
USE QuestionBank
Go

DROP TABLE IF EXISTS dbo.Weather
GO

CREATE TABLE dbo.Weather (
	id          INT   NOT NULL IDENTITY(1,1)
  , recordDate  DATE  NOT NULL
  , temperature INT   NOT NULL
  CONSTRAINT PK_dbo_Weather_id PRIMARY KEY (id)
)

INSERT INTO dbo.Weather (recordDate, temperature)
VALUES ('2015-01-01', 10)
     , ('2015-01-02', 25)
	 , ('2015-01-03', 20)
	 , ('2015-01-04', 30)

SELECT * FROM dbo.Weather

--1. JOIN
SELECT * 
FROM dbo.Weather W1
INNER JOIN dbo.Weather W2 ON W2.id = W1.id - 1
WHERE W1.temperature > W2.temperature