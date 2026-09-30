-- Create the company dimension table

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.DimCompany;
GO

CREATE TABLE dbo.DimCompany (
    CompanyID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(100) UNIQUE NOT NULL,
    Industry VARCHAR(50)
);
GO