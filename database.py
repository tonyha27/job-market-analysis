# LAST MODIFIED: 9/11/2026

import os # Access environmental variables containing the Azure configuration. 
import struct # For Azure authentication purposes. 
import pyodbc # Connects Python to SQL Server and executes SQL queries. 
from azure.identity import ManagedIdentityCredential # Authenticates the application using an Aure Managed Identity. 

# This function authenticates our application using an Azure Managed Identity, in order to connect to an Azure SQL database in a logical server
# specified by the environmental variables.  
SQL_COPT_SS_ACCESS_TOKEN = 1256
def connect_database():
    server = os.environ["AZURE_SQL_SERVER"]
    database = os.environ["AZURE_SQL_DATABASE"]
    client_id = os.environ["AZURE_CLIENT_ID"]
    credential = ManagedIdentityCredential(
    client_id=client_id
    )
    token = credential.get_token(
        "https://database.windows.net/.default"
    ).token
    token_bytes = token.encode("utf-16-le")
    token_struct = struct.pack(
        "<I", len(token_bytes)
    ) + token_bytes
    connection_string = (
        "DRIVER={ODBC Driver 18 for SQL Server};"
        f"SERVER=tcp:{server},1433;"
        f"DATABASE={database};"
        "Encrypt=yes;"
        "TrustServerCertificate=no;"
        "Connection Timeout=30;"
    )

    return pyodbc.connect(
        connection_string,
        attrs_before={
            SQL_COPT_SS_ACCESS_TOKEN: token_struct
        }
    )

# Load the jobs into our staging table. 
def save_jobs(jobs):

    if not jobs:
        print("No jobs to save.")
        return

    connection = connect_database()

    try:
        cursor = connection.cursor() # Used to execute SQL statements and retrieve query results. 

        # For each job, store the information in the database. 
        for job in jobs:
            date = job["Date"]
            title = job["Title"]
            company = job["Company Name"]
            location = job["Location"]
            industry = job["Industry"]
            employment_type = job["Employment type"]
            seniority_level = job["Seniority level"]
            description = job["Description"]
            salary = job.get("Salary")

            cursor.execute(
                """
                INSERT INTO dbo.StagingJobs
                (
                    JobDate,
                    Title,
                    Company,
                    State,
                    Industry,
                    EmploymentType,
                    SeniorityLevel,
                    Description,
                    Salary
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """,
                date,
                title,
                company,
                location,
                industry,
                employment_type,
                seniority_level,
                description,
                salary
            )

        connection.commit()

        print(f"{len(jobs)} jobs saved to Azure SQL Database")

    except Exception:
        connection.rollback()
        raise

    finally:
        connection.close()