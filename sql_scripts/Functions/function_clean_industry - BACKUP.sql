-- Cleans the industry column from the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanIndustry;
GO

CREATE FUNCTION dbo.CleanIndustry
(
	@RawIndustry VARCHAR(200)
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @CleanedIndustry VARCHAR(50);

	SELECT TOP 1 @CleanedIndustry = Industry
	FROM MappingIndustry
	WHERE UPPER(@RawIndustry) LIKE '%' + Keyword + '%';

	RETURN @CleanedIndustry
END;
GO




