# Build rules for building finite state transducer grammars
# using Thrax (http://www.openfst.org/twiki/bin/view/GRM/Thrax).
package(default_visibility = ['PUBLIC'])

export_file(
    name = 'grm',
    src = 'grm.build_defs',
)

cc_binary(
    name = 'test_main',
    srcs = ['grm_test_main.cc'],
    linker_flags = ['-lthrax -lfstfar -lfst -ldl'],
)
