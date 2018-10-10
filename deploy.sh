#!/bin/bash

# Build Images of Docker
docker build -t widesoftware/multi-client:latest -t widesoftware/multi-client:${SHA} -f ./client/Dockerfile ./client
docker build -t widesoftware/multi-server:latest -t widesoftware/multi-server:${SHA} -f ./server/Dockerfile ./server
docker build -t widesoftware/multi-worker:latest -t widesoftware/multi-worker:${SHA} -f ./worker/Dockerfile ./worker

# Push then to repository
docker push widesoftware/multi-client:latest
docker push widesoftware/multi-client:${SHA}

docker push widesoftware/multi-server:latest
docker push widesoftware/multi-server:${SHA}

docker push widesoftware/multi-worker:latest
docker push widesoftware/multi-worker:${SHA}

# Deploy in Kubernetes Cluster
kubectl apply -f k8s/

# Forces creates new image (Could use bash to do so by sed commands)
kubectl set image deployments/server-deployment server=widesoftware/multi-server:${SHA}
kubectl set image deployments/client-deployment client=widesoftware/multi-client:${SHA}
kubectl set image deployments/worker-deployment worker=widesoftware/multi-client:${SHA}

