
---------------------------------------------------------------------
-- CROSS JOIN

-- It implements only 1 logical quey processing phase - Apply Cartesian Product
-- Each row from one input is matched with all rows from the other
-- So if you have m rows in one table and n rows in other, you get m x n rows in the result.

-- Note: ON Predicate is NOT required
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Customers
SELECT * FROM HR.Employees

SELECT C.contactname 'Customer'
     , CONCAT(E.lastname, ', ', firstname) 'Employee'
FROM Sales.Customers C
CROSS JOIN HR.Employees E

---------------------------------------------------------------------
-- SELF CROSS JOIN

-- In a SELF JOIN, aliasing table is not optional. Without table aliases, all column names in the result of the join would be ambiguous
---------------------------------------------------------------------

SELECT CONCAT(E1.lastname, ', ', E1.firstname) 'Employee1'
     , CONCAT(E2.lastname, ', ', E2.firstname) 'Employee2'
FROM HR.Employees E1
CROSS JOIN HR.Employees E2

---------------------------------------------------------------------
-- Query: Produce a result set with a sequence of integers (1, 2, 3, and so on).

---------------------------------------------------------------------
USE TSQLV4

CREATE TABLE dbo.Digits
(
	digit int NOT NULL
)
INSERT INTO dbo.Digits(digit)
VALUES (0)
     , (1)
	 , (2)
	 , (3)
	 , (4)
	 , (5)
	 , (6)
	 , (7)
	 , (8)
	 , (9)

SELECT * FROM dbo.Digits

SELECT D1.digit
     , D2.digit
	 , D2.digit * 10 + D1.digit + 1 'Number'
FROM dbo.Digits D1
CROSS JOIN dbo.Digits D2