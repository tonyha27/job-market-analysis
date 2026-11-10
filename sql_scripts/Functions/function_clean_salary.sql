-- LAST MODIFIED: 6/11/2026

/* 
This function preprocesses the raw salary data. It checks if the salary information is an hourly or yearly rate, and whether it is a range or a single number. 
It also handles dubious salary data; if the number is clearly wrong (such as extremely low or high values), then a NULL value is returned instead.
*/

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanSalary;
GO

CREATE FUNCTION dbo.CleanSalary
(
	@RawSalary VARCHAR(50)
)
RETURNS FLOAT
AS
BEGIN
	DECLARE 
		@StrippedSalary VARCHAR(50), -- Contains only the necessary numerical information, with all other characters stripped.
		@MinSalary FlOAT, -- The minimum salary in the range.
		@MaxSalary FLOAT, -- The maximum salary in the range.
		@AverageSalary FLOAT, -- The average salary of the range.
		@CleanedSalary FLOAT; -- The preprocessed salary value that will be returned. 
	SET @RawSalary = UPPER(@RawSalary); -- Standardise the salary text so that preprocessing becomes easier.
	IF @RawSalary LIKE '%H%' -- If salary is an hourly rate.
	BEGIN
		IF @RawSalary LIKE '%-%' -- If the hourly rate is a range.
		BEGIN
		    SET @StrippedSalary = REPLACE(TRANSLATE(@RawSalary, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ!$&()+:'',/', '                                    '), ' ', '');
			SET @MinSalary = TRY_CAST(LEFT(@StrippedSalary, CHARINDEX('-', @StrippedSalary) - 1) AS FLOAT);
			SET @MaxSalary = TRY_CAST(SUBSTRING(@StrippedSalary, CHARINDEX('-', @StrippedSalary) + 1, LEN(@StrippedSalary)) AS FLOAT);
			SET @AverageSalary = (@MinSalary + @MaxSalary)/2;
			SET @CleanedSalary = @AverageSalary*38*52 -- Convert to a yearly rate, assuming a work schedule of 38 hours per week and 52 weeks a year.
			IF @CleanedSalary < 50000 OR @CleanedSalary > 1000000 
				RETURN NULL;
		END
		ELSE -- If the hourly rate is a single number.
		BEGIN
			SET @StrippedSalary = REPLACE(TRANSLATE(@RawSalary, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ!$&()+:'',/', '                                    '), ' ', '');
			SET @CleanedSalary = TRY_CAST(@StrippedSalary AS FLOAT)*38*52; -- Convert to a yearly rate, assuming a work schedule of 38 hours per week and 52 weeks a year.
			IF @CleanedSalary < 50000 OR @CleanedSalary > 1000000
				RETURN NULL;
		END
	END
	ELSE -- If the salary is a yearly rate.
	BEGIN
		IF @RawSalary LIKE '%-%' -- If the yearly rate is a range.
		BEGIN
			SET @StrippedSalary = REPLACE(REPLACE(TRANSLATE(@RawSalary, 'ABCDEFGHIJLMNOPQRSTUVWXYZ!$&()+:'',/', '                                   '), 'K', '000'), ' ', '');
			SET @MinSalary = TRY_CAST(LEFT(@StrippedSalary, CHARINDEX('-', @StrippedSalary) - 1) AS FLOAT);
			SET @MaxSalary = TRY_CAST(SUBSTRING(@StrippedSalary, CHARINDEX('-', @StrippedSalary) + 1, LEN(@StrippedSalary)) AS FLOAT);
			SET @CleanedSalary = (@MinSalary + @MaxSalary)/2
			IF @CleanedSalary < 50000 OR @CleanedSalary > 1000000
				RETURN NULL;
		END
		ELSE -- If the yearly rate is a single number.
		BEGIN
			SET @StrippedSalary = REPLACE(REPLACE(TRANSLATE(@RawSalary, 'ABCDEFGHIJLMNOPQRSTUVWXYZ!$&()+:'',/', '                                   '), 'K', '000'), ' ', '');
			SET @CleanedSalary = TRY_CAST(@StrippedSalary AS FLOAT);
			IF @CleanedSalary < 50000 OR @CleanedSalary > 1000000
				RETURN NULL;
		END
	END
	RETURN @CleanedSalary;
END;
GO