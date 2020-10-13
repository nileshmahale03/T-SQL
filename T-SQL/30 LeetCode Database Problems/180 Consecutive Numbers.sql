
/*---------------------------------------------------------------------
Exercise 180

Write a SQL query to find all numbers that appear at least three times consecutively.

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+

*/---------------------------------------------------------------------
USE QuestionBank
Go

DROP TABLE IF EXISTS dbo.Logs

CREATE TABLE dbo.Logs (
  Id  INT NOT NULL IDENTITY(1, 1)
, Num INT NOT NULL
)

INSERT INTO dbo.Logs (Num)
VALUES (1)
     , (1)
     , (1)
	 , (1)
     , (2)
     , (1)
     , (2)
     , (2)
     , (2)

SELECT * FROM dbo.Logs

--1. JOIN

SELECT T1.Id
     , T1.Num, t2.Num, T3.Num
FROM dbo.Logs T1
LEFT JOIN dbo.Logs T2 ON T2.Id = t1.Id - 1
LEFT JOIN dbo.Logs T3 ON T3.Id = t1.Id - 2

SELECT DISTINCT T1.Num 'ConsecutiveNums'
FROM dbo.Logs T1
LEFT JOIN dbo.Logs T2 ON T2.Id = t1.Id - 1
LEFT JOIN dbo.Logs T3 ON T3.Id = t1.Id - 2
WHERE T1.Num = t2.Num AND T1.Num = T3.Num


--2. Window Function

; WITH CTE AS(
SELECT Id 
     , Num 'Cur'
	 , LAG(Num, 1) OVER(ORDER BY Id) 'Prev1'
	 , LAG(Num, 2) OVER(ORDER BY Id) 'Prev2'
FROM dbo.Logs
)

SELECT DISTINCT Cur
FROM CTE
WHERE Cur = Prev1 and Cur = Prev2 

DROP TABLE IF EXISTS dbo.Logs