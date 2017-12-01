#!/bin/bash

# Use a Kubeconfig specific to demo-2 so we don't clobber stuff
export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)

# Create demo-2 cluster, w/ ABAC disabled
gcloud container clusters create demo-2 --zone=us-west1-b --project=gcastle-gke-dev --no-enable-legacy-authorization

# Create Kubernetes objects
kubectl create ns payments
kubectl create ns signup
kubectl create -n payments -f ../../pyramidcorp/manifests/2_rbac_payments.yaml
kubectl create -n signup -f ../../pyramidcorp/manifests/2_rbac_signup.yaml
echo "KUBECONFIG=${KUBECONFIG}"
