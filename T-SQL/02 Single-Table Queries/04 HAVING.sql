---------------------------------------------------------------------
-- HAVING

-- Whereas the WHERE clause is a row filter, the HAVING clause is a group filter

-- Only groups for which the HAVING predicate evaluates to TRUE are returned by the HAVING phase to the next logical query processing phase.

-- Groups for which the predicate evaluates to FALSE or UNKNOWN are discarded.
---------------------------------------------------------------------

USE TSQLV4

SELECT empid                        
     , YEAR(orderdate) 'OrderYear'
	 , COUNT(*) 'NumOfOrders'
FROM Sales.Orders                   
WHERE custid = 71                   
GROUP BY empid, YEAR(orderdate)     
HAVING COUNT(*) > 1                 
