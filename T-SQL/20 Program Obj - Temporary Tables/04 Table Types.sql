
---------------------------------------------------------------------
-- Programmable objects

-- Temporary Tables

-- When you need to temporarily store data in tables, in certain cases you might prefer not to work with permanent tables.
-- Another case where people use temporary tables is when they don’t have permissions to create permanent tables in a user database.

-- T-SQL supports three kinds of temporary tables
-- 4. Table Types

-- You can use a table type to preserve a table definition as an object in the database

-- Use Cases:
-- 1. you can reuse it as the table definition of table variables 
-- 2. also as an input parameters of stored procedures and user-defined functions.
---------------------------------------------------------------------

USE TSQLV4
GO

DROP TYPE IF EXISTS dbo.Emp
CREATE TYPE dbo.Emp AS TABLE (
	empid      INT 
  , firstname  VARCHAR(20)
  , lastname   VARCHAR(20)
)
GO

DECLARE @Emp AS dbo.Emp

INSERT INTO @Emp (empid, firstname, lastname)
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE firstname LIKE 'P%' 

SELECT * FROM @Emp