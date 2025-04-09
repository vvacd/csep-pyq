import streamlit as st
from google.cloud import bigquery
from google.oauth2 import service_account
import pandas as pd

# Convert secrets to a regular dict
service_account_info = dict(st.secrets["gcp_service_account"])

# Create credentials
credentials = service_account.Credentials.from_service_account_info(service_account_info)

# Set up BigQuery client
client = bigquery.Client(credentials=credentials, project=credentials.project_id)

# Query BigQuery
query = "SELECT * FROM `bq2409.c1_cse.csep_pyq1` LIMIT 10"
query_job = client.query(query)
results = query_job.result()

# Show results
df = results.to_dataframe()
st.write("BigQuery Results:")
st.dataframe(df)
