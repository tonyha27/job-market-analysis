-- Cleans the employment type column from the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanEmploymentType;
GO

CREATE FUNCTION dbo.CleanEmploymentType
(
	@EmploymentType VARCHAR(100)
)
RETURNS VARCHAR(20)
AS
BEGIN
	SET @EmploymentType = UPPER(@EmploymentType);
	RETURN
		CASE
			WHEN @EmploymentType LIKE '%FULL%' THEN 'Full-time'
			WHEN @EmploymentType LIKE '%PART%' THEN 'Part-time'			
			WHEN @EmploymentType LIKE '%CONTRACT%' Then 'Contract'			
			WHEN @EmploymentType LIKE '%TEMPORARY%' Then 'Temporay'			
			WHEN @EmploymentType LIKE '%INTERN%' Then 'Internship'			
			ELSE 'Other'
		END
END;
GO




