-- LAST MODIFIED: 5/11/2026

-- Checks if a job listing requires AI skills based on its description.

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
	IF @Description IS NOT NULL -- If the job has a description, then check for AI skills and return 1 or 0 accordingly. Otherwise return "NULL".
	BEGIN
		SET @Description = UPPER(@Description) -- Standardise the description so that checking becomes easier. 
		RETURN
			CASE 
				WHEN @Description LIKE '%ARTIFICIAL INTELLIGENCE%' 
					OR @Description LIKE '% AI %' -- If 'AI' appears at the beginning or middle of a sentence.
					OR @Description LIKE '% AI.%' -- If 'AI' appears at the end of a sentence.
					 THEN 1
				ELSE 0
			END
	END
	RETURN NULL;
END;
GO



