
/*---------------------------------------------------------------------
Exercise 182

Write a SQL query to find all duplicate emails in a table named Person.

+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
For example, your query should return the following for the above table:

+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Note: All emails are in lowercase.

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
VALUES ('a@b.com')
     , ('c@d.com')
	 , ('a@b.com')
     , ('c@d.com')

SELECT * FROM dbo.Person

--1.
;WITH CTEDupEmail As (
SELECT Id
     , Email
	 , ROW_NUMBER() OVER(PARTITION BY Email ORDER BY Email) 'EmailRowNum'
FROM dbo.Person
)
SELECT * 
FROM CTEDupEmail
WHERE EmailRowNum > 1


--2.
SELECT DISTINCT P1.Email 
FROM dbo.Person P1
INNER JOIN dbo.Person P2 ON P2.Id != P1.Id AND P2.Email = P1.Email