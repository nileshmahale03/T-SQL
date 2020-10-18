
/*---------------------------------------------------------------------
Exercise 181

The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
Given the Employee table, write a SQL query that finds out employees who earn more than their managers. For the above table, Joe is the only employee who earns more than his manager.

+----------+
| Employee |
+----------+
| Joe      |
+----------+

*/---------------------------------------------------------------------
USE QuestionBank
Go

DROP TABLE IF EXISTS dbo.Employee 

CREATE TABLE dbo.Employee (
	Id        INT         NOT NULL IDENTITY(1,1)
  , Name      VARCHAR(10) NOT NULL
  , Salary    INT         NOT NULL
  , ManagerId INT         NULL
  CONSTRAINT PK_dbo_Employee_Id PRIMARY KEY (Id)
)

SELECT * FROM dbo.Employee

INSERT INTO dbo.Employee (Name, Salary, ManagerId)
VALUES ('Joe', 70000, 3)
     , ('Henry', 80000, 4)
	 , ('Sam', 60000, NULL)
	 , ('Max', 90000, NULL)

--1

SELECT * FROM dbo.Employee