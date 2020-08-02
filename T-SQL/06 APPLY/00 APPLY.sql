
---------------------------------------------------------------------
-- APPLY

-- The APPLY operator operates on 2 input tables, left and right, The right table is typically a (correlated) derived table (subquery) or TVF.

-- With APPLY, the left side is evaluated first, and the right side is evaluated per row from the left.
-- Beacuse of the way APLLY works, there is no APPLY equivalent of a RIGHT JOIN
-- This is not possible with the JOIN as JOIN opeartes on 2 input tables and you can not refer on one side of elements to the other side.

-- One way to think of the CROSS APPLY operator is as a hybrid of a CROSS JOIN and a correlated subquery

-- The CROSS APPLY operator is similar to a CROSS JOIN,
-- only the inner query in the right input is allowed to have correlations to elements from the left input. 
-- The left input, like a CROSS JOIN, has to be self-contained.

--Uses: 1. TOP N Per Group
--      2. Reuse of column aliases
---------------------------------------------------------------------
SELECT <select_list>
FROM <left_input_table>
{CROSS | OUTER} APPLY <right_input_table> AS <alias>