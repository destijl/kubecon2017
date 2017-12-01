#!/bin/bash

# Use a Kubeconfig specific so we don't clobber stuff
export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)

# Create demo-1 cluster, w/ ABAC enabled
gcloud container clusters create demo-1 --zone=us-west1-b --project=gcastle-gke-dev --enable-legacy-authorization

# Create Kubernetes objects
kubectl create -f ../../pyramidcorp/manifests/1_default.yaml
echo "KUBECONFIG=${KUBECONFIG}"
