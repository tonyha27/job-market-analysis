-- Extract education data from the description column in the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanEducation;
GO

CREATE FUNCTION dbo.CleanEducation
(
	@Description VARCHAR(MAX)
)
RETURNS VARCHAR(20)
AS
BEGIN
	IF @Description IS NOT NULL
	BEGIN
		DECLARE @CleanedEducation VARCHAR(20);
		SELECT TOP 1 @CleanedEducation = Education
		FROM MappingEducation
		WHERE UPPER(@Description) LIKE '%' + Keyword + '%'
		ORDER BY Priority;

		RETURN @CleanedEducation
	END
	RETURN NULL;
END;
GO




