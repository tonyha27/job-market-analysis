-- LAST MODIFIED: 6/11/2026

-- This procedure removes jobs from the staging table that are older than a specified threshold date. 

USE JobMarket;
GO

DROP PROCEDURE IF EXISTS dbo.delete_old_jobs;
GO

CREATE PROCEDURE dbo.delete_old_jobs
AS
BEGIN
	DECLARE @ThresholdDate DATE = DATEADD(MONTH, -1, GETDATE());
	DELETE FROM StagingJobs
	WHERE InsertedDate < @ThresholdDate;
END;
GO