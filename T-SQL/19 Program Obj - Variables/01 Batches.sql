
---------------------------------------------------------------------
-- Programmable objects

-- Batches

-- A batch is one or more T-SQL statements sent by a client application to SQL Server for execution as a single unit.
-- The batch undergoes parsing (syntax checking), resolution/binding (checking the existence of referenced objects and columns, permissions checking), and optimization as a unit.
-- 
-- 1. A batch as a unit of parsing
-- 2. A variable is local to the batch in which it’s defined. If you refer to a variable that was defined in another batch, you’ll get an error saying that the variable was not defined.
-- 3. Statements that cannot be combined in the same batch
/*		 		 1. CREATE FUNCTION
		 2. CREATE PROCEDURE
		 3. CREATE SCHEMA
		 4. CREATE TRIGGER
		 5. CREATE VIEW
		 6. CREATE DEFAULT
		 7. CREATE RULE
*/
-- 4. One best practice you can follow to avoid such problems is to separate data-definition language (DDL) and Data-Manipulation Language (DML) statements into different batches,
-- 5. Go n option : This command supports an argument indicating how many times you want to execute the batch.
---------------------------------------------------------------------

-- 1. A batch as a unit of parsing
SELECT 'First batch'
USE TSQLV4
GO

SELECT 'Second batch'
SELECT custid FROM Sales.Customers
SELECT orderid FRO Sales.Orders
GO

SELECT 'Third batch'
SELECT empid FROM HR.Employees

-- 2. A variable is local to the batch in which it’s defined. 
DECLARE @i INT 
SET @i = 10 

SELECT @i
GO

SELECT @i --Must declare the scalar variable "@i"

--3. Statements that cannot be combined in the same batch
DROP TABLE IF EXISTS dbo.MyTable 
CREATE TABLE dbo.MyTable (
	col1 INT
)

DROP VIEW IF EXISTS dbo.MyView
GO
CREATE VIEW dbo.MyView  --'CREATE VIEW' must be the first statement in a query batch.
AS

SELECT *
FROM Sales.Orders
GO

--4. Separate data-definition language (DDL) and Data-Manipulation Language (DML) statements into different batches
--DML: SELECT, INSERT, UPDATE, DELETE, TRUNCATE, MERGE 
--DDL: CREATE, ALTER, DROP

DROP TABLE IF EXISTS dbo.MyTable
CREATE TABLE dbo.MyTable (
	col1 INT 
)

ALTER TABLE dbo.MyTable
ADD col2 INT

GO

SELECT col1, col2 FROM dbo.MyTable

--5. Go n option
SELECT 123
GO 7