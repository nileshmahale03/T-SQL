
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- DELETE

-- T-SQL provides two statements for deleting rows from a table: DELETE and TRUNCATE
-- The DELETE statement is a standard statement used to delete data from a table based on an optional filter predicate.
-- Syntax - DELETE FROM (WHERE)
-- The DELETE statement tends to be expensive when you delete a large number of rows, mainly because it’s a fully logged operation.

-- Fully logged
-- The DELETE statement is processed as a transaction
---------------------------------------------------------------------

USE TSQLV4
GO

DROP TABLE IF EXISTS dbo.Orders

SELECT * FROM dbo.Orders

SELECT *
INTO dbo.Orders
FROM Sales.Orders

--1
DELETE O
FROM dbo.Orders O

--2
DELETE FROM dbo.Orders
WHERE orderdate > '2014-07-30'

--3
SET NOCOUNT ON
DELETE FROM dbo.Orders
WHERE orderdate > '2014-07-30'

