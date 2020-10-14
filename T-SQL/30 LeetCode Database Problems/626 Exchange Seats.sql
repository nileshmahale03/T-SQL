
/*---------------------------------------------------------------------
Exercise 626

Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.

The column id is continuous increment.
 
Mary wants to change seats for the adjacent students.
 
Can you write a SQL query to output the result for Mary?
 
+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Abbot   |
|    2    | Doris   |
|    3    | Emerson |
|    4    | Green   |
|    5    | Jeames  |
+---------+---------+
For the sample input, the output is:
 
+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Doris   |
|    2    | Abbot   |
|    3    | Green   |
|    4    | Emerson |
|    5    | Jeames  |
+---------+---------+
Note:
If the number of students is odd, there is no need to change the last one's seat.

*/---------------------------------------------------------------------
USE QuestionBank
GO

DROP TABLE IF EXISTS dbo.seat
GO

CREATE TABLE dbo.seat (
	id      INT         NOT NULL IDENTITY(1, 1)
  , student VARCHAR(10) NOT NULL
  CONSTRAINT PK_dbo_seat_id PRIMARY KEY (id)
)

INSERT INTO dbo.seat (student)
VALUES ('Abbot')
     , ('Doris')
	 , ('Emerson')
	 , ('Green')
	 , ('Jeames')

SELECT * FROM dbo.seat

--1.
;WITH CTEReShuffling AS (
SELECT id
     , student
	 , LEAD(student) OVER(ORDER BY id) 'NxtStudent'
	 , LAG(Student) OVER(ORDER BY id) 'PrevStudent'
FROM dbo.seat
)

SELECT id
     , CASE WHEN id % 2 = 0 THEN PrevStudent 
	        WHEN id % 2 = 1 AND id != (SELECT MAX(id) FROM dbo.seat) THEN NxtStudent
			WHEN id % 2 = 1 AND id = (SELECT MAX(id) FROM dbo.seat) THEN student END 'student'
FROM CTEReShuffling

