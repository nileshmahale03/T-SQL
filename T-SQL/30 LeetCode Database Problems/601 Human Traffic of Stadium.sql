
/*---------------------------------------------------------------------
Exercise 601

Table: Stadium

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the primary key for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
No two rows will have the same visit_date, and as the id increases, the dates increase as well.
 
Write a SQL query to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

Return the result table ordered by visit_date in ascending order.

The query result format is in the following example.

Stadium table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+

Result table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
The rows with ids 2 and 3 are not included because we need at least three consecutive ids.

*/---------------------------------------------------------------------
USE QuestionBank
GO

DROP TABLE IF EXISTS dbo.Stadium
GO

CREATE TABLE dbo.Stadium (
	id         INT  NOT NULL IDENTITY(1, 1)
  , visit_date DATE NOT NULL
  , people     INT  NOT NULL
  CONSTRAINT PK_dbo_Stadium_id PRIMARY KEY (id)
)

INSERT INTO dbo.Stadium (visit_date, people)
VALUES ('2017-01-01', 10)
     , ('2017-01-02', 109)
	 , ('2017-01-03', 150)
	 , ('2017-01-04', 99)
	 , ('2017-01-05', 145)
	 , ('2017-01-06', 1455)
	 , ('2017-01-07', 199)
	 , ('2017-01-09', 188)

SELECT * FROM dbo.Stadium

--1.
SELECT S1.id
     , S1.visit_date
	 , S1.people 'Grp1Cur', S2.people 'Grp1Prev1', S3.people 'Grp1Prev2'
	 , S1.people 'Grp2Cur', S4.people 'Grp2Nxt1', S5.people 'Grp2Nxt2'
	 , S1.people 'Grp3Cur', S2.people 'Grp3Prev1', S4.people 'Grp3Nxt1'
FROM dbo.Stadium S1
LEFT JOIN dbo.Stadium S2 ON S2.id = S1.id - 1
LEFT JOIN dbo.Stadium S3 ON S3.id = S1.id - 2
LEFT JOIN dbo.Stadium S4 ON S4.id = S1.id + 1
LEFT JOIN dbo.Stadium S5 ON S5.id = S1.id + 2
WHERE (S1.people >= 100 AND S2.people >= 100 AND S3.people >= 100) 
    OR (S1.people >= 100 AND S4.people >= 100 AND S5.people >= 100) 
	OR (S1.people >= 100 AND S2.people >= 100 AND S4.people >= 100)