
---------------------------------------------------------------------
-- Table Expressions

-- A table expression is a named query expression that represents a valid relational table.
-- Types - 1.Derived Tables 2.CTEs 3.VIEWs 4.Inline TVFs
-- Table expressions are not physically materialized anywhere—they are virtual.
-- The benefits of using table expressions are typically related to logical aspects of your code and not to performance.
-- Table expressions also help you circumvent certain restrictions in the language

-- Rule 1: Order is not guaranteed
-- Rule 2: All columns must have names
-- Rule 3: All column names must be unique

-- Inline TVFs    : Definition are stored as permanent objects, reusable
--                : Reusable table expressions that support input parameters. 
--                : Paramaterized views
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Customers 

SELECT * FROM Sales.Orders


---------------------------------------------------------------------
-- Query: Get Customer Orders

---------------------------------------------------------------------
DROP FUNCTION IF EXISTS dbo.fnGetCustOrders
GO

CREATE FUNCTION dbo.fnGetCustOrders
(@custid INT)
RETURNS TABLE
AS

RETURN

SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE custid = @custid

GO

SELECT * 
FROM dbo.fnGetCustOrders(1)

---------------------------------------------------------------------
-- Query: As with tables, you can refer to an inline TVF as part of a join.

---------------------------------------------------------------------
SELECT * 
FROM dbo.fnGetCustOrders(1) CO
INNER JOIN Sales.OrderDetails OD ON OD.orderid = CO.orderid