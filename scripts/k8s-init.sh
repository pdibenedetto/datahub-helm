#!/usr/bin/env bash
set -euo pipefail

#source ~/.zshrc
echo $REGISTRY1_PASSWORD

kubectl create namespace datahub

kubectl create secret docker-registry dockerhub \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username="$DOCKERHUB_USERNAME" \
  --docker-password="$DOCKERHUB_TOKEN" \
  --docker-email="$DOCKERHUB_EMAIL" \
  -n datahub

kubectl create secret docker-registry ironbank-pull-secret \
  --docker-server=registry1.dso.mil \
  --docker-username="$REGISTRY1_USERNAME" \
  --docker-password="$REGISTRY1_PASSWORD" \
  --docker-email="$REGISTRY1_EMAIL" \
  -n datahub

kubectl create secret generic postgresql-secrets \
    --from-literal=postgres-password=datahub \
    --from-literal=password=datahub \
    --from-literal=replication-password=datahub \
    -n datahub

kubectl create secret docker-registry dockerhub \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username="$DOCKERHUB_USERNAME" \
  --docker-password="$DOCKERHUB_TOKEN" \
  --docker-email="$DOCKERHUB_EMAIL"

kubectl create secret docker-registry ironbank-pull-secret \
  --docker-server=registry1.dso.mil \
  --docker-username="$REGISTRY1_USERNAME" \
  --docker-password="$REGISTRY1_PASSWORD" \
  --docker-email="$REGISTRY1_EMAIL"

helm install prerequisites datahub/datahub-prerequisites \
    --values ./charts/prerequisites/values.yaml \
    -n datahub