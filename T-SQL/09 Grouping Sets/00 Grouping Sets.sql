
---------------------------------------------------------------------
-- GROUPING SETS

-- T-SQL supports standard features you can use to define multiple grouping sets in the same query.

-- Those are the 
-- 1. GROUPING SETS subclauses of the GROUP BY clause
-- 2. CUBE subclauses of the GROUP BY clause
-- 3. ROLLUP subclauses of the GROUP BY clause
-- 4. GROUPING function
-- 5. GROUPING_ID function

-- The main use cases are reporting and data analysis
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

SELECT NULL 'empid', NULL 'custid',  SUM(qty)
FROM dbo.Orders
UNION ALL
SELECT empid, NULL 'custid', SUM(qty)
FROM dbo.Orders
GROUP BY empid
UNION ALL
SELECT NULL 'empid', custid, SUM(qty)
FROM dbo.Orders
GROUP BY custid
UNION ALL
SELECT empid, custid, SUM(qty)
FROM dbo.Orders
GROUP BY empid, custid






