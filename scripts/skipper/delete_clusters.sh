#!/bin/bash

# $Id: $

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}
gcloud container clusters delete --quiet demo-1 
gcloud container clusters delete --quiet demo-2
gcloud container clusters delete --quiet demo-3

