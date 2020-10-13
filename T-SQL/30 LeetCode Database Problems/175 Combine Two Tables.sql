
/*---------------------------------------------------------------------
Exercise 175

Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| PersonId    | int     |
| FirstName   | varchar |
| LastName    | varchar |
+-------------+---------+
PersonId is the primary key column for this table.

Table: Address

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| AddressId   | int     |
| PersonId    | int     |
| City        | varchar |
| State       | varchar |
+-------------+---------+
AddressId is the primary key column for this table.
 
Write a SQL query for a report that provides the following information for each person in the Person table, regardless if there is an address for each of those people:

FirstName, LastName, City, State

*/---------------------------------------------------------------------
USE QuestionBank
Go

DROP TABLE IF EXISTS dbo.Person 
CREATE TABLE dbo.Person (
	PersonId  INT
  , FirstName VARCHAR(20)
  , LastName  VARCHAR(20)
  CONSTRAINT PK_Person_PersonId PRIMARY KEY (PersonId)
)

DROP TABLE IF EXISTS dbo.Address 
CREATE TABLE dbo.Address (
	AddressId INT
  , PersonId  INT
  , City      VARCHAR(20)
  , State     VARCHAR(20)
  CONSTRAINT PK_Address_AddressId PRIMARY KEY (AddressId)
)

INSERT INTO dbo.Person (PersonId, FirstName, LastName)
VALUES  (1, 'Nilesh', 'Mahale')
      , (2, 'Madhuri', 'Nirmale')
	  , (3, 'Jordan', 'Hoffman')

INSERT INTO dbo.Address (AddressId, PersonId, City, State)
VALUES  (1, 1, 'Buena Park', 'CA')
	  , (2, 3, 'Woodland Hills', 'CA')

SELECT * FROM dbo.Person

SELECT * FROM dbo.Address

--1. JOIN

SELECT P.FirstName, P.LastName
     , A.City, A.State
FROM dbo.Person P
LEFT JOIN dbo.Address A ON P.PersonId = A.PersonId 