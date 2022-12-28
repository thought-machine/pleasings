#!/usr/bin/env bash
# This script provides a tool for working with Terraform via the Please Build System.
set -Eeuo pipefail

# Bash version check
if [ -z "${BASH_VERSINFO[*]}" ] || [ -z "${BASH_VERSINFO[0]}" ] || [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
    echo "This script requires Bash version >= 4"
    exit 1
fi

# CONSTANTS
## PLZ_TF_METADATA_DIR is the relative path against modules/providers to store metadata used by this Please tool.
PLZ_TF_METADATA_DIR=".please/terraform" 
## PLZ_TF_WORKSPACE_BASE is the absolute path to run Terraform commands under.
PLZ_TF_WORKSPACE_BASE="${TMPDIR:-/tmp}/please/terraform/workspaces"
## PLZ_TF_PLUGIN_CACHE_DIR is the absolute path to use as a Terraform provider cache.
PLZ_TF_PLUGIN_CACHE_DIR="${TMPDIR:-/tmp}/please/terraform/cache"

# provider_build
# This function prepares a Terraform provider for use with Please by:
# * Adding metadata to the Terraform provider.
function provider_build {
    local \
        provider_path \
        out \
        registry \
        namespace \
        provider_name \
        version \
        os \
        arch

    provider_path="$(_parse_flag provider_path "$@")"
    out="$(_parse_flag out "$@")"
    registry="$(_parse_flag registry "$@")"
    namespace="$(_parse_flag namespace "$@")"
    provider_name="$(_parse_flag provider_name "$@")"
    version="$(_parse_flag version "$@")"
    os="$(_parse_flag os "$@")"
    arch="$(_parse_flag arch "$@")"

    # extract the provider zip if it is a zip.
    if [[ "$provider_path" == *.zip ]]; then
        unzip "$provider_path" -d tmp
        mkdir -p "$out"
        plugin_bin="$(find tmp -type f -name "terraform-provider-${provider_name}*")"
        mv "$plugin_bin" "$out/"
    else
        mv "$provider_path" "$out/"
    fi

    # add metadata
    mkdir -p "$out/$PLZ_TF_METADATA_DIR"
    echo "$registry" > "$out/$PLZ_TF_METADATA_DIR/.registry"
    echo "$namespace" > "$out/$PLZ_TF_METADATA_DIR/.namespace"
    echo "$provider_name" > "$out/$PLZ_TF_METADATA_DIR/.provider_name"
    echo "$version" > "$out/$PLZ_TF_METADATA_DIR/.version"
    echo "$os" > "$out/$PLZ_TF_METADATA_DIR/.os"
    echo "$arch" > "$out/$PLZ_TF_METADATA_DIR/.arch"
}

# module_build
# This function prepares a Terraform module for use with Please by:
# * Replacing sub-modules (deps) with colocated references.
function module_build {
    local pkg \
        name \
        module_dir \
        out \
        url \
        strip \
        deps

    pkg="$(_parse_flag pkg "$@")"
    name="$(_parse_flag name "$@")"
    module_dir="$(_parse_flag module-dir "$@")"
    out="$(_parse_flag out "$@")"
    url="$(_parse_flag url "$@")"
    IFS=',' read -r -a strip <<< "$(_parse_flag strip "$@")"
    IFS=',' read -r -a deps <<< "$(_parse_flag deps "$@")"

    mv "${module_dir}" "${out}"

    _colocate_modules "$out" "${deps[@]}"
    
    # strip directories
    for s in "${strip[@]}"; do
        log::debug "removing ${out:?}/${s}"
        rm -rf "${out:?}/${s}"
    done

    # Add aliases to the module for dependants to use.
    module_metadata_dir="${out}/${PLZ_TF_METADATA_DIR}"
    mkdir -p "${module_metadata_dir}"
    rm -f "${module_metadata_dir}/.module_aliases"
    aliases=(
        # add a replace-me search for an interesting part of the URL
        "$( echo "${url}" | cut -f3-5 -d/ )" 
        # add a replace-me search for the canonical Please build rule
        "${pkg}:${name}"
    )    
    for a in "${aliases[@]}"; do
        log::debug "adding ${a} to ${module_metadata_dir}/.module_aliases"
        echo "${a}" >> "${module_metadata_dir}/.module_aliases"
    done
}

# root_build
# This function prepares a Terraform Root module with:
# * Replaced Please build environment vars in Terraform configuration.
# * Colocated Terraform modules.
# * Terraform var files.
function root_build {
    local pkg \
        name \
        os \
        arch \
        terraform_binary \
        out \
        pkg_dir \
        srcs \
        var_files \
        modules

    pkg="$(_parse_flag pkg "$@")"
    name="$(_parse_flag name "$@")"
    os="$(_parse_flag os "$@")"
    arch="$(_parse_flag arch "$@")"
    out="$(_parse_flag out "$@")"
    pkg_dir="$(_parse_flag pkg-dir "$@")"
    IFS=',' read -r -a srcs <<< "$(_parse_flag srcs "$@")"
    IFS=',' read -r -a var_files <<< "$(_parse_flag var_files "$@")"
    IFS=',' read -r -a modules <<< "$(_parse_flag modules "$@")"


    mkdir -p "${out}"

    # shift srcs into outs. These are flattened as Terraform modules 
    # should not span multiple directories.
    for src in "${srcs[@]}"; do 
        cp "${src}" "${out}/"
    done

    _colocate_modules "$out" "${modules[@]}"

    # substitute build env vars to srcs
    # This is useful for re-using source file in multiple workspaces,
    # such as templating a Terraform remote state configuration.
    find "${out}" -maxdepth 1 -name "*.tf" -exec sed -i.bak "s#\$PKG#${pkg}#g" {} +
    find "${out}" -maxdepth 1 -name "*.tf" -exec sed -i.bak "s#\$PKG_DIR#${pkg_dir}#g" {} +
    find "${out}" -maxdepth 1 -name "*.tf" -exec sed -i.bak "s#\$NAME#${name}#g" {} +
    find "${out}" -maxdepth 1 -name "*.tf" -exec sed -i.bak "s#\$ARCH#${arch}#g" {} +
    find "${out}" -maxdepth 1 -name "*.tf" -exec sed -i.bak "s#\$OS#${os}#g" {} +

    # shift var files into outs
    # copies the given var files into the 
    # Terraform root and renames them so that they are auto-loaded 
    # by Terraform so we don't have to use non-global `-var-file` flag.
    for i in "${!var_files[@]}"; do
        var_file="${var_files[i]}"
        cp "${var_file}" "${out}/${i}-$(basename "${var_file}" | sed 's#\.tfvars#\.auto\.tfvars#')"
    done
}

# _colocate_modules
# This function takes the given outpath and module paths and
# copies the module paths into a modules subdirectory. Each module aliases are replaced
# with the new module paths in that subdirectory.
function _colocate_modules {
    local \
        out \
        modules
    
    out="$1"
    shift
    modules=("$@")

    log::debug "colocating modules to ${out}: ${modules[*]}"
    if [ ${#modules[@]} -ne 0 ]; then
        mkdir "${out}/modules/"
        for m in "${modules[@]}"; do
            log::debug "colocating '${m}'"
            replace="./modules/${m}"

            mapfile -t searches <"${m}/${PLZ_TF_METADATA_DIR}/.module_aliases"
            for search in "${searches[@]}"; do
                log::debug "replacing '${search}' with '${replace}'"
                find . -name "*.tf" -exec sed -i.bak "s#\"[^\"]*${search}[^\"]*\"#\"${replace}\"#g" {} +
            done
            mkdir -p "${out}/modules/${m}"
            cp -r "$m" "${out}/modules/$(dirname ${m})/"
        done
    fi
}

# _cache_providers_v0.11+ configures plugins for Terraform 0.11+
# Terraform v0.11+ store plugins in the following structure:
# `./${os}_{arch}/${binary}`
# e.g. ``./linux_amd64/terraform-provider-null_v2.1.2_x4`
function _cache_providers_v0.11+ {
    local \
        cache_dir \
        plugin_paths \
        plugin_dir \
        plugin_bin

    cache_dir="$1"; shift
    plugin_paths=("$@")

    plugin_dir="${cache_dir}/${os}_${arch}"
    mkdir -p "${plugin_dir}"

    for plugin_path in "${plugin_paths[@]}"; do
        provider_name=$(<"${plugin_path}/$PLZ_TF_METADATA_DIR/.provider_name")
        plugin_bin="$(find "$plugin_path" -type f -name "terraform-provider-${provider_name}*")"
        rsync "$plugin_bin" "${plugin_dir}/"
    done
}

# _cache_providers_v0.13+ configures plugins for Terraform 0.13+
# Terraform v0.13+ store plugins in the following structure:
# `./${registry}/${namespace}/${type}/${version}/${os}_{arch}/${binary}`
# e.g. `./registry.terraform.io/hashicorp/null/2.1.2/linux_amd64/terraform-provider-null_v2.1.2_x4`
function _cache_providers_v0.13+ {
    local \
        cache_dir \
        plugin_paths \
        registry \
        namespace \
        provider_name \
        version \
        plugin_dir \
        plugin_bin

    cache_dir="$1"; shift
    plugin_paths=("$@")

    for plugin_path in "${plugin_paths[@]}"; do
        registry=$(<"${plugin_path}/$PLZ_TF_METADATA_DIR/.registry")
        namespace=$(<"${plugin_path}/$PLZ_TF_METADATA_DIR/.namespace")
        provider_name=$(<"${plugin_path}/$PLZ_TF_METADATA_DIR/.provider_name")
        version=$(<"${plugin_path}/$PLZ_TF_METADATA_DIR/.version")
        os=$(<"${plugin_path}/$PLZ_TF_METADATA_DIR/.os")
        arch=$(<"${plugin_path}/$PLZ_TF_METADATA_DIR/.arch")
        plugin_dir="${cache_dir}/${registry}/${namespace}/${provider_name}/${version}/${os}_${arch}"
        plugin_bin="$(find "$plugin_path" -type f -name "terraform-provider-${provider_name}*")"
        mkdir -p "${plugin_dir}"
        rsync "$plugin_bin" "${plugin_dir}/"
    done
}

# _cache_providers caches the given providers appropriately
# against the given Terraform binary.
function _cache_providers {
    local \
        terraform_binary \
        provider_paths \
        terraform_minor_version
    
    terraform_binary="$1"
    shift
    provider_paths=("$@")
    terraform_minor_version="$(head -n1 <($terraform_binary version) | awk '{ print $2 }' | cut -f1-2 -d\.)"

    case "${terraform_minor_version}" in
        "v0.11") _cache_providers_v0.11+ "$PLZ_TF_PLUGIN_CACHE_DIR" "${provider_paths[@]}" ;;
        "v0.12") _cache_providers_v0.11+ "$PLZ_TF_PLUGIN_CACHE_DIR" "${provider_paths[@]}" ;;
        "v0.13") _cache_providers_v0.13+ "$PLZ_TF_PLUGIN_CACHE_DIR" "${provider_paths[@]}" ;;
        *) _cache_providers_v0.13+ "$PLZ_TF_PLUGIN_CACHE_DIR" "${provider_paths[@]}" ;;
    esac
}

# root_workspace
# This function prepares a Terraform root module workspace suitable for running `terraform` (and other) commands.
# It takes inspiration from python's virtualenv where the end-user would eval the output this function to change
# into the Terraform root module workspace working directory and obtain `terraform` in $PATH.
function root_workspace {
    terraform_binary="$(_parse_flag terraform-binary "$@")"
    os="$(_parse_flag os "$@")"
    arch="$(_parse_flag arch "$@")"
    root_module="$(_parse_flag root-module "$@")"
    IFS=',' read -r -a provider_paths <<< "$(_parse_flag provider-paths "$@")"

    # use absolute plz-out/ path when referring to terraform_binary at `plz run ...`-time.
    if [[ $terraform_binary == *"plz-out/bin"* ]]; then
        script_path="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
        # shellcheck disable=SC2001
        repo_path="$( echo "$script_path" | sed 's#/plz-out.*$##' )"
        terraform_binary="$repo_path/$terraform_binary"
    fi

    # add the `terraform` binary to the end-user's $PATH.
    cat <<EOF
set -e
PATH="$(dirname "${terraform_binary}"):$PATH"
export PATH
EOF

    # if there are configured providers, mirror them and enable the Terraform provider cache.
    if [ ${#provider_paths[@]} -ne 0 ]; then
        _cache_providers "$terraform_binary" "${provider_paths[@]}"
        # configure Terraform to use the plugin cache.
        cat <<EOF
TF_PLUGIN_CACHE_DIR="$PLZ_TF_PLUGIN_CACHE_DIR"
export TF_PLUGIN_CACHE_DIR
printf "..> plugin cache directory: %s\n" "${PLZ_TF_PLUGIN_CACHE_DIR}"
EOF
    fi

    # We cannot run Terraform commands in the `plz-out/gen/<rule>` workspace
    # as Terraform creates symlinks which plz warns us may be removed, thus
    # we create a `/tmp` directory and `rsync` the following:
    # - Generated Terraform workspace (root_build), which has:
    #   - Root module and all the modules it depends on under ./modules.
    # We have used TMPDIR as it is more likely to result in consistent paths across different
    # machines. This allows us to apply a pre-generated Terraform plan on a different machine
    # regardless of where the repository is cloned to.
    terraform_workspace="${PLZ_TF_WORKSPACE_BASE}/$(echo "$root_module" | sed 's#^.*plz-out/gen##')"
    log::debug "workspace: ${terraform_workspace}"
    mkdir -p "${terraform_workspace}"
    rsync -ah --delete --exclude=.terraform* --exclude=*.tfstate "${root_module}/" "${terraform_workspace}/"

    # change the end-user's working directory to the Terraform workspace, suitable for running `terraform` commands.
    cat <<EOF
printf "..> working directory: %s\n" "${terraform_workspace}"
cd "${terraform_workspace}"
EOF

}

function log::debug {
    if [ -v PLZ_TF_DEBUG ] || [ -v PKG ]; then
        >&2 printf "<debug: #${BASH_LINENO[0]}> %s\n" "$1"
    fi
}

function _csv_to_array {
    local csv="$1"

    echo "${csv//,/ }"
}

function _parse_flag {
    local name="$1"
    shift
    while test $# -gt 0; do
        case "$1" in
            "--${name}="*)
                value="$(echo "$1" | cut -d= -f2-)"
                echo "$value"
                log::debug "parsed flag '${name}': $value (from: \"$*\")"
                shift
            ;;
            *)
                shift
            ;;
        esac
    done
}


case "$1" in
    "provider_build")
        provider_build "$@"
    ;;
    "module_build")
        module_build "$@"
    ;;
    "root_build")
        root_build "$@"
    ;;
    "root_workspace")
        root_workspace "$@"
    ;;
esac
