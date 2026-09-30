-- Determines if the job requires machine learning from the description column in the staging table

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
		SET @Description = UPPER(@Description)
		RETURN
			CASE 
				WHEN @Description LIKE '%MACHINE LEARNING%' 
					OR @Description LIKE '% ML %' -- If 'ML' appears at the beginning or middle of a sentence
					OR @Description LIKE '% ML.%' -- If 'ML' appears at the end of a sentence
					 THEN 1
				ELSE 0
			END
	END
	RETURN NULL;
END;
GO



