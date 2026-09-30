/*
Map keywords to the following roles in data analytics:
	- Data Scientist
	- Data Engineer
	- Data Officer
	- Finance Analyst
	- Business Analyst
	- Reporting Analyst
	- Data Architect
	- Data Quality Analyst
	- Machine Learning Engineer
	- Business Intelligence Developer
	- Database Administrator
	- Data Analyst
	- Other
*/

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.MappingRole;
GO

CREATE TABLE dbo.MappingRole (
	Keyword VARCHAR(50),
	Role VARCHAR(50),
	Priority TINYINT -- In the event of multiple matches, choose the highest priority one
);
GO

INSERT INTO MappingRole VALUES
('DATA%SCIENTIST', 'Data Scientist', 1),
('DATA%ENGINEER', 'Data Engineer', 1),
('DATA%OFFICER', 'Data Officer', 1),
('FINANC%ANALYST', 'Finance Analyst', 1),
('BUSINESS%ANALYST', 'Business Analyst', 1),
('REPORTING%ANALYST', 'Reporting Analyst', 1),
('DATA%ARCHITECT', 'Data Architect', 1),
('DATA%QUALITY%ANALYST', 'Data Quality Analyst', 1),
('ML ENGINEER', 'Machine Learning Engineer', 1),
('MACHINE LEARNING ENGINEER', 'Machine Learning Engineer', 1),
('BI%DEVELOPER', 'Business Intelligence Developer', 1),
('BUSINESS INTELLIGENCE%DEVELOPER', 'Business Intelligence Developer', 1),
('DBA', 'Database Administrator', 1),
('DB ADMIN', 'Database Administrator', 1),
('DATABASE ADMIN', 'Database Administrator', 1),
('DATA ANALYST', 'Data Analyst', 1),
('BUSINESS INTELLIGENCE%ANALYST', 'Data Analyst', 1),
('BI%ANALYST', 'Data Analyst', 1),
('', 'Other', 2);
GO













