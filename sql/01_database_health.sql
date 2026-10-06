/* Database health and availability */
SELECT
    name AS database_name,
    state_desc,
    recovery_model_desc,
    user_access_desc,
    compatibility_level,
    create_date
FROM sys.databases
ORDER BY name;
