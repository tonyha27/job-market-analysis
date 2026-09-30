/*
Map keywords to the following education levels:
	- No university degree
	- Undergraduate
	- Postgraduate
	- Docotoral
*/

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.MappingEducation;
GO

CREATE TABLE dbo.MappingEducation (
	Keyword VARCHAR(20),
	Education VARCHAR(20),
	Priority TINYINT -- In the event of multiple matches, choose the highest priority one
);
GO

INSERT INTO MappingEducation VALUES
('UNDERGRAD', 'Undergraduate', 1),
('BACHELOR', 'Undergraduate', 1), 
('POSTGRAD', 'Postgraduate', 2),
('MASTER''S', 'Postgraduate', 2),
('DOCTORAL', 'Doctoral', 3),
('PHD', 'Doctoral', 3),
('', 'No degree', 4)
GO