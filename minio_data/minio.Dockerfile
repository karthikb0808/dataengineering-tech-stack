FROM minio/minio:RELEASE.2024-12-13T22-19-12Z

# Set the working directory (optional, just for organizational purposes)
WORKDIR /data_project/minio

# Expose the port (Optinal, just for reference, already specified in docker-compose file)
EXPOSE 9000 9001

# Run the MinIO server
CMD [ "server", "/data_project/data", "--console-address", ":9001"]