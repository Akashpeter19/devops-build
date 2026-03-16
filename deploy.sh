#!/bin/bash
set -e

echo "Stopping old container if it exists..."
docker rm -f devops-build-container 2>/dev/null || true

echo "Starting new container on port 80..."
docker run -d \
  --name devops-build-container \
  --platform linux/amd64 \
  -p 80:80 \
  devops-build:local

echo "Deployment completed successfully."
docker ps --filter "name=devops-build-container"
