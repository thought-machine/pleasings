# Pleasings has been deprecated in favour of the new plugins API
These rules are now unmaintained. Since v17 Please has introduced the plugins API and many of these rules have been moved here:
https://github.com/please-build/please-rules

If you'd like to use something in this repo that has not been migrated to a plugin, Please raise an issue on the main [Please repo](https://github.com/thought-machine/please). 

# Pleasings [![Build Status](https://circleci.com/gh/thought-machine/pleasings.svg?style=shield)](https://circleci.com/gh/thought-machine/pleasings)


Addons &amp; new build rules for [Please](https://github.com/thought-machine/please)

Most of these are either still experimental or sufficiently esoteric that we prefer not to make them
part of the main Please distribution.

Currently contains the following:
 * C++: Replacement rules that use [ThinLTO](http://blog.llvm.org/2016/06/thinlto-scalable-and-incremental-lto.html)
   to perform fast incremental link-time optimisation.
 * Go: `go_bindata` rule to pack arbitrary files into Go source (see [go-bindata](https://github.com/jteeuwen/go-bindata))
 * Grm: Rules for building [Thrax](http://www.openfst.org/twiki/bin/view/GRM/Thrax) grammars.
   You'll need to have OpenFST and Thrax installed for these.
 * Rust: A very basic set of rules for building Rust code. Hasn't gone much beyond "hello world" yet.
 * Protocol Buffers: Extensions to the builtin proto rules, currently one to generate a REST proxy
   using [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway)
 * Python: Basic rules for importing dependencies from `requirements.txt`. Does not support all possible entries yet.
 * Java: An extended compiler worker that integrates
   [error-prone](https://github.com/google/error-prone) for additional compile-time diagnostics.
 * Scala: Basic rules for compiling scala code to `.jar` files. No test support yet.
 * Javascript: A set of rules integrating Yarn dependencies and a Webpack-based build into Please.
   Still somewhat incomplete.
 * Package: Rules for packaging things. Currently contains a generic wrapper to
            [fpm](https://github.com/jordansissel/fpm) and a specific one for building .deb files.
 * Remote: Various extended rules for fetching remote files. Includes some conveniences for handling
           git / github and one for verifying downloaded files against GPG ASCII-armoured signatures.
