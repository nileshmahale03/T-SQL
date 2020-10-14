
/*---------------------------------------------------------------------
Exercise 262

The Trips table holds all taxi trips. Each trip has a unique Id, while Client_Id and Driver_Id are both foreign keys to the Users_Id at the Users table. Status is an ENUM type of (‘completed’, ‘cancelled_by_driver’, ‘cancelled_by_client’).

+----+-----------+-----------+---------+--------------------+----------+
| Id | Client_Id | Driver_Id | City_Id |        Status      |Request_at|
+----+-----------+-----------+---------+--------------------+----------+
| 1  |     1     |    10     |    1    |     completed      |2013-10-01|
| 2  |     2     |    11     |    1    | cancelled_by_driver|2013-10-01|
| 3  |     3     |    12     |    6    |     completed      |2013-10-01|
| 4  |     4     |    13     |    6    | cancelled_by_client|2013-10-01|
| 5  |     1     |    10     |    1    |     completed      |2013-10-02|
| 6  |     2     |    11     |    6    |     completed      |2013-10-02|
| 7  |     3     |    12     |    6    |     completed      |2013-10-02|
| 8  |     2     |    12     |    12   |     completed      |2013-10-03|
| 9  |     3     |    10     |    12   |     completed      |2013-10-03| 
| 10 |     4     |    13     |    12   | cancelled_by_driver|2013-10-03|
+----+-----------+-----------+---------+--------------------+----------+
The Users table holds all users. Each user has an unique Users_Id, and Role is an ENUM type of (‘client’, ‘driver’, ‘partner’).

+----------+--------+--------+
| Users_Id | Banned |  Role  |
+----------+--------+--------+
|    1     |   No   | client |
|    2     |   Yes  | client |
|    3     |   No   | client |
|    4     |   No   | client |
|    10    |   No   | driver |
|    11    |   No   | driver |
|    12    |   No   | driver |
|    13    |   No   | driver |
+----------+--------+--------+
Write a SQL query to find the cancellation rate of requests made by unbanned users (both client and driver must be unbanned) between Oct 1, 2013 and Oct 3, 2013. 
The cancellation rate is computed by dividing the number of canceled (by client or driver) requests made by unbanned users by the total number of requests made by unbanned users.

For the above tables, your SQL query should return the following rows with the cancellation rate being rounded to two decimal places.

+------------+-------------------+
|     Day    | Cancellation Rate |
+------------+-------------------+
| 2013-10-01 |       0.33        |
| 2013-10-02 |       0.00        |
| 2013-10-03 |       0.50        |
+------------+-------------------+
*/---------------------------------------------------------------------
USE QuestionBank
GO

DROP TABLE IF EXISTS dbo.Trips
GO
DROP TABLE IF EXISTS dbo.Users
GO

CREATE TABLE dbo.Trips (
	Id         INT          NOT NULL IDENTITY(1,1)
  , Client_Id  INT          NOT NULL
  , Driver_Id  INT          NOT NULL
  , City_Id    INT          NOT NULL
  , Status     VARCHAR(20)  NOT NULL
  , Request_at DATE         NOT NULL
  CONSTRAINT PK_dbo_Trips_Id PRIMARY KEY (Id)
)

CREATE TABLE dbo.Users (
	Users_Id  INT         NOT NULL 
  , Banned    VARCHAR(20) NOT NULL
  , Role      VARCHAR(20) NOT NULL
  CONSTRAINT PK_dbo_Users_Users_Id PRIMARY KEY (Users_Id)
)

INSERT INTO dbo.Trips (Client_Id, Driver_Id, City_Id, Status, Request_at)
VALUES (1, 10, 1 , 'Completed'          , '2013-10-01')
     , (2, 11, 1 , 'cancelled_by_driver', '2013-10-01')
	 , (3, 12, 6 , 'Completed'          , '2013-10-01')
	 , (4, 13, 6 , 'cancelled_by_client', '2013-10-01')
	 , (1, 10, 1 , 'Completed'          , '2013-10-02')
	 , (2, 11, 6 , 'Completed'          , '2013-10-02')
	 , (3, 12, 6 , 'Completed'          , '2013-10-02')
	 , (2, 12, 12, 'Completed'          , '2013-10-03')
	 , (3, 10, 12, 'Completed'          , '2013-10-03')
	 , (4, 13, 12, 'cancelled_by_driver', '2013-10-03')

INSERT INTO dbo.Users (Users_Id, Banned, Role)
VALUES (1 , 'No' , 'Client')
     , (2 , 'Yes', 'Client')
	 , (3 , 'No' , 'Client')
	 , (4 , 'No' , 'Client')
	 , (10, 'No' , 'driver')
	 , (11, 'No' , 'driver')
	 , (12, 'No' , 'driver')
	 , (13, 'No' , 'driver')

SELECT * FROM dbo.Trips
SELECT * FROM dbo.Users

--1.

SELECT T.*
     , C.Banned 'Client_Banned', C.Role 'Client_Role'
	 , D.Banned 'Driver_Banned', D.Role 'Driver_Role'
FROM dbo.Trips T
INNER JOIN dbo.Users C ON C.Users_Id = T.Client_Id
INNER JOIN dbo.Users D ON D.Users_Id = T.Driver_Id
WHERE C.Banned = 'No' and D.Banned = 'No'

--Denominator
SELECT Request_at, COUNT(Id) 'Den'
FROM dbo.Trips T
INNER JOIN dbo.Users C ON C.Users_Id = T.Client_Id
INNER JOIN dbo.Users D ON D.Users_Id = T.Driver_Id
WHERE C.Banned = 'No' and D.Banned = 'No'
GROUP BY Request_at

--Numerator
SELECT Request_at, COUNT(Id) 'Num'
FROM dbo.Trips T
INNER JOIN dbo.Users C ON C.Users_Id = T.Client_Id
INNER JOIN dbo.Users D ON D.Users_Id = T.Driver_Id
WHERE C.Banned = 'No' and D.Banned = 'No'
AND Status IN ('cancelled_by_client', 'cancelled_by_driver')
GROUP BY Request_at


SELECT Request_at 'Day'
     , COUNT(Id) 'Den'
	 , SUM(CASE WHEN Status != 'Completed' THEN 1 ELSE 0 END) 'Num'
	 , CAST(CAST(SUM(CASE WHEN Status != 'Completed' THEN 1 ELSE 0 END) AS NUMERIC(5,2)) / CAST(COUNT(Id) AS NUMERIC(5,2)) AS NUMERIC(5,2)) 'CancellationRate'
FROM dbo.Trips T
INNER JOIN dbo.Users C ON C.Users_Id = T.Client_Id
INNER JOIN dbo.Users D ON D.Users_Id = T.Driver_Id
WHERE C.Banned = 'No' 
  AND D.Banned = 'No'
  AND T.Request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY Request_at

