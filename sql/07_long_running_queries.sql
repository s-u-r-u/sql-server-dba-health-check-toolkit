/* Currently executing requests with high elapsed time */
SELECT
    r.session_id,
    DB_NAME(r.database_id) AS database_name,
    r.status,
    r.start_time,
    DATEDIFF(SECOND, r.start_time, GETDATE()) AS elapsed_seconds,
    r.cpu_time,
    r.logical_reads,
    r.wait_type,
    r.wait_time,
    st.text AS sql_text
FROM sys.dm_exec_requests AS r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS st
WHERE r.session_id <> @@SPID
ORDER BY elapsed_seconds DESC;
