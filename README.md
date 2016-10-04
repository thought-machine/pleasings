# Pleasings [![Build Status](https://travis-ci.org/thought-machine/pleasings.svg?branch=master)](https://travis-ci.org/thought-machine/pleasings)
Addons &amp; new build rules for [Please](https://github.com/thought-machine/please)

Most of these are either still experimental or sufficiently esoteric that we prefer not to make them
part of the main Please distribution.

Currently contains the following:
 * Android: A set of rules to build Android .apk files. Includes an `android_maven_jar` rule for fetching third-party
   dependencies which are dexed in parallel for fast rebuild times.
 * Go: `go_bindata` rule to pack arbitrary files into Go source (see [go-bindata](https://github.com/jteeuwen/go-bindata))
 * Grm: Rules for building [Thrax](http://www.openfst.org/twiki/bin/view/GRM/Thrax) grammars.
   You'll need to have OpenFST and Thrax installed for these.
 * Rust: A very basic set of rules for building Rust code. Hasn't gone much beyond "hello world" yet.
