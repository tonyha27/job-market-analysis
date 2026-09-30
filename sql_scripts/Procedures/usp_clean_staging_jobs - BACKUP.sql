-- Creates a procedure that cleans raw jobs from the staging table

USE JobMarket;
GO

DROP PROCEDURE IF EXISTS dbo.clean_staging_jobs;
GO

CREATE PROCEDURE dbo.clean_staging_jobs
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
                        UPPER(TRIM(CompanyName)),
                        dbo.CleanState(State)
                    ORDER BY (SELECT JobID)
                ) AS rn
        FROM dbo.StagingJobs
        WHERE Cleaned = 0
    )
	INSERT INTO dbo.CleanedJobs
    (
    JobDate,
    Title, 
    Role,
    CompanyName, 
    Industry, 
    Locality, 
    State,  
    EmploymentType, 
    WorkType, 
    Experience, 
    Education, 
    SQL, 
    Excel, 
    Python, 
    R, 
    PowerBI, 
    Tableau, 
    MachineLearning, 
    Git, 
    Salary 
    )
    SELECT
        dbo.CleanDate(JobDate),
        UPPER(TRIM(Title)),
        dbo.CleanRole(Title),
        UPPER(TRIM(CompanyName)), 
        dbo.CleanIndustry(Industry),
        UPPER(TRIM(Locality)),
        dbo.CleanState(State), 
        dbo.CleanEmploymentType(EmploymentType, Description),
        dbo.CleanWorkType(WorkType),
        dbo.CleanExperience(Description),
        dbo.CleanEducation(Description),
        dbo.CleanSkill(Description, 'SQL'),
        dbo.CleanExcel(Description),
        dbo.CleanSkill(Description, 'PYTHON'),
        dbo.CleanR(Description),
        dbo.CleanSkill(Description, 'POWER BI'),
        dbo.CleanSkill(Description, 'TABLEAU'),
        dbo.CleanSkill(Description, 'STATISTICS'),
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
        FROM dbo.CleanedJobs c
        WHERE c.Title = UPPER(TRIM(d.Title))
        AND c.CompanyName = UPPER(TRIM(d.CompanyName))
        AND c.State = dbo.CleanState(d.State)
    ) 
    -- Determine whether the job is relevant based on the job description. If the description is null then use hte job title instead
    AND (
        (d.Description IS NOT NULL AND (UPPER(d.Description) LIKE '%DATA%' OR UPPER(d.Description) LIKE '%ANALY%'))
        OR 
        (d.Description IS NULL AND (UPPER(d.Title) LIKE '%DATA%' OR UPPER(d.Title) LIKE '%ANALY%'))
        );

    -- Label the processed jobs as cleaned
    UPDATE StagingJobs
    SET Cleaned = 1
    WHERE Cleaned = 0;
END;
GO