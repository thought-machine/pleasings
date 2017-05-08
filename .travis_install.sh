#!/bin/sh
# Provided for Travis, to download dependencies for their container
# infrastructure and to set up a custom config.
# See https://docs.travis-ci.com/user/migrating-from-legacy/ for details.

set -eu

cat <<EOF > .plzconfig.local
[build]
path = $PATH:$HOME/openfst/bin:$HOME/thrax/bin

[go]
goroot = $GOROOT

[cpp]
cctool = g++-4.8
defaultoptcflags = --std=c++11 -O2 -DNDEBUG -I $HOME/openfst/include -L $HOME/openfst/lib -I $HOME/thrax/include -L $HOME/thrax/lib -Wl,-rpath $HOME/openfst/lib -Wl,-rpath $HOME/thrax/lib

[proto]
protoctool = ${HOME}/protoc

[cache]
dir = $HOME/plz-cache

EOF

if [ ! -f "$HOME/openfst/bin/farextract" ]; then
    rm -rf "$HOME/openfst"
    curl -fsSL https://get.please.build/ci/openfst-1.5.4_linux_amd64.tar.gz | tar -xzC $HOME
else
    echo 'Using cached openfst'
fi

if [ ! -f "$HOME/thrax/bin/thraxcompiler" ]; then
    rm -rf "$HOME/thrax"
    curl -fsSL https://get.please.build/ci/thrax-1.2.2_linux_amd64.tar.gz | tar -xzC $HOME
else
    echo 'Using cached thrax'
fi

if [ ! -f "$HOME/protoc" ]; then
    rm -rf "$HOME/protoc"
    echo 'Downloading protobuf...'
    curl -fsSLO https://github.com/google/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip
    unzip protoc-3.0.0-linux-x86_64.zip bin/protoc
    mv bin/protoc "$HOME/protoc"
else
    echo 'Using cached protobuf.';
fi

if [ ! -f "$HOME/grpc_cpp_plugin" ]; then
    rm -rf "$HOME/grpc_cpp_plugin"
    echo 'Downloading grpc_cpp_plugin...'
    curl -fsSLo "$HOME/grpc_cpp_plugin" https://get.please.build/third_party/binary/grpc_cpp_plugin-1.1.1
    chmod +x "$HOME/grpc_cpp_plugin"
else
    echo 'Using cached grpc_cpp_plugin.';
fi
