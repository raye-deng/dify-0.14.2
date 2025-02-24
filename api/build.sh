#!/bin/bash

# Set variables
HARBOR_URL=""
HARBOR_USERNAME=""
HARBOR_PASSWORD=""
IMAGE_NAME="dify/dify-api"  # Replace with your desired image name
TAG=$(date +%Y%m%d%H%M%S)  # Use the current timestamp as the tag

# Login to Harbor
echo "Logging in to Harbor..."
echo $HARBOR_PASSWORD | docker login -u $HARBOR_USERNAME --password-stdin $HARBOR_URL

# Build the Docker image
echo "Building Docker image..."
docker buildx build --platform linux/amd64,linux/arm64 -t $HARBOR_URL/$IMAGE_NAME:$TAG -f ./Dockerfile --push .

# Push the Docker image to Harbor
echo "Pushing Docker image to Harbor..."
docker push $HARBOR_URL/$IMAGE_NAME:$TAG

echo "Build and push completed successfully."