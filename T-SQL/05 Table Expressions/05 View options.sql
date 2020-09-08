
---------------------------------------------------------------------
-- VIEWs

-- A table expression is a named query expression that represents a valid relational table.
-- Types - 1.Derived Tables 2.CTEs 3.VIEWs 4.Inline TVFs
-- Table expressions are not physically materialized anywhere—they are virtual.
-- The benefits of using table expressions are typically related to logical aspects of your code and not to performance.
-- Table expressions also help you circumvent certain restrictions in the language

-- Rule 1: Order is not guaranteed
-- Rule 2: All columns must have names
-- Rule 3: All column names must be unique

-- VIEWs          : Definition are stored as permanent objects, reusable
--                : Because a view is an object in the database, you can manage access permissions similar to the way you do for tables. 
--                 (These permissions include SELECT, INSERT, UPDATE, and DELETE.) 
-- View option    : ENCRYPTION
--                  The ENCRYPTION option indicates that SQL Server will internally store the text with the definition of the object in an obfuscated format.

--                : SCHEMABINDING
--                  It binds the schema of referenced objects and columns to the schema of the referencing object.
--                  It indicates that referenced objects cannot be dropped and that referenced columns cannot be dropped or altered.
--                  * is not allowed with SCHEMABINDING
--                  You must use schema-qualified two-part names when referring to objects

--                : CHECK OPTION
--                  The purpose of CHECK OPTION is to prevent modifications through the view that conflict with the view’s filter
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Customers 

SELECT * FROM Sales.Orders


---------------------------------------------------------------------
-- Query: all customers from the United States

---------------------------------------------------------------------
DROP VIEW IF EXISTS Sales.vwUSACusts
GO
CREATE VIEW Sales.vwUSACusts
AS

SELECT *
FROM Sales.Customers
WHERE country = 'USA'

GO

SELECT * FROM Sales.vwUSACusts

---------------------------------------------------------------------
-- Query: ENCRYPTION

---------------------------------------------------------------------
DROP VIEW IF EXISTS Sales.vwUSACusts
GO
CREATE VIEW Sales.vwUSACusts WITH ENCRYPTION
AS

SELECT *
FROM Sales.Customers
WHERE country = 'USA'

GO

SELECT * FROM Sales.vwUSACusts

---------------------------------------------------------------------
-- Query: SCHEMABINDING

---------------------------------------------------------------------
DROP VIEW IF EXISTS Sales.vwUSACusts
GO
CREATE VIEW Sales.vwUSACusts WITH SCHEMABINDING
AS

SELECT custid, companyname, contactname, contacttitle, address
     , city, region, postalcode, country, phone, fax
FROM Sales.Customers
WHERE country = 'USA'

GO

SELECT * FROM Sales.vwUSACusts

ALTER TABLE Sales.Customers
DROP COLUMN address

---------------------------------------------------------------------
-- Query: CHECK OPTION

---------------------------------------------------------------------
INSERT INTO Sales.vwUSACusts (companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
VALUES (N'CustomerABCDE', N'ContactABCDE', N'TitleABCDE', N'AddressABCDE', N'London', NULL, N'12345', N'UK', N'012-3456789', N'012-3456789');

SELECT * FROM Sales.vwUSACusts

SELECT * FROM Sales.Customers

DROP VIEW IF EXISTS Sales.vwUSACusts
GO
CREATE VIEW Sales.vwUSACusts 
AS

SELECT *
FROM Sales.Customers
WHERE country = 'USA'
WITH CHECK OPTION
GO

SELECT * FROM Sales.vwUSACusts

DELETE 
FROM Sales.Customers 
WHERE custid = 92