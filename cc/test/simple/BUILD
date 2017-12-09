# Simpler test case than //cc/test.
subinclude('//cc:thinlto')
package(
    cc_tool = 'clang-6.0',
    ld_tool = 'gold',
)

c_library(
    name = 'lib',
    srcs = ['file2.c'],
)

c_binary(
    name = 'bin',
    srcs = ['file1.c'],
    deps = [':lib'],
)
