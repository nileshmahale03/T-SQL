
/*---------------------------------------------------------------------
Exercise 1179

Table: Department

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| revenue       | int     |
| month         | varchar |
+---------------+---------+
(id, month) is the primary key of this table.
The table has information about the revenue of each department per month.
The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 
Write an SQL query to reformat the table such that there is a department id column and a revenue column for each month.

The query result format is in the following example:

Department table:
+------+---------+-------+
| id   | revenue | month |
+------+---------+-------+
| 1    | 8000    | Jan   |
| 2    | 9000    | Jan   |
| 3    | 10000   | Feb   |
| 1    | 7000    | Feb   |
| 1    | 6000    | Mar   |
+------+---------+-------+

Result table:
+------+-------------+-------------+-------------+-----+-------------+
| id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
+------+-------------+-------------+-------------+-----+-------------+
| 1    | 8000        | 7000        | 6000        | ... | null        |
| 2    | 9000        | null        | null        | ... | null        |
| 3    | null        | 10000       | null        | ... | null        |
+------+-------------+-------------+-------------+-----+-------------+

Note that the result table has 13 columns (1 for the department id + 12 for the months).

*/---------------------------------------------------------------------
USE QuestionBank
GO

DROP TABLE IF EXISTS dbo.Department
GO

CREATE TABLE dbo.Department (
	id      INT        NOT NULL
  , revenue INT        NOT NULL
  , month   VARCHAR(3) NOT NULL
  CONSTRAINT PK_dbo_department_id_month PRIMARY KEY (id, month)
)

INSERT INTO dbo.Department (id, revenue, month)
VALUES (1, 8000, 'Jan')
     , (2, 9000, 'Jan')
	 , (3, 1000, 'Feb')
	 , (1, 7000, 'Feb')
	 , (1, 6000, 'Mar')

SELECT * FROM dbo.Department

--1.
SELECT id
     , MIN(CASE WHEN month = 'Jan' then revenue END) 'Jan_Revenue'
	 , MIN(CASE WHEN month = 'Feb' then revenue END) 'Feb_Revenue'
	 , MIN(CASE WHEN month = 'Mar' then revenue END) 'Mar_Revenue'
FROM Department
GROUP BY id