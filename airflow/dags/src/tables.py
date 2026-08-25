from sqlalchemy import inspect
from src.db_connections import get_connection

def list_tables_dellstore():
    conn = get_connection()
    list_tables = inspect(conn).get_table_names()
    return list_tables
