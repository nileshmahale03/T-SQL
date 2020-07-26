
-- CREATE TABLE

USE TSQLV4
GO

DROP SCHEMA IF EXISTS Test
GO

--'CREATE SCHEMA' must be the first statement in a query batch.
CREATE SCHEMA Test
GO
--'CREATE SCHEMA' must be the only statement in a query batch.

DROP TABLE IF EXISTS Test.Employees
CREATE TABLE Test.Employees
(
	EmpID      INT          NOT NULL
  , FirstName  VARCHAR(20)  NOT NULL
  ,	LastName   VARCHAR(20)  NOT NULL
  ,	BirthDate  DATE         NOT NULL
  ,	HireDate   DATE         NOT NULL
  ,	Phone      VARCHAR(10)  NULL
)

SELECT * FROM Test.Employees

INSERT INTO Test.Employees (EmpID, FirstName, LastName, BirthDate, HireDate, Phone)
VALUES (1, 'Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,(1, 'Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)

--Problem statament: Multiple employees with EmpID = 1
------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Test.Employees
CREATE TABLE Test.Employees
(
	EmpID      INT          NOT NULL IDENTITY(1,1)
  , FirstName  VARCHAR(20)  NOT NULL
  ,	LastName   VARCHAR(20)  NOT NULL
  ,	BirthDate  DATE         NOT NULL
  ,	HireDate   DATE         NOT NULL
  ,	Phone      VARCHAR(10)  NULL
)

SELECT * FROM Test.Employees

--Cannot insert explicit value for identity column in table 'Employees' when IDENTITY_INSERT is set to OFF.
INSERT INTO Test.Employees (EmpID, FirstName, LastName, BirthDate, HireDate, Phone)
VALUES (1, 'Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,(1, 'Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)

--1. Remove EmpID column from INSERT statement
INSERT INTO Test.Employees (FirstName, LastName, BirthDate, HireDate, Phone)
VALUES ('Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,('Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)

--2. SET IDENTITY_INSERT ON
SET IDENTITY_INSERT Test.Employees ON
INSERT INTO Test.Employees (EmpID, FirstName, LastName, BirthDate, HireDate, Phone)
VALUES (1, 'Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,(1, 'Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)
SET IDENTITY_INSERT Test.Employees OFF

--Problem statament: Multiple employees with EmpID = 1
------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Test.Employees
CREATE TABLE Test.Employees
(
	EmpID      INT          NOT NULL IDENTITY(1,1) PRIMARY KEY
  , FirstName  VARCHAR(20)  NOT NULL
  ,	LastName   VARCHAR(20)  NOT NULL
  ,	BirthDate  DATE         NOT NULL
  ,	HireDate   DATE         NOT NULL
  ,	Phone      VARCHAR(10)  NULL
)

SELECT * FROM Test.Employees

--Cannot insert explicit value for identity column in table 'Employees' when IDENTITY_INSERT is set to OFF.
INSERT INTO Test.Employees (EmpID, FirstName, LastName, BirthDate, HireDate, Phone)
VALUES (1, 'Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,(1, 'Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)

--1. Remove EmpID column from INSERT statement
INSERT INTO Test.Employees (FirstName, LastName, BirthDate, HireDate, Phone)
VALUES ('Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,('Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)

--2. SET IDENTITY_INSERT ON
--Violation of PRIMARY KEY constraint 'PK__Employee__AF2DBA79B09C19F9'. Cannot insert duplicate key in object 'Test.Employees'. 
--The duplicate key value is (1).
SET IDENTITY_INSERT Test.Employees ON
INSERT INTO Test.Employees (EmpID, FirstName, LastName, BirthDate, HireDate, Phone)
VALUES (1, 'Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,(1, 'Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)
SET IDENTITY_INSERT Test.Employees OFF

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Test.Employees
CREATE TABLE Test.Employees
(
	EmpID      INT          NOT NULL IDENTITY(1,1) 
  , FirstName  VARCHAR(20)  NOT NULL
  ,	LastName   VARCHAR(20)  NOT NULL
  ,	BirthDate  DATE         NOT NULL
  ,	HireDate   DATE         NOT NULL
  ,	Phone      VARCHAR(10)  NULL
  CONSTRAINT PK_TestEmployees PRIMARY KEY(EmpID)
)

SELECT * FROM Test.Employees

INSERT INTO Test.Employees (FirstName, LastName, BirthDate, HireDate, Phone)
VALUES ('Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,('Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)
	  ,('Rakesh', 'Mahale', '1984-04-17', getdate(), NULL)
	  ,('Sonal', 'Chaudhari', '1989-04-23', getdate(), NULL)


--Note: EmpID Column is PrimaryKey so you can not have 2 or multiple rows with same EmpID
--    : EmpID Column is Identity Column so if you don't provide a value for it, it will automatically increase 
------------------------------------------------------------------------------------------------------------------------------------------
