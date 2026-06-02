#!/usr/bin/env bash
set -euo pipefail

kubectl create namespace datahub

kubectl create secret docker-registry dockerhub \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username="$DOCKERHUB_USERNAME" \
  --docker-password="$DOCKERHUB_TOKEN" \
  --docker-email="$DOCKERHUB_EMAIL" \
  -n datahub

kubectl create secret generic postgresql-secrets \
    --from-literal=postgres-password=datahub \
    --from-literal=password=datahub \
    --from-literal=replication-password=datahub \
    -n datahub
