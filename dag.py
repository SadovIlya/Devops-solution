import sys
sys.path.append('/usr/local/airflow/.local/lib/python3.7/site-packages')
from datetime import datetime
from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator
from clickhouse_driver import Client
from airflow.utils.dates import days_ago

def insert():
    client = Client('54.202.79.82', port=32129 ) 
    result = client.execute("INSERT INTO default.geocoded_random (Latitude, Longitude) SELECT DISTINCT Latitude, Longitude FROM NYPD_Complaint")
    return(result)

def update():
    client = Client('54.202.79.82', port=32129 ) 
    result = client.execute("ALTER TABLE default.geocoded_random UPDATE random = rand()  WHERE Latitude IS NOT NULL")
    return(result)

def truncate():
    client = Client('54.202.79.82', port=32129 ) 
    result = client.execute("TRUNCATE TABLE default.geocoded_random")
    return(result)

dag = DAG('Clickhouse_db', description='Clickhouse DAG',          
          start_date=days_ago(0,0,0,0,0))

python_operator1 = PythonOperator(task_id='Clickhouse_truncate', python_callable=truncate, dag=dag)

python_operator2 = PythonOperator(task_id='Clickhouse_insert', python_callable=insert, dag=dag)

python_operator3 = PythonOperator(task_id='Clickhouse_update', python_callable=update, dag=dag)


python_operator1 >> python_operator2 >> python_operator3