/* Current blocking relationships */
SELECT
    r.session_id,
    r.blocking_session_id,
    DB_NAME(r.database_id) AS database_name,
    r.status,
    r.wait_type,
    r.wait_time,
    r.wait_resource,
    s.login_name,
    s.host_name,
    s.program_name,
    st.text AS sql_text
FROM sys.dm_exec_requests AS r
JOIN sys.dm_exec_sessions AS s
    ON r.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS st
WHERE r.blocking_session_id <> 0
ORDER BY r.wait_time DESC;
