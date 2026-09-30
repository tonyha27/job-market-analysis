-- Extracts experience data from the description column in the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanExperience;
GO

CREATE FUNCTION dbo.CleanExperience
(
	@Description VARCHAR(MAX)
)
RETURNS VARCHAR(10)
AS
BEGIN
	IF @Description IS NOT NULL
	BEGIN
		DECLARE @CleanedExperience VARCHAR(10);

		SELECT TOP 1 @CleanedExperience = Experience
		FROM MappingExperience
		WHERE UPPER(@Description) LIKE '%' + Keyword + '%'
		ORDER BY Priority;

		RETURN @CleanedExperience
	END

	RETURN NULL;
END;
GO




