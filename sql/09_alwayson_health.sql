/* Always On replica and database synchronization status */
SELECT
    ar.replica_server_name,
    ars.role_desc,
    ars.connected_state_desc,
    ars.operational_state_desc,
    ars.synchronization_health_desc,
    adc.database_name,
    drs.synchronization_state_desc,
    drs.synchronization_health_desc,
    drs.log_send_queue_size,
    drs.redo_queue_size
FROM sys.availability_replicas AS ar
JOIN sys.dm_hadr_availability_replica_states AS ars
    ON ar.replica_id = ars.replica_id
LEFT JOIN sys.availability_databases_cluster AS adc
    ON 1 = 1
LEFT JOIN sys.dm_hadr_database_replica_states AS drs
    ON adc.group_database_id = drs.group_database_id
    AND ar.replica_id = drs.replica_id
ORDER BY ar.replica_server_name, adc.database_name;
