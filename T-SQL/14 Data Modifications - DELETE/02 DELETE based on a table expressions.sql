
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- DELETE

-- T-SQL supports a nonstandard DELETE syntax based on joins.
-- This means you can delete rows from one table based on a filter against attributes in related rows from another table.
-- Start with the FROM clause with the joins, move on to the WHERE clause
-- and finally—instead of specifying a SELECT clause—specify a DELETE clause with the alias of the side of the join that is supposed to be the target for the deletion.

-- T-SQL supports using the TOP option directly in INSERT, UPDATE, DELETE, and MERGE statements.
-- When you use the TOP option with such statements, SQL Server stops processing the modification as soon as the specified number or percentage of rows is processed.
-- Unfortunately, unlike with the SELECT statement, you cannot specify an ORDER BY clause for the TOP filter in modification statements. 
-- Essentially, whichever rows SQL Server happens to access first will be modified
---------------------------------------------------------------------

USE TSQLV4
GO

DROP TABLE IF EXISTS dbo.Orders

SELECT * FROM dbo.Orders

SELECT *
INTO dbo.Orders
FROM Sales.Orders

SELECT * 
FROM dbo.Orders
WHERE orderdate > '2014-07-30'

--1
DELETE
FROM dbo.Orders
WHERE orderdate > '2014-07-30'

--2
;WITH DeleteCTE AS (
	SELECT * 
	FROM dbo.Orders
	WHERE orderdate > '2014-07-30'
)
DELETE
FROM DeleteCTE

--3
DELETE TOP(50)
FROM dbo.Orders

; WITH TopCTE AS (
	SELECT TOP(50) *
	FROM dbo.Orders
	ORDER BY orderid DESC
)
DELETE
FROM TopCTE