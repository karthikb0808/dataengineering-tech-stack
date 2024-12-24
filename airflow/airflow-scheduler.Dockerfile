FROM apache/airflow:2.10.4-python3.10

WORKDIR /data_project/airflow-schedular

CMD [ "airflow", "scheduler" ]