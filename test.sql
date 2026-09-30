-- BE CAREFUL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- truncate table dbo.stagingjobs;

--truncate table dbo.CleanedJobs;

--truncate table dbo.FactJobs;

--delete from dbo.DimCompany;

--delete from dbo.DimLocation;

--delete from dbo.DimDate;

-- BE CAREFUL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

update dbo.StagingJobs
set Cleaned = 0
where Cleaned = 1;


select * from dbo.stagingjobs;

select * from dbo.Jobs;

exec dbo.clean_staging_jobs
exec dbo.load_cleaned_jobs

grant exec to n8n_user_job_market

select * from dbo.CleanedJobs order by State;

select count(*) from dbo.StagingJobs;


SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;