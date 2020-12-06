
/*---------------------------------------------------------------------
Exercise 619

Table my_numbers contains many numbers in column num including duplicated ones.
Can you write a SQL query to find the biggest number, which only appears once.

+---+
|num|
+---+
| 8 |
| 8 |
| 3 |
| 3 |
| 1 |
| 4 |
| 5 |
| 6 | 
For the sample data above, your query should return the following result:
+---+
|num|
+---+
| 6 |
Note:
If there is no such number, just output null.

*/---------------------------------------------------------------------
USE QuestionBank
GO

DROP TABLE IF EXISTS dbo.my_numbers
GO

CREATE TABLE dbo.my_numbers (
	num INT NOT NULL
)

INSERT INTO dbo.my_numbers (num)
VALUES (8)
     , (8)
	 , (3)
	 , (3)
	 --, (1)
	 --, (4)
	 --, (5)
	 --, (6)

SELECT * FROM dbo.my_numbers

--1.

SELECT (
	SELECT TOP 1 num
		 --, COUNT(*) 'Freq'
	FROM dbo.my_numbers
	GROUP BY num
	HAVING COUNT(*) = 1
	ORDER BY num DESC 
) 'num'