
/*---------------------------------------------------------------------
Exercise 620

X city opened a new cinema, many people would like to go to this cinema. The cinema also gives out a poster indicating the movies’ ratings and descriptions.
Please write a SQL query to output movies with an odd numbered ID and a description that is not 'boring'. Order the result by rating.

For example, table cinema:

+---------+-----------+--------------+-----------+
|   id    | movie     |  description |  rating   |
+---------+-----------+--------------+-----------+
|   1     | War       |   great 3D   |   8.9     |
|   2     | Science   |   fiction    |   8.5     |
|   3     | irish     |   boring     |   6.2     |
|   4     | Ice song  |   Fantacy    |   8.6     |
|   5     | House card|   Interesting|   9.1     |
+---------+-----------+--------------+-----------+

For the example above, the output should be:
+---------+-----------+--------------+-----------+
|   id    | movie     |  description |  rating   |
+---------+-----------+--------------+-----------+
|   5     | House card|   Interesting|   9.1     |
|   1     | War       |   great 3D   |   8.9     |
+---------+-----------+--------------+-----------+

*/---------------------------------------------------------------------
USE QuestionBank
GO

--EVEN
SELECT 2 % 2 
SELECT 4 % 2
SELECT 6 % 2

--ODD
SELECT 1 % 2
SELECT 3 % 2
SELECT 5 % 2

DROP TABLE IF EXISTS dbo.cinema
GO

CREATE TABLE dbo.cinema (
	id          INT          NOT NULL IDENTITY(1,1)
  , movie       VARCHAR(20)  NOT NULL
  , description VARCHAR(20)  NOT NULL
  , rating      NUMERIC(5,2) NOT NULL
  CONSTRAINT PK_dbo_cinema_id PRIMARY KEY (id)
)

INSERT INTO dbo.cinema (movie, description, rating)
VALUES ('War'       , 'great 3D'   , 8.9)
     , ('Science'   , 'fiction'    , 8.5)
	 , ('irish'     , 'boring'     , 6.2)
	 , ('Ice song'  , 'Fantacy'    , 8.6)
	 , ('House card', 'Interesting', 9.1)

SELECT * FROM dbo.cinema

--1.
SELECT * 
FROM dbo.cinema
WHERE id % 2 = 1 AND description != 'boring'