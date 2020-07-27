#!/bin/bash

# Installs the module and runs index.js to generate our 3rd party libs
# TODO(jpoole): remove this intermediate file once index.js works with files rather than std in/out
cat yarn.lock | plz run //js/yarn_deps > /tmp/BUILD.third_party && mv /tmp/BUILD.third_party third_party/BUILD
