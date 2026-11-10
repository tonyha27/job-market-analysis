-- LAST MODIFIED: 5/11/2026

-- Preprocess the date so that it is in the standard format yyyy-mm-dd.

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanDate;
GO

/*
We handle the different date formats used by LinkedIn separately.

	- X minute/s ago
	- X hour/s ago
	- X day/s ago
	- X week/s ago
	- X month/s ago

*/

CREATE FUNCTION dbo.CleanDate
(
	@JobDate VARCHAR(100)
)
RETURNS DATE
AS
BEGIN
	RETURN 
		CASE 
		-- If the format is 'X minute/s ago', then subtract the number of minutes from the current date.
		WHEN @JobDate LIKE '%minute%'
			THEN TRY_CAST(DATEADD(MINUTE, -CAST(LEFT(@JobDate, CHARINDEX('m', @JobDate) - 2) AS INT), GETDATE()) AS DATE)

		-- If the format is 'X hour/s ago', then subtract the number of hours from the current date.
		WHEN @JobDate LIKE '%hour%'
			THEN TRY_CAST(DATEADD(HOUR, -CAST(LEFT(@JobDate, CHARINDEX('h', @JobDate) - 2) AS INT), GETDATE()) AS DATE)

		-- IF the format is 'X day/s ago', then subtract the number of days from the current date.
		WHEN @JobDate LIKE '%day%'
			THEN TRY_CAST(DATEADD(DAY, -CAST(LEFT(@JobDate, CHARINDEX('d', @JobDate) - 2) AS INT), GETDATE()) AS DATE)

		-- If the format is 'X week/s ago', then subtract the number of days from the current date.
		WHEN @JobDate LIKE '%week%'
			THEN TRY_CAST(DATEADD(WEEK, -CAST(LEFT(@JobDate, CHARINDEX('w', @JobDate) - 2) AS INT), GETDATE()) AS DATE)

		-- If the format is 'X month/s ago', then subtract the number of days from the current date.
		WHEN @JobDate LIKE '%month%'
			THEN TRY_CAST(DATEADD(MONTH, -CAST(LEFT(@JobDate, CHARINDEX('m', @JobDate) - 2) AS INT), GETDATE()) AS DATE)
		END
END;
GO



