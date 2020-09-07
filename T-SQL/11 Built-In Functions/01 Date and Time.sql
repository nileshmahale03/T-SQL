---------------------------------------------------------------------
-- Functions
/*
DATETIME
SMALLDATETIME
DATE
TIME
DATETIME2
DATETIMEOFFSET
*/
---------------------------------------------------------------------
USE TSQLV4

--1. GETDATE
-- DATETIME
SELECT GETDATE()

--2. CURRENT_TIMESTAMP
-- DATETIME
SELECT CURRENT_TIMESTAMP

--3. GETUTCDATE
-- DATETIME
SELECT GETUTCDATE()

--4. SYSDATETIME
-- DATETIME2
SELECT SYSDATETIME()

--5. SYSUTCDATETIME
-- DATETIME2
SELECT SYSUTCDATETIME()

--6. SYSDATETIMEOFFSET
-- DATETIMEOFFSET
SELECT SYSDATETIMEOFFSET()

--7. SYSDATETIME
SELECT CAST(SYSDATETIME() AS DATE)

--8. SYSDATETIME
SELECT CAST(SYSDATETIME() AS TIME)

--9.SWITCHOFFSET
-- The SWITCHOFFSET function adjusts an input DATETIMEOFFSET value to a specified target offset from UTC.

SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '+05:30')

--10.TODATETIMEOFFSET 
-- The TODATETIMEOFFSET function constructs a DATETIMEOFFSET typed value from a local date and time value and an offset from UTC.

SELECT TODATETIMEOFFSET (SYSDATETIME(), '-07:00')

SELECT name, current_utc_offset, is_currently_dst
FROM sys.time_zone_info;

--11.AT TIME ZONE
-- The AT TIME ZONE function accepts an input date and time value and converts it to a datetimeoffset value 
-- that corresponds to the specified target time zone.

SELECT CAST('20160212 12:00:00.0000000' AS DATETIME2) AT TIME ZONE 'Pacific Standard Time' AS val1
     , CAST('20160812 12:00:00.0000000' AS DATETIME2) AT TIME ZONE 'Pacific Standard Time' AS val2;

SELECT CAST('20160212 12:00:00.0000000 -05:00' AS DATETIMEOFFSET) AT TIME ZONE 'Pacific Standard Time' AS val1
     , CAST('20160812 12:00:00.0000000 -04:00' AS DATETIMEOFFSET) AT TIME ZONE 'Pacific Standard Time' AS val2;

--12.DATEADD
-- You use the DATEADD function to add a specified number of units of a specified date part to an input date and time value.

SELECT DATEADD(YEAR, 1, GETDATE())
SELECT DATEADD(MONTH, 1, GETDATE())
SELECT DATEADD(DAY, 1, GETDATE())

--13.DATEDIFF
-- The DATEDIFF and DATEDIFF_BIG functions return the difference between two date and time values in terms of a specified date part.

SELECT DATEDIFF(YEAR, '1986-02-03', GETDATE())
SELECT DATEDIFF(MONTH, '2019-04-27', GETDATE())

--14.DATEPART
-- The DATEPART function returns an integer representing a requested part of a date and time value.

SELECT DATEPART(MONTH, GETDATE())

--15.YEAR, MONTH, DAY
-- The YEAR, MONTH, and DAY functions are abbreviations for the DATEPART function returning the
-- integer representation of the year, month, and day parts of an input date and time value.

SELECT DAY('20160212')  'DAY'
     , MONTH('20160212') 'MONTH'
     , YEAR('20160212') 'YEAR';

--16.DATENAME
-- The DATENAME function returns a character string representing a part of a date and time value.

SELECT DATENAME(MONTH, GETDATE())

--17.ISDATE
-- The ISDATE function accepts a character string as input and returns 1 if it is convertible to a date and
-- time data type and 0 if it isn’t.

SELECT ISDATE('20160212');
SELECT ISDATE('20160230');

--18.FROMPARTS
-- The FROMPARTS functions accept integer inputs representing parts of a date and time value and construct 
-- a value of the requested type from those parts.

SELECT
	DATEFROMPARTS(2016, 02, 12),
	DATETIME2FROMPARTS(2016, 02, 12, 13, 30, 5, 1, 7),
	DATETIMEFROMPARTS(2016, 02, 12, 13, 30, 5, 997),
	DATETIMEOFFSETFROMPARTS(2016, 02, 12, 13, 30, 5, 1, -8, 0, 7),
	SMALLDATETIMEFROMPARTS(2016, 02, 12, 13, 30),
	TIMEFROMPARTS(13, 30, 5, 1, 7);

--19.EOMONTH
-- The EOMONTH function accepts an input date and time value and returns the respective end-of-
-- month date as a DATE typed value.

SELECT EOMONTH(SYSDATETIME())
SELECT DATEADD(month, DATEDIFF(month, '18991231', SYSDATETIME()), '18991231')

