

---------------------------------------------------------------------
-- Programmable objects

-- Cursors

-- T-SQL supports an object called cursor you can use to process rows from a result of a query one at a time and in a requested order.
-- This is incontrast to using set-based queries—normal queries without a cursor for which you manipulate the set or multiset as a whole and cannot rely on order.

-- With set-based solutions, you write declarative code where you mainly focus on the logical aspects of the solution (What to get)
-- With cursors, you write imperative solutions (How to get)

-- 1. One example is when you need to apply a certain task to each row from some table or view.
-- e.g. You might need to execute some administrative task for each index or table in your database.

-- 2. When your set-based solution performs badly and you exhaust your tuning efforts using the set-based approach
-- e.g. computing running aggregates using T-SQL code that don’t support the frame option in window functions.

-- SQL_VARIANT
---------------------------------------------------------------------
USE TSQLV4
GO


--1: Running Aggregate using JOIN

SELECT * 
FROM Sales.CustOrders
ORDER BY custid, ordermonth

SELECT CO1.custid, CO1.ordermonth
     , SUM(CO2.qty) 'runQty'
FROM Sales.CustOrders CO1
INNER JOIN Sales.CustOrders CO2 ON CO2.custid = CO1.custid and CO2.ordermonth <= CO1.ordermonth
GROUP BY CO1.custid, CO1.ordermonth
ORDER BY CO1.custid, CO1.ordermonth

SELECT CO.*
     , D.runQty
FROM Sales.CustOrders CO
JOIN (
	SELECT CO1.custid, CO1.ordermonth
		 , SUM(CO2.qty) 'runQty'
	FROM Sales.CustOrders CO1
	INNER JOIN Sales.CustOrders CO2 ON CO2.custid = CO1.custid and CO2.ordermonth <= CO1.ordermonth
	GROUP BY CO1.custid, CO1.ordermonth
) D ON D.custid = CO.custid and D.ordermonth = CO.ordermonth
ORDER BY D.custid, D.ordermonth

--2: Running Aggregate using Subquery

SELECT CO1.custid
     , CO1.ordermonth
	 , CO1.qty
	 , (SELECT SUM(CO2.qty)  
	    FROM Sales.CustOrders CO2 
		WHERE CO2.custid = CO1.custid and CO2.ordermonth <= CO1.ordermonth) 'runQty'
FROM Sales.CustOrders CO1
ORDER BY custid, ordermonth

--3: Running Aggregate using Cursor

DECLARE @Result TABLE (
	custid     INT
  , ordermonth DATE
  , qty        INT
  , runQty     INT
)

DECLARE @custid     INT
      , @prevCustid INT
      , @ordermonth DATE
	  , @qty        INT
	  , @runQty     INT

DECLARE aggCursor CURSOR
FOR 
	SELECT custid, ordermonth, qty 
	FROM Sales.CustOrders
	ORDER BY custid, ordermonth

OPEN aggCursor
FETCH NEXT FROM aggCursor INTO @custid, @ordermonth, @qty

SET @prevCustid = @custid
SET @runQty = 0

--SELECT @custid, @ordermonth, @qty

WHILE @@FETCH_STATUS = 0

BEGIN
    
	IF @prevCustid <> @custid
	BEGIN
		SET @prevCustid = @custid
		SET @runQty = 0 
	END

	SET @runQty = @runQty + @qty

	INSERT INTO @Result (custid, ordermonth, qty, runQty)
	VALUES (@custid, @ordermonth, @qty, @runQty)

	FETCH NEXT FROM aggCursor INTO @custid, @ordermonth, @qty

END

CLOSE aggCursor
DEALLOCATE aggCursor

SELECT custid
     , ordermonth
	 , qty
	 , runQty
FROM @Result
ORDER BY custid, ordermonth
