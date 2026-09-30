-- Create the date dimension table

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.DimDate;
GO

CREATE TABLE dbo.DimDate (
    DateValue DATE PRIMARY KEY,
    MonthNumber  TINYINT NOT NULL,
    MonthName VARCHAR(9) NOT NULL,
    Year SMALLINT NOT NULL
);
GO

-- Insert contiguous dates starting from a given date and lasting for a given duration. 
DECLARE @StartDate DATE = '2024-01-01'; -- Starting date 
DECLARE @Days INT = 4*365; -- Duration    
;WITH Tally AS (
    SELECT value as n
    FROM GENERATE_SERIES(0, @Days - 1)
)
INSERT INTO dbo.DimDate(DateValue, MonthNumber, MonthName, Year)
SELECT
    d = DATEADD(DAY, n, @StartDate),
    MONTH(DATEADD(DAY, n, @StartDate)),
    DATENAME(MONTH, DATEADD(DAY, n, @StartDate)),
    YEAR(DATEADD(DAY, n, @StartDate))
FROM Tally
ORDER BY d;
GO


