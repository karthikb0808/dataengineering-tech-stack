FROM apache/airflow:2.10.4-python3.10

USER root

WORKDIR /data_project/airflow-ui

COPY entrypoint.sh /entrypoint.sh

EXPOSE 8080

RUN chmod +wrx /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "webserver" ]