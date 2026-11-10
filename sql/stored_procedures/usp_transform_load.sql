-- LAST MODIFIED: 6/11/2026

-- This procedure uses the functions developed in other SQL scripts to transform the raw data and load the resulting cleaned information into the fact table.

USE JobMarket;
GO

DROP PROCEDURE IF EXISTS dbo.transform_load;
GO

CREATE PROCEDURE dbo.transform_load
AS
BEGIN
    /*
    We encase the stored procedure logic within TRY...CATCH and SQL transaction statements to handle errors resulting from either the transform step or the 
    load step. If everything proceeds without errors then the procedure commits the transaction and saves the state. However, if any error occurs, then it will
    roll back to its previous state and cancel any transformation and loading steps that has been applied.
    */
    BEGIN TRY 
        BEGIN TRANSACTION; 
        /*
        The purose of this CTE is to extract the new jobs that have not been processed yet and to mark any duplicates within them. It will result in a subtable 
        of the staging table (mamely, those that have not been procssed yet), with an extra column that tells us whether a job is a duplicate. We achieve this by 
        using the window function ROW_NUMBER(). The idea is that, two jobs are considered duplicates if they share the same title, comapany, and state values. 
        For any job, the window function ROW_NUMBER() will assign the number 1 to the first instance of the job, and any other instance of the job that it comes 
        across will be assigned the numbers 2, 3, and so on. Therefore, the list of unique jobs with all duplicates removed, are the ones where their ROW_NUMBER()
        values are equal to 1. We will filter out the duplicate entries in FROM clause of the INSERT statement below. 
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
                        ORDER BY JobID
                    ) AS rn
            FROM dbo.StagingJobs
            WHERE Processed = 0
        )
	    INSERT INTO dbo.Jobs -- Insert preprocessed jobs into the fact table.
        (
        JobDate,
        Title, 
        Role,
        Company,       
        State,
        Industry, 
        EmploymentType, 
        SeniorityLevel, 
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
        /*
        In the SELECT clause of the INSERT statement, we apply the functions to transform the raw data so that they can be used by Power BI. Some columns in the 
        staging table are already in a cleaned state, and therefore appear as they are in the SELECT clause without any functions applied to them. 
        */
        SELECT 
            dbo.CleanDate(JobDate),
            UPPER(TRIM(Title)),
            dbo.CleanRole(Title),
            UPPER(TRIM(Company)), 
            dbo.CleanState(State),
            Industry,
            EmploymentType,
            SeniorityLevel,
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
        The FROM clause of the INSERT statement is where we filter the jobs from the staging table so that we only consider jobs that:
            - have not been processed yet
            - are relevant
            - are unique (no duplicate entries)
        */
        FROM DeduplicatedJobs d -- By considering jobs from the CTE table developed earlier, we only include those jobs that have not been processed yet.
        WHERE d.rn = 1 -- Recall that the list of jobs where their ROW_NUMBER() values are equal to 1 comprise unique jobs with no duplicate entries. 
        /*
        So far we have removed duplicates within the new batch of jobs form the staging table, and we are left with a list of such jobs that are unique.
        However, we also need to consider if any of these jobs are the same as those already in the fact table, and to remove them if so. 
        */
        AND NOT EXISTS 
        (
            SELECT 1
            FROM dbo.Jobs j
            WHERE j.Title = UPPER(TRIM(d.Title))
            AND j.Company = UPPER(TRIM(d.Company))
            AND j.State = dbo.CleanState(d.State)
        ) 
        /*
        This part filters relevant jobs. If a job contains a desciption, the job is deemed relevant if its description contains both the texts 'data' and 'analy'. 
        The second text accounts for 'analysis', 'analytics', and so on. If it does not contain a description, then we use its title instead. In this case, 
        it need not contain both of the texts. 
        */
        AND (
            (d.Description IS NOT NULL AND (UPPER(d.Description) LIKE '%DATA%' AND UPPER(d.Description) LIKE '%ANALY%'))
            OR 
            (d.Description IS NULL AND (UPPER(d.Title) LIKE '%DATA%' OR UPPER(d.Title) LIKE '%ANALY%'))
            );

        -- After we have processed the new jobs we label them as such.
        UPDATE StagingJobs
        SET Processed = 1
        WHERE Processed = 0;

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0 
		    ROLLBACK TRANSACTION;
		PRINT 'Error while transforming and loading data';
		PRINT ERROR_MESSAGE();
	END CATCH
END;
GO