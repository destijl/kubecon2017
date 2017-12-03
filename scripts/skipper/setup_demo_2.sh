#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}

# Use a Kubeconfig specific to demo-2 so we don't clobber stuff
export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE}")/ && pwd)

gcloud container clusters get-credentials demo-2 --zone=${ZONE} --project=${PROJECT}

# Cleanup
# Deleting namespaces cleans it all up, but kubectl doesn't wait
kubectl delete -n payments -f ${SCRIPT_DIR}/../../pyramidcorp/manifests/2_rbac_payments.yaml || true
kubectl delete -n signup -f ${SCRIPT_DIR}/../../pyramidcorp/manifests/2_rbac_signup.yaml || true

# Create Kubernetes objects
kubectl create ns payments || true
kubectl create ns signup || true
kubectl create -n payments -f ${SCRIPT_DIR}/../../pyramidcorp/manifests/2_rbac_payments.yaml
kubectl create -n signup -f ${SCRIPT_DIR}/../../pyramidcorp/manifests/2_rbac_signup.yaml
echo "KUBECONFIG=${KUBECONFIG}"
