
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
--                : SCHEMABINDING
--                : CHECK OPTION

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
--ORDER BY region

GO

SELECT * FROM Sales.vwUSACusts