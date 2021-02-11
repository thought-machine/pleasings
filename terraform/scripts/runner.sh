#!/bin/bash
# This script runs Terraform in the target's working directory with the following features:
# - Plugin cache directory pointing to our prepared plugins directory.
# - Strips out various noisy output (https://github.com/hashicorp/terraform/issues/20960)
set -euo pipefail

ABS="${PWD}"

TERRAFORM_BIN="${ABS}/${TERRAFORM_BIN}"
PATH="$(dirname "${TERRAFORM_BIN}"):$PATH"
export PATH
export TF_PLUGIN_CACHE_DIR="${ABS}/${TERRAFORM_WORKSPACE}/_plugins"

TF_CLEAN_OUTPUT="${TF_CLEAN_OUTPUT:-false}"

# tf_clean_output strips the Terraform output down. 
# This is useful in CI/CD where Terraform logs are usually noisy by default.
function tf_clean_output {
    local cmd extra_args is_last
    cmd=($(echo "${1}"))
    shift
    is_last="$1"
    shift
    extra_args=("${@}")

    args=("${cmd[@]}")
    if [ "${is_last}" == "true" ]; then
        args=("${args[@]}" "${extra_args[@]}")
    fi
    echo "..> terraform ${args[@]}"
    if [ "${TF_CLEAN_OUTPUT}" == "false" ]; then
        "${TERRAFORM_BIN}" "${args[@]}"
    else
        "${TERRAFORM_BIN}" "${args[@]}" \
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

for bin in "${PRE_BINARIES[@]}"; do
    "${ABS}/${bin}"
done

for i in "${!TERRAFORM_CMDS[@]}"; do
    cmd="${TERRAFORM_CMDS[i]}"
    if [ $((i+1)) == "${#TERRAFORM_CMDS[@]}" ]; then
        tf_clean_output "${cmd}" "true" "$@" 
    else
        tf_clean_output "${cmd}" "false" "$@" 
    fi

    echo ""
done

for bin in "${POST_BINARIES[@]}"; do
    "${ABS}/${bin}"
done
