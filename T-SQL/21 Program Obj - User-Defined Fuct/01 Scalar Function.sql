
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


-- 1: Scalar

-- NOT INLINE
-- Use in SELECT
-- Needs BEGIN END block
-- Need RETURNS datatype and RETURN
-- Need to use schema name while using function
-- Is called Once-per row (not good for performance)

-- Use case- e.g. GetDecryptData function to get Decrypt account number
-- If possible try to convert Scalar function into inline TVFs
---------------------------------------------------------------------
USE TSQLV4
GO

SELECT * FROM Sales.Customers
GO

CREATE FUNCTION dbo.UDF_GetCustomerAddress (@custid INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @address VARCHAR(100)

	SELECT @address = address 
	FROM Sales.Customers
	WHERE custid = @custid

	RETURN @address
END

SET STATISTICS IO ON
SET STATISTICS TIME ON
SELECT custid, contactname
     , dbo.UDF_GetCustomerAddress(custid) 'address'
FROM Sales.Customers

SELECT dbo.UDF_GetCustomerAddress(3)