
/*---------------------------------------------------------------------
Exercise 627

Given a table salary, such as the one below, that has m=male and f=female values. 
Swap all f and m values (i.e., change all f values to m and vice versa) with a single update statement and no intermediate temp table.

Note that you must write a single update statement, DO NOT write any select statement for this problem.

Example:

| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | m   | 2500   |
| 2  | B    | f   | 1500   |
| 3  | C    | m   | 5500   |
| 4  | D    | f   | 500    |

After running your update statement, the above salary table should have the following rows:

| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | f   | 2500   |
| 2  | B    | m   | 1500   |
| 3  | C    | f   | 5500   |
| 4  | D    | m   | 500    |

*/---------------------------------------------------------------------
USE QuestionBank
GO

DROP TABLE IF EXISTS dbo.salary 
GO

CREATE TABLE dbo.salary (
	id     INT        NOT NULL iDENTITY(1, 1)
  , name   VARCHAR(1) NOT NULL
  , sex    VARCHAR(1) NOT NULL
  , salary INT        NOT NULL
  CONSTRAINT PK_dbo_salary_id PRIMARY KEY(id)
)

INSERT INTO dbo.salary (name, sex, salary)
VALUES ('A', 'm', 2500)
     , ('B', 'f', 1500)
	 , ('C', 'm', 5500)
	 , ('D', 'f', 500)

SELECT * FROM dbo.salary

--1.
UPDATE S
SET sex = CASE WHEN sex = 'm' then 'f'
               WHEN sex = 'f' then 'm' END
FROM dbo.salary S

SELECT * FROM dbo.salary
