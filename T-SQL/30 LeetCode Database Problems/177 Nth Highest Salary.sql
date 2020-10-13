
/*---------------------------------------------------------------------
Exercise 177

Write a SQL query to get the nth highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+

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


