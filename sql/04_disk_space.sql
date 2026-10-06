/* SQL Server volume free-space information */
SELECT
    vs.volume_mount_point,
    vs.total_bytes / 1073741824.0 AS total_gb,
    vs.available_bytes / 1073741824.0 AS available_gb,
    CAST(vs.available_bytes * 100.0 / NULLIF(vs.total_bytes,0) AS decimal(5,2)) AS free_percent
FROM sys.master_files AS mf
CROSS APPLY sys.dm_os_volume_stats(mf.database_id, mf.file_id) AS vs
GROUP BY vs.volume_mount_point, vs.total_bytes, vs.available_bytes
ORDER BY free_percent ASC;
