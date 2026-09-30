-- Contains the raw job data 

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.StagingJobs;
GO

CREATE TABLE dbo.StagingJobs (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    JobDate VARCHAR(50) NOT NULL,
    InsertedDATE DATE DEFAULT GETDATE(),
    Title VARCHAR(100) NOT NULL,
    CompanyName VARCHAR(100) NOT NULL,
    Industry VARCHAR(200),
    Locality VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    EmploymentType VARCHAR(50),
    WorkType VARCHAR(50),
    Salary VARCHAR(100),
    Description VARCHAR(MAX),
    Cleaned BIT NOT NULL DEFAULT 0,
);
GO