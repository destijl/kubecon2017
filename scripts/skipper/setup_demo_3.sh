#!/bin/bash

export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)

# Create demo-3 cluster, w/ ABAC disabled, network policy enabled
gcloud container clusters create demo-3 --zone=us-west1-b --project=gcastle-gke-dev --no-enable-legacy-authorization --enable-network-policy

# Create Kubernetes objects
kubectl create ns payments
kubectl create ns signup
kubectl create -n payments -f ../../pyramidcorp/manifests/3_payments.yaml
kubectl create -n signup -f ../../pyramidcorp/manifests/3_signup.yaml
echo "KUBECONFIG=${KUBECONFIG}"
