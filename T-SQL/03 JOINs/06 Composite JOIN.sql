
---------------------------------------------------------------------
-- Composite JOIN

-- A composite join is simply a join where you need to match multiple attributes from each side.

-- For a more tangible example, suppose you need to do some updates 
-- Because the relationship is based on multiple attributes, the join condition is composite. 
---------------------------------------------------------------------

FROM dbo.Table1 T1
INNER JOIN dbo.Table2 T2 ON T2.col1 = T1.col1 AND T2.col2 = T1.col1