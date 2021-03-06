
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- UPDATE

-- T-SQL supports a standard UPDATE statement you can use to update rows in a table.
-- T-SQL also supports nonstandard forms of the UPDATE statement with joins and with variables.
---Syntax - UPDATE
--          SET    : You specify the assignment of values to columns in a SET clause, separated by commas.
--			FROM   : 
--			WHERE  : To identify the subset of rows you need to update, you specify a predicate in a WHERE clause.
-- 
---------------------------------------------------------------------

USE TSQLV4
GO

DROP TABLE IF EXISTS dbo.Orders
DROP TABLE IF EXISTS dbo.OrderDetails

SELECT * 
INTO dbo.Orders
FROM Sales.Orders

SELECT * 
INTO dbo.OrderDetails
FROM Sales.OrderDetails

SELECT * FROM dbo.Orders
SELECT * FROM dbo.OrderDetails

--1
SELECT * 
FROM dbo.OrderDetails
WHERE productid = 51

UPDATE OD
SET discount = discount + 0.05
FROM dbo.OrderDetails OD
WHERE productid = 51

--2: All-at-once operation
UPDATE OD
SET productid = qty
  , qty       = productid
FROM dbo.OrderDetails OD
WHERE productid = 51