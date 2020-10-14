
/*---------------------------------------------------------------------
Exercise 596

There is a table courses with columns: student and class

Please list out all classes which have more than or equal to 5 students.

For example, the table:

+---------+------------+
| student | class      |
+---------+------------+
| A       | Math       |
| B       | English    |
| C       | Math       |
| D       | Biology    |
| E       | Math       |
| F       | Computer   |
| G       | Math       |
| H       | Math       |
| I       | Math       |
+---------+------------+
Should output:

+---------+
| class   |
+---------+
| Math    |
+---------+
 

Note:
The students should not be counted duplicate in each course.

*/---------------------------------------------------------------------
USE QuestionBank
GO

DROP TABLE IF EXISTS dbo.courses
GO

CREATE TABLE dbo.courses (
	student VARCHAR(1)  NOT NULL
  , class   VARCHAR(10) NOT NULL
)

INSERT INTO dbo.courses (student, class)
VALUES ('A', 'Math'    )
     , ('B', 'English' )
     , ('C', 'Math'    )
     , ('D', 'Biology' )
     , ('E', 'Math'    )
     , ('F', 'Computer')
     , ('G', 'Math'    )
     , ('H', 'Math'    )
     , ('I', 'Math'    )

SELECT * FROM dbo.courses

--1. 
SELECT class, COUNT(student) 
FROM dbo.courses
GROUP BY class
HAVING COUNT(student) >= 5