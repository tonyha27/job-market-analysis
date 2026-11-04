-- Create the fact table

USE JobMarket;
GO

DROP TABLE IF EXISTS dbo.Jobs;
GO

CREATE TABLE dbo.Jobs (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    JobDate DATE NOT NULL,
    Title VARCHAR(200) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Company VARCHAR(200) NOT NULL,
    State VARCHAR(10) NOT NULL,
    Industry VARCHAR(200),
    EmploymentType VARCHAR(20),
    SeniorityLevel VARCHAR(20),
    SQL BIT,
    Python BIT,
    Excel BIT,
    R BIT,
    PowerBI BIT,
    Tableau BIT,
    MachineLearning BIT,
    DeepLearning BIT,
    AI BIT,
    Salary FLOAT
);
GO