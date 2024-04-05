import pandas as pd
import pyarrow
import os

from google.cloud import bigquery


filepath = os.listdir('./2022/')

df_response = []

for item in filepath:
    df = pd.read_parquet(f"./2022/{item}", engine='pyarrow')
    print(df.shape)
    df_response.append(df)

df_response = pd.concat(df_response)
df_response.to_csv("output.csv")

bigquery_client = bigquery.Client()
table_id = 'weighty-rookery-413711.ny_taxi.green_taxi_data'

# # This example uses JSON, but you can use other formats.
# # See https://cloud.google.com/bigquery/loading-data
job_config = bigquery.LoadJobConfig(
    # source_format='NEWLINE_DELIMITED_JSON'
    source_format=bigquery.SourceFormat.CSV,
)

source_file_name = './output.csv'

with open(source_file_name, 'rb') as source_file:
    job = bigquery_client.load_table_from_file(
        source_file, table_id, job_config=job_config
    )

job.result() 

print(df_response.head())
print(df_response.shape)
