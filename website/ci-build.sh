#!/usr/bin/env bash
set -euo pipefail

VERSION=$(<version.txt)
IMAGE_NAME="${IMAGE_NAME:-bayazee/k8s-sample-app-website}"

# We can use other values fpor tags. For example git tag, commit hash, etc.
TAG="${VERSION}"
FULL_IMAGE="${IMAGE_NAME}:${TAG}"

CONTAINER_NAME="website-ci-test"


# Check if Docker is installed
# If we don't have DinD in our CI/CD pipeline, we can use other options like Kaniko or BuildKit
command -v docker >/dev/null || { echo "Docker is required but not installed."; exit 1; }

##### Build Docker image #####

echo "Building Docker image: $FULL_IMAGE"
docker build -t "$FULL_IMAGE" .

##### Make sure no container is running with the same name #####
stop_container() {
    docker stop "$CONTAINER_NAME" || true
    docker rm "$CONTAINER_NAME" || true
}


##### Test 1 #####
# Run container and check if it starts successfully
echo "Running test container: $CONTAINER_NAME"
docker run -d --rm -p 8080:80 --name "$CONTAINER_NAME" "$FULL_IMAGE"

echo "Waiting for container to start..."
sleep 3

echo "Testing HTTP response..."
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/)

stop_container

if [[ "$STATUS_CODE" != "200" ]]; then
  echo "Test failed: expected HTTP 200, got $STATUS_CODE"
  docker stop "$CONTAINER_NAME" || true
  exit 1
fi

##### Test 2 #####
# Run container with environment variables and verify output
echo "Running test with environment variables..."

docker run -d --rm -p 8081:80 \
  -e ENVIRONMENT="test-env" \
  -e SECRET_MESSAGE="test-secret" \
  --name "$CONTAINER_NAME" "$FULL_IMAGE"

sleep 2

RESPONSE=$(curl -s http://localhost:8081)

stop_container

if [[ "$RESPONSE" == *"test-env"* && "$RESPONSE" == *"test-secret"* ]]; then
  echo "Environment variable test passed."
else
  echo "Environment variable test failed!"
  echo "Response:"
  echo "$RESPONSE"
  exit 1
fi

echo "Test passed: NGINX returned HTTP 200"

echo "Cleaning up test container..."
stop_container


##### Push Docker image to Docker Hub #####
echo "Pushing image to Docker Hub: $FULL_IMAGE"
docker push "$FULL_IMAGE"

echo "Build, test, and push completed successfully."