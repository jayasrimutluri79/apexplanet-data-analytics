import sqlite3
import pandas as pd

def create_connection(db_path):
    return sqlite3.connect(db_path)

def load_data_to_database(csv_path, db_path, table_name="superstore"):
    df = pd.read_csv(csv_path)
    conn = create_connection(db_path)
    df.to_sql(table_name, conn, if_exists="replace", index=False)
    conn.close()
    return df.shape

def run_query(db_path, query):
    conn = create_connection(db_path)
    result = pd.read_sql(query, conn)
    conn.close()
    return result
