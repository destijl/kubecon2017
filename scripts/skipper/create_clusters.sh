#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}

# Create demo-1 cluster, w/ ABAC enabled
gcloud container clusters create demo-1 --zone=${ZONE} --project=${PROJECT} --enable-legacy-authorization
# Create demo-2 cluster, w/ ABAC disabled
gcloud container clusters create demo-2 --zone=${ZONE} --project=${PROJECT} --no-enable-legacy-authorization
# Create demo-3 cluster, w/ network policy enabled
gcloud container clusters create demo-3 --zone=${ZONE} --project=${PROJECT} --no-enable-legacy-authorization --enable-network-policy

