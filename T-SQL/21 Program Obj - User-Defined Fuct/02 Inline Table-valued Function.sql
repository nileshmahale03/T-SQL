
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

-- 1. Inline Table-valued Functions

-- IS INLINE
-- Use in FROM 
-- SQL Server can access underlined objects
-- Similar to VIEW but has parameters so Paramaterized views
-- NO BEGIN END block
-- Returns TABLE
-- Better Performance
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

CREATE FUNCTION dbo.UDFI_GetProductName (@custid INT)
RETURNS TABLE
AS
RETURN
(
	SELECT DISTINCT P.productid, P.productname
	FROM Sales.Orders O
	JOIN Sales.OrderDetails OD ON OD.orderid = O.orderid
	JOIN Production.Products P ON P.productid = OD.productid
	WHERE O.custid = @custid
)

SELECT * 
FROM dbo.UDFI_GetProductName (85)