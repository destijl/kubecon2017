#!/bin/bash
# Tear down the demo-1 cluster
gcloud container clusters delete demo-1 --zone=us-west1-b --project=gcastle-gke-dev
