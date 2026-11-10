-- LAST MODIFIED: 6/11/2026

-- This is a staging table that stores the raw data from LinkedIn job listings.

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.StagingJobs;
GO

CREATE TABLE dbo.StagingJobs (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    JobDate VARCHAR(100) NOT NULL,
    InsertedDATE DATE DEFAULT GETDATE(),
    Title VARCHAR(200) NOT NULL,
    Company VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Industry VARCHAR(200),
    EmploymentType VARCHAR(50),
    SeniorityLevel VARCHAR(20),
    Description VARCHAR(MAX),
    Salary VARCHAR(50),
    Processed BIT NOT NULL DEFAULT 0,
);
GO