#!/bin/bash

# $Id: $
set -e

OUTDIR="${HOME}/msf/demo1"

if [ ! -f ./kubectl ]; then
  echo "No kubectl, downloading."
  curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.8.3/bin/linux/amd64/kubectl
  chmod a+x kubectl
fi

echo "./kubectl --kubeconfig=${OUTDIR}/kubeconfig get pods"
./kubectl --kubeconfig=${OUTDIR}/kubeconfig get pods
read -n1 -s 
NS_POD=$(./kubectl --kubeconfig=${OUTDIR}/kubeconfig get pods --selector=app=payment --output=jsonpath={.items..metadata.name})
# Need to actually mount the secret in.
#echo "./kubectl --kubeconfig=${OUTDIR}/kubeconfig get pod $NS_POD -o yaml | grep -a1 secret"
#./kubectl --kubeconfig=${OUTDIR}/kubeconfig get pod $NS_POD -o yaml | grep -a1 secret
#read -n1 -s 
echo "./kubectl --kubeconfig=${OUTDIR}/kubeconfig get secret payments-api-key -o yaml"
./kubectl --kubeconfig=${OUTDIR}/kubeconfig get secret payments-api-key -o yaml
read -n1 -s 
echo "./kubectl --kubeconfig=${OUTDIR}/kubeconfig exec -it $NS_POD /bin/bash"
./kubectl --kubeconfig=${OUTDIR}/kubeconfig exec -it $NS_POD /bin/bash

