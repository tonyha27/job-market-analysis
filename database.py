
import os
import struct
import pyodbc

from azure.identity import ManagedIdentityCredential

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


def save_jobs(jobs):
    if not jobs:
        print("No jobs to save")
        return

    connection = connect_database()

    try:
        cursor = connection.cursor()

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

        print(f"Saved {len(jobs)} jobs to Azure SQL")

    except Exception:
        connection.rollback()
        raise

    finally:
        connection.close()
