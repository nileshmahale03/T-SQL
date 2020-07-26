
-- ALTER 

--1. ADD new column
--2. Modify Data type of an existing column
--3. DROP an existing column

USE TSQLV4
GO

SELECT * FROM Test.Employees

ALTER TABLE Test.Employees ADD Address VARCHAR(50)

ALTER TABLE Test.Employees ALTER COLUMN Address VARCHAR(80)

ALTER TABLE Test.Employees DROP COLUMN Address