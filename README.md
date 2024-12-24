# Data Engineering Tech Stack

This repository provides a Docker Compose file for a complete data engineering environment. It covers data ingestion, storage, transformations, governance, and visualization. The main tools are:

1. **MinIO (Object Storage)**
2. **Airflow (Workflow Orchestration)**
3. **PostgreSQL (Relational Database)**
4. **Project Nessie (Data Version Control)**
5. **Trino (SQL Query Engine)**
6. **Apache Superset (Data Visualization)**
7. **Custom Python-based Ingestion & Transformation Services**

## Table of Contents
- [Overview](#overview)
- [Services](#services)
  - [object-storage (MinIO)](#object-storage-minio)
  - [airflow](#airflow)
  - [airflow-scheduler](#airflow-scheduler)
  - [extraction](#extraction)
  - [postgres](#postgres)
  - [nessie](#nessie)
  - [transformation](#transformation)
  - [trino](#trino)
  - [superset](#superset)
- [How to Run](#how-to-run)
- [Environment Variables](#environment-variables)
- [Volumes and Data Persistence](#volumes-and-data-persistence)
- [Health Checks](#health-checks)
- [Troubleshooting](#troubleshooting)
- [License](#license)

---

## Overview

This Compose file stands up a multi-container environment suitable for learning and practicing data engineering concepts. It demonstrates how different components can be orchestrated together—object storage for landing raw data, a relational database for storing metadata and structured data, a workflow orchestrator for scheduling ETL/ELT tasks, a query engine for federated querying, and a data visualization tool for insights.

---

## Services

Below is a breakdown of each service as defined in the `docker-compose.yml` file.

### object-storage (MinIO)
- **Purpose**: Acts as your on-premise (or local) S3-compatible object storage.  
- **Ports**:  
  - `9000`: MinIO’s main API endpoint.  
  - `9001`: MinIO Console UI for administration.
- **Data**:  
  - Mounted under `./minio_data:/data_project/data:rw` for persistence.
- **Environment Variables**:  
  - Stored in `.env/minio.env`.

### airflow
- **Purpose**: The Airflow webserver, allowing you to view and manage your DAGs.  
- **Ports**:
  - `8081` mapped to the Airflow webserver’s default `8080`.
- **Volumes**:  
  - `./airflow/dags:/opt/airflow/dags`  
  - `./airflow/plugins:/opt/airflow/plugins`  
  - `./airflow/logs:/opt/airflow/logs`  
- **Environment Variables**:  
  - Stored in `.env/airflow.env`.
- **Depends on**: `postgres` to ensure the Airflow metadata DB is up.

### airflow-scheduler
- **Purpose**: Runs as a separate container to schedule DAG tasks.  
- **Shares** the DAGs, plugins, and logs volumes with the main Airflow container.  
- **Depends on**: `postgres` so the scheduler sees the same database.

### extraction
- **Purpose**: A custom service (built from `ingestion.Dockerfile`) responsible for ingesting or extracting data into MinIO.  
- **Ports**:  
  - `8888`: Typically for a Jupyter or other web-based environment if included.
- **Volumes**:  
  - Maps `./ingestion:/data_project/ingestion`.
- **Environment Variables**:  
  - Stored in `.env/minio.env` so it can connect to MinIO.  
- **Depends on**: `object-storage` and `airflow` so the ingestion process can rely on both.

### postgres
- **Purpose**: Main relational database for metadata (e.g., Airflow’s backend), plus any additional staging or OLTP data as needed.  
- **Ports**:
  - `5432`: PostgreSQL default.
- **Volumes**:  
  - `./postgres/postgres_data:/var/lib/postgresql/data:rw` for persistent storage.  
- **Environment Variables**:  
  - Stored in `.env/postgres.env`.

### nessie
- **Purpose**: Project Nessie manages data version control, enabling you to track changes to tables or files in data lakes/lakehouses.  
- **Ports**:
  - `19120`: Nessie’s main API.
- **Environment Variables**:  
  - Stored in `.env/nessie.env`.
- **Depends on**: `postgres`, `object-storage`, `airflow`.

### transformation
- **Purpose**: A Spark or Python-based container (based on `transformation.Dockerfile`) for running transformations on data read from MinIO or Nessie.  
- **Ports**:  
  - `8889`: Possibly a Jupyter environment.  
  - `4040`: Spark UI.  
  - `7070`: Custom or additional port.  
- **Volumes**:  
  - `./transformation:/data_project/transformation`.
- **Environment Variables**:  
  - Stored in `.env/minio.env`.
- **Depends on**: All key data services—`object-storage`, `postgres`, `nessie`, `airflow`.

### trino
- **Purpose**: A federated query engine that can query data from multiple sources, including MinIO (via Hive connector), Nessie, PostgreSQL, etc.  
- **Ports**:
  - `8080`: Trino CLI/Web UI.
- **Volumes**:
  - `./trino/etc:/etc/trino:rw` for configuration files.  
  - `./trino/data:/var/trino:rw` for local data.
- **Environment Variables**:  
  - Stored in `.env/minio.env`.
- **Restart Policy**:
  - `always` ensures it restarts if something goes wrong.

### superset
- **Purpose**: Data exploration and visualization. Connects to Trino, PostgreSQL, or other databases for dashboards.  
- **Ports**:
  - `8088`: Superset’s web UI.
- **Environment Variables**:
  - Merged from `.env/postgres.env` (for the DB connection) and `.env/superset.env`.
- **Depends on**: `postgres`, `trino`, `nessie`, `airflow`.

---

## How to Run

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/username/dataengineering-tech-stack.git
   cd dataengineering-tech-stack
   ```
2. **Set Environment Variables**
    - Fill in your configurations in .env/airflow.env, .env/minio.env, .env/postgres.env, etc.

3. **Build & Start Services**
    ``` bash
      docker-compose up -d --build
    ```

4. **Access Servies**
   - MinIO Console: http://localhost:9001
   - Airflow Web UI: http://localhost:8081
   - PostgreSQL: localhost:5432
   - Nessie: http://localhost:19120
   - Trino: http://localhost:8080
   - Superset: http://localhost:8088
