---------------------------------------------------------------------
-- GROUP BY

-- You can use the GROUP BY phase to arrange the rows returned by the previous logical query processing phase in groups.

-- If the query involves grouping, all phases subsequent to the GROUP BY phase—including HAVING,-- SELECT, and ORDER BY—must operate on groups as opposed to operating on individual rows.

-- Each group is ultimately represented by a single row in the final result of the query. 
-- This implies that all expressions you specify in clauses that are processed in phases subsequent to the GROUP BY phase are
-- required to guarantee returning a scalar (single value) per group.

-- Elements that do not participate in the GROUP BY clause are allowed only as inputs to an aggregate function such as COUNT, SUM, AVG, MIN, or MAX.

-- Note that all aggregate functions ignore NULLs, with one exception—COUNT(*).
---------------------------------------------------------------------

USE TSQLV4

SELECT empid                        
     , YEAR(orderdate) 'OrderYear'
FROM Sales.Orders                   
WHERE custid = 71                   
GROUP BY empid, YEAR(orderdate)     
