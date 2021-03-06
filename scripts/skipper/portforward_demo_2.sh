#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}

export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)

# Point at demo-2 cluster
gcloud container clusters get-credentials demo-2 --zone=${ZONE} --project=${PROJECT}

# Port-forward signup pod to localhost:8081, silently in the background.
POD=$(kubectl get pods -n signup --selector=app=signup -o=jsonpath={.items..metadata.name})
if [[ -z "${POD}" ]]; then
  echo "signup pod not found. Is the deployment still creating?"
  exit 1
fi
kubectl port-forward -n signup $POD 8081:80 > /dev/null &
