/* Database and file size */
SELECT
    DB_NAME(database_id) AS database_name,
    name AS logical_file_name,
    type_desc,
    size * 8.0 / 1024 AS size_mb,
    physical_name
FROM sys.master_files
ORDER BY DB_NAME(database_id), type_desc, name;
