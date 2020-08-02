
---------------------------------------------------------------------
-- LEFT OUTER JOIN

-- 1. Apply Cartesian Product - m*n ROWS
-- 2. Apply ON Predicate      - Only rows where ON Predicate is TRUE are returned
-- 3. Add OUTER Rows          - Preserve LEFT side Table

-- Note: 1. ON Predicate serves as a matching purpose
--       2. WHERE Predicate serves as filtering purpose
--       2. For OUTER JOIN there is logical difference between ON and WHERE clauses
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM dbo.Customers
SELECT * FROM dbo.Orders

SELECT * 
FROM dbo.Customers C
LEFT JOIN dbo.Orders O ON O.CustID = C.CustID

SELECT * 
FROM dbo.Customers C
LEFT JOIN dbo.Orders O ON O.CustID = C.CustID
WHERE C.City = 'Madrid'

SELECT * 
FROM dbo.Customers C
LEFT JOIN dbo.Orders O ON O.CustID = C.CustID AND C.City = 'Madrid'