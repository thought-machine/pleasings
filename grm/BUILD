# Build rules for building finite state transducer grammars
# using Thrax (http://www.openfst.org/twiki/bin/view/GRM/Thrax).
package(default_visibility=['PUBLIC'])

export_file(
    name = 'grm',
    src = 'grm.build_defs',
)

cc_binary(
    name = 'test_main',
    srcs = ['grm_test_main.cc'],
    linker_flags = [
        # We don't know which of these libfst will get installed in, but neither is
        # on the linker path by default. pkg-config would be preferable but of course
        # we can't rely on that being set up for us.
        '-L/usr/local/lib/fst',
        '-L/usr/lib/fst',
        '-lthrax -lfst  -lfstfar -ldl',
    ],
)
