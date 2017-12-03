#!/bin/bash

# $Id: $
set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE}")/ && pwd)
${SCRIPT_DIR}/setup_demo_1.sh
${SCRIPT_DIR}/setup_demo_2.sh
${SCRIPT_DIR}/setup_demo_3.sh

pkill -f "kubectl\ port-forward" || true

sleep 30
${SCRIPT_DIR}/portforward_demo_1.sh
${SCRIPT_DIR}/portforward_demo_2.sh
${SCRIPT_DIR}/portforward_demo_3.sh
