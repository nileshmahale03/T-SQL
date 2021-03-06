
---------------------------------------------------------------------
-- Programmable objects

-- Triggers

-- A trigger is a special kind of stored procedure�one that cannot be executed explicitly.
-- Instead, it�s attached to an event. Whenever the event takes place, the trigger fires and the trigger�s code runs. 
-- Uses: 1. Auditing
--       2. Enforcing Integrity Rules
--       3. Enforcing Policies
--       4. Change management
-- Triggers in SQL Server fire per statement and not per modified row.
-- In the trigger�s code, you can access pseudo tables called inserted and deleted that contain the rows that were affected by the modification that caused the trigger to fire. 

--Types:  1. DML
--			 a. AFTER or FOR 
--           b. INSTEAD OF
--        2. DDL
---------------------------------------------------------------------




