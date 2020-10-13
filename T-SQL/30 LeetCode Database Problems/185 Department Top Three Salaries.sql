
/*---------------------------------------------------------------------
Exercise 185

The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
Explanation:

In IT department, Max earns the highest salary, both Randy and Joe earn the second highest salary, and Will earns the third highest salary. There are only two employees in the Sales department, Henry earns the highest salary while Sam earns the second highest salary.
*/---------------------------------------------------------------------
USE QuestionBank
Go

DROP TABLE IF EXISTS dbo.Employee 
GO
DROP TABLE IF EXISTS dbo.Department
GO

CREATE TABLE dbo.Employee (
	Id            INT          NOT NULL IDENTITY(1,1)
  , Name          VARCHAR(10)  NOT NULL
  , Salary        INT          NOT NULL
  , DepartmentId  INT          NOT NULL
  CONSTRAINT PK_dbo_Employee_Id PRIMARY KEY (Id)
)

CREATE TABLE dbo.Department (
	Id            INT          NOT NULL IDENTITY(1,1)
  , Name          VARCHAR(10)  NOT NULL
  CONSTRAINT PK_dbo_Department_Id PRIMARY KEY (Id)
)

INSERT INTO dbo.Employee (Name, Salary, DepartmentId)
VALUES ('Joe'  , 85000, 1)
     , ('Henry', 80000, 1)
	 , ('Sam'  , 60000, 2)
	 , ('Max'  , 90000, 2)
	 , ('Janet', 69000, 1)
	 , ('Randy', 85000, 1)
	 , ('Will' , 70000, 1)

INSERT INTO dbo.Department (Name)
VALUES ('IT')
     , ('Sales')

SELECT * FROM dbo.Employee
SELECT * FROM dbo.Department

--1. 

; WITH CTE AS (
SELECT DISTINCT DepartmentId
     , Salary
     , DENSE_RANK() OVER(PARTITION BY DepartmentId ORDER BY Salary DESC) 'TopSalary'
FROM dbo.Employee
), CTE2 AS(
SELECT * 
FROM CTE
WHERE TopSalary < 4
)

SELECT * 
FROM dbo.Employee E
JOIN CTE2 C ON C.DepartmentId = E.DepartmentId AND C.Salary = E.Salary
