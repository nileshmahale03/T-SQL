
-- DROP 

--1. DROP Table
--2. DROP an existing column of a Table

USE TSQLV4
GO

SELECT * FROM Test.Employees

ALTER TABLE Test.Employees DROP COLUMN Phone

DROP TABLE Test.Employees