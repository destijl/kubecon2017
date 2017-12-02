#!/bin/bash

# $Id: $
set -e

OUTDIR="${HOME}/msf/demo2"

if [ ! -f ./kubectl ]; then
  echo "No kubectl, downloading."
  curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.8.3/bin/linux/amd64/kubectl
  chmod a+x kubectl
fi

# Should all fail
echo "./kubectl --kubeconfig=${OUTDIR}/kubeconfig get pods"
read -n1 -s 
./kubectl --kubeconfig=${OUTDIR}/kubeconfig get pods || true
read -n1 -s 
echo "./kubectl --kubeconfig=${OUTDIR}/kubeconfig get secret payments-api-key -o yaml"
read -n1 -s 
./kubectl --kubeconfig=${OUTDIR}/kubeconfig get secret payments-api-key -o yaml || true
read -n1 -s 

