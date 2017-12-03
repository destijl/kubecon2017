#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}

export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)

# Point at demo-3 cluster
gcloud container clusters get-credentials demo-3 --zone=us-west1-b --project=gcastle-gke-dev &> /dev/null

echo "cat ../../pyramidcorp/manifests/4_network_policy.yaml"
read -n1 -s 
cat ../../pyramidcorp/manifests/4_network_policy.yaml
read -n1 -s 
echo "kubectl create -n payments -f ../../pyramidcorp/manifests/4_network_policy.yaml"
read -n1 -s 
kubectl create -n payments -f ../../pyramidcorp/manifests/4_network_policy.yaml
read -n1 -s 
echo "kubectl -n payments get networkpolicy"
read -n1 -s 
kubectl -n payments get networkpolicy 
