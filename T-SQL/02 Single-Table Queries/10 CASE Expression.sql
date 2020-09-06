---------------------------------------------------------------------
-- CASE expression

-- A CASE expression is a scalar expression that returns a value based on conditional logic.
-- Because CASE is a scalar expression, it is allowed wherever scalar expressions are allowed, such as in the SELECT, WHERE,
-- HAVING, and ORDER BY clauses and in CHECK constraints.

-- abbreviations of the CASE expression: ISNULL, COALESCE, IIF, and CHOOSE.
---------------------------------------------------------------------
SELECT orderid
     , custid
	 , val
	 , CASE
	   WHEN val < 1000.00                   THEN 'Less than 1000'
	   WHEN val BETWEEN 1000.00 AND 3000.00 THEN 'Between 1000 and 3000'
	   WHEN val > 3000.00                   THEN 'More than 3000'
	   ELSE 'Unknown' END 'valuecategory'
FROM Sales.OrderValues;