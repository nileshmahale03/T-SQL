
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- Nested DML

--T-SQL supports a feature called nested DML you can use to directly insert into the final target table only the subset of rows you need from the full set of modified rows.

---------------------------------------------------------------------

USE TSQLV4
GO

DROP TABLE IF EXISTS dbo.Orders

CREATE TABLE dbo.Orders (
	orderid   INT         NOT NULL IDENTITY(10001, 1)
  , orderdate DATE        NOT NULL
  , empid     INT         NOT NULL
  , custid    VARCHAR(10) NOT NULL
)

INSERT INTO dbo.Orders (orderdate, empid, custid)
OUTPUT inserted.orderid
     , inserted.orderdate
	 , inserted.empid
	 , inserted.custid
VALUES  ('20160212', 3, 'A')
      , ('20160213', 4, 'A')
	  , ('20160214', 1, 'C')
	  , ('20160215', 2, 'C')
	  , ('20160216', 6, 'C')
      , ('20160213', 4, 'A')
	  , ('20160214', 1, 'C')
	  , ('20160215', 2, 'C')
	  , ('20160216', 6, 'C')

--1
SELECT * FROM dbo.Orders

UPDATE O
SET empid = empid + orderid
FROM dbo.Orders O
WHERE orderid < 100012

UPDATE O
SET empid = empid + orderid
OUTPUT inserted.orderid
     , deleted.empid 'Old_empid'
	 , inserted.empid 'New_empid'
FROM dbo.Orders O
WHERE orderid < 100012

DROP TABLE IF EXISTS dbo.OrdersAudit
CREATE TABLE dbo.OrdersAudit (
	orderid    INT
  , Old_empid  INT
  , New_empid  INT
)

INSERT INTO dbo.OrdersAudit (orderid, Old_empid, New_empid)
SELECT orderid, Old_empid, New_empid 
FROM (
	UPDATE O
	SET empid = empid + orderid
	OUTPUT inserted.orderid
		 , deleted.empid 'Old_empid'
		 , inserted.empid 'New_empid'
	FROM dbo.Orders O
	WHERE orderid < 100012
) D
WHERE orderid = 10003

SELECT * FROM dbo.OrdersAudit
