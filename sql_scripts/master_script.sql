-- Run all the project scripts at once

-- Create database
--:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\create_database.sql"

-- Create tables
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Tables\jobs.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Tables\staging_jobs.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Tables\mapping_role.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Tables\mapping_experience.sql"

-- Create functions
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Functions\function_clean_date.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Functions\function_clean_role.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Functions\function_clean_state.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Functions\function_clean_experience.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Functions\function_clean_skill.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Functions\function_clean_excel.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Functions\function_clean_r.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Functions\function_clean_machine_learning.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Functions\function_clean_ai.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Functions\function_clean_salary.sql"

-- Create procedures
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Procedures\usp_transform_load.sql"
:r "C:\Users\haton\OneDrive\Documents\Job Market Analysis Project\Procedures\usp_delete_old_jobs.sql"

