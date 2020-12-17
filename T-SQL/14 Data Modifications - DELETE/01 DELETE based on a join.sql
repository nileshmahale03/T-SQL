
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- DELETE

-- T-SQL supports a nonstandard DELETE syntax based on joins.
-- This means you can delete rows from one table based on a filter against attributes in related rows from another table.
-- Start with the FROM clause with the joins, move on to the WHERE clause
-- and finally—instead of specifying a SELECT clause—specify a DELETE clause with the alias of the side of the join that is supposed to be the target for the deletion.
-- 
---------------------------------------------------------------------

USE TSQLV4
GO

DROP TABLE IF EXISTS dbo.Orders
DROP TABLE IF EXISTS dbo.Customers

SELECT * FROM dbo.Orders
SELECT * FROM dbo.Customers

SELECT *
INTO dbo.Customers
FROM Sales.Customers

SELECT *
INTO dbo.Orders
FROM Sales.Orders


--1
SELECT * FROM dbo.Orders
SELECT * FROM dbo.Customers

SELECT * 
FROM dbo.Orders O
JOIN dbo.Customers C ON C.custid = O.custid
WHERE C.country = 'USA'

DELETE O
FROM dbo.Orders O
JOIN dbo.Customers C ON C.custid = O.custid
WHERE C.country = 'USA'

--2
SELECT * FROM dbo.Orders
SELECT * FROM dbo.Customers

SELECT * 
FROM dbo.Orders O
WHERE EXISTS (
	SELECT *
	FROM dbo.Customers C
	WHERE C.custid = O.custid AND C.country = 'USA'
)

DELETE O
FROM dbo.Orders O
WHERE EXISTS (
	SELECT *
	FROM dbo.Customers C
	WHERE C.custid = O.custid AND C.country = 'USA'
)