-- Extracts the role from the title columm in the staging table

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

	SELECT TOP 1 @CleanedRole = Role
	FROM MappingRole
	WHERE UPPER(@Title) LIKE '%' + Keyword + '%'
	ORDER BY Priority;

	RETURN @CleanedRole
END;
GO




