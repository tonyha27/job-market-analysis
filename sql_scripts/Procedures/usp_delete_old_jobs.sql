-- Creates a procedre that deletes old jobs from the staging table

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