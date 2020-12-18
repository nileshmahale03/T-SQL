
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- OUTPUT Clause (Not a statement)

-- Normally, a modification statement just modifies data. 
-- However, sometimes you might find it useful to return information from the modified rows for troubleshooting, auditing, and archiving. 
-- T-SQL supports this capability via a clause called OUTPUT that you add to the modification statement.

-- The OUTPUT clause is designed similarly to the SELECT clause, only you need to prefix the attributes with either the inserted or deleted keyword.
-- In an INSERT statement, you refer to inserted; 
-- In a DELETE statement, you refer to deleted; and 
-- In an UPDATE statement, you refer to deleted for the old state of the row and inserted for the new state.
-- In an MERGE statement, to identify which DML action produced each output row, you can invoke a function called $action in the OUTPUT clause, 
--                        which will return a string representing the action (INSERT, UPDATE, or DELETE).

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

DELETE
FROM dbo.Orders
WHERE orderid < 10012

DELETE
FROM dbo.Orders
OUTPUT deleted.orderid
     , deleted.orderdate
	 , deleted.empid
	 , deleted.custid
WHERE orderid < 10012