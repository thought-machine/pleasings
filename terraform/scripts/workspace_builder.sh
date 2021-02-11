#!/bin/bash
# This script prepares a Terraform Workspace with:
# * Terraform Plugins
# * Terraform Modules
set -euo pipefail

TERRAFORM_MINOR_VERSION="$(head -n1 < <($TERRAFORM_BIN version) | awk '{ print $2 }' | cut -f1-2 -d\.)"

PLUGIN_DIR="${OUTS}/_plugins"
MODULE_DIR="${OUTS}/_modules"

mkdir -p "${OUTS}"

# plugins_v0.11+ configures plugins for Terraform 0.11+
# Terraform v0.11+ store plugins in the following structure:
# `./${os}_{arch}/${binary}`
# e.g. ``./linux_amd64/terraform-provider-null_v2.1.2_x4`
function plugins_v0.11+ {
    local plugin_dir
    local plugin_bin
    plugin_dir="${PLUGIN_DIR}/${CONFIG_OS}_${CONFIG_ARCH}"
    mkdir -p "${plugin_dir}"
    for plugin in $SRCS_PLUGINS; do
        plugin_bin="$(find "$plugin" -not -path '*/\.*' -type f | head -n1)"
        cp "$plugin_bin" "${plugin_dir}/"
    done
}

# plugins_v0.13+ configures plugins for Terraform 0.13+
# Terraform v0.13+ store plugins in the following structure:
# `./${registry}/${namespace}/${type}/${version}/${os}_{arch}/${binary}`
# e.g. `./registry.terraform.io/hashicorp/null/2.1.2/linux_amd64/terraform-provider-null_v2.1.2_x4`
function plugins_v0.13+ {
    local registry namespace provider_name version plugin_dir plugin_bin
    for plugin in $SRCS_PLUGINS; do
        registry=$(<"${plugin}/.registry")
        namespace=$(<"${plugin}/.namespace")
        provider_name=$(<"${plugin}/.provider_name")
        version=$(<"${plugin}/.version")
        plugin_dir="${PLUGIN_DIR}/${registry}/${namespace}/${provider_name}/${version}/${CONFIG_OS}_${CONFIG_ARCH}"
        plugin_bin="$(find "$plugin" -not -path '*/\.*' -type f | head -n1)"
        mkdir -p "${plugin_dir}"
        cp "$plugin_bin" "${plugin_dir}/"
    done
}

# copy plugins (providers)
if [[ -v SRCS_PLUGINS ]]; then
    case "${TERRAFORM_MINOR_VERSION}" in
        "v0.11") plugins_v0.11+ ;;
        "v0.12") plugins_v0.11+ ;;
        "v0.13") plugins_v0.13+ ;;
        *) plugins_v0.13+ ;;
    esac
fi

# modules configures modules for Terraform
# Terraform modules via Please work by copying the module's source to
# a relative sub-directory of the workspace and updating the reference to
# that sub-directory.
function modules {
    local rel_module_dir

    mkdir -p "${MODULE_DIR}"
    rel_module_dir="${MODULE_DIR//$OUTS/\.}"

    for module in $SRCS_MODULES; do
        cp -r "${module}" "${MODULE_DIR}/"
    done

    for module in "${!MODULE_PATHS[@]}"; do
        path="${MODULE_PATHS[$module]}"
        sed -i "s#${module}#${rel_module_dir}/$(basename "${path}")#g" "$SRCS_SRCS"
    done
}

# copy modules
if [[ -v SRCS_MODULES ]]; then
    modules
fi

# shift srcs into outs
for src in $SRCS_SRCS; do 
    cp "${src}" "${OUTS}/"
done
