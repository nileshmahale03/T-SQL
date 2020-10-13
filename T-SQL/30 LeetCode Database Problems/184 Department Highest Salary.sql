
/*---------------------------------------------------------------------
Exercise 184

The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
Explanation:

Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.
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
VALUES ('Joe'  , 70000, 1)
     , ('Jim'  , 90000, 1)
	 , ('Henry', 80000, 2)
	 , ('Sam'  , 60000, 2)
	 , ('Max'  , 90000, 1)

INSERT INTO dbo.Department (Name)
VALUES ('IT')
     , ('Sales')

SELECT * FROM dbo.Employee
SELECT * FROM dbo.Department

--1. JOIN

SELECT D2.Name 'Department'
     , E.Name 'Employee'
	 , E.Salary 
FROM dbo.Employee E
INNER JOIN (
	SELECT DepartmentId
		 , MAX(Salary) 'HSalary'
	FROM dbo.Employee 
	GROUP BY DepartmentId
) D1 ON D1.DepartmentId = E.DepartmentId AND D1.HSalary = E.Salary
INNER JOIN dbo.Department D2 ON D2.Id = E.DepartmentId

--2. Correlated subquery

SELECT * 
FROM dbo.Employee E1
WHERE Salary IN (
	SELECT MAX(Salary)
	FROM dbo.Employee E2
	WHERE E2.DepartmentId = E1.DepartmentId
)

--3. EXISTS Predicate 

; WITH CTE AS(
SELECT DepartmentId
	, MAX(Salary) 'HSalary'
FROM dbo.Employee 
GROUP BY DepartmentId
) 

SELECT * 
FROM dbo.Employee E1
WHERE EXISTS (
	SELECT *
	FROM CTE C
	WHERE C.DepartmentId = E1.DepartmentId AND C.HSalary = E1.Salary
)
