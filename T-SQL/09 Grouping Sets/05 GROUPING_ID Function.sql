
---------------------------------------------------------------------
-- GROUPING_ID function

-- If a grouping column allows NULLs in the table, you cannot tell for sure whether a NULL in the result set originated from the data 
-- or is a placeholder for a nonparticipating member in a grouping set.

-- One way to solve this problem is to use the GROUPING function. 
-- This function accepts a name of a column and returns 0 if it is a member of the current grouping set (a detail element) and 1 otherwise (an aggregate element).
-- T-SQL supports another function, called GROUPING_ID, that can further simplify the process of associating result rows and grouping sets.

-- You provide the function with all elements that participate in any grouping set as inputs—for example, GROUPING_ID(a, b, c, d)—
-- and the function returns an integer bitmap in which each bit represents a different input element

-- Now you can easily figure out which grouping set each row is associated with. 
-- The integer 0 (binary 00) represents the grouping set (empid, custid); 
-- the integer 1 (binary 01) represents (empid); 
-- the integer 2 (binary 10) represents (custid); and 
-- the integer 3 (binary 11) represents ().

---------------------------------------------------------------------

USE TSQLV4
GO

SELECT GROUPING_ID(empid, custid) 'GrpID'
     , GROUPING(empid) 'GrpEmp'
     , GROUPING(custid) 'GrpCust'
	 , empid, custid, SUM(qty) 'SumQty'
FROM dbo.Orders
GROUP BY CUBE(empid, custid)