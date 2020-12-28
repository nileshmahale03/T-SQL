
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

-- 2. Multi-statement Table-values Functions

-- NOT INLINE
-- Use in FROM 
-- SQL Server cannot access underlined objects
-- Not Similar to VIEW but has parameters so Paramaterized views
-- BEGIN END block
-- Returns Table Varibale
-- Not Better Performance / Good for procedural code, Top Down approach, While Loop, Variables
---------------------------------------------------------------------
USE TSQLV4
GO

SELECT * FROM Sales.Orders WHERE custid = 85
SELECT * FROM Sales.OrderDetails WHERE orderid = 10248
SELECT * FROM Production.Products WHERE productid = 11

SELECT DISTINCT P.productid, P.productname
FROM Sales.Orders O
JOIN Sales.OrderDetails OD ON OD.orderid = O.orderid
JOIN Production.Products P ON P.productid = OD.productid
WHERE O.custid = 85
GO

CREATE FUNCTION dbo.UDFM_GetProductName (@custid INT)
RETURNS @table TABLE (productid INT, productname VARCHAR(100))
AS
BEGIN

    INSERT INTO @table (productid, productname)
	SELECT DISTINCT P.productid, P.productname
	FROM Sales.Orders O
	JOIN Sales.OrderDetails OD ON OD.orderid = O.orderid
	JOIN Production.Products P ON P.productid = OD.productid
	WHERE O.custid = @custid

	RETURN
END


SET STATISTICS IO ON 
SELECT * FROM dbo.UDFI_GetProductName (85)
SET STATISTICS IO ON 
SELECT * FROM dbo.UDFM_GetProductName (85)


SET STATISTICS TIME ON 
SELECT * FROM dbo.UDFI_GetProductName (85)
SET STATISTICS TIME ON 
SELECT * FROM dbo.UDFM_GetProductName (85)

SET STATISTICS TIME ON 
SELECT custid, productid, productname
FROM Sales.Customers
CROSS APPLY dbo.UDFI_GetProductName (custid)
SET STATISTICS TIME ON 
SELECT custid, productid, productname
FROM Sales.Customers
CROSS APPLY dbo.UDFM_GetProductName (custid)