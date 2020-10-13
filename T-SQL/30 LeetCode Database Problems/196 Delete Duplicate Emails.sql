
/*---------------------------------------------------------------------
Exercise 196

Write a SQL query to delete all duplicate email entries in a table named Person, keeping only unique emails based on its smallest Id.

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.
For example, after running your query, the above Person table should have the following rows:

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Note:

Your output is the whole Person table after executing your sql. Use delete statement.
*/---------------------------------------------------------------------
USE QuestionBank
Go

DROP TABLE IF EXISTS dbo.Person
GO

CREATE TABLE dbo.Person (
	Id    INT         NOT NULL IDENTITY(1,1)
  , Email VARCHAR(20) NOT NULL
  CONSTRAINT PK_dbo_Person_Id PRIMARY KEY (Id)
)

INSERT INTO dbo.Person (Email)
VALUES ('john@example.com ')
     , ('bob@example.com')
	 , ('john@example.com')

SELECT * FROM dbo.Person

--1. 

;WITH CTEDupEmail AS (
SELECT Id
     , Email
	 , ROW_NUMBER() OVER(PARTITION BY Email ORDER BY Id ASC) 'EmailRowNum'
FROM dbo.Person
)
DELETE
FROM CTEDupEmail
WHERE EmailRowNum != 1

SELECT * FROM dbo.Person