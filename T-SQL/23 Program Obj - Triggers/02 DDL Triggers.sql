
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

-- DDL (Database Trigger)
---------------------------------------------------------------------

USE TSQLV4
GO

DROP TABLE IF EXISTS dbo.DDLAudit

CREATE TABLE dbo.DDLAudit (
	audit_key  INT         IDENTITY(1,1) PRIMARY KEY
  , event_date DATE        DEFAULT GETDATE()
  , login_name SYSNAME     DEFAULT ORIGINAL_LOGIN()
  , event_log  XML
)

CREATE TRIGGER TRG_DDL_DDLAudit --Cannot specify a schema name as a prefix to the trigger name for database and server level triggers.
ON DATABASE 
FOR  CREATE_TABLE
   , DROP_TABLE
   , ALTER_TABLE
AS
BEGIN
	INSERT INTO dbo.DDLAudit (event_log)
	VALUES (EVENTDATA())
	PRINT 'You must ask your DBA to create, drop or alter tables!'
END

SELECT * FROM dbo.DDLAudit