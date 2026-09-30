/*
Map keywords to the following employment types:
	- Full-time
	- Part-time
	- Contract
	- Temporary
	- Internship
	- Other
*/

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.MappingEmploymentType;
GO

CREATE TABLE dbo.MappingEmploymentType (
	Keyword VARCHAR(50),
	EmploymentType VARCHAR(20),
	Priority TINYINT -- In the event of multiple matches, choose the highest priority one
);
GO

INSERT INTO MappingEmploymentType VALUES
('FULL', 'Full-time', 1),
('PART', 'Part-time', 1),
('INTERNSHIP', 'Internship', 1),
('GRADUATE PROGRAMME', 'Graduate', 1),
('GRADUATE PROGRAM', 'Graduate', 1),
('', 'Other', 2)
GO