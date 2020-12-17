
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- UPDATE

-- T-SQL supports a standard UPDATE statement you can use to update rows in a table.
-- T-SQL also supports nonstandard forms of the UPDATE statement with joins and with variables.
--	     Purpose 1: Filtering
--               2: Assignment 
---Syntax - UPDATE
--          SET    : You specify the assignment of values to columns in a SET clause, separated by commas.
--			FROM   : 
--			WHERE  : To identify the subset of rows you need to update, you specify a predicate in a WHERE clause.
-- Start with the FROM clause with the joins, move on to the WHERE clause
-- and finally—instead of specifying a SELECT clause—specify a UPDATE SET clause with the alias of the side of the join that is supposed to be the target for the updation.
---------------------------------------------------------------------

USE TSQLV4
GO

--1: Using JOIN for filtering purpose
SELECT *
FROM dbo.OrderDetails OD
JOIN dbo.Orders O ON O.orderid = OD.orderid
WHERE O.custid = 1

UPDATE OD
SET discount = discount + 0.05
FROM dbo.OrderDetails OD
JOIN dbo.Orders O ON O.orderid = OD.orderid
WHERE O.custid = 1


--2: Using JOIN for assignment purpose
SELECT *
FROM dbo.OrderDetails OD
JOIN dbo.Orders O ON O.orderid = OD.orderid
WHERE O.custid = 1

UPDATE OD
SET unitprice = O.freight
FROM dbo.OrderDetails OD
JOIN dbo.Orders O ON O.orderid = OD.orderid
WHERE O.custid = 1