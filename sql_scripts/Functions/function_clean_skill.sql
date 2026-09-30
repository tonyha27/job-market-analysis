-- Determines if the job requires the skill passed in as an argument

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanSkill;
GO

CREATE FUNCTION dbo.CleanSkill
(
	@Description VARCHAR(MAX),
	@Skill VARCHAR(20)
)
RETURNS BIT
AS
BEGIN
	IF @Description IS NOT NULL
	BEGIN
		RETURN
			CASE 
				WHEN UPPER(@Description) LIKE '%' + @Skill + '%' THEN 1
				ELSE 0
			END
	END
	RETURN NULL;
END;
GO



