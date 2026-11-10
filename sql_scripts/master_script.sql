-- LAST MODIFIED: 6/11/2026

-- Run all the scripts at once.

-- Create database
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\create_database.sql"

-- Create tables
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Tables\jobs.sql"
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Tables\staging_jobs.sql"
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Tables\mapping_role.sql"

-- Create functions
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Functions\function_clean_date.sql"
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Functions\function_clean_role.sql"
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Functions\function_clean_state.sql"
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Functions\function_clean_skill.sql"
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Functions\function_clean_excel.sql"
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Functions\function_clean_r.sql"
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Functions\function_clean_machine_learning.sql"
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Functions\function_clean_ai.sql"
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Functions\function_clean_salary.sql"

-- Create procedures
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Procedures\usp_transform_load.sql"
:r "C:\Users\haton\OneDrive\Documents\GitHub Projects\job-market-analysis\sql_scripts\Procedures\usp_delete_old_jobs.sql"