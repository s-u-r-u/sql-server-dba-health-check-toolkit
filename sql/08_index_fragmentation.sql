/* Index fragmentation overview */
SELECT
    DB_NAME(ps.database_id) AS database_name,
    OBJECT_SCHEMA_NAME(ps.object_id, ps.database_id) AS schema_name,
    OBJECT_NAME(ps.object_id, ps.database_id) AS table_name,
    i.name AS index_name,
    ps.index_type_desc,
    ps.avg_fragmentation_in_percent,
    ps.page_count
FROM sys.dm_db_index_physical_stats
(
    NULL, NULL, NULL, NULL, 'LIMITED'
) AS ps
JOIN sys.indexes AS i
    ON ps.object_id = i.object_id
    AND ps.index_id = i.index_id
WHERE ps.database_id > 4
  AND ps.page_count >= 1000
ORDER BY ps.avg_fragmentation_in_percent DESC;
