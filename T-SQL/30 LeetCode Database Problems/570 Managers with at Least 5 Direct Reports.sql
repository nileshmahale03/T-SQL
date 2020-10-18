
/*---------------------------------------------------------------------
Exercise 570

The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

+------+----------+-----------+----------+
|Id    |Name 	  |Department |ManagerId |
+------+----------+-----------+----------+
|101   |John 	  |A 	      |null      |
|102   |Dan 	  |A 	      |101       |
|103   |James 	  |A 	      |101       |
|104   |Amy 	  |A 	      |101       |
|105   |Anne 	  |A 	      |101       |
|106   |Ron 	  |B 	      |101       |
+------+----------+-----------+----------+

Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. For the above table, your SQL query should return:

+-------+
| Name  |
+-------+
| John  |
+-------+

*/---------------------------------------------------------------------
USE QuestionBank
Go

DROP TABLE IF EXISTS dbo.Employee 
GO

CREATE TABLE dbo.Employee (
	Id         INT         NOT NULL IDENTITY(101,1)
  , Name       VARCHAR(10) NOT NULL
  , Department VARCHAR(1)  NOT NULL
  , ManagerId  INT         NULL
  CONSTRAINT PK_dbo_Employee_Id PRIMARY KEY (Id)
)

INSERT INTO dbo.Employee (Name, Department, ManagerId)
VALUES ('John', 'A', NULL)
     , ('Dan', 'A', 101)
	 , ('James', 'A', 101)
	 , ('Amy', 'A', 101)
	 , ('Anne', 'A', 101)
	 , ('Ron', 'B', 101)

SELECT * FROM dbo.Employee

--1. JOIN

SELECT Mng.Name
FROM dbo.Employee Emp
INNER JOIN dbo.Employee Mng ON Emp.ManagerId = Mng.Id
GROUP BY Mng.Name
HAVING COUNT(Emp.Id) >= 5
