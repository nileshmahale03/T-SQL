
---------------------------------------------------------------------
-- Aggregate Window Functions

-- You use aggregate window functions to aggregate the rows in the defined window.

-- The window-partition clause (PARTITION BY)                                   : Supports
-- The window-order clause (ORDER BY)                                           : Supports - optional 
-- A window-frame clause (ROWS BETWEEN <top delimiter> AND <bottom delimiter>)  : Supports

-- T-SQL supports four Aggregate functions: 
-- 1. SUM    : 
-- 2. COUNT  : 
-- 3. MIN    : 
-- 4. MAX    : 
-- 5. AVG    : 

-- Aggregate window functions also support a window frame. The frame allows for more sophisticated calculations, such as running and moving aggregates, YTD and MTD calculations, and others
---------------------------------------------------------------------

USE TSQLV4
GO

SELECT *
FROM Sales.OrderValues

SELECT orderid, custid, val
     , SUM(val) OVER() 'Total'
	 , SUM(val) OVER(PARTITION BY custid) 'TotalByCustomer'
	 , SUM(val) OVER(PARTITION BY custid ORDER BY orderid) 'RunningTotalByCustomer'
	 , SUM(val) OVER(PARTITION BY custid ORDER BY orderid ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 'Frame1'
	 , SUM(val) OVER(PARTITION BY custid ORDER BY orderid ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) 'Frame2'
	 , SUM(val) OVER(PARTITION BY custid ORDER BY orderid ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) 'Frame3'
	 , SUM(val) OVER(PARTITION BY custid ORDER BY orderid ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) 'Frame4'
	 , SUM(val) OVER(PARTITION BY custid ORDER BY orderid ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) 'Frame5'
FROM Sales.OrderValues
order by custid, orderid
