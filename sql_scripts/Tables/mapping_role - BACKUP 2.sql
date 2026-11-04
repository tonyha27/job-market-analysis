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
	- Financial Analyst
	- Forecasting Analyst
	- Machine Learning Engineer 
	- Marketing Analyst
	- Operations Analyst 
	- Performance Analyst
	- Pricing Analyst
	- Product Analyst
	- Reporting Analyst 
	- Research Analyst 
	- Risk Analyst
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
('BI%SPECIALIST', 'Business Intelligence Developer', 1),
('BUSINESS INTELLIGENCE%DEVELOPER', 'Business Intelligence Developer', 1),
('BUSINESS INTELLIGENCE%SPECIALIST', 'Business Intelligence Developer', 1),
('BUSINESS%ANALY', 'Business Analyst', 1),
('DATA%ARCHITECT', 'Data Architect', 1),
('DATA ENGINEER', 'Data Engineer', 1),
('DATA%GOVERNANCE', 'Data Governance', 1),
('DATA%MANAGEMENT', 'Data Governance', 1),
('DATA%STEWARD', 'Data Governance', 1),
('DATA%QUALITY%ANALY', 'Data Quality Analyst', 1),
('DATA%SCIENTIST', 'Data Scientist', 1),
('DBA', 'Database Administrator', 1),
('DB ADMIN', 'Database Administrator', 1),
('DATABASE ADMIN', 'Database Administrator', 1),
('FINANC%ANALY', 'Financial Analyst', 1),
('COMMERC%ANALY', 'Financial Analyst', 1),
('FORECAST%ANALY', 'Forecasting Analyst', 1),
('ML ENGINEER', 'Machine Learning Engineer', 1),
('MACHINE LEARNING ENGINEER', 'Machine Learning Engineer', 1),
('MARKETING%ANALY', 'Marketing Analyst', 1),
('OPERATION%ANALY', 'Operations Analyst', 1),
('INVENTORY', 'Operations Analyst', 1),
('WORKFORCE', 'Operations Analyst', 1),
('PERFORMANCE', 'Performance Analyst', 1),
('PRIC%ANALY', 'Pricing Analyst', 1),
('PRODUCT ANALY', 'Product Analyst', 1),
('REPORTING%ANALY', 'Reporting Analyst', 1),
('RESEARCH%ANALY', 'Research Analyst', 1),
('RISK%ANALY', 'Risk Analyst', 1),
('RISK%MODEL', 'Risk Analyst', 1),
('CREDIT%ANALY', 'Risk Analyst', 1),
('SUPPLY CHAIN%ANALY', 'Supply Chain Analyst', 1),
('DATA%ANALY', 'Data Analyst', 2),
('BI ANALY', 'Data Analyst', 2),
('BUSINESS INTELLIGENCE ANALY', 'Data Analyst', 2),
('INSIGHT%ANALY', 'Data Analyst', 2),
('ANALYTICS', 'Data Analyst', 2), 
('', 'Other', 3);
GO













