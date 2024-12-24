#!/bin/bash

# Check if the superset database already exists
DB_NAME1="superset"
psql -U "$POSTGRES_USER" -d nessie -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME1';" | grep -q 1

if [ $? -ne 0 ]; then
  # Database doesn't exist; create it
  echo "Creating database $DB_NAME1..."
  psql -U "$POSTGRES_USER" -d nessie -c "CREATE DATABASE $DB_NAME1;"
else
  echo "Database $DB_NAME1 already exists."
fi

# Check if the airflow database already exists
DB_NAME2="airflow"
psql -U "$POSTGRES_USER" -d nessie -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME2';" | grep -q 1

if [ $? -ne 0 ]; then
  # Database doesn't exist; create it
  echo "Creating database $DB_NAME2..."
  psql -U "$POSTGRES_USER" -d nessie -c "CREATE DATABASE $DB_NAME2;"
else
  echo "Database $DB_NAME2 already exists."
fi