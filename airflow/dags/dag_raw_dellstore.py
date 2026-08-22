from airflow.sdk import dag, task
from airflow.sdk import get_current_context
from airflow.providers.standard.operators.empty import EmptyOperator
from datetime import timedelta
import pendulum
from sqlalchemy import inspect
from src.extract import extract_tables_dellstore
from src.db_connections import get_connection

@dag(
        
    dag_id = 'dag_raw_dellstore',
    schedule = '@hourly',
    start_date = pendulum.datetime(2026,8,20, tz='Europe/Amsterdam'),
    catchup = False,
    tags = ['Raw DAG DellStore'],

    default_args={
        "depends_on_past": False,
        "retries": 1,
        "retry_delay": timedelta(minutes=5),
    },

)

def dag_extraction_dellstore():

    start = EmptyOperator(task_id = 'start')
    end = EmptyOperator(task_id = 'end')

    conn = get_connection()
    list_tables = inspect(conn).get_table_names()

    @task(task_id = 'raw_dellstore', map_index_template="{{ table_name }}")
    def load_tables_dellstore(table_name, logical_date=None):
        context = get_current_context()
        context["table_name"] = table_name

        partition_date = logical_date.in_timezone('Europe/Amsterdam').format('YYYY-MM-DD')
        return extract_tables_dellstore(table=table_name, partition_date=partition_date)

    raw_tables = load_tables_dellstore.expand(table_name=list_tables)

    start >> raw_tables >> end

dag_extraction_dellstore()
