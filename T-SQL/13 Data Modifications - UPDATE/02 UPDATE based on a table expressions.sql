
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

-- T-SQL doesn’t limit the actions against table expressions to SELECT only; it also allows other DML statements (INSERT, UPDATE, DELETE, and MERGE) against those.
-- One use case for modifying data through table expressions is for better debugging and troubleshooting capabilities.

-- However, in some cases using a table expression is the only option. e.g. ROW_NUMBER() is not allowed in UPDATE statement
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

-- One use case for modifying data through table expressions is for better debugging and troubleshooting capabilities.
;WITH UpdateCTE AS (
	SELECT OD.*
	FROM dbo.OrderDetails OD
	JOIN dbo.Orders O ON O.orderid = OD.orderid
	WHERE O.custid = 1
)
UPDATE UpdateCTE
SET discount = discount + 0.05

-- However, in some cases using a table expression is the only option.
-- e.g. ROW_NUMBER() is not allowed in UPDATE statement

DROP TABLE IF EXISTS dbo.T1

CREATE TABLE dbo.T1 (
	col1 INT NULL
  , col2 INT NULL
)

INSERT INTO dbo.T1 (col1, col2)
OUTPUT inserted.col1
     , inserted.col2
VALUES (10, NULL)
     , (30, NULL)
	 , (20, NULL)

SELECT * FROM dbo.T1

SELECT col1
     , col2
	 , ROW_NUMBER() OVER(ORDER BY col1) 'rowNum'
FROM dbo.T1

UPDATE T1
SET col2    = ROW_NUMBER() OVER(ORDER BY col1)
FROM dbo.T1

--Windowed functions can only appear in the SELECT or ORDER BY clauses.

;WITH UpdateCTE AS (
SELECT col1
     , col2
	 , ROW_NUMBER() OVER(ORDER BY col1) 'rowNum'
FROM dbo.T1
)

UPDATE UpdateCTE
SET col2 = rowNum