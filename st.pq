# streamlit_app.py

import streamlit as st
from google.oauth2 import service_account
from google.cloud import bigquery
from googleapiclient.discovery import build

# Create API client.
credentials = service_account.Credentials.from_service_account_info(
    st.secrets["gcp_service_account"]
)
client = bigquery.Client(credentials=credentials)

# Perform query.
# Uses st.cache_data to only rerun when the query changes or after 10 min.
@st.cache_data(ttl=600)
def run_query(query):
    query_job = client.query(query)
    rows_raw = query_job.result()
    # Convert to list of dicts. Required for st.cache_data to hash the return value.
    rows = [dict(row) for row in rows_raw]
    return rows

# Replace `your_project_id`, `your_dataset_id`, and `your_table_id` with your actual BigQuery table details.
#rows = run_query("SELECT * FROM `bq2409.c1_cse.c2` LIMIT 100")

rows = run_query("SELECT * FROM `bq2409.c1_cse.csep_pyq1` LIMIT 100")

# Print results.
st.write("Data from your BigQuery table:")
for row in rows:
    st.write(row)  # Adjust this to display specific fields if needed




