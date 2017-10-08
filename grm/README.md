Thrax
=====

Rules for building OpenFST grammars using [Thrax](http://www.openfst.org/twiki/bin/view/GRM/Thrax).

You will need to have Thrax and OpenFST installed on your system for these to work.


Testing
-------

Includes rules and a C++ wrapper for unit testing them. Since the wrapper
has to be compiled, currently we recommend that you vendorise it in your
repo along with the Thrax build rules (you could also fetch it remotely,
but that seems overkill given that it's one file of about 6kB).
