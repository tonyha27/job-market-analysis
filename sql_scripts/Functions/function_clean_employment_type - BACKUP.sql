-- Cleans the employment type column from the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanEmploymentType;
GO

CREATE FUNCTION dbo.CleanEmploymentType
(
	@RawEmploymentType VARCHAR(50),
	@Description VARCHAR(MAX)
)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @CleanedEmploymentType VARCHAR(20);

	IF @Description IS NOT NULL
	BEGIN

		/*
		Get the employment type from the description column. 
		If the type cannot be determined from it then use the employment type column.
		*/
		SELECT TOP 1 @CleanedEmploymentType = EmploymentType
		FROM MappingEmploymentType
		WHERE UPPER(@Description) LIKE '%' + Keyword + '%'
		ORDER BY Priority;
		IF @CleanedEmploymentType = 'Other' AND @RawEmploymentType IS NOT NULL
			SELECT TOP 1 @CleanedEmploymentType = EmploymentType
			FROM MappingEmploymentType
			WHERE UPPER(@RawEmploymentType) LIKE '%' + Keyword + '%'
			ORDER BY Priority;

		RETURN @CleanedEmploymentType
	END
	
	-- If there is no description then use the employment type column
	SELECT TOP 1 @CleanedEmploymentType = EmploymentType
	FROM MappingEmploymentType
	WHERE UPPER(@RawEmploymentType) LIKE '%' + Keyword + '%'
	ORDER BY Priority;
	RETURN @CleanedEmploymentType;
END;
GO




