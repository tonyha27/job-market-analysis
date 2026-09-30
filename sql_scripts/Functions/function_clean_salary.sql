-- Cleans the salary column from the staging table

USE JobMarket;
GO

DROP FUNCTION IF EXISTS dbo.CleanSalary;
GO

CREATE FUNCTION dbo.CleanSalary
(
	@RawSalary VARCHAR(100)
)
RETURNS FLOAT
AS
BEGIN
	DECLARE 
		@Salary FLOAT,
		@StrippedSalary VARCHAR(100),
		@MinSalary FlOAT,
		@MaxSalary FLOAT,
		@AverageSalary FLOAT,
		@CleanedSalary FLOAT;
	SET @RawSalary = UPPER(@RawSalary);	
	IF @RawSalary LIKE '%H%' -- If salary is an hourly rate
	BEGIN
		IF @RawSalary LIKE '%-%' -- If the hourly rate is a range
		BEGIN
			-- We first remove unneccesary characters so that only the number range remain
		    SET @StrippedSalary = REPLACE(TRANSLATE(@RawSalary, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ!$&()+:'',/', '                                    '), ' ', '');
			SET @MinSalary = TRY_CAST(LEFT(@StrippedSalary, CHARINDEX('-', @StrippedSalary) - 1) AS FLOAT);
			SET @MaxSalary = TRY_CAST(SUBSTRING(@StrippedSalary, CHARINDEX('-', @StrippedSalary) + 1, LEN(@StrippedSalary)) AS FLOAT);
			SET @AverageSalary = (@MinSalary + @MaxSalary)/2;
			SET @CleanedSalary = @AverageSalary*38*52
			IF @CleanedSalary < 50000 OR @CleanedSalary > 1000000
				RETURN NULL;
		END
		ELSE -- If the hourly rate is a single number
		BEGIN
			-- We first remove unnecessary characters so that only the number remains
			SET @StrippedSalary = REPLACE(TRANSLATE(@RawSalary, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ!$&()+:'',/', '                                    '), ' ', '');
			SET @CleanedSalary = TRY_CAST(@StrippedSalary AS FLOAT)*38*52;
			IF @CleanedSalary < 50000 OR @CleanedSalary > 1000000
				RETURN NULL;
		END
	END
	ELSE -- If the salary is a yearly rate
	BEGIN
		IF @RawSalary LIKE '%-%' -- If the yearly rate is a range
			BEGIN
				SET @StrippedSalary = REPLACE(REPLACE(TRANSLATE(@RawSalary, 'ABCDEFGHIJLMNOPQRSTUVWXYZ!$&()+:'',/', '                                   '), 'K', '000'), ' ', '');
				SET @MinSalary = TRY_CAST(LEFT(@StrippedSalary, CHARINDEX('-', @StrippedSalary) - 1) AS FLOAT);
				SET @MaxSalary = TRY_CAST(SUBSTRING(@StrippedSalary, CHARINDEX('-', @StrippedSalary) + 1, LEN(@StrippedSalary)) AS FLOAT);
				SET @CleanedSalary = (@MinSalary + @MaxSalary)/2
				IF @CleanedSalary < 50000 OR @CleanedSalary > 1000000
					RETURN NULL;
			END
			ELSE -- If the yearly rate is a single number
			BEGIN
				SET @StrippedSalary = REPLACE(REPLACE(TRANSLATE(@RawSalary, 'ABCDEFGHIJLMNOPQRSTUVWXYZ!$&()+:'',/', '                                   '), 'K', '000'), ' ', '');
				SET @CleanedSalary = TRY_CAST(@StrippedSalary AS FLOAT);
				IF @CleanedSalary < 50000 OR @CleanedSalary > 1000000
					RETURN NULL;
			END
	END
	RETURN @CleanedSalary
END;
GO