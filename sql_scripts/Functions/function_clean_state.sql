-- LAST MODIFIED: 6/11/2026

-- This function preprocesses the raw location information and returns the state that the work is based in.

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanState;
GO

CREATE FUNCTION dbo.CleanState
(
	@State VARCHAR(100)
)
RETURNS VARCHAR(10)
AS
BEGIN
	Set @State = UPPER(@State); -- Standardise the location text so that preprocessing becomes easier.
	RETURN
		CASE 
            WHEN @State LIKE '%NEW SOUTH WALES%' OR @State LIKE '%SYDNEY%'
				THEN 'NSW'
			WHEN @State LIKE '%VICTORIA%' OR @State LIKE '%MELBOURNE%'
				THEN 'VIC'
			WHEN @State LIKE '%QUEENSLAND%' OR @State LIKE '%BRISBANE%'
				THEN 'QLD'
			WHEN @State LIKE '%WESTERN AUSTRALIA%' OR @State LIKE '%PERTH%'
				THEN 'WA'
			WHEN @State LIKE '%SOUTH AUSTRALIA%' OR @State LIKE '%ADELAIDE%'
				THEN 'SA'
			WHEN @State LIKE '%TASMANIA%' OR @State LIKE '%HOBART%'
				THEN 'TAS'
			WHEN @State LIKE '%AUSTRALIAN CAPITAL TERRITORY%' OR @State LIKE '%CANBERRA%'
				THEN 'ACT'
			WHEN @State LIKE '%NORTHERN TERRITORY%' OR @State LIKE '%DARWIN%'
				THEN 'NT'
			ELSE 'Unknown'
        END
END;
GO