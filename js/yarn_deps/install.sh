#!/bin/bash

# Installs the module nad runs index.js to generate our 3rd party libs
yarn install && cat yarn.lock | node index.js > third_party/BUILD