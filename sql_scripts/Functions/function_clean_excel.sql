-- Determines if the job requires Excel from the description column of the staging table

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
	    RETURN
		    CASE 
                WHEN UPPER(@Description) LIKE '%MICROSOFT EXCEL%'
                  OR UPPER(@Description) LIKE '%MS EXCEL%'
                  OR UPPER(@Description) LIKE '%EXCEL SPREADSHEET%'
                  OR (
                        UPPER(@Description) LIKE '%EXCEL%'
                     AND (
                            UPPER(@Description) LIKE '%SPREADSHEET'
                         OR UPPER(@Description) LIKE '%VLOOKUP%'
                         OR UPPER(@Description) LIKE '%PIVOT%'
                         OR UPPER(@Description) LIKE '%FORMULA%'
                     )
                  )
                THEN 1
                ELSE 0
            END
    END
    RETURN NULL;
END;
GO




