# Example of how to use the grm rules.
subinclude('//grm')

grm_library(
    name = 'example_far',
    src = 'example.grm',
)

grm_test(
    name = 'example_test',
    ref = 'example.ref',
    far = ':example_far',
)
