
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- INSERT

-- 1. INSERT INTO VALUES

-- In T-SQL, specifying the INTO clause is optional. 
-- a. Standard : INSERT VALUES statement to insert a single row into the table
-- b. Enhanced : T-SQL supports an enhanced standard VALUES clause you can use to specify multiple rows separated by commas
-- The INSERT VALUES statement is processed as a transaction, meaning that if any row fails to enter the table, none of the rows in the statement enters the table.

---------------------------------------------------------------------
USE TSQLV4
GO

DROP TABLE IF EXISTS dbo.Orders

CREATE TABLE dbo.Orders (
	orderid   INT         NOT NULL
  , orderdate DATE        NOT NULL
  , empid     INT         NOT NULL
  , custid    VARCHAR(10) NOT NULL
)

SELECT * FROM dbo.Orders

INSERT dbo.Orders (orderid, orderdate, empid, custid)
VALUES(10001, '20160212', 3, 'A')


INSERT INTO dbo.Orders (orderid, orderdate, empid, custid)
VALUES  (10001, '20160212', 3, 'A')
      , (10002, '20160213', 4, 'A')
	  , (10003, '20160214', 1, 'C')
	  , (10004, '20160215', 2, 'C')
	  , (10005, '20160216', 6, 'C')


SELECT * 
FROM (
	VALUES  (10001, '20160212', 3, 'A')
		  , (10002, '20160213', 4, 'A')
		  , (10003, '20160214', 1, 'C')
		  , (10004, '20160215', 2, 'C')
		  , (10005, '20160216', 6, 'C')
) D

--No column name was specified for column 1 of 'D'.

SELECT * 
FROM (
	VALUES  (10001, '20160212', 3, 'A')
		  , (10002, '20160213', 4, 'A')
		  , (10003, '20160214', 1, 'C')
		  , (10004, '20160215', 2, 'C')
		  , (10005, '20160216', 6, 'C')
) D (orderid, orderdate, empid, custid)

SELECT * 
FROM (
	VALUES  (10001, '20160212', 3, 'A')
		  , (10002, '20160213', 4, 'A')
		  , (10003, '20160214', 1, 'C')
		  , (10004, '20160215', 2, 'C')
		  , (10005, '20160216', 6, 'C')
) D (orderid, orderdate, empid, custid)
INNER JOIN (
	VALUES  (10001, '20160212', 3, 'A')
		  , (10002, '20160213', 4, 'A')
		  , (10003, '20160214', 1, 'C')
		  , (10004, '20160215', 2, 'C')
		  , (10005, '20160216', 6, 'C')
) D1 (orderid, orderdate, empid, custid) ON D.orderid = D1.orderid