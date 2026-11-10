-- LAST MODIFIED: 5/11/2026

-- Checks if a job listing requires Excel skills based on its description.

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanExcel;
GO

CREATE FUNCTION dbo.CleanExcel
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
                WHEN @Description LIKE '%MICROSOFT EXCEL%'
                  OR @Description LIKE '%MS EXCEL%'
                  OR @Description LIKE '%EXCEL SPREADSHEET%'
                  OR (
                        @Description LIKE '%EXCEL%'
                     AND (
                            @Description LIKE '%SPREADSHEET'
                         OR @Description LIKE '%VLOOKUP%'
                         OR @Description LIKE '%PIVOT%'
                         OR @Description LIKE '%FORMULA%'
                     )
                  )
                THEN 1
                ELSE 0
            END
    END
    RETURN NULL;
END;
GO




