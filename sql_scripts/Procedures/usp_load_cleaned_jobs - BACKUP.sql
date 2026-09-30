-- Creates a procedure that loads jobs from the cleaned table to the fact and dimension tables

USE JobMarket;
GO

DROP PROCEDURE IF EXISTS dbo.load_cleaned_jobs;
GO

CREATE PROCEDURE dbo.load_cleaned_jobs
AS
BEGIN

	BEGIN TRY
		BEGIN TRANSACTION;

		-- Load new companies into the company dimension table
		INSERT INTO DimCompany (CompanyName, Industry)
		SELECT cl.CompanyName, MAX(cl.Industry) AS Industry
		FROM CleanedJobs cl
		LEFT JOIN DimCompany co
			ON cl.CompanyName = co.CompanyName
		WHERE cl.Loaded = 0 AND co.CompanyID IS NULL
		GROUP BY cl.CompanyName;

		-- Load new locations into the location dimension table
		INSERT INTO DimLocation (Locality, State)
		SELECT DISTINCT c.Locality, c.State
		FROM CleanedJobs c
		LEFT JOIN DimLocation l
			ON c.Locality = l.Locality AND c.State = l.State
		WHERE c.Loaded = 0 AND l.LocationID IS NULL

		-- Load new jobs into the fact table
		INSERT INTO FactJobs 
		(
		JobDate,
		Title,
		Role,
		CompanyID,
		LocationID,
		EmploymentType,
		WorkType,
		Experience,
		Education,
		SQL,
		Excel,
		Python,
		R,
		PowerBI,
		Tableau,
		MachineLearning,
		Git,
		Salary
		)
		SELECT
			cl.JobDate,
			cl.Title,
			cl.Role,
			co.CompanyID,
			l.LocationID,
			cl.EmploymentType,
			cl.WorkType,
			cl.Experience,
			cl.Education,
			cl.SQL,
			cl.Excel,
			cl.Python,
			cl.R,
			cl.PowerBI,
			cl.Tableau,
			cl.MachineLearning,
			cl.Git,
			cl.Salary
		FROM CleanedJobs cl
		JOIN DimCompany co on cl.CompanyName = co.CompanyName
		JOIN DimLocation l on cl.Locality = l.Locality AND cl.State = l.State
		WHERE cl.loaded = 0

		-- Mark the unloaded jobs as loaded
		UPDATE CleanedJobs
		SET Loaded = 1
		WHERE Loaded = 0

		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
		 IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		PRINT 'Error loading cleaned data into fact and dimension tables.';
		PRINT ERROR_MESSAGE();
	END CATCH

END;
GO