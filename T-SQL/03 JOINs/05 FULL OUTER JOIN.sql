
---------------------------------------------------------------------
-- FULL OUTER JOIN

-- 1. Apply Cartesian Product - m*n ROWS
-- 2. Apply ON Predicate      - Only rows where ON Predicate is TRUE are returned
-- 3. Add OUTER Rows          - Preserve LEFT and RIGHT side Table

-- Note: ON Predicate serves as a matching purpose
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM dbo.Customers
SELECT * FROM dbo.Orders

SELECT * 
FROM dbo.Customers C
FULL JOIN dbo.Orders O ON O.CustID = C.CustID

SELECT * 
FROM dbo.Customers C
FULL JOIN dbo.Orders O ON O.CustID = C.CustID
WHERE C.City = 'Madrid'

SELECT * 
FROM dbo.Customers C
FULL JOIN dbo.Orders O ON O.CustID = C.CustID AND C.City = 'Madrid'