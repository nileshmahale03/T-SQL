
---------------------------------------------------------------------
-- CROSS JOIN

-- 1. Apply Cartesian Product

-- Note: ON Predicate is NOT required
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM dbo.Customers
SELECT * FROM dbo.Orders

SELECT * 
FROM dbo.Customers
CROSS JOIN dbo.Orders