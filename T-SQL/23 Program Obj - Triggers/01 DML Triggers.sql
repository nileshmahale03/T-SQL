
---------------------------------------------------------------------
-- Programmable objects

-- Triggers

-- A trigger is a special kind of stored procedure—one that cannot be executed explicitly.
-- Instead, it’s attached to an event. Whenever the event takes place, the trigger fires and the trigger’s code runs. 
-- Uses: 1. Auditing
--       2. Enforcing Integrity Rules
--       3. Enforcing Policies
-- Triggers in SQL Server fire per statement and not per modified row.
-- In the trigger’s code, you can access pseudo tables called inserted and deleted that contain the rows that were affected by the modification that caused the trigger to fire. 

--Types:  1. DML
--			 a. AFTER or FOR 
--           b. INSTEAD OF
--        2. DDL

-- DML (at Object level)
---------------------------------------------------------------------

USE TSQLV4
GO

DROP TABLE IF EXISTS dbo.T1

CREATE TABLE dbo.T1 (
	col1 INT
  , col2 VARCHAR(10)
)

DROP TABLE IF EXISTS dbo.Audit

CREATE TABLE dbo.Audit (
	audit_key  INT         IDENTITY(1,1) PRIMARY KEY
  , event_date DATE        DEFAULT GETDATE()
  , login_name SYSNAME     DEFAULT ORIGINAL_LOGIN()
  , col1       INT
  , col2       VARCHAR(10)
)

SELECT * FROM dbo.T1
SELECT * FROM dbo.Audit

INSERT INTO dbo.T1 (col1, col2)
VALUES (1, 'Trigger')
      ,(2, 'AFTER/FOR')


CREATE TRIGGER dbo.TRG_T1_AFTER_INSERT_Audit ON dbo.T1 AFTER INSERT
AS
BEGIN

	INSERT INTO dbo.Audit (col1, col2)
	SELECT col1, col2
	FROM inserted

END

GO