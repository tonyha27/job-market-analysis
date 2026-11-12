# DAX Measures

This document contains the DAX measures used inthe Job Market Analytics Power BI report.

## Total Jobs

Calculates the number of job postings.

```dax
Total Postings = 
/*
If a skill is filtered then we allow the filter to propagate via the function TREATAS(). Note that this is 
necessary as there is no relationship going from the Skills table to the Fact table. If no skills are filtered then 
we just use COUNTROWS(Jobs). 
*/
IF(
    ISFILTERED('Skills'[Skill]),
    CALCULATE(
        COUNTROWS(Jobs),
        TREATAS(
            VALUES('Jobs Skills Bridge'[Job Index]),
            Jobs[Index]
        )
    ),
    COUNTROWS(Jobs)
)
```

## % of Total Jobs

Calculates the percentage of postings for each category.

```dax
% Postings = DIVIDE(
                [Total Postings], 
                CALCULATE([Total Postings], ALLSELECTED()) // Use ALLSELECTED() to remove filters from the visual.
)
```

## Total Companies

Calculates the number of companies across all job listings.

```dax
Total Companies = 
/*
If a skill is filtered then we allow the filter to propagate via the function TREATAS(). Note that this is 
necessary as there is no relationship going from the Skills table to the Fact table. If no skills are filtered then 
we just use DISTINCTCOUNT(Jobs[Company Index]). 
*/
IF(
    ISFILTERED('Skills'[Skill]),
    CALCULATE(
        DISTINCTCOUNT(Jobs[Company Index]),
        TREATAS(
            VALUES('Jobs Skills Bridge'[Job Index]),
            Jobs[Index]
        )
    ),
    DISTINCTCOUNT(Jobs[Company Index])
)
```

## % Entry Level Jobs

This measures calculates the proportion of entry-level jobs. The denominator is the number of jobs for which the seniority level is known.

```dax
% Entry Level Jobs = 
VAR EntryLevelJobs = 
    CALCULATE(
        [Total Postings],
        'Seniority Levels'[Seniority Level] = "Entry level"
    )

VAR KnownSeniorityJobs = 
    CALCULATE(
        [Total Postings],
        'Seniority Levels'[Seniority Level] <> "Not Applicable"
    )

RETURN 
    DIVIDE(EntryLevelJobs, KnownSeniorityJobs)
```

## Average Salary

Calculates the average salary using the arithmetic mean.

```dax
Average Salary = 
/*
If a skill is filtered then we allow the filter to propagate via the function TREATAS(). Note that this is 
necessary as there is no relationship going from the Skills table to the Fact table. If no skills are filtered then 
we just use AVERAGE(Jobs[Salary]). 
*/
IF(
    ISFILTERED('Skills'[Skill]),
    CALCULATE(
        AVERAGE(Jobs[Salary]),
        TREATAS(
            VALUES('Jobs Skills Bridge'[Job Index]),
            Jobs[Index]
        )
    ),
    AVERAGE(Jobs[Salary])
)
```

## % of Total Jobs by Skill

Calculates the percentage of postings for each skill.

```dax
% Postings by Skill = DIVIDE(
                        COUNTROWS('Jobs Skills Bridge'),
                        COUNTROWS(Jobs)
)
```

## % of Total Jobs by State

Calculates the percentage of postings for each state. Only rows with known states are considered.

```dax
% Postings by State = DIVIDE(
                        [Total Postings],
                        CALCULATE([Total Postings], States[State] <> "Unkonwn")
)
```

## Total Jobs by Skill

Calculates the number of postings by each skill.

```dax
Postings by Skill = COUNTROWS('Jobs Skills Bridge')
```