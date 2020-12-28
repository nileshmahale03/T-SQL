
---------------------------------------------------------------------
-- Stored Procedures

-- 1. Stored procedures are programmable objects that encapsulate code to calculate a result or to execute activity. 
-- 2. They can have input and output parameters, they can return result sets of queries.
-- 3. You can modify data through stored procedures.

-- Compared to using ad-hoc code, the use of stored procedures gives you many benefits
-- 1. SP encapsulate logic
--         If you need to change the implementation of a stored procedure, you apply the change in one place using the ALTER PROC command, 
--         and all users of the procedure will use the new version from that point.

-- 2. SP give you better control of security
--         You can grant a user permissions to execute the procedure without granting the user direct permissions to 
--         perform the underlying activities.

-- 3. Stored procedures with parameters can help prevent SQL injection.

-- 4. You can incorporate all error-handling code within a procedure.

-- 5. SP give you performance benefits.
--         Reuse previously cached plans
--         Reduction in network traffic.

---------------------------------------------------------------------
USE TSQLV4
GO

SELECT custid, orderid, empid, orderdate 
FROM Sales.Orders
WHERE custid = 85
AND orderdate >= '19000101'
AND orderdate < '99991231'

DROP PROCEDURE IF EXISTS dbo.USP_GetCustOrders

CREATE PROCEDURE dbo.USP_GetCustOrders 
     @custid     INT
   , @fromDate   DATE = '19000101'
   , @toDate     DATE = '99991231'
   , @orderCount INT OUTPUT
AS
BEGIN

	SELECT custid, orderid, empid, orderdate 
	FROM Sales.Orders
	WHERE custid = @custid
	AND orderdate >= @fromDate
	AND orderdate < @toDate

	SET @orderCount = @@ROWCOUNT
END

DECLARE @orderCount INT

EXECUTE dbo.USP_GetCustOrders 85, '20000101', '20201231', @orderCount = @orderCount OUTPUT

SELECT @orderCount