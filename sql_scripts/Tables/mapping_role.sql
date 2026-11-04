/*
Map keywords to the following roles in data & analytics profession:

	- BI Analyst/Developer
	- Business Analyst
	- Data Analyst
	- Data Engineer
	- Data Governance & Quality
	- Data Scientist
	- Financial Analyst
	- Marketing Analyst
	- Operations Analyst
	- Risk Analyst

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

('BI%ANALY', 'BI Analyst/Developer', 1),
('BI%DEVELOPER', 'BI Analyst/Developer', 1),
('BI%SPECIALIST', 'BI Analyst/Developer', 1),
('BUSINESS INTELLIGENCE', 'BI Analyst/Developer', 1),

('BUSINESS%ANALY', 'Business Analyst', 1),

('DATA ENGINEER', 'Data Engineer', 1),

('DATA%GOVERNANCE', 'Data Governance & Quality', 1),
('DATA%MANAGEMENT', 'Data Governance & Quality', 1),
('DATA%STEWARD', 'Data Governance & Quality', 1),
('DATA%QUALITY%ANALY', 'Data Governance & Quality', 1),

('DATA%SCIENTIST', 'Data Scientist', 1),

('FINANC%ANALY', 'Financial Analyst', 1),
('COMMERC%ANALY', 'Financial Analyst', 1),
('PRIC%ANALY', 'Financial Analyst', 1),

('MARKETING%ANALY', 'Marketing Analyst', 1),

('OPERATION%ANALY', 'Operations Analyst', 1),
('INVENTORY', 'Operations Analyst', 1),
('WORKFORCE', 'Operations Analyst', 1),
('PERFORMANCE', 'Operations Analyst', 1),
('SUPPLY CHAIN%ANALY', 'Operations Analyst', 1),

('RISK%ANALY', 'Risk Analyst', 1),
('RISK%MODEL', 'Risk Analyst', 1),
('CREDIT%ANALY', 'Risk Analyst', 1),

('DATA%ANALY', 'Data Analyst', 2),
('BI ANALY', 'Data Analyst', 2),
('BUSINESS INTELLIGENCE ANALY', 'Data Analyst', 2),
('INSIGHT%ANALY', 'Data Analyst', 2),
('PRODUCT ANALY', 'Data Analyst', 2),
('REPORTING%ANALY', 'Data Analyst', 2),
('ANALYTICS', 'Data Analyst', 2), 

('', 'Other', 3);
GO













