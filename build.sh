#!/bin/bash
set -e

echo "Building Docker image for linux/amd64..."
docker buildx build --platform linux/amd64 -t devops-build:local --load .
echo "Build completed successfully."
