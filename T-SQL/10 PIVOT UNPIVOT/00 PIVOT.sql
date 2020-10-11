
---------------------------------------------------------------------
-- PIVOT

-- Pivoting rotates data from a state of rows to columns

-- 1. grouped query
-- 2. PIVOT operator

-- As a table operator, PIVOT operates in the context of the FROM clause like any other table operator (for example, JOIN)
-- Pivoting data involves rotating data from a state of rows to a state of columns, possibly aggregating values along the way.
-- The pivoting of data is handled by the presentation layer for purposes such as reporting

-- Pivoting involves grouping, spreading, and aggregating

-- As a best practice with the PIVOT operator, you should always work with a table expression and not query the underlying table directly.
---------------------------------------------------------------------

USE TSQLV4
GO

DROP TABLE IF EXISTS dbo.Orders;

CREATE TABLE dbo.Orders
(
	orderid   INT        NOT NULL,
	orderdate DATE       NOT NULL,
	empid     INT        NOT NULL,
	custid    VARCHAR(5) NOT NULL,
	qty       INT        NOT NULL,
	CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);

INSERT INTO dbo.Orders(orderid, orderdate, empid, custid, qty)
VALUES
(30001, '20140802', 3, 'A', 10),
(10001, '20141224', 2, 'A', 12),
(10005, '20141224', 1, 'B', 20),
(40001, '20150109', 2, 'A', 40),
(10006, '20150118', 1, 'C', 14),
(20001, '20150212', 2, 'B', 12),
(40005, '20160212', 3, 'A', 10),
(20002, '20160216', 1, 'C', 20),
(30003, '20160418', 2, 'B', 15),
(30004, '20140418', 3, 'C', 22),
(30007, '20160907', 3, 'D', 30);

SELECT * FROM dbo.Orders;

---------------------------------------------------------------------
-- Pivoting with a grouped query

-- grouping    : GROUP BY empid
-- spreading   : SELECT with CASE expression
-- aggregating : SUM or MAX, MIN, COUNT
---------------------------------------------------------------------

SELECT empid
     , SUM(CASE WHEN custid = 'A' THEN qty END) 'A'
	 , SUM(CASE WHEN custid = 'B' THEN qty END) 'B'
	 , SUM(CASE WHEN custid = 'C' THEN qty END) 'C'
	 , SUM(CASE WHEN custid = 'D' THEN qty END) 'D'
FROM dbo.Orders
GROUP BY empid

---------------------------------------------------------------------
-- Pivoting with the PIVOT operator
/*
SELECT ...
FROM <input_table>
PIVOT(<agg_function>(<aggregation_element>)
FOR <spreading_element> IN (<list_of_target_columns>)) AS <result_table_alias>
WHERE ...;
*/
---------------------------------------------------------------------

SELECT empid, A, B, C, D
FROM dbo.Orders                   --everything else is GROUP BY
PIVOT (SUM(qty)
FOR custid IN (A, B, C, D))  P

SELECT empid, A, B, C, D
FROM (SELECT empid, custid, qty   --empid is GROUP BY
      FROM dbo.Orders) D
PIVOT (SUM(qty)
FOR custid IN (A, B, C, D)) P

SELECT custid, [1], [2], [3]
FROM (SELECT empid, custid, qty   
      FROM dbo.Orders) D
PIVOT (SUM(qty)
FOR empid IN ([1], [2], [3])) P     --delimit them—hence, the use of square brackets.