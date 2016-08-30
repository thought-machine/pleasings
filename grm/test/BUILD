# Example of how to use the grm rules.
subinclude('//grm')
package(
    farextract = '//third_party/grm:farextract',
    openfst_lib = '//third_party/grm:openfst',
    thrax_lib = '//third_party/grm:thrax',
    thraxcompiler = '//third_party/grm:thraxcompiler',
)

grm_library(
    name = 'example_far',
    src = 'example.grm',
)

grm_test(
    name = 'example_test',
    far = ':example_far',
    ref = 'example.ref',
)
