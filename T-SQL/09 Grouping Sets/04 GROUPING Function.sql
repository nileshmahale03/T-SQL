
---------------------------------------------------------------------
-- GROUPING function

-- If a grouping column allows NULLs in the table, you cannot tell for sure whether a NULL in the result set originated from the data 
-- or is a placeholder for a nonparticipating member in a grouping set.

-- One way to solve this problem is to use the GROUPING function. 
-- This function accepts a name of a column and returns 0 if it is a member of the current grouping set (a detail element) and 1 otherwise (an aggregate element).

-- For example, all rows in which GrpEmp is 0 and GrpCust is 0 are associated with the grouping set (empid, custid). 
-- All rows in which GrpEmp is 0 and GrpCust is 1 are associated with the grouping set (empid), and so on.
---------------------------------------------------------------------

USE TSQLV4
GO

SELECT GROUPING(empid) 'GrpEmp'
     , GROUPING(custid) 'GrpCust'
	 , empid, custid, SUM(qty) 'SumQty'
FROM dbo.Orders
GROUP BY CUBE(empid, custid)
