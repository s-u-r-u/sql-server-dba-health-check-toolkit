# SQL Server DBA Health Check & Monitoring Toolkit

A reusable SQL Server DBA toolkit for routine health checks and proactive monitoring.

## Purpose

DBAs need a fast way to answer:

- Are databases online and healthy?
- When did each database last receive a full, differential, and log backup?
- Are SQL Server Agent jobs failing?
- Is there blocking?
- Are queries running for an unusually long time?
- Is index fragmentation high?
- Are database files or drives running low on space?
- Is an Always On Availability Group showing synchronization problems?

This repository provides read-only diagnostic T-SQL scripts and an optional PowerShell report wrapper.

## Technology

- Microsoft SQL Server 2016+
- T-SQL
- Dynamic Management Views (DMVs)
- SQL Server Agent metadata
- PowerShell

## Repository structure

```text
sql/
  01_database_health.sql
  02_database_size.sql
  03_backup_status.sql
  04_disk_space.sql
  05_sql_agent_jobs.sql
  06_blocking_sessions.sql
  07_long_running_queries.sql
  08_index_fragmentation.sql
  09_alwayson_health.sql
powershell/
  Generate-DBAHealthReport.ps1
sample-output/
  health-report.md
docs/
  troubleshooting-guide.md
```

## Prerequisites

- SQL Server login with permission to read the required DMVs and metadata.
- PowerShell 5.1+ for the optional PowerShell wrapper.
- For Always On checks, run the AG query on a replica that has the required HADR metadata access.

## Usage

Run the SQL scripts individually in SSMS. Start with:

1. Database health
2. Backup status
3. SQL Agent jobs
4. Blocking
5. Long-running queries
6. Storage
7. Index fragmentation
8. Always On health

These scripts are intended for lab/demo environments and general DBA diagnostics. Review queries before using them in production.

## What I learned

This project demonstrates how to turn common DBA checks into repeatable diagnostics instead of manually checking each database.

## Safety

No production data, credentials, company scripts, or server names are included.
