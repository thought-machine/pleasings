C / C++ rules
=============

Here we have a set of replacement C and C++ rules using [ThinLTO](http://blog.llvm.org/2016/06/thinlto-scalable-and-incremental-lto.html)
to perform fast incremental link-time optimisation.

Note that you must have sufficiently recent versions of Clang and Gold
for this to work. The examples here use Clang 6 although you can
almost certainly use older versions as well.

There's a small set of extremely contrived code to illustrate and
lightly test it.

This is still *extremely* experimental and is known not to work
entirely correctly yet.
