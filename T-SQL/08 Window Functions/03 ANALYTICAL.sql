
---------------------------------------------------------------------
-- Offset Window Functions

-- You use offset window functions to return an element from a row that is at a certain offset from the current row or at the beginning or end of a window frame.

-- T-SQL supports four Offset functions: 
-- 1. LAG            : The LAG function looks before the current row; previous value
-- 2. LEAD           : The LEAD function looks ahead the current row; next value

-- The window-partition clause (PARTITION BY)                                   : Supports
-- The window-order clause (ORDER BY)                                           : must have an OVER clause with ORDER BY
-- A window-frame clause (ROWS BETWEEN <top delimiter> AND <bottom delimiter>)  : no relevance

-- The first argument to the functions (which is mandatory) is the element you want to return; 
-- The second argument (optional) is the offset (1 if not specified); 
-- The third argument (optional) is the default value to return if there is no row at the requested offset (which is NULL if not specified otherwise).

-- 3. FIRST_VALUE    : If you want the element from the first row in the window partition, use FIRST_VALUE with the window frame extent ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW.
-- 4. LAST_VALUE     : If you want the element from the last row in the window partition, use LAST_VALUE with the window frame extent ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING.

-- The window-partition clause (PARTITION BY)                                   : Supports
-- The window-order clause (ORDER BY)                                           : must have an OVER clause with ORDER BY
-- A window-frame clause (ROWS BETWEEN <top delimiter> AND <bottom delimiter>)  : Supports

---------------------------------------------------------------------

USE TSQLV4
GO

SELECT custid, orderdate, orderid, val
FROM Sales.OrderValues
ORDER BY custid, orderdate, orderid ASC

SELECT custid, orderdate, orderid, val
     , LAG(val, 1, NULL) OVER(PARTITION BY custid ORDER BY orderdate, orderid) 'LAG'
	 , LAG(val, 2, NULL) OVER(PARTITION BY custid ORDER BY orderdate, orderid) 'LAG'
	 , LAG(val, 2, 0) OVER(PARTITION BY custid ORDER BY orderdate, orderid)    'LAG'
FROM Sales.OrderValues
ORDER BY custid, orderdate, orderid ASC


SELECT custid, orderdate, orderid, val
     , FIRST_VALUE(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid) 'FIRST_VALUE'
	 , LAST_VALUE(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid) 'LAST_VALUE'
FROM Sales.OrderValues
ORDER BY custid, orderdate, orderid ASC

SELECT custid, orderdate, orderid, val
     , FIRST_VALUE(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 'FIRST_VALUE'
	 , LAST_VALUE(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) 'LAST_VALUE'
FROM Sales.OrderValues
ORDER BY custid, orderdate, orderid ASC