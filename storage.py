
import os
import json
from datetime import datetime, timezone

from azure.identity import ManagedIdentityCredential
from azure.storage.blob import BlobServiceClient


def upload_jobs(jobs):
    account_name = os.environ["AZURE_STORAGE_ACCOUNT"]

    account_url = (
        f"https://{account_name}.blob.core.windows.net"
    )

    credential = ManagedIdentityCredential(client_id=os.environ["AZURE_CLIENT_ID"])

    blob_service = BlobServiceClient(
        account_url=account_url,
        credential=credential
    )

    container_client = blob_service.get_container_client(
        "job-postings"
    )

    timestamp = datetime.now(timezone.utc).strftime(
        "%Y%m%d_%H%M%S_%f"
    )

    blob_name = f"linkedin/jobs_{timestamp}.json"

    blob_client = container_client.get_blob_client(
        blob_name
    )

    data = json.dumps(
        jobs,
        ensure_ascii=False,
        default=str
    )

    blob_client.upload_blob(
        data,
        overwrite=False
    )

    print(f"Uploaded {len(jobs)} jobs to {blob_name}")
