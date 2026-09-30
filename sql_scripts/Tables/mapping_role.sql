/*
Map keywords to the following roles in data analytics:

	- Analytics Engineer 
	- BI Developer 
	- Business Analyst 
	- Data Analyst 
	- Data Architect 
	- Data Engineer 
	- Data Governance 
	- Data Quality Analyst 
	- Data Scientist 
	- Database Administrator 
	- Machine Learning Engineer 
	- Operations Analyst 
	- Reporting Analyst 
	- Research Analyst 
	- Supply Chain Analyst 
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
('ANALYTICS%ENGINEER', 'Analytics Engineer', 1),
('BI%DEVELOPER', 'Business Intelligence Developer', 1),
('BUSINESS INTELLIGENCE%DEVELOPER', 'Business Intelligence Developer', 1),
('BUSINESS%ANALYST', 'Business Analyst', 1),
('DATA%ARCHITECT', 'Data Architect', 1),
('DATA%ENGINEER', 'Data Engineer', 1),
('DATA%GOVERNANCE%', 'Data Governance', 1),
('DATA%MANAGEMENT%', 'Data Governance', 1),
('DATA%STEWARD%', 'Data Governance', 1),
('DATA%QUALITY%ANALYST', 'Data Quality Analyst', 1),
('DATA%SCIENTIST', 'Data Scientist', 1),
('DBA', 'Database Administrator', 1),
('DB ADMIN', 'Database Administrator', 1),
('DATABASE ADMIN', 'Database Administrator', 1),
('ML ENGINEER', 'Machine Learning Engineer', 1),
('MACHINE LEARNING ENGINEER', 'Machine Learning Engineer', 1),
('OPERATION%ANALYST', 'Operations Analyst', 1),
('REPORTING%ANALYST', 'Reporting Analyst', 1),
('RESEARCH%ANALYST', 'Research Analyst', 1),
('SUPPLY CHAIN%ANALYST', 'Supply Chain Analyst', 1),
('DATA ANALYST', 'Data Analyst', 2),
('', 'Other', 3);
GO













