
/*---------------------------------------------------------------------
Exercise 176

Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

*/---------------------------------------------------------------------
USE QuestionBank
Go

DROP TABLE IF EXISTS dbo.Employee
CREATE TABLE dbo.Employee (
	Id     INT 
  , Salary INT
)

--Test Case 1
INSERT INTO dbo.Employee (Id, Salary)
VALUES (1, 100)
     , (2, 200)
     , (3, 300)

--Test Case 2
INSERT INTO dbo.Employee (Id, Salary)
VALUES (1, 100)
     , (2, 200)
     , (3, 300)
     , (4, 300)

--Test Case 3
INSERT INTO dbo.Employee (Id, Salary)
VALUES (1, 100)
     , (2, 100)

--Test Case 4
INSERT INTO dbo.Employee (Id, Salary)
VALUES (1, 200)
     , (2, 200)
     , (3, 300)
     , (4, 300)

SELECT * FROM dbo.Employee

SELECT Salary FROM dbo.Employee WHERE Id = 3

select (SELECT Salary FROM dbo.Employee WHERE Id = 3)

--1. Window Function
--Note: we cannot use RowNum as RowNum will always assign a unique row to each salary and what if we have 2 employees with same salary
--Note: we cannot use RANK as RANK will 

;WITH CTESalary AS(
SELECT Id
     , Salary
	 , ROW_NUMBER() OVER(ORDER BY Salary DESC) 'RowNum'
	 , RANK() OVER(ORDER BY Salary DESC) 'Rank'
	 , DENSE_RANK() OVER(ORDER BY Salary DESC) 'DenseRank'
FROM dbo.Employee
)

SELECT (
	SELECT Salary 
	FROM CTESalary 
	WHERE DenseRank = 2 
) 'SecondHighestSalary'

--2. Second highest salary will be the max salary less than the highest salary

SELECT MAX(Salary) 'SecondHighestSalary'
FROM dbo.Employee
WHERE Salary < (
	SELECT MAX(Salary) 
	FROM dbo.Employee
)

--3. Sort the DISTINCT salary in the DESC order and then use OFFSET FETCH to get the 2nd highest salary

SELECT DISTINCT Salary 'SecondHighestSalary'
FROM dbo.Employee
ORDER BY Salary DESC
OFFSET 1 ROW FETCH NEXT 1 ROW ONLY

SELECT (
	SELECT DISTINCT Salary
	FROM dbo.Employee
	ORDER BY Salary DESC
	OFFSET 1 ROW FETCH NEXT 1 ROW ONLY
) 'SecondHighestSalary'

