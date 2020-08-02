GETDATE()

COUNT()

COUNT(*) returns the number of items in a group. This includes NULL values and duplicates.

COUNT(ALL expression) evaluates expression for each row in a group, and returns the number of nonnull values.

COUNT(DISTINCT expression) evaluates expression for each row in a group, and returns the number of unique, nonnull values.

For return values exceeding 2^31-1, COUNT returns an error. For these cases, use COUNT_BIG instead.

COUNT is a deterministic function when used without the OVER and ORDER BY clauses. It is nondeterministic when used with the OVER and ORDER BY clauses