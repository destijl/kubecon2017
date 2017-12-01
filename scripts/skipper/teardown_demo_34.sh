#!/bin/bash
# Tear down the demo-3 cluster
gcloud container clusters delete demo-3 --zone=us-west1-b --project=gcastle-gke-dev
