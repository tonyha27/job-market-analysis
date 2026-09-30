-- Cleans the date column from the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanDate;
GO

/*
Assumes the argument is in one of the following formats:
	- d/m/yy, for example 5/11/26 and 24/3/26
	- yyyy-mm-dd%, for example 2026-06-18T04:02:19.771Z
	- %h ago, for example 17h ago
	- %d ago, for example 3d ago
	- %m ago, for example 2m ago
*/
CREATE FUNCTION dbo.CleanDate
(
	@JobDate VARCHAR(50)
)
RETURNS DATE
AS
BEGIN
	SET @JobDate = LTRIM(REPLACE(UPPER(@JobDate), 'POSTED', '')) -- Remove the word 'Posted' in the beginning and make upper case 
	RETURN 
		CASE 
		-- If format is '%h ago' then subtract the number of hours from the current date
		WHEN @JobDate LIKE '%H%' 
			THEN TRY_CAST(DATEADD(HOUR, -CAST(LEFT(@JobDate, CHARINDEX('H', @JobDate) - 1) AS INT), GETDATE()) AS DATE)

	    -- If format is '%d ago' then subtract the number of days from the current date
		WHEN @JobDate LIKE '%D%' 
			THEN TRY_CAST(DATEADD(DAY, -CAST(LEFT(@JobDate, CHARINDEX('D', @JobDate) - 1) AS INT), GETDATE()) AS DATE)

		-- If format is '%m ago' then subtract the number of months from the current date
		WHEN @JobDate LIKE '%M%' 
			THEN TRY_CAST(DATEADD(MONTH, -CAST(LEFT(@JobDate, CHARINDEX('M', @JobDate) - 1) AS INT), GETDATE()) AS DATE)

		WHEN @JobDate LIKE '%/%' -- When this happens the date should be in the format d/m/yy
			THEN TRY_CONVERT(DATE, @JobDate, 3) 

		WHEN @JobDate LIKE '%-%' -- When this happens the date should be in the format yyyy-mm-dd%
			THEN TRY_CAST(LEFT(@JobDate, 10) AS DATE)   
		END
END;
GO



