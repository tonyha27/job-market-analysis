# Data Ecosystem

The following diagram shows the architecture and infrastructure of the project. It illustrates its end-to-end ETL (extract, transform, and load) pipeline and contains all of its major components. 

!(data_ecosystem.png)

We describe the process and some of methodology hereafter. 

## Data Extraction

The first step in the whole process is the Docker image, which is first built locally form the Dockerfile in this repository. It is then pushed to the Azure Container Registry, which is a Microsoft cloud service that allows for storage, management, and distribution of Docker container images. 

The Container Apps Job then pulls (downloads) the docker image from the Container Registry, and is what allows us to run our python scripts on the cloud as a containerised workload. The Container Apps Environment is simply just a place where all the containerised workloads are stored. In our project we only use the one workload. The two main functions that are executed by this workload are scrape_linkedin() and save_jobs(), which scrapes linkedin for jobs and saves them into our database respectively. 

Once the Contianer Apps Job has finished, the raw job data will have been loaded into the Azure SQL database, which is stored in a Azure SQL logical server. More specifically, it is stored in the staging table, to prepare it for data transformaiton. Periodically, old jobs from the staging table are deleted to save space. This is done via a SQL stored procedure, which is hosted on Azure Logic Apps (a Microsoft cloud service for automating workflows). 

## Data Transformation

The raw data from the staging table is preprocessed via another stored procedure in Logic Apps. The stored procedure consists of serveral user defined fuctions that contains the actual cleaning logic. Each function cleans a single column from the staging table. 

## Data Loading

Once the stored procedure has finished, the cleaned data are then loaded into the fact table, which is the table that is actually used inside the Power BI report. All the SQL stored procedures and functions mentioned can be found in the 'sql' folder in this repository.

The Power BI report uses Import mode instead of DirectQuery, and so requires a manual refresh to load the latest data and for up-to-date insights. On the other hand, the ETL process itself is fully automated by the Azure cloud service. 