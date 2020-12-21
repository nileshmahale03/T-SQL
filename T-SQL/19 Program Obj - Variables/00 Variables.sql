
---------------------------------------------------------------------
-- Programmable objects

-- Variables

-- You use variables to temporarily store data values for later use in the same batch in which they were declared.
-- Declare one or more variables     - DECLARE
-- Assign values to single variable   - SET
-- NULL, which is the default for variables that were not initialized.

-- Assign values to multiple variable - Multiple SET statement or Single SELECT statement
-- The assignment SELECT has predictable behavior when exactly one row qualifies.
-- The assignment SELECT has UNPREDICTABLE behavior when more than one row qualifies.

---------------------------------------------------------------------

USE TSQLV4
GO

--1
DECLARE @i INT 
SET @i = 10

SELECT @i

--2 : Alternatively, you can declare and initialize a variable in the same statement
DECLARE @j INT = 20

SELECT @j

--3: When you assign a value to a scalar variable, the value must be the result of a scalar expression. The expression can be a scalar subquery.

DECLARE @firstName VARCHAR(20)

SET @firstName = (SELECT firstname
				  FROM HR.Employees
				  WHERE empid = 9)

SELECT @firstName
GO

--4: The SET statement can operate on only one variable at a time

DECLARE @firstName VARCHAR(20)
      , @lastName VARCHAR(20)

SET @firstName = (SELECT firstname
				  FROM HR.Employees
				  WHERE empid = 9)

SET @lastName = (SELECT lastname
				  FROM HR.Employees
				  WHERE empid = 9)

SELECT @firstName, @lastName
GO

--5. Single SELECT statement

DECLARE @firstName VARCHAR(20)
      , @lastName VARCHAR(20)

SELECT @firstName = firstname
     , @lastName = lastname
FROM HR.Employees
WHERE empid = 6

SELECT @firstName, @lastName
GO

--6
DECLARE @firstName VARCHAR(20)
      , @lastName VARCHAR(20)

SET @firstName = (SELECT firstname
				  FROM HR.Employees
				  WHERE empid IN (6, 9))  --Subquery returned more than 1 value. 

SET @lastName = (SELECT lastname
				  FROM HR.Employees
				  WHERE empid IN (6, 9))  --Subquery returned more than 1 value. 

SELECT @firstName, @lastName
GO

DECLARE @firstName VARCHAR(20)
      , @lastName VARCHAR(20)

SELECT @firstName = firstname
     , @lastName = lastname
FROM HR.Employees
WHERE empid IN (6, 9)

SELECT @firstName, @lastName
GO