
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- INSERT

-- 4. SELECT INTO

-- The SELECT INTO statement is a nonstandard T-SQL statement that creates a target table and populates it with the result set of a query.
-- The target table’s structure and data are based on the source table.
-- In terms of syntax, simply add INTO <target_table_name> right before the FROM clause of the SELECT query you want to use to produce the result set.
-- You cannot use this statement to insert data into an existing table.
-- If you need to use a SELECT INTO statement with set operations, you specify the INTO clause right in front of the FROM clause of the first query.

---------------------------------------------------------------------
USE TSQLV4
GO

SELECT * FROM dbo.Orders

SELECT orderid, orderdate, empid, custid 
FROM Sales.Orders

SELECT orderid, orderdate, empid, custid 
INTO dbo.Orders
FROM Sales.Orders


SELECT orderid, orderdate, empid, custid 
FROM Sales.Orders
WHERE 1 = 2

SELECT orderid, orderdate, empid, custid 
INTO dbo.Orders
FROM Sales.Orders
WHERE 1 = 2