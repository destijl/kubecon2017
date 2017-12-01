#!/bin/bash
# Tear down the demo-2 cluster
gcloud container clusters delete demo-2 --zone=us-west1-b --project=gcastle-gke-dev
