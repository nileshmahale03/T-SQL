
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- TRUNCATE

-- T-SQL provides two statements for deleting rows from a table: DELETE and TRUNCATE
-- The standard TRUNCATE statement deletes all rows from a table.
-- Unlike the DELETE statement, TRUNCATE has no filter.
-- TRUNCATE resets the identity value back to the original seed, but DELETE doesn’t—even when used without a filter
-- The TRUNCATE statement is not allowed when the target table is referenced by a foreign-key constraint.
-- In case you have partitioned tables in your database, SQL Server 2016 enhances the TRUNCATE statement by supporting the truncation of individual partitions.

-- Minimally logged
-- The TRUNCATE statement is processed as a transaction
---------------------------------------------------------------------

USE TSQLV4
GO

--1: The standard TRUNCATE statement deletes all rows from a table, , TRUNCATE has no filter.
DROP TABLE IF EXISTS dbo.Orders
DROP TABLE IF EXISTS dbo.Customers

SELECT * FROM dbo.Orders
SELECT * FROM dbo.Customers

SELECT *
INTO dbo.Customers
FROM Sales.Customers

SELECT *
INTO dbo.Orders
FROM Sales.Orders

TRUNCATE TABLE dbo.Orders

--2: TRUNCATE resets the identity value back to the original seed, but DELETE doesn’t—even when used without a filter
DROP TABLE IF EXISTS dbo.Orders

CREATE TABLE dbo.Orders (
	orderid   INT         NOT NULL IDENTITY(1,1)
  , orderdate DATE        NOT NULL
  , empid     INT         NOT NULL
  , custid    VARCHAR(10) NOT NULL
)

SELECT * FROM dbo.Orders

INSERT INTO dbo.Orders (orderdate, empid, custid)
VALUES  ('20160212', 3, 'A')
      , ('20160213', 4, 'A')
	  , ('20160214', 1, 'C')
	  , ('20160215', 2, 'C')
	  , ('20160216', 6, 'C')

DELETE FROM dbo.Orders

INSERT INTO dbo.Orders (orderdate, empid, custid)
VALUES  ('20160212', 3, 'A')
      , ('20160213', 4, 'A')

TRUNCATE TABLE dbo.Orders

--3: The TRUNCATE statement is not allowed when the target table is referenced by a foreign-key constraint.
DROP TABLE IF EXISTS dbo.Customers

CREATE TABLE dbo.Customers (
	custid      INT         NOT NULL IDENTITY(1,1)
  , companyname VARCHAR(70) NOT NULL
  , address     VARCHAR(70) NOT NULL
  , city        VARCHAR(70) NOT NULL
  CONSTRAINT PK_dboCustomers_custid PRIMARY KEY (custid)
)

SELECT * FROM dbo.Customers

DROP TABLE IF EXISTS dbo.Orders

CREATE TABLE dbo.Orders (
	orderid   INT         NOT NULL IDENTITY(1,1)
  , orderdate DATE        NOT NULL
  , empid     INT         NOT NULL
  , custid    INT         NOT NULL
  CONSTRAINT PK_dboOrders_orderid PRIMARY KEY (orderid)
  CONSTRAINT FK_dboOrders_custid FOREIGN KEY (custid) REFERENCES dbo.Customers(custid) 
)

SELECT * FROM dbo.Orders

SET IDENTITY_INSERT dbo.Customers ON
INSERT INTO dbo.Customers (custid, companyname, address, city)
SELECT custid, companyname, address, city
FROM Sales.Customers
SET IDENTITY_INSERT dbo.Customers OFF

SET IDENTITY_INSERT dbo.Orders ON
INSERT INTO dbo.Orders (orderid, orderdate, empid, custid)
SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
SET IDENTITY_INSERT dbo.Orders OFF

TRUNCATE TABLE dbo.Orders
TRUNCATE TABLE dbo.Customers  --Cannot truncate table 'dbo.Customers' because it is being referenced by a FOREIGN KEY constraint.

DELETE FROM dbo.Orders
DELETE FROM dbo.Customers