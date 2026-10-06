/* SQL Agent jobs with latest execution result */
SELECT
    j.name AS job_name,
    j.enabled,
    h.run_date,
    h.run_time,
    h.run_status,
    h.message
FROM msdb.dbo.sysjobs AS j
LEFT JOIN
(
    SELECT
        job_id,
        run_date,
        run_time,
        run_status,
        message,
        ROW_NUMBER() OVER(PARTITION BY job_id ORDER BY instance_id DESC) AS rn
    FROM msdb.dbo.sysjobhistory
    WHERE step_id = 0
) AS h
ON j.job_id = h.job_id
AND h.rn = 1
ORDER BY j.name;
