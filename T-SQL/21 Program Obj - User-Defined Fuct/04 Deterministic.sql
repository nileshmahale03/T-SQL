
---------------------------------------------------------------------
-- User-Defined Functions

-- Types: 
-- 1: Scalar
-- 2: Table  -- 1. Inline Table-valued Functions
--           -- 2. Multi-statement Table-values Functions

-- Can be used in Queries/Constraints/Computed Columns
-- Cannot be used in Dynamic SQL 

-- Can create/access Table Variables
-- Cannot create/access Temp Tables

-- Types: 
-- 1: Determinstic      : Every time you call the function, output is same e.g. CONCAT
-- 2: Non-Deterministic : Returns different results every time e.g. GETDATE()
--                      : Ran only 1 per statement

-- 1: Determinstic
---------------------------------------------------------------------
USE TSQLV4
GO

SELECT firstname
     , lastname
	 , CONCAT(firstname, ' ', lastname) 'fullname'
FROM HR.Employees

