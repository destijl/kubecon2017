#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}

export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE}")/ && pwd)

gcloud container clusters get-credentials demo-3 --zone=${ZONE} --project=${PROJECT}

# Cleanup
# Deleting namespaces cleans it all up, but kubectl doesn't wait
kubectl delete -n payments -f ${SCRIPT_DIR}/../../pyramidcorp/manifests/3_payments.yaml || true
kubectl delete -n signup -f ${SCRIPT_DIR}/../../pyramidcorp/manifests/3_signup.yaml || true
kubectl delete -n payments -f ${SCRIPT_DIR}/../../pyramidcorp/manifests/4_network_policy.yaml || true

# Create Kubernetes objects
kubectl create ns payments || true
kubectl create ns signup || true
kubectl create -n payments -f ${SCRIPT_DIR}/../../pyramidcorp/manifests/3_payments.yaml
kubectl create -n signup -f ${SCRIPT_DIR}/../../pyramidcorp/manifests/3_signup.yaml
echo "KUBECONFIG=${KUBECONFIG}"
