#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}

export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE}")/ && pwd)
gcloud container clusters get-credentials demo-1 --zone=${ZONE} --project=${PROJECT}

# Cleanup
kubectl delete -f ${SCRIPT_DIR}/../../pyramidcorp/manifests/1_default.yaml || true

# Create Kubernetes objects
kubectl create -f ${SCRIPT_DIR}/../../pyramidcorp/manifests/1_default.yaml
echo "KUBECONFIG=${KUBECONFIG}"
