-- Creates a procedure that cleans raw jobs from the staging table

USE JobMarket;
GO

DROP PROCEDURE IF EXISTS dbo.transform_load;
GO

CREATE PROCEDURE dbo.transform_load
AS
BEGIN
    /* 
    The 'DeduplicatedJobs' CTE results in a table containing the new batch of rows from the staging table that have not been cleaned yet. 
    It has an extra column that will later be used to remove duplicated within the batch.
    */
    WITH DeduplicatedJobs AS
    (
        SELECT *,
               ROW_NUMBER() OVER
               (
                    PARTITION BY
                        UPPER(TRIM(Title)),
                        UPPER(TRIM(Company)),
                        dbo.CleanState(State)
                    ORDER BY (SELECT JobID)
                ) AS rn
        FROM dbo.StagingJobs
        WHERE Processed = 0
    )
	INSERT INTO dbo.Jobs
    (
    JobDate,
    Title, 
    Role,
    Company,       
    State,
    Industry, 
    EmploymentType, 
    Experience, 
    SQL, 
    Python,
    Excel, 
    R, 
    PowerBI, 
    Tableau, 
    MachineLearning, 
    DeepLearning,
    AI,
    Salary 
    )
    SELECT
        dbo.CleanDate(JobDate),
        UPPER(TRIM(Title)),
        dbo.CleanRole(Title),
        UPPER(TRIM(Company)), 
        dbo.CleanState(State),
        Industry,
        EmploymentType,
        dbo.CleanExperience(Description),
        dbo.CleanSkill(Description, 'SQL'),
        dbo.CleanSkill(Description, 'PYTHON'),
        dbo.CleanExcel(Description),
        dbo.CleanR(Description),
        dbo.CleanSkill(Description, 'POWER BI'),
        dbo.CleanSkill(Description, 'TABLEAU'),
        dbo.CleanMachineLearning(Description),
        dbo.CleanSkill(Description, 'DEEP LEARNING'),
        dbo.CleanAI(Description),
        dbo.CleanSalary(Salary)
    /*  
    The resultig table of the below FROM clause is a subset of the rows of the staging table that are:
        - not been cleaned yet
        - relevant jobs
        - not duplicates
    */
    FROM DeduplicatedJobs d
    WHERE d.rn = 1 -- If there are duplicate records in the uncleaned batch of jobs in the staging table then keep only one
    -- Keeps jobs not already in the cleaned table
    AND NOT EXISTS 
    (
        SELECT 1
        FROM dbo.Jobs j
        WHERE j.Title = UPPER(TRIM(d.Title))
        AND j.Company = UPPER(TRIM(d.Company))
        AND j.State = dbo.CleanState(d.State)
    ) 
    -- Determine whether the job is relevant based on the job description. If the description is null then use hte job title instead
    AND (
        (d.Description IS NOT NULL AND (UPPER(d.Description) LIKE '%DATA%' AND UPPER(d.Description) LIKE '%ANALY%'))
        OR 
        (d.Description IS NULL AND (UPPER(d.Title) LIKE '%DATA%' OR UPPER(d.Title) LIKE '%ANALY%'))
        );

    -- Label the processed jobs as cleaned
    UPDATE StagingJobs
    SET Processed = 1
    WHERE Processed = 0;
END;
GO