
---------------------------------------------------------------------
-- SET Operators

-- Set operators are operators that combine rows from two query result sets

-- T-SQL supports the following operators: 
-- 1. UNION
-- 2. UNION ALL
-- 3. INTERSECT 
-- 4. EXCEPT

-- In a query that contains multiple set operators, first INTERSECT operators are evaluated, and then operators with the same precedence are evaluated based on their order of appearance.

-- The queries involved cannot have ORDER BY clauses, you can optionally add an ORDER BY clause to the result of the operator.

-- The two input queries must produce results with the same number of columns, and corresponding columns must have compatible data types.

-- Standard SQL supports two “flavors” of each operator—DISTINCT (the default) and ALL.
-- The DISTINCT flavor eliminates duplicates and returns a set.
-- ALL doesn’t attempt to remove duplicates and therefore returns a multiset.
---------------------------------------------------------------------
Input Query1
<set_operator>
Input Query2
[ORDER BY ...];