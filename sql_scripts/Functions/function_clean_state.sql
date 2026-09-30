-- Cleans the state column from the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanState;
GO

CREATE FUNCTION dbo.CleanState
(
	@State VARCHAR(100)
)
RETURNS VARCHAR(6)
AS
BEGIN
	Set @State = UPPER(@State);
	RETURN
		CASE 
            WHEN @State LIKE '%NEW SOUTH WALES%' OR @State = 'NSW' OR @State LIKE 'NSW %' OR @State LIKE '% NSW %' OR @State LIKE '% NSW'
				THEN 'NSW'
			WHEN @State LIKE '%VICTORIA%' OR @State = 'VIC' OR @State LIKE 'VIC %' OR @State LIKE '% VIC %' OR @State LIKE '% VIC'
				THEN 'VIC'
			WHEN @State LIKE '%QUEENSLAND%' OR @State = 'QLD' OR @State LIKE 'QLD %' OR @State LIKE '% QLD %' OR @State LIKE '% QLD'
				THEN 'QLD'
			WHEN @State LIKE '%WESTERN AUSTRALIA%' OR @State = 'WA' OR @State LIKE 'WA %' OR @State LIKE '% WA %' OR @State LIKE '% WA'
				THEN 'WA'
			WHEN @State LIKE '%SOUTH AUSTRALIA%' OR @State = 'SA' OR @State LIKE 'SA %' OR @State LIKE '% SA %' OR @State LIKE '% SA'
				THEN 'SA'
			WHEN @State LIKE '%TASMANIA%' OR @State = 'TAS' OR @State LIKE 'TAS %' OR @State LIKE '% TAS %' OR @State LIKE '% TAS'
				THEN 'TAS'
			WHEN @State LIKE '%AUSTRALIAN CAPITAL TERRITORY%' OR @State = 'ACT' OR @State LIKE 'ACT %' OR @State LIKE '% ACT %' OR @State LIKE '% ACT'
				THEN 'ACT'
			WHEN @State LIKE '%NORTHERN TERRITORY%' OR @State = 'NT' OR @State LIKE 'NT %' OR @State LIKE '% NT %' OR @State LIKE '% NT'
				THEN 'NT'
			ELSE
				'REMOTE'
        END
END;
GO




