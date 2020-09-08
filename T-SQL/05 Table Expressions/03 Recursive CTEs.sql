
---------------------------------------------------------------------
-- Recursive CTEs

/*
WITH<CTE_Name>[(<target_column_list>)]
AS
(
<anchor_member>
UNION ALL
<recursive_member>
)
<outer_query_against_CTE>;
*/

-- The anchor member query is invoked only once.
-- The recursive member is a query that has a reference to the CTE name and is invoked repeatedly until it returns an empty set.
-- As a safety measure, SQL Server restricts the number of times the recursive member can be invoked to 100 by default.
-- You can change the default maximum recursion limit (that is, the number of times the recursive member can be invoked) by specifying 
-- the hint OPTION(MAXRECURSION n) at the end of the outer query, where n is an integer in the range 0 through 32,767.
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM HR.Employees

---------------------------------------------------------------------
-- Query: Generate a list of numbers from 1 to 100

---------------------------------------------------------------------
;WITH CTEGenNum AS(
	SELECT 1 'n'

	UNION ALL

	SELECT n + 1
	FROM CTEGenNum
	WHERE N < 110
)
SELECT * 
FROM CTEGenNum
OPTION (MAXRECURSION 110)
---------------------------------------------------------------------
-- Query: The following code demonstrates how to return information about an employee (Don Funk, employee ID 2) and all the employee’s subordinates at all levels (direct or indirect):

---------------------------------------------------------------------
; WITH CTEEmpSub AS(
	SELECT empid, mgrid, firstname, lastname
	FROM HR.Employees
	WHERE empid = 2

	UNION ALL

	SELECT E.empid, E.mgrid, E.firstname, E.lastname
	FROM CTEEmpSub C
	JOIN HR.Employees E ON E.mgrid = C.empid
)
SELECT * 
FROM CTEEmpSub