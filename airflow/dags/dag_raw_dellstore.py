from airflow.sdk import dag, task
from airflow.providers.standard.operators.empty import EmptyOperator
from datetime import timedelta
import pendulum
from src.extract import extract_tables_dellstore
from src.tables import list_tables_dellstore

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

    list_tables = list_tables_dellstore()
    
    for table in list_tables:

        @task(task_id = f'{table}')
        def load_tables_dellstore(table_name, logical_date=None):
            
            partition_date = logical_date.in_timezone('Europe/Amsterdam').format('YYYY-MM-DD')
            return extract_tables_dellstore(table=table_name, partition_date=partition_date)
        
        raw_tables_dellstore = load_tables_dellstore(table_name=table)

        start >> raw_tables_dellstore >> end

dag_extraction_dellstore()
