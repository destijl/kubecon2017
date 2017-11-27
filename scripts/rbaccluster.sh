#!/bin/bash

gcloud beta container clusters create rbaccluster --no-enable-legacy-authorization

# TODO: file bug about namespace not being respected in the schema.
kubectl create namespace frontend
kubectl -n frontend create -f frontend.yaml

kubectl create namespace payments
# Replace with real payments app
kubectl -n payments create -f payments.yaml
