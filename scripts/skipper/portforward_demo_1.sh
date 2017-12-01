#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)

# Point at demo-1 cluster
gcloud container clusters get-credentials demo-1 --zone=us-west1-b --project=gcastle-gke-dev

# Port-forward signup pod to localhost:8080
POD=$(kubectl get pods --selector=app=signup --output=jsonpath={.items..metadata.name})
if [[ -z "${POD}" ]]; then
  echo "signup pod not found. Is the deployment still creating?"
  exit 1
fi
kubectl port-forward $POD 8080:80 > /dev/null &
