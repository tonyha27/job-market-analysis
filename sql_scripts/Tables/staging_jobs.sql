-- Contains the raw job data 

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.StagingJobs;
GO

CREATE TABLE dbo.StagingJobs (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    JobDate VARCHAR(100) NOT NULL,
    InsertedDATE DATE DEFAULT GETDATE(),
    Title VARCHAR(200) NOT NULL,
    Company VARCHAR(200) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Industry VARCHAR(200),
    EmploymentType VARCHAR(100),
    Description VARCHAR(MAX),
    Salary VARCHAR(200),
    Processed BIT NOT NULL DEFAULT 0,
);
GO