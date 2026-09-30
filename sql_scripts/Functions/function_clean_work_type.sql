-- Cleans the work type column from the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanWorkType;
GO

CREATE FUNCTION dbo.CleanWorkType
(
	@WorkType VARCHAR(100)
)
RETURNS VARCHAR(10)
AS
BEGIN
	SET @WorkType = UPPER(@WorkType);
	RETURN
		CASE
			WHEN @WorkType LIKE '%REMOTE%'
				THEN 'Remote'
			WHEN @WorkType LIKE '%HYBRID%'
				THEN 'Hybrid'
			WHEN @WorkType LIKE '%SITE%' or @WorkType LIKE '%PREMISE%'
				Then 'On-premise'
		END
END;
GO




