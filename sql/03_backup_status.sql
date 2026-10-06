/* Last successful full, differential and log backup */
WITH BackupSummary AS
(
    SELECT
        database_name,
        MAX(CASE WHEN type = 'D' THEN backup_finish_date END) AS last_full_backup,
        MAX(CASE WHEN type = 'I' THEN backup_finish_date END) AS last_diff_backup,
        MAX(CASE WHEN type = 'L' THEN backup_finish_date END) AS last_log_backup
    FROM msdb.dbo.backupset
    GROUP BY database_name
)
SELECT *
FROM BackupSummary
ORDER BY database_name;
