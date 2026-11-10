-- LAST MODIFIED: 5/11/2026

-- Returns the role corresponding to the job listing based on its job title.

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanRole;
GO

CREATE FUNCTION dbo.CleanRole
(
	@Title VARCHAR(200)
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @CleanedRole VARCHAR(50);

	-- Retrieve the rows in the mapping table with matching keywords, and select the most relevant one among them (as determined by its priority).  
	SELECT TOP 1 @CleanedRole = Role
	FROM MappingRole
	WHERE UPPER(@Title) LIKE '%' + Keyword + '%'
	ORDER BY Priority;

	RETURN @CleanedRole
END;
GO