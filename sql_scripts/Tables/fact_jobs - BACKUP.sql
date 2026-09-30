-- Create the fact table

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.FactJobs;
GO

CREATE TABLE dbo.FactJobs (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    JobDate DATE NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    CompanyID INT NOT NULL,
    LocationID INT NOT NULL,
    EmploymentType VARCHAR(20), 
    WorkType VARCHAR(20),
    Experience VARCHAR(10),
    Education VARCHAR(20),
    SQL BIT,
    Excel BIT,
    Python BIT,
    R BIT,
    PowerBI BIT,
    Tableau BIT,
    MachineLearning BIT,
    Git BIT,
    Salary FLOAT
    CONSTRAINT FK_FactJobs_DimDate FOREIGN KEY (JobDate) REFERENCES dbo.DimDate (DateValue),
    CONSTRAINT FK_FactJobs_DimCompany FOREIGN KEY (CompanyID) REFERENCES dbo.DimCompany (CompanyID),
    CONSTRAINT FK_FactJobs_DimLocation FOREIGN KEY (LocationID) REFERENCES dbo.DimLocation (LocationID),
);
GO