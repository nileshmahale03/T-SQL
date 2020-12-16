
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- INSERT

-- 2. INSERT INTO SELECT

-- In T-SQL, specifying the INTO clause is optional. 
-- INSERT SELECT statement inserts a set of rows returned by a SELECT query into a target table.
-- The INSERT SELECT statement is performed as a transaction, so if any row fails to enter the target table, none of the rows enters the table.
-- 
---------------------------------------------------------------------
USE TSQLV4
GO

SELECT * FROM dbo.Orders

SELECT orderid, orderdate, empid, custid 
FROM Sales.Orders
WHERE shipcountry = 'UK'

INSERT INTO dbo.Orders (orderid, orderdate, empid, custid)
SELECT orderid, orderdate, empid, custid 
FROM Sales.Orders
WHERE shipcountry = 'UK'

-- In T-SQL, specifying the INTO clause is optional. 

INSERT dbo.Orders (orderid, orderdate, empid, custid)
SELECT orderid, orderdate, empid, custid 
FROM Sales.Orders
WHERE shipcountry = 'UK'