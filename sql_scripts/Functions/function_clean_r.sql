-- Determines if the job requires R from the description column in the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanR;
GO

CREATE FUNCTION dbo.CleanR
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
				-- Return 1 when 'R' is mentioned at the beginning, middle, or end of a sentence, otherwise return 0
				WHEN @Description LIKE '% R %' OR @Description LIKE '% R.%' THEN 1
				ELSE 0
			END
	END
	RETURN NULL;
END;
GO



