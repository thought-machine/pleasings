#!/bin/bash
# This script runs Terraform in the target's working directory with the following features:
# - Plugin cache directory pointing to our prepared plugins directory.
# - Strips out various noisy output (https://github.com/hashicorp/terraform/issues/20960)
set -euo pipefail

TERRAFORM_BIN="${PWD}/${TERRAFORM_BIN}"
PATH="$(dirname "${TERRAFORM_BIN}"):$PATH"
export PATH
export TF_PLUGIN_CACHE_DIR="${PWD}/${TERRAFORM_WORKSPACE}/_plugins"

TF_CLEAN_OUTPUT="${TF_CLEAN_OUTPUT:-false}"

# tf_clean_output strips the Terraform output down. 
# This is useful in CI/CD where Terraform logs are usually noisy by default.
function tf_clean_output {
    local cmd
    cmd="$1"
    echo "..> terraform ${cmd}"
    if [ "${TF_CLEAN_OUTPUT}" == "false" ]; then
        "${TERRAFORM_BIN}" "${cmd}"
    else
        "${TERRAFORM_BIN}" "${cmd}" \
        | sed '/successfully initialized/,$d' \
        | sed "/You didn't specify an \"-out\"/,\$d" \
        | sed '/.terraform.lock.hcl/,$d' \
        | sed '/Refreshing state/d' \
        | sed '/The refreshed state will be used to calculate this plan/d' \
        | sed '/persisted to local or remote state storage/d' \
        | sed '/^[[:space:]]*$/d'
    fi
}

cd "${TERRAFORM_WORKSPACE}"

for cmd in "${TERRAFORM_CMDS[@]}"; do
    tf_clean_output "${cmd}"

    echo ""
done
