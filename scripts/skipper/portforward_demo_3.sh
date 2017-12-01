#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)

# Point at demo-3 cluster
gcloud container clusters get-credentials demo-3 --zone=us-west1-b --project=gcastle-gke-dev

# Port-forward signup pod to localhost:8082, silently in the background.
POD=$(kubectl get pods -n signup --selector=app=signup -o=jsonpath={.items..metadata.name})
if [[ -z "${POD}" ]]; then
  echo "signup pod not found. Is the deployment still creating?"
  exit 1
fi
kubectl port-forward -n signup $POD 8082:80 > /dev/null 2>&1 &
