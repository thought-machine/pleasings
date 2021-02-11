#!/bin/bash
# This script prepares a Terraform module for use with Please by:
# * Replacing sub-modules (deps) with local references.
# * Ensuring all sub-modules have local references.
set -euo pipefail

# dependencies prepares a module dependencies for a module
# A Terraform module can have dependencies and can be depended on.
# To accomodate this, we add 
function dependencies {
    mkdir "${OUTS}/modules/"
    for m in $SRCS_DEPS; do
        replace=$(basename "$m")
        searches=($(<"${m}/.module_source_searches"))
        for search in "${searches[@]}"; do
            find . -name "*.tf" -exec sed -i  "s#[^\"]*${search}[^\"]*#./modules/${replace}#g" {} +
        done
        cp -r "$m" "${OUTS}/modules/"
    done
}

# dependants prepares the module for having dependants 
function dependants {
    # add a replace-me search for an interesting part of the URL
    echo "${URL}" | cut -f3-5 -d/ > "${OUTS}/.module_source_searches"
    # add a replace-me search for the canonical Please build rule
    echo "${PKG}:${NAME}" | cut -f3-5 -d/ > "${OUTS}/.module_source_searches"
}

# strip removes the given files/directories from the module
function strip {
    for s in "${STRIP[@]}"; do
        rm -rf "${OUTS:?}/${s}"
    done
}

# validate_module_sources validates that the module has no remaining modules that are not declared in deps
function validate_module_sources {
    if grep -r --include \*.tf -A3 "module \"" "${OUTS}" | grep -E "source\s*=\s*\"[^\/\.]+.*"; then
        echo "found module source not declared in deps"
        exit 1
    fi
}

mv "${OG_MODULE_DIR}" "${OUTS}"

if [[ -v SRCS_DEPS ]]; then
    dependencies
fi

strip

dependants

validate_module_sources
