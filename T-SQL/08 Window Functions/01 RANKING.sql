
---------------------------------------------------------------------
-- Ranking Window Functions

-- You use ranking window functions to rank each row with respect to others in the window.

-- The window-partition clause (PARTITION BY)                                   : Supports
-- The window-order clause (ORDER BY)                                           : must have an OVER clause with ORDER BY
-- A window-frame clause (ROWS BETWEEN <top delimiter> AND <bottom delimiter>)  : may not have a window frame

-- T-SQL supports four ranking functions: 
-- 1. ROW_NUMBER    : The ROW_NUMBER function assigns incremental sequential integers to the rows in the query result based on the mandatory window ordering.
--                    If you want to produce the same rank value given the same ordering value, use the RANK or DENSE_RANK
-- 2. RANK          : RANK reflects the count of rows that have a lower ordering value than the current row (plus 1)
-- 3. DENSE_RANK    : DENSE_RANK reflects the count of distinct ordering values that are lower than the current row (plus 1)
-- 4. NTILE         : Use the NTILE function to associate the rows in the result with tiles (equally sized groups of rows) by assigning a tile number to each row
--                    If the number of rows can’t be evenly divided by the number of tiles, an extra row is added to each of the first tiles from the remainder.
--                    For example, if 102 rows and five tiles were requested, the first two tiles would have 21 rows instead of 20.

-- If you want to make a row number calculation deterministic, you need to add a tiebreaker to the ORDER BY list to make it unique.
---------------------------------------------------------------------

USE TSQLV4
GO

SELECT *
FROM Sales.OrderValues
ORDER BY val ASC

SELECT COUNT(DISTINCT val)
FROM Sales.OrderValues

SELECT *
     , ROW_NUMBER() OVER(ORDER BY val ASC) 'ROW_NUMBER'
	 , RANK() OVER(ORDER BY val ASC) 'RANK'
	 , DENSE_RANK() OVER(ORDER BY val ASC) 'DENSE_RANK'
	 , NTILE(100) OVER(ORDER BY val ASC) 'NTILE'
FROM Sales.OrderValues
ORDER BY val ASC


SELECT *
     , ROW_NUMBER() OVER(PARTITION BY custid ORDER BY val ASC) 'ROW_NUMBER'
FROM Sales.OrderValues
ORDER BY custid, val ASC
