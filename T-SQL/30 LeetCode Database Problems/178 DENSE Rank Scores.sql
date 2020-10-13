
/*---------------------------------------------------------------------
Exercise 178

Write a SQL query to rank scores. If there is a tie between two scores, both should have the same ranking. Note that after a tie, the next ranking number should be the next consecutive integer value. 
In other words, there should be no "holes" between ranks.

+----+-------+
| Id | Score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+
For example, given the above Scores table, your query should generate the following report (order by highest score):

+-------+---------+
| score | Rank    |
+-------+---------+
| 4.00  | 1       |
| 4.00  | 1       |
| 3.85  | 2       |
| 3.65  | 3       |
| 3.65  | 3       |
| 3.50  | 4       |
+-------+---------+
Important Note: For MySQL solutions, to escape reserved words used as column names, you can use an apostrophe before and after the keyword. For example `Rank`.

*/---------------------------------------------------------------------
USE QuestionBank
Go

DROP TABLE IF EXISTS dbo.Scores
CREATE TABLE dbo.Scores (
	Id    INT          NOT NULL IDENTITY(1,1)
  , Score NUMERIC(5,2) NOT NULL
  CONSTRAINT PK_Scores_Id PRIMARY KEY (Id)
)

INSERT INTO dbo.Scores (Score)
VALUES ('3.50')
      ,('3.65')
      ,('4.00')
      ,('3.85')
      ,('4.00')
      ,('3.65')

SELECT * FROM dbo.Scores

--1. 
DROP TABLE IF EXISTS #tmpCounter
CREATE TABLE #tmpCounter (
	Id        INT          NOT NULL IDENTITY(1,1)
  , Score     NUMERIC(5,2) NOT NULL
  , done      INT          NOT NULL DEFAULT 0
  , ScoreRank INT          NULL
  CONSTRAINT PK_Scores_Id PRIMARY KEY (Id)
)

INSERT INTO #tmpCounter (Score)
SELECT Score
FROM dbo.Scores 
ORDER BY Score DESC

SELECT * FROM #tmpCounter

DECLARE @Score NUMERIC(5,2)
DECLARE @Counter INT = 0

WHILE ((SELECT COUNT(*) FROM #tmpCounter WHERE done = 0) >= 1)
BEGIN

	SELECT @Score = MAX(Score)
	FROM #tmpCounter
	WHERE done = 0

	SET @Counter = @Counter + 1

	UPDATE #tmpCounter
	SET ScoreRank = @Counter
	   , done     = 1
	WHERE score = @Score

END

SELECT Score, ScoreRank 'Rank' FROM #tmpCounter

--1.
SELECT S1.Score
    , (SELECT COUNT(DISTINCT Score) FROM Scores)
	, (COUNT(DISTINCT s2.Score))
	, (SELECT COUNT(DISTINCT Score) FROM Scores) - (COUNT(DISTINCT s2.Score)) 'Rank'
FROM dbo.Scores S1
LEFT JOIN dbo.Scores S2 ON S2.Score < S1.Score
GROUP BY S1.Score
ORDER BY S1.Score DESC
