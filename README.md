# Data Engineering Tech Stack: Learn Modern Data Engineering Tools

This repository provides a comprehensive environment to learn and practice modern data engineering concepts using Docker Compose. With this setup, you'll gain hands-on experience working with some of the most popular tools in the data engineering ecosystem. Whether you’re a beginner or looking to expand your skills, this tech stack offers everything you need to work with ETL/ELT pipelines, data lakes, querying, and visualization.

## What You Will Learn

- **Apache Spark**: Learn distributed data processing with one of the most powerful engines for large-scale data transformations.
- **Apache Iceberg**: Understand how to work with Iceberg tables for managing large datasets in data lakes with schema evolution and time travel.
- **Project Nessie**: Explore version control for your data lakehouse, allowing you to track changes to datasets just like Git for code.
- **Apache Airflow**: Master workflow orchestration and scheduling for complex ETL/ELT pipelines.
- **Trino**: Query your data from multiple sources (MinIO, PostgreSQL, Iceberg) with a fast federated SQL engine.
- **Apache Superset**: Create interactive dashboards and visualizations to analyze and present your data.
- **MinIO**: Learn about object storage and how it integrates with modern data pipelines, serving as your S3-compatible storage layer.
- **PostgreSQL**: Use a relational database for metadata management and storing structured data.

---

## Table of Contents
- [Overview](#overview)
- [What You Will Learn](#what-you-will-learn)
- [Services](#services)
  - [MinIO](#minio-object-storage)
  - [Airflow](#airflow)
  - [Extraction and Transformation](#extraction-and-transformation)
  - [PostgreSQL](#postgresql)
  - [Project Nessie](#project-nessie)
  - [Trino](#trino)
  - [Superset](#superset)
- [How to Run](#how-to-run)
- [Learning Objectives for Each Tool](#learning-objectives-for-each-tool)
- [Environment Variables](#environment-variables)
- [Troubleshooting](#troubleshooting)
- [License](#license)

---

## Services

### MinIO (Object Storage)
- **Purpose**: Acts as an S3-compatible object storage layer for raw and processed data.
- **What You’ll Learn**:
  - Uploading and managing files via the MinIO Console.
  - Using MinIO as a source and destination for ETL pipelines.
- **Console URL**: [http://localhost:9001](http://localhost:9001)

### Airflow
- **Purpose**: Workflow orchestration and ETL pipeline management.
- **What You’ll Learn**:
  - Building and scheduling DAGs (Directed Acyclic Graphs) to automate workflows.
  - Managing and monitoring pipelines through the Airflow web interface.
- **Web Interface URL**: [http://localhost:8081](http://localhost:8081)

### Extraction and Transformation
- **Purpose**: Run Spark and custom Python scripts for data ingestion and transformation.
- **What You’ll Learn**:
  - Writing Spark jobs to process large-scale datasets.
  - Using Python scripts to ingest and transform data into MinIO or PostgreSQL.

### PostgreSQL
- **Purpose**: A relational database for storing metadata, structured data, and managing transactions.
- **What You’ll Learn**:
  - Querying relational datasets using SQL.
  - Storing and retrieving structured data for analysis or visualization.

### Project Nessie
- **Purpose**: Version control for data lakes and Iceberg tables.
- **What You’ll Learn**:
  - Creating branches and commits for data changes.
  - Rolling back or time-traveling to previous versions of datasets.
- **API URL**: [http://localhost:19120](http://localhost:19120)

### Trino
- **Purpose**: A federated query engine for SQL-based exploration of multiple data sources.
- **What You’ll Learn**:
  - Querying data stored in MinIO, PostgreSQL, and Iceberg tables.
  - Using SQL to join data from different sources.
- **Web Interface URL**: [http://localhost:8080](http://localhost:8080)

### Superset
- **Purpose**: Visualization and dashboarding tool for creating insights from data.
- **What You’ll Learn**:
  - Building interactive dashboards connected to Trino and PostgreSQL.
  - Analyzing data through visualizations.
- **Dashboard URL**: [http://localhost:8088](http://localhost:8088)

---

## How to Run

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/username/dataengineering-tech-stack.git
   cd dataengineering-tech-stack

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
