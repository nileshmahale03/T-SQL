
---------------------------------------------------------------------
-- Programmable objects

-- Temporary Tables

-- When you need to temporarily store data in tables, in certain cases you might prefer not to work with permanent tables.
-- Another case where people use temporary tables is when they don’t have permissions to create permanent tables in a user database.

-- T-SQL supports three kinds of temporary tables
-- 3. Table Variables

-- You declare table variables much like you declare other variables, by using the DECLARE statement.
-- Table Variables Tables are created in the tempdb database.
-- Table Variables Tables is visible to current batch only. Table variables are visible neither to inner batches in the call stack nor to subsequent batches in the session.
-- Table Variables are destroyed automatically by SQL Server when batch ends.
-- In terms of performance, usually it makes more sense to use table variables with small volumes of data (only a few rows) and to use local temporary tables otherwise.

-- Use Cases:
-- 1. 

---------------------------------------------------------------------

USE TSQLV4
GO

DECLARE @Emp TABLE (
	empid     INT
  , firstname VARCHAR(20)
  , lastname  VARCHAR(20)
)

INSERT INTO @Emp (empid, firstname, lastname)
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE firstname LIKE 'P%' 

SELECT * FROM @Emp
