import pandas as pd
from sqlalchemy import inspect
from src.db_connections import get_connection


def extract_tables_dellstore(table, partition_date=None):

    conn = get_connection()

    df = pd.read_sql_table(table, con=conn)
    send_s3 = df.to_parquet(f's3://lakehouse-dellstore/bronze/{table}/{partition_date}', engine='pyarrow')

    return send_s3
