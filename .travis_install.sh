#!/bin/sh
# Provided for Travis, to download dependencies for their container
# infrastructure and to set up a custom config.
# See https://docs.travis-ci.com/user/migrating-from-legacy/ for details.

set -eu

cat <<EOF > .plzconfig.local
[build]
path = $PATH:$HOME/fst/bin

[go]
goroot = $GOROOT

[cpp]
cctool = g++-4.8
defaultoptcflags = --std=c++11 -O2 -DNDEBUG -I $HOME/fst/include -L $HOME/fst/lib -Wl,-rpath $HOME/fst/lib

[cache]
dir = $HOME/plz-cache

EOF

if [ ! -f "$HOME/fst/lib/libfst.so" ]; then
    cd $HOME
    rm -rf $HOME/fst
    curl -fsSLO http://openfst.org/twiki/pub/FST/FstDownload/openfst-1.5.4.tar.gz
    tar -xzf openfst-1.5.4.tar.gz
    cd openfst-1.5.4
    export CC=gcc-4.8
    export CXX=g++-4.8
    ./configure --enable-const-fsts --enable-const-fsts --enable-far --enable-lookahead-fsts --enable-pdt --enable-mpdt --enable-static --prefix=$HOME/fst
    make -j4
    make install
    cd $HOME
else
    echo 'Using cached openfst.';
fi

if [ ! -f "$HOME/thrax/lib/libthrax.so" ]; then
    cd $HOME
    export CXXFLAGS="-I$HOME/fst/include"
    export LDFLAGS="-L$HOME/fst/lib"
    curl -fsSLO http://www.openfst.org/twiki/pub/GRM/ThraxDownload/thrax-1.2.2.tar.gz
    tar -xzf thrax-1.2.2.tar.gz
    cd thrax-1.2.2
    export CC=gcc-4.8
    export CXX=g++-4.8
    ./configure --enable-static --prefix=$HOME/fst
    make -j4
    make install
    cd $HOME
else
    echo 'Using cached thrax.';
fi
