#!/bin/sh

export IMAGE="$1"
export TAG="$2"

echo Pushing [${IMAGE}:${TAG}] to registry...
echo docker push ${IMAGE}:${TAG}
docker push ${IMAGE}:${TAG} > /dev/null
echo cache ok