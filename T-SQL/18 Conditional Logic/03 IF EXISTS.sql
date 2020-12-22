
---------------------------------------------------------------------
-- Conditional Logic

-- You use flow elements to control the flow of your code.

-- 3. IF EXISTS

-- You use the IF . . . ELSE element to control the flow of your code based on the result of a predicate.
-- If you need to run more than one statement in the IF or ELSE sections, you need to use a statement block. 
-- You mark the boundaries of a statement block with the BEGIN and END keywords.

---------------------------------------------------------------------

USE TSQLV4
GO

CREATE TABLE Sales.Orders (  --There is already an object named 'Orders' in the database.
	orderid   INT
  , custid    INT
  , empid     INT
  , orderdate DATE
)

IF NOT EXISTS (
	SELECT * 
	FROM sys.tables
	WHERE object_id =  OBJECT_ID('Sales.Orders')
)
BEGIN

	SELECT 1
	CREATE TABLE Sales.Orders (  --There is already an object named 'Orders' in the database.
		orderid   INT
	  , custid    INT
	  , empid     INT
	  , orderdate DATE
	)

END