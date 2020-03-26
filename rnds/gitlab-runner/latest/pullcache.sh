#!/bin/sh

export IMAGE="$1"
export TAG="$2"

echo Pulling from [${IMAGE}:latest] cache...
echo docker pull ${IMAGE}:latest
docker pull ${IMAGE}:latest &> /dev/null || true

echo Pulling from [${IMAGE}:${TAG}] cache...
echo docker pull ${IMAGE}:${TAG}
docker pull ${IMAGE}:${TAG} &> /dev/null || true
echo cache ok