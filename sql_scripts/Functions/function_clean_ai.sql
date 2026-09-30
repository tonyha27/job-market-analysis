-- Determines if the job requires AI skills from the description column in the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanAI;
GO

CREATE FUNCTION dbo.CleanAI
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
				WHEN @Description LIKE '%ARTIFICIAL INTELLIGENCE%' 
					OR @Description LIKE '% AI %' -- If 'ML' appears at the beginning or middle of a sentence
					OR @Description LIKE '% AI.%' -- If 'ML' appears at the end of a sentence
					 THEN 1
				ELSE 0
			END
	END
	RETURN NULL;
END;
GO



