param(
    [Parameter(Mandatory=$true)]
    [string]$ServerInstance
)

Import-Module SqlServer -ErrorAction Stop

$queries = @{
    "DatabaseHealth" = "SELECT name,state_desc,recovery_model_desc,user_access_desc FROM sys.databases ORDER BY name;"
    "BackupStatus" = "SELECT database_name, MAX(CASE WHEN type='D' THEN backup_finish_date END) last_full_backup, MAX(CASE WHEN type='L' THEN backup_finish_date END) last_log_backup FROM msdb.dbo.backupset GROUP BY database_name;"
    "Blocking" = "SELECT session_id,blocking_session_id,wait_type,wait_time FROM sys.dm_exec_requests WHERE blocking_session_id <> 0;"
}

$out = Join-Path $PWD "health-report.csv"

foreach ($name in $queries.Keys) {
    $data = Invoke-Sqlcmd -ServerInstance $ServerInstance -Query $queries[$name]
    $data | Export-Csv -Path (Join-Path $PWD "$name.csv") -NoTypeInformation
}

Write-Host "Health-check reports generated in $PWD"
