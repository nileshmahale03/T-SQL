
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- INSERT

-- 3. INSERT INTO EXEC

-- In T-SQL, specifying the INTO clause is optional. 
-- You use the INSERT EXEC statement to insert a result set returned from a stored procedure or a dynamic SQL batch into a target table.
-- The INSERT SELECT statement is performed as a transaction, so if any row fails to enter the target table, none of the rows enters the table.
-- 
---------------------------------------------------------------------
USE TSQLV4
GO

SELECT * FROM dbo.Orders
GO

CREATE PROCEDURE Sales.SPGetOrders
	@Country VARCHAR(40)
AS
SELECT orderid, orderdate, empid, custid 
FROM Sales.Orders
WHERE shipcountry = @Country
GO

INSERT INTO dbo.Orders (orderid, orderdate, empid, custid)
EXEC Sales.SPGetOrders 'France'

INSERT dbo.Orders (orderid, orderdate, empid, custid)
EXEC Sales.SPGetOrders @Country = 'UK'