/*
Map keywords to the following industries:
	- Techonology
	- Finance
	- Healthcare
	- Retail
	- Manufacturing
	- Mining, Energy & Utilities
	- Government & Public Sector
	- Education
	- Telecommunications
	- Transportation
	- Construction & Real Estate
	- Consulting & Professional Services
	- Marketing, Media & Entertainmnet
	- Hospitality & Tourism
	- Agriculture
	- Human Resources & Recruitment
	- Non-profit
	- Defence & Aerospace
	- Science & Research
	- Other
*/

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.MappingIndustry;
GO

CREATE TABLE dbo.MappingIndustry (
	Keyword VARCHAR(20),
	Industry VARCHAR(50)
);
GO

INSERT INTO MappingIndustry VALUES
('TECH', 'Technology'),
('IT', 'Technology'),
('FINANCE', 'Finance'),
('BANKING', 'Finance'),
('INSURANCE', 'Finance'),
('SUPERANNUATION', 'Finance'),
('HEALTH', 'Healthcare'),
('PHARMA', 'Healthcare'),
('RETAIL', 'Retail'),
('COMMERCE', 'Retail'),
('SALE', 'Retail'),
('CONSUMER GOODS', 'Retail'),
('MANUFACTURING', 'Manufacturing'),
('MINING', 'Mining, Energy & Utilities'),
('ENERGY', 'Mining, Energy & Utilities'),
('UTILITIES', 'Mining, Energy & Utilities'),
('OIL', 'Mining, Energy & Utilities'),
('GAS', 'Mining, Energy & Utilities'),
('ELECTRICITY', 'Mining, Energy & Utilities'),
('WATER', 'Mining, Energy & Utilities'),
('GOVERNMNET', 'Governmnet & Public Sector'),
('PUBLIC', 'Governmnet & Public Sector'),
('EDUCATION', 'Education'),
('TEACH', 'Education'),
('TELECOMMUNICATION', 'Telecommunications'),
('INTERNET', 'Telecommunications'),
('TRANSPORT', 'Transportation'),
('LOGISTIC', 'Transportation'),
('SHIPPING', 'Transportation'),
('AIRLINE', 'Transportation'),
('SUPPLY CHAIN', 'Transportation'),
('CONSTRUCTION' , 'Construction & Real Estate'),
('REAL ESTATE', 'Construction & Real Estate'),
('CONSULTING', 'Consulting & Professional Services'),
('PROFESSIONAL SERVICE', 'Consulting & Professional Services'),
('LEGAL', 'Consulting & Professional Services'),
('BUSINESS ADVISORY', 'Consulting & Professional Services'),
('MARKETING', 'Marketing, Media & Entertainment'),
('MEDIA', 'Marketing, Media & Entertainment'),
('ENTERTAINMENT', 'Marketing, Media & Entertainment'),
('ADVERTISING', 'Marketing, Media & Entertainment'),
('PUBLISHING', 'Marketing, Media & Entertainment'),
('GAMING', 'Marketing, Media & Entertainment'),
('BROADCAST', 'Marketing, Media & Entertainment'),
('HOSPITALITY', 'Hospitality & Tourism'),
('TOURISM', 'Hospitality & Tourism'),
('HOTEL', 'Hospitality & Tourism'),
('RESTAURANT', 'Hospitality & Tourism'),
('TRAVEL', 'Hospitality & Tourism'),
('AGRICULTURE', 'Agriculture'),
('FORESTRY', 'Agriculture'),
('FISHERIES', 'Agriculture'),
('HUMAN RESOURCES', 'Human Resources & Recruitment'),
('HR', 'Human Resources & Recruitment'),
('RECRUIT', 'Human Resources & Recruitment'),
('NON-PROFIT', 'Non-profit'),
('COMMUNITY SERVICE', 'Non-profit'),
('CHARITY', 'Non-profit'),
('CHARITIES', 'Non-profit'),
('NGO', 'Non-profit'),
('SOCIAL SERVICE', 'Non-profit'),
('DEFENCE', 'Defence & Aerospace'),
('DEFENSE', 'Defence & Aerospace'),
('AEROSPACE', 'Defence & Aerospace'),
('SECURITY', 'Defence & Aerospace'),
('SCIENCE', 'Science & Research'),
('RESEARCH', 'Science & Research');
GO