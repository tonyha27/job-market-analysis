-- Cleans the date column from the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanDate;
GO

/*
Assumes the argument is in one of the following formats:

	- % hour/s ago
	- % day/s ago
	- % week/s ago
	- % month/s ago

*/
CREATE FUNCTION dbo.CleanDate
(
	@JobDate VARCHAR(50)
)
RETURNS DATE
AS
BEGIN
	RETURN 
		CASE 
		-- If format is % hour/s ago, then subtract the number of hours from the current date
		WHEN @JobDate LIKE '%hour%'
			THEN TRY_CAST(DATEADD(HOUR, -CAST(LEFT(@JobDate, CHARINDEX('h', @JobDate) - 2) AS INT), GETDATE()) AS DATE)

		-- IF format is % day/s ago, then subtract the number of days from the current date
		WHEN @JobDate LIKE '%day%'
			THEN TRY_CAST(DATEADD(DAY, -CAST(LEFT(@JobDate, CHARINDEX('d', @JobDate) - 2) AS INT), GETDATE()) AS DATE)

		-- If format is % week/s ago, then subtract the number of days from the current date
		WHEN @JobDate LIKE '%week%'
			THEN TRY_CAST(DATEADD(WEEK, -CAST(LEFT(@JobDate, CHARINDEX('w', @JobDate) - 2) AS INT), GETDATE()) AS DATE)

		-- If format is % month/s ago, then subtract the number of days from the current date
		WHEN @JobDate LIKE '%month%'
			THEN TRY_CAST(DATEADD(MONTH, -CAST(LEFT(@JobDate, CHARINDEX('m', @JobDate) - 2) AS INT), GETDATE()) AS DATE)
		END
END;
GO



