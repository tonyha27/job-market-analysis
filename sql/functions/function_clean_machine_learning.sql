-- LAST MODIFIED: 5/11/2026

-- Checks if a job listing requires machine learning skills based on its description.

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanMachineLearning;
GO

CREATE FUNCTION dbo.CleanMachineLearning
(
	@Description VARCHAR(MAX)
)
RETURNS BIT
AS
BEGIN
	IF @Description IS NOT NULL
	BEGIN
		SET @Description = UPPER(@Description) -- Standardise the description so that checking becomes easier. 
		RETURN
			CASE 
				WHEN @Description LIKE '%MACHINE LEARNING%' 
					OR @Description LIKE '% ML %' -- If 'ML' appears at the beginning or middle of a sentence.
					OR @Description LIKE '% ML.%' -- If 'ML' appears at the end of a sentence.
					THEN 1
				ELSE 0
			END
	END
	RETURN NULL;
END;
GO



