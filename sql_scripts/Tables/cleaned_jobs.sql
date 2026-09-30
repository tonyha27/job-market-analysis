-- Conains the the jobs that have been pre-processed from the staging table

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.CleanedJobs;
GO

CREATE TABLE dbo.CleanedJobs (
    JobDate DATE NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    CompanyName VARCHAR(100) NOT NULL,
    Industry VARCHAR(50),
    Locality VARCHAR(100) NOT NULL,
    State VARCHAR(6) NOT NULL,
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
    Salary FLOAT,
    Loaded BIT NOT NULL DEFAULT 0,
);
GO