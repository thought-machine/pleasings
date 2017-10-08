# Pleasings [![Build Status](https://circleci.com/gh/thought-machine/pleasings.svg?style=shield)](https://circleci.com/gh/thought-machine/pleasings)
Addons &amp; new build rules for [Please](https://github.com/thought-machine/please)

Most of these are either still experimental or sufficiently esoteric that we prefer not to make them
part of the main Please distribution.

Currently contains the following:
 * Android: A set of rules to build Android .apk files. Includes rules for many features of Android
   apps, including dependencies, and a set of rules for native development using the NDK.
 * Go: `go_bindata` rule to pack arbitrary files into Go source (see [go-bindata](https://github.com/jteeuwen/go-bindata))
 * Grm: Rules for building [Thrax](http://www.openfst.org/twiki/bin/view/GRM/Thrax) grammars.
   You'll need to have OpenFST and Thrax installed for these.
 * Rust: A very basic set of rules for building Rust code. Hasn't gone much beyond "hello world" yet.
 * Protocol Buffers: Extensions to the builtin proto rules, currently one to generate a REST proxy
   using [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway)
 * Java: An extended compiler worker that integrates
   [error-prone](https://github.com/google/error-prone) for additional compile-time diagnostics.
 * Javascript: A set of rules integrating Yarn dependencies and a Webpack-based build into Please.
   Still somewhat incomplete.
