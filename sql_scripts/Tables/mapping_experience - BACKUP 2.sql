/*
Map keywords to the following experience levels:
	- No experience (0 years)
	- Junior (1-2 years)
	- Mid-level (3-5 years)
	- Senior (6+ years)
*/

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.MappingExperience;
GO

CREATE TABLE dbo.MappingExperience (
	Keyword VARCHAR(50),
	Experience VARCHAR(10),
	Priority TINYINT -- In the event of multiple matches, choose the highest priority one
);
GO

INSERT INTO MappingExperience VALUES
('MORE THAN FIVE YEARS OF EXPERIENCE', '6+ years', 1),
('MORE THAN 5 YEARS OF EXPERIENCE', '6+ years', 1),
('GREATER THAN FIVE YEARS OF EXPERIENCE', '6+ years', 1),
('GREATER THAN 5 YEARS OF EXPERIENCE', '6+ years', 1),
('6 YEARS OF EXPERIENCE', '6+ years', 1),
('6+ YEARS OF EXPERIENCE', '6+ years', 1),
('SIX YEARS OF EXPERIENCE', '6+ years', 1),
('7 YEARS OF EXPERIENCE', '6+ years', 1),
('7+ YEARS OF EXPERIENCE', '6+ years', 1),
('SEVEN YEARS OF EXPERIENCE', '6+ years', 1),
('8 YEARS OF EXPERIENCE', '6+ years', 1),
('8+ YEARS OF EXPERIENCE', '6+ years', 1),
('EIGHT YEARS OF EXPERIENCE', '6+ years', 1),
('9 YEARS OF EXPERIENCE', '6+ years', 1),
('9+ YEARS OF EXPERIENCE', '6+ years', 1),
('NINE YEARS OF EXPERIENCE', '6+ years', 1),
('10 YEARS OF EXPERIENCE', '6+ years', 1),
('10+ YEARS OF EXPERIENCE', '6+ years', 1),
('TEN YEARS OF EXPERIENCE', '6+ years', 1),
('MORE THAN TWO YEARS OF EXPERIENCE', '3-5 years', 2),
('MORE THAN 2 YEARS OF EXPERIENCE', '3-5 years', 2),
('GREATER THAN TWO YEARS OF EXPERIENCE', '3-5 years', 2),
('GREATER THAN 2 YEARS OF EXPERIENCE', '3-5 years', 2),
('3 YEARS OF EXPERIENCE', '3-5 years', 2),
('3+ YEARS OF EXPERIENCE', '3-5 years', 2),
('THREE YEARS OF EXPERIENCE', '3-5 years', 2),
('4 YEARS OF EXPERIENCE', '3-5 years', 2),
('4+ YEARS OF EXPERIENCE', '3-5 years', 2),
('FOUR YEARS OF EXPERIENCE', '3-5 years', 2),
('5 YEARS OF EXPERIENCE', '3-5 years', 2),
('5+ YEARS OF EXPERIENCE', '3-5 years', 2),
('FIVE YEARS OF EXPERIENCE', '3-5 years', 2),
('1 YEAR OF EXPERIENCE', '1-2 years', 3),
('1+ YEAR OF EXPERIENCE', '1-2 years', 3),
('1+ YEARS OF EXPERIENCE', '1-2 years', 3),
('A YEAR OF EXPERIENCE', '1-2 years', 3),
('ONE YEAR OF EXPERIENCE', '1-2years', 3),
('2 YEARS OF EXPERIENCE', '1-2 years', 3),
('2+ YEARS OF EXPERIENCE', '1-2 years', 3),
('TWO YEARS OF EXPERIENCE', '1-2 years', 3),
('0 EXPERIENCE', '0', 4),
('NO EXPERIENCE', '0', 4),
('ZERO EXPERIENCE', '0', 4),
('INTERN', '0', 4),
('GRADUATE', '0', 4);
GO